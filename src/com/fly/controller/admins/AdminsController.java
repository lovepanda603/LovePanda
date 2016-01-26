
package com.fly.controller.admins;

import java.io.File;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fly.controller.BaseController;
import com.fly.entity.Advice;
import com.fly.entity.Beauty;
import com.fly.entity.Blog;
import com.fly.entity.Blogcategory;
import com.fly.entity.Gonggao;
import com.fly.entity.Iplog;
import com.fly.entity.Link;
import com.fly.entity.Picrecommend;
import com.fly.entity.Resourceslog;
import com.fly.entity.Role;
import com.fly.entity.User;
import com.fly.entity.Userrole;
import com.fly.entity.Video;
import com.fly.interceptor.AdminInterceptor;
import com.fly.interceptor.LoginInterceptor;
import com.fly.uibutil.ToolWeb;
import com.fly.util.HtmlUtil;
import com.fly.util.Utility;
import com.github.abel533.echarts.Legend;
import com.github.abel533.echarts.Option;
import com.github.abel533.echarts.axis.Axis;
import com.github.abel533.echarts.axis.CategoryAxis;
import com.github.abel533.echarts.axis.ValueAxis;
import com.github.abel533.echarts.code.FontWeight;
import com.github.abel533.echarts.code.MarkType;
import com.github.abel533.echarts.code.PointerType;
import com.github.abel533.echarts.code.Tool;
import com.github.abel533.echarts.code.Trigger;
import com.github.abel533.echarts.data.PointData;
import com.github.abel533.echarts.json.GsonUtil;
import com.github.abel533.echarts.series.Line;
import com.github.abel533.echarts.style.TextStyle;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.jfinal.aop.Before;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheName;
import com.jfinal.plugin.ehcache.EvictInterceptor;
import com.jfinal.upload.UploadFile;

@Before({LoginInterceptor.class, AdminInterceptor.class})
public class AdminsController extends BaseController
{
    public void index()
    {
        render("index.jsp");
    }

    /**
     * 后台博客列表
     */
    public void blogList()
    {
        String sql = "";
        Blog searchBlog = getModel(Blog.class, "blog");
        Page<Blog> pagelist = null;
        if (!Utility.empty(searchBlog.getStr("title")))
        {
            String title = searchBlog.getStr("title");
            String titlelike = "";
            if (Utility.empty(title))
            {
                titlelike = "'%%'";
            }
            else
            {
                titlelike = "'%" + title + "%'";
            }
            sql += " and title like " + titlelike + " ";
        }
        String bozhu = getPara("bozhu");
        if (!empty(bozhu))
        {
            setAttr("bozhu", bozhu);
            List<User> userlist = User.me.findByUsername(bozhu);
            if ((!empty(userlist)) && userlist.size() >= 1)
            {
                User u = userlist.get(0);
                sql += " and user_id=" + u.getInt("id") + " ";
            }
        }
        if (!empty(searchBlog.getInt("ispublic")))
        {
            sql += " and ispublic=" + searchBlog.getInt("ispublic") + " ";
        }
        if (!empty(searchBlog.getInt("level")))
        {
            sql += " and level=" + searchBlog.getInt("level") + " ";
        }
        setAttr("blog", searchBlog);
        pagelist = Blog.me.adminPaginatListBlogs(getParaToInt("page", 1), 10,
                sql);
        List<Blog> blogs = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Blog b : blogs)
        {
            Map every = new HashMap();
            every.put("id", b.getInt("id"));
            every.put("user_id", b.getInt("user_id"));
            every.put("title", b.getStr("title"));
            every.put("ispublic", b.getInt("ispublic"));
            every.put("content_show", b.getStr("content_show"));
            every.put("keyword", b.getStr("keyword"));
            every.put("create_time", b.getDate("create_time"));
            every.put("level", b.getInt("level"));
            Blogcategory c = b.getBlogcategory();
            every.put("categorystr", c.getStr("category"));
            User blogUser = b.getUser();
            every.put("username", blogUser.getStr("username"));
            results.add(every);
        }
        setAttr("blogPage",
                new Page(results, pagelist.getPageNumber(),
                        pagelist.getPageSize(), pagelist.getTotalPage(),
                        pagelist.getTotalRow()));
        render("blogList.jsp");
    }

    public void gonggaoList()
    {
        List<Gonggao> list = Gonggao.me.listAll();
        setAttr("gonggaoList", list);
        render("gonggaoList.jsp");
    }

    public void gonggaoAdd()
    {
        render("gonggaoAdd.jsp");
    }

    public void gonggaoSave()
    {
        getFile();
        Gonggao gonggao = getModel(Gonggao.class, "gonggao");
        if (empty(gonggao.getStr("content")))
        {
            message = "公告内容不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (empty(gonggao.getStr("url")))
        {
            message = "公告URL不能为空,如果没有请填写‘#’";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (empty(gonggao.getInt("sn")))
        {
            gonggao.set("sn", 0);
            gonggao.set("type", 0);
            gonggao.set("deleted", 0);
            gonggao.set("create_time", new Date());
            gonggao.save();
            gonggao.set("sn", gonggao.getInt("id"));
            gonggao.update();
        }
        else
        {
            gonggao.set("type", 0);
            gonggao.set("deleted", 0);
            gonggao.set("create_time", new Date());
            gonggao.save();
        }
        message = "公告保存成功";
        setAttr("message", message);
        renderJsp("/WEB-INF/content/common/result.jsp");
        redirectionUrl = getRequest().getContextPath() + "/admins/gonggaoList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
        return;
    }

    public void refreshGonggao()
    {
        List<Gonggao> lsit = Gonggao.me.listAll();
        JFinal.me().getServletContext().removeAttribute("gonggao");
        JFinal.me().getServletContext().setAttribute("gonggao", lsit);
        message = "公告刷新成功";
        setAttr("message", message);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void gonggaoDelete()
    {
        int id = getParaToInt("id");
        if (empty(id))
        {
            message = "参数错误";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
        }
        Gonggao.me.deleteById(id);
        message = "公告删除成功";
        setAttr("message", message);
        renderJsp("/WEB-INF/content/common/result.jsp");
        redirectionUrl = getRequest().getContextPath() + "/admins/gonggaoList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void gonggaoEdit()
    {
        int id = getParaToInt("id");
        Gonggao gonggao = Gonggao.me.findById(id);
        if (empty(id) || empty(gonggao))
        {
            message = "参数错误或所指定的ID的公告不存在";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
        }
        setAttr("gonggao", gonggao);
        render("gonggaoEdit.jsp");
    }

    public void gonggaoUpdate()
    {
        getFile();
        Gonggao gonggao = getModel(Gonggao.class, "gonggao");
        if (empty(gonggao.getInt("id")))
        {
            message = "参数错误";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (empty(gonggao.getStr("content")))
        {
            message = "公告内容不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (empty(gonggao.getStr("url")))
        {
            message = "公告URL不能为空,如果没有请填写‘#’";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        Gonggao ug = Gonggao.me.findById(gonggao.getInt("id"));
        if (empty(gonggao.getInt("sn")))
        {
            ug.set("content", gonggao.getStr("content"));
            ug.set("url", gonggao.getStr("url"));
            ug.set("sn", ug.getInt("id"));
            ug.update();
        }
        else
        {
            ug.set("content", gonggao.getStr("content"));
            ug.set("url", gonggao.getStr("url"));
            ug.set("sn", gonggao.getInt("sn"));
            ug.update();
        }
        message = "公告编辑成功";
        setAttr("message", message);
        renderJsp("/WEB-INF/content/common/result.jsp");
        redirectionUrl = getRequest().getContextPath() + "/admins/gonggaoList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
        return;
    }

    // ===========================================================
    /**
     * 后台博客删除（标记删除）
     */
    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void blogDelete()
    {
        int id = getParaToInt("id");
        Blog b = Blog.me.findById(id);
        if (Utility.empty(b))
        {
            message = "该博客不存在！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        else
        {
            b.set("deleted", 1);
            b.update();
        }
        message = "删除成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/blogList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
        return;
    }

    /**
     * 从数据库直接删除
     */
    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void blogDel()
    {
        int id = getParaToInt("id");
        Blog b = Blog.me.findById(id);
        if (Utility.empty(b))
        {
            message = "该博客不存在！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        else
        {
            b.delete();
        }
        message = "删除成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath()
                + "/admins/blogDeletedList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
        return;
    }

    /**
     * 已删除的博客
     */
    public void blogDeletedList()
    {
        String sql = "";
        Blog searchBlog = getModel(Blog.class, "blog");
        Page<Blog> pagelist = null;
        if (!Utility.empty(searchBlog.getStr("title")))
        {
            String title = searchBlog.getStr("title");
            String titlelike = "";
            if (Utility.empty(title))
            {
                titlelike = "'%%'";
            }
            else
            {
                titlelike = "'%" + title + "%'";
            }
            sql += " and title like " + titlelike + " ";
        }
        String bozhu = getPara("bozhu");
        if (!empty(bozhu))
        {
            setAttr("bozhu", bozhu);
            List<User> userlist = User.me.findByUsername(bozhu);
            if ((!empty(userlist)) && userlist.size() >= 1)
            {
                User u = userlist.get(0);
                sql += " and user_id=" + u.getInt("id") + " ";
            }
        }
        if (!empty(searchBlog.getInt("ispublic")))
        {
            sql += " and ispublic=" + searchBlog.getInt("ispublic") + " ";
        }
        if (!empty(searchBlog.getInt("level")))
        {
            sql += " and level=" + searchBlog.getInt("level") + " ";
        }
        setAttr("blog", searchBlog);
        pagelist = Blog.me.adminPaginatListdeletedBlogs(getParaToInt("page", 1),
                10, sql);
        List<Blog> blogs = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Blog b : blogs)
        {
            Map every = new HashMap();
            every.put("id", b.getInt("id"));
            every.put("user_id", b.getInt("user_id"));
            every.put("title", b.getStr("title"));
            every.put("ispublic", b.getInt("ispublic"));
            every.put("content_show", b.getStr("content_show"));
            every.put("keyword", b.getStr("keyword"));
            every.put("create_time", b.getDate("create_time"));
            every.put("level", b.getInt("level"));
            Blogcategory c = b.getBlogcategory();
            every.put("categorystr", c.getStr("category"));
            User blogUser = b.getUser();
            every.put("username", blogUser.getStr("username"));
            results.add(every);
        }
        setAttr("blogPage",
                new Page(results, pagelist.getPageNumber(),
                        pagelist.getPageSize(), pagelist.getTotalPage(),
                        pagelist.getTotalRow()));
        render("blogDeletedList.jsp");
    }

    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void blogRecover()
    {
        int id = getParaToInt("id");
        Blog b = Blog.me.findById(id);
        b.set("deleted", 0);
        b.update();
        message = "博客恢复成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath()
                + "/admins/blogDeletedList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    /**
     * 跳转到博客等级修改页面
     */
    public void toBlogLevel()
    {
        int id = getParaToInt();
        Blog b = Blog.me.findById(id);
        renderJson(b);
    }

    /**
     * 修改博客等级
     */
    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void editBlogLevel()
    {
        int id = getParaToInt("id");
        int level = getParaToInt("level");
        Blog b = Blog.me.findById(id);
        b.set("level", level);
        b.update();
        message = "修改成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/blogList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    // ==================意见建议=====================
    public void adviceList()
    {
        Page<Advice> pagelist = Advice.me.paginate(getParaToInt("page", 1), 10);
        List<Advice> list = pagelist.getList();
        List<Advice> result = new ArrayList<Advice>();
        for (Advice a : list)
        {
            if (!empty(a.getInt("user_id")))
            {
                User u = User.me.findById(a.getInt("user_id"));
                a.put("username", u.getStr("username"));
            }
            String show = ToolWeb.HtmltoText(a.getStr("content"));
            if (show.length() > 30)
            {
                show = show.substring(0, 28) + "...";
            }
            a.put("content_show", show);
            result.add(a);

        }
        setAttr("advicePage",
                new Page(result, pagelist.getPageNumber(),
                        pagelist.getPageSize(), pagelist.getTotalPage(),
                        pagelist.getTotalRow()));
        render("adviceList.jsp");
    }

    public void adviceDelete()
    {
        int id = getParaToInt("id");
        if (empty(id))
        {
            message = "参数错误";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        Advice.me.deleteById(id);
        message = "删除成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/adviceList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void adviceDetail()
    {
        int id = getParaToInt("id");
        if (empty(id))
        {
            message = "参数错误";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        Advice advice = Advice.me.findById(id);
        if (!empty(advice.getInt("user_id")))
        {
            User u = User.me.findById(advice.getInt("user_id"));
            advice.put("username", u.getStr("username"));
        }
        setAttr("advice", advice);
        render("adviceDetail.jsp");

    }

    public void adviceRead()
    {
        int id = getParaToInt("id");
        if (empty(id))
        {
            message = "参数错误";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        Advice advice = Advice.me.findById(id);
        advice.set("isread", 1);
        advice.update();
        message = "标记成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/adviceList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    // ============================IP日志分析==================================
    public void iplogList()
    {
        String start = getPara("start");
        String end = getPara("end");
        String sql = " ";
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (!empty(start) && !" ".equals(start))
        {
            try
            {
                setAttr("startDate", sdf1.parse(start));
            }
            catch (Exception e)
            {
                message = "时间格式不正确";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            setAttr("start", start);
            sql = sql + " and create_time >='" + start + "'";
        }
        if (!empty(end) && !" ".equals(end))
        {
            try
            {
                setAttr("endDate", sdf1.parse(end));
            }
            catch (Exception e)
            {
                message = "时间格式不正确";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            setAttr("end", end);
            sql = sql + " and create_time <='" + end + "'";
        }
        if ((empty(start) || " ".equals(start))
                && (empty(end) || " ".equals(end)))
        {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date today = new Date();
            String day = sdf.format(today);
            start = "'" + day + " 00:00:00'";
            end = "'" + day + " 23:59:59'";
            sql = " and create_time>=" + start + " and create_time<=" + end;
        }
        Page<Iplog> pagelist = Iplog.me.paginate(getParaToInt("page", 1),
                getParaToInt("pageSize", 100), sql);
        setAttr("pageSize", getParaToInt("pageSize", 100));
        setAttr("iplogPage", pagelist);
        render("iplogList.jsp");
    }

    public void iplogIpSum()
    {
        String start = getPara("start");
        String end = getPara("end");
        String sql = "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (!empty(start) && !" ".equals(start))
        {
            try
            {
                setAttr("startDate", sdf.parse(start));
                setAttr("start", start);
            }
            catch (Exception e)
            {
                message = "时间格式不正确";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            start = start + " 00:00:00";
            sql = sql + " and create_time>='" + start + "'";
        }
        if (!empty(end) && !" ".equals(end))
        {
            try
            {
                setAttr("endDate", sdf.parse(end));
                setAttr("end", end);
            }
            catch (Exception e)
            {
                message = "时间格式不正确";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            end = end + " 23:59:59";
            sql = sql + " and create_time<='" + end + "'";
        }
        if ((empty(start) || " ".equals(start))
                && (empty(end) || " ".equals(end)))
        {
            Date today = new Date();
            String day = sdf.format(today);
            start = "'" + day + " 00:00:00'";
            end = "'" + day + " 23:59:59'";
            setAttr("endDate", today);
            setAttr("start", day);
            setAttr("end", day);
            setAttr("startDate", today);
            sql = " and create_time>=" + start + " and create_time<=" + end;
        }
        List<Record> list = Iplog.me.listIps(sql);
        setAttr("Ips", list);
        render("iplogIpSum.jsp");
    }

    public void iplogIpDetail()
    {
        String ip = getPara("ip");
        setAttr("ip", ip);
        String start = getPara("start");
        String end = getPara("end");
        String sql = "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (!empty(start) && !" ".equals(start))
        {
            try
            {
                setAttr("startDate", sdf.parse(start));
            }
            catch (Exception e)
            {
                message = "时间格式不正确";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            start = start + " 00:00:00";
            sql = sql + " and create_time>='" + start + "'";
        }
        if (!empty(end) && !" ".equals(end))
        {
            try
            {
                setAttr("endDate", sdf.parse(end));
            }
            catch (Exception e)
            {
                message = "时间格式不正确";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            end = end + " 23:59:59";
            sql = sql + " and create_time<='" + end + "'";
        }
        if ((empty(start) || " ".equals(start))
                && (empty(end) || " ".equals(end)))
        {
            Date today = new Date();
            String day = sdf.format(today);
            start = "'" + day + " 00:00:00'";
            end = "'" + day + " 23:59:59'";
            setAttr("endDate", today);
            setAttr("startDate", today);
            sql = " and create_time>=" + start + " and create_time<=" + end;
        }
        List<Iplog> list = Iplog.me.listIplogIpDetail(ip, sql);
        setAttr("Ips", list);
        render("iplogIpDetail.jsp");

    }

    // =============================系统监控日志================================
    public void resourcelogList()
    {
        String day = getPara("day");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date today = null;
        if (!empty(day) && !" ".equals(day))
        {
            try
            {
                today = sdf.parse(day);
            }
            catch (Exception e)
            {
                message = "时间格式不正确";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
        }
        else
        {
            today = new Date();
        }
        setAttr("day", today);
        String sql = "";
        // setAttr("end", end);
        sql = sql + " create_time like'" + sdf.format(today) + "%'";
        setAttr("dayStr", sdf.format(today));
        Page<Resourceslog> list = Resourceslog.me
                .paginate(getParaToInt("page", 1), 100, sql);
        setAttr("resourceslogPage", list);
        render("resourcelogList.jsp");
    }

    /**
     * 系统监控统计，此方法可以精简，没有时间做
     */
    public void resourcelogTongji()
    {
        String day = getPara("day");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH");
        Date now = new Date();
        if (!empty(day))
        {
            try
            {
                now = sdf.parse(day);
            }
            catch (ParseException e)
            {

            }
        }
        String next = getPara("next");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);
        if (!empty(next) && "1".equals(next))
        {
            calendar.add(Calendar.HOUR_OF_DAY, 1);
            now = calendar.getTime();
        }
        if (!empty(next) && "-1".equals(next))
        {
            calendar.add(Calendar.HOUR_OF_DAY, -1);
            now = calendar.getTime();
        }
        setAttr("day", now);
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        String start = sdf.format(now) + ":00:00";
        String end = sdf.format(now) + ":59:59";
        String sql = " and create_time>='" + start + "' and create_time<='"
                + end + "'";
        List<Resourceslog> list = Resourceslog.me.listTongji(sql);
        // x轴的时间
        List<String> xname = new ArrayList<String>();
        // cpu
        List<BigDecimal> ynameCPU = new ArrayList<BigDecimal>();
        List<Double> ynamePhymemory = new ArrayList<Double>();
        List<Double> ynamePhyusedmemory = new ArrayList<Double>();
        List<Double> ynameDiskmemory = new ArrayList<Double>();
        List<Double> ynameDiskusedmemory = new ArrayList<Double>();
        List<Double> ynameJVMtotal = new ArrayList<Double>();
        List<Double> ynameJVMused = new ArrayList<Double>();
        List<Double> ynameJVMsum = new ArrayList<Double>();
        List<Long> ynameGC = new ArrayList<Long>();
        SimpleDateFormat sdf1 = new SimpleDateFormat("mm:ss");
        for (Resourceslog rl : list)
        {
            xname.add(sdf1.format(rl.getDate("create_time")));
            ynameCPU.add(rl.getBigDecimal("cpuratio"));
            ynamePhymemory.add(rl.getLong("phymemory") / 1024.00);
            ynamePhyusedmemory
                    .add((rl.getLong("phymemory") - rl.getLong("phyfreememory"))
                            / 1024.00);
            ynameDiskmemory.add(rl.getLong("diskmemory") / 1024.00);
            ynameDiskusedmemory.add(
                    (rl.getLong("diskmemory") - rl.getLong("diskfreememory"))
                            / 1024.00);
            ynameJVMtotal.add(rl.getLong("jvmtotalmemory") / 1024.00);
            ynameJVMused.add(
                    (rl.getLong("jvmtotalmemory") - rl.getLong("jvmfreememory"))
                            / 1024.00);
            ynameJVMsum.add(rl.getLong("jvmmaxmemory") / 1024.00);
            ynameGC.add(rl.getLong("gccount"));
        }
        // CPU统计
        Option option = new Option();
        option.title(
                sdf.format(now) + " " + hour + "点段CPU使用率(X轴单位：分:秒。Y轴单位：%)");
        option.tooltip().trigger(Trigger.axis);
        option.tooltip().axisPointer().setType(PointerType.shadow);
        option.legend(new Legend("CPU"));
        option.toolbox().show(true).feature(Tool.dataView, Tool.restore,
                Tool.saveAsImage);
        option.calculable(true);
        option.getLegend().padding(40);
        option.xAxis(new CategoryAxis().data(xname.toArray()));
        List<Axis> xlist = option.getxAxis();
        for (int i = 0; i < xlist.size(); i++)
        {
            xlist.get(i).axisLabel().setRotate(60);
            xlist.get(i).axisLabel().setMargin(1);
            xlist.get(i).axisLabel().setTextStyle(
                    new TextStyle().fontWeight(FontWeight.bold));
            xlist.get(i).splitArea().show(true);
        }
        option.yAxis(new ValueAxis());
        Line l1 = new Line("CPU");
        l1.data(ynameCPU.toArray());
        option.series(l1);
        l1.markPoint().data(new PointData().type(MarkType.max).name("最大值"),
                new PointData().type(MarkType.min).name("最小值"));
        GsonUtil gu = new GsonUtil();
        setAttr("cpuTJ", gu.format(option));
        // 内存统计
        Option optionNeicun = new Option();
        optionNeicun.title(
                sdf.format(now) + " " + hour + "点段内存使用情况(X轴单位：分:秒。Y轴单位：GB)");
        optionNeicun.tooltip().trigger(Trigger.axis);
        optionNeicun.tooltip().axisPointer().setType(PointerType.shadow);
        optionNeicun.legend(new Legend("内存总量", "内存已使用总量"));
        optionNeicun.toolbox().show(true).feature(Tool.dataView, Tool.restore,
                Tool.saveAsImage);
        optionNeicun.calculable(true);
        optionNeicun.getLegend().padding(40);
        optionNeicun.xAxis(new CategoryAxis().data(xname.toArray()));
        List<Axis> xlistPhy = optionNeicun.getxAxis();
        for (int i = 0; i < xlist.size(); i++)
        {
            xlistPhy.get(i).axisLabel().setRotate(60);
            xlistPhy.get(i).axisLabel().setMargin(1);
            xlistPhy.get(i).axisLabel().setTextStyle(
                    new TextStyle().fontWeight(FontWeight.bold));
            xlistPhy.get(i).splitArea().show(true);
        }
        optionNeicun.yAxis(new ValueAxis());
        Line lPhy1 = new Line("内存总量");
        lPhy1.data(ynamePhymemory.toArray());
        Line lPhy2 = new Line("内存已使用总量");
        lPhy2.data(ynamePhyusedmemory.toArray());
        optionNeicun.series(lPhy1, lPhy2);
        lPhy2.markPoint().data(new PointData().type(MarkType.max).name("最大值"),
                new PointData().type(MarkType.min).name("最小值"));
        setAttr("phyTJ", gu.format(optionNeicun));
        // 硬盘统计
        Option optionDisk = new Option();
        optionDisk.title(
                sdf.format(now) + " " + hour + "点段硬盘使用情况(X轴单位：分:秒。Y轴单位：GB)");
        optionDisk.tooltip().trigger(Trigger.axis);
        optionDisk.tooltip().axisPointer().setType(PointerType.shadow);
        optionDisk.legend(new Legend("硬盘大小", "硬盘已使用"));
        optionDisk.toolbox().show(true).feature(Tool.dataView, Tool.restore,
                Tool.saveAsImage);
        optionDisk.calculable(true);
        optionDisk.getLegend().padding(40);
        optionDisk.xAxis(new CategoryAxis().data(xname.toArray()));
        List<Axis> xlistDisk = optionDisk.getxAxis();
        for (int i = 0; i < xlist.size(); i++)
        {
            xlistDisk.get(i).axisLabel().setRotate(60);
            xlistDisk.get(i).axisLabel().setMargin(1);
            xlistDisk.get(i).axisLabel().setTextStyle(
                    new TextStyle().fontWeight(FontWeight.bold));
            xlistDisk.get(i).splitArea().show(true);
        }
        optionDisk.yAxis(new ValueAxis());
        Line lDisk1 = new Line("硬盘大小");
        lDisk1.data(ynameDiskmemory.toArray());
        Line lDisk2 = new Line("硬盘已使用");
        lDisk2.data(ynameDiskusedmemory.toArray());
        optionDisk.series(lDisk1, lDisk2);
        lDisk2.markPoint().data(new PointData().type(MarkType.max).name("最大值"),
                new PointData().type(MarkType.min).name("最小值"));
        setAttr("diskTJ", gu.format(optionDisk));
        // JVM
        Option optionJVM = new Option();
        optionJVM.title(
                sdf.format(now) + " " + hour + "点段JVM使用情况(X轴单位：分:秒。Y轴单位：GB)");
        optionJVM.tooltip().trigger(Trigger.axis);
        optionJVM.tooltip().axisPointer().setType(PointerType.shadow);
        optionJVM.legend(new Legend("JVM总量", "JVM已使用", "JVM最大值"));
        optionJVM.toolbox().show(true).feature(Tool.dataView, Tool.restore,
                Tool.saveAsImage);
        optionJVM.calculable(true);
        optionJVM.getLegend().padding(40);
        optionJVM.xAxis(new CategoryAxis().data(xname.toArray()));
        List<Axis> xlistJVM = optionJVM.getxAxis();
        for (int i = 0; i < xlist.size(); i++)
        {
            xlistJVM.get(i).axisLabel().setRotate(60);
            xlistJVM.get(i).axisLabel().setMargin(1);
            xlistJVM.get(i).axisLabel().setTextStyle(
                    new TextStyle().fontWeight(FontWeight.bold));
            xlistJVM.get(i).splitArea().show(true);
        }
        optionJVM.yAxis(new ValueAxis());
        Line lJVM1 = new Line("JVM总量");
        lJVM1.data(ynameJVMtotal.toArray());
        Line lJVM2 = new Line("JVM已使用");
        lJVM2.data(ynameJVMused.toArray());
        Line lJVM3 = new Line("JVM最大值");
        lJVM3.data(ynameJVMsum.toArray());
        optionJVM.series(lJVM1, lJVM2, lJVM3);
        lDisk2.markPoint().data(new PointData().type(MarkType.max).name("最大值"),
                new PointData().type(MarkType.min).name("最小值"));
        setAttr("jvmTJ", gu.format(optionJVM));
        // gc
        Option optionGC = new Option();
        optionGC.title(
                sdf.format(now) + " " + hour + "点段GC次数(X轴单位：分:秒。Y轴单位：次)");
        optionGC.tooltip().trigger(Trigger.axis);
        optionGC.tooltip().axisPointer().setType(PointerType.shadow);
        optionGC.legend(new Legend("GC"));
        optionGC.toolbox().show(true).feature(Tool.dataView, Tool.restore,
                Tool.saveAsImage);
        optionGC.calculable(true);
        optionGC.getLegend().padding(40);
        optionGC.xAxis(new CategoryAxis().data(xname.toArray()));
        List<Axis> xlistGC = optionGC.getxAxis();
        for (int i = 0; i < xlist.size(); i++)
        {
            xlistGC.get(i).axisLabel().setRotate(60);
            xlistGC.get(i).axisLabel().setMargin(1);
            xlistGC.get(i).axisLabel().setTextStyle(
                    new TextStyle().fontWeight(FontWeight.bold));
            xlistGC.get(i).splitArea().show(true);
        }
        optionGC.yAxis(new ValueAxis());
        Line lGC = new Line("GC");
        lGC.data(ynameGC.toArray());
        optionGC.series(lGC);
        setAttr("gcTJ", gu.format(optionGC));
        render("resourcelogTongji.jsp");
    }

    // ============================首页图片推荐================================

    public void picRecommend()
    {
        List<Picrecommend> list = Picrecommend.me.listAll();
        setAttr("picRecommendList", list);
        render("picRecommend.jsp");
    }

    public void picRecommendAdd()
    {
        render("picRecommendAdd.jsp");
    }

    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void picRecommendSave()
    {
        getFile();
        UploadFile uf = getFile("upload");

        Picrecommend pic = getModel(Picrecommend.class, "pic");
        if (Utility.empty(uf))
        {
            message = "推荐图片不能为空！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        else
        {
            String[] suffixarr = uf.getFileName().split("\\.");
            String suffix = suffixarr[suffixarr.length - 1];
            String filename = UUID() + "." + suffix;
            uf.getFile().renameTo(new File(PathKit.getWebRootPath()
                    + "/attached/picrecommend/" + filename));
            pic.set("image", filename);
        }
        if (Utility.empty(pic.getStr("title")))
        {
            message = "推荐标题不能为空！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        pic.set("deleted", 0);
        pic.set("create_time", new Date());
        if (Utility.empty(pic.getInt("sn")))
        {
            pic.set("sn", 1);
            pic.save();
            pic.set("sn", pic.getInt("id"));
            pic.update();
        }
        else
        {
            pic.save();
        }
        message = "添加推荐成功";
        setAttr("message", message);
        renderJsp("/WEB-INF/content/common/result.jsp");
        redirectionUrl = getRequest().getContextPath()
                + "/admins/picRecommend/";
        setAttr("redirectionUrl", redirectionUrl);
        return;
    }

    public void picRecommendEdit()
    {
        int id = getParaToInt(0);
        if (Utility.empty(id))
        {
            message = "参数错误！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        Picrecommend pic = Picrecommend.me.findById(id);
        if (Utility.empty(pic))
        {
            message = "该推荐不存在！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        setAttr("pic", pic);
        render("picRecommendEdit.jsp");
    }

    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void picRecommendUpdate()
    {
        getFile();
        UploadFile uf = getFile("upload");

        Picrecommend pic = getModel(Picrecommend.class, "pic");
        Picrecommend old = Picrecommend.me.findById(pic.getInt("id"));
        if (Utility.empty(uf))
        {
            pic.set("image", old.getStr("image"));
        }
        else
        {
            String[] suffixarr = uf.getFileName().split("\\.");
            String suffix = suffixarr[suffixarr.length - 1];
            String filename = UUID() + "." + suffix;
            uf.getFile().renameTo(new File(PathKit.getWebRootPath()
                    + "/attached/picrecommend/" + filename));
            pic.set("image", filename);
        }
        if (Utility.empty(pic.getStr("title")))
        {
            message = "推荐标题不能为空！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        pic.set("deleted", old.getInt("deleted"));
        pic.set("create_time", old.getDate("create_time"));
        if (Utility.empty(pic.getInt("sn")))
        {
            pic.set("sn", pic.getInt("id"));
            pic.update();
        }
        else
        {
            pic.update();
        }
        message = "修改推荐成功";
        setAttr("message", message);
        renderJsp("/WEB-INF/content/common/result.jsp");
        redirectionUrl = getRequest().getContextPath()
                + "/admins/picRecommend/";
        setAttr("redirectionUrl", redirectionUrl);
        return;
    }

    /**
     * 首页推荐状态修改
     */
    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void picRecommendUpdateDeleted()
    {
        int id = getParaToInt("id");
        int deleted = getParaToInt("deleted");
        Picrecommend pic = Picrecommend.me.findById(id);
        pic.set("deleted", deleted);
        pic.update();
        message = "修改推荐状态成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath()
                + "/admins/picRecommend/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void picRecommendDelete()
    {
        int id = getParaToInt();
        Picrecommend pic = Picrecommend.me.findById(id);
        if (!empty(pic))
        {
            pic.delete();
        }
        message = "删除推荐成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath()
                + "/admins/picRecommend/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    // ===========================beauty====================================
    public void beautyList()
    {
        String sql = "";
        Beauty searchBeauty = getModel(Beauty.class, "beauty");
        Page<Beauty> pagelist = null;
        if (!Utility.empty(searchBeauty.getStr("title")))
        {
            String title = searchBeauty.getStr("title");
            String titlelike = "";
            if (Utility.empty(title))
            {
                titlelike = "'%%'";
            }
            else
            {
                titlelike = "'%" + title + "%'";
            }
            sql += " and title like " + titlelike + " ";
        }
        String bozhu = getPara("bozhu");
        if (!empty(bozhu))
        {
            setAttr("bozhu", bozhu);
            List<User> userlist = User.me.findByUsername(bozhu);
            if ((!empty(userlist)) && userlist.size() >= 1)
            {
                User u = userlist.get(0);
                sql += " and user_id=" + u.getInt("id") + " ";
            }
        }
        if (!empty(searchBeauty.getInt("level")))
        {
            sql += " and level=" + searchBeauty.getInt("level") + " ";
        }
        setAttr("beauty", searchBeauty);
        pagelist = Beauty.me.adminPaginatListBeautys(getParaToInt("page", 1),
                10, sql);
        List<Beauty> blogs = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Beauty b : blogs)
        {
            Map every = new HashMap();
            every.put("id", b.getInt("id"));
            every.put("user_id", b.getInt("user_id"));
            every.put("title", b.getStr("title"));
            every.put("keyword", b.getStr("keyword"));
            every.put("view", b.getInt("view"));
            every.put("level", b.getInt("level"));
            String img = b.getStr("img");
            Gson g = new GsonBuilder().create();
            Map<String, String> m = g.fromJson(img, Map.class);
            every.put("img", m);
            every.put("create_time", b.getDate("create_time"));
            User blogUser = b.getUser();
            every.put("username", blogUser.getStr("username"));
            String content_show = "";
            if (!empty(b.getStr("content")))
            {
                content_show = HtmlUtil.getNoHTMLString(
                        HtmlUtil.Decode(b.getStr("content")), 150);
            }
            every.put("content", content_show);
            results.add(every);
        }
        setAttr("beautyPage",
                new Page(results, pagelist.getPageNumber(),
                        pagelist.getPageSize(), pagelist.getTotalPage(),
                        pagelist.getTotalRow()));
        render("beautyList.jsp");
    }

    /**
     * 跳转到美图等级修改页面
     */
    public void toBeautyLevel()
    {
        int id = getParaToInt();
        Beauty b = Beauty.me.findById(id);
        renderJson(b);
    }

    /**
     * 修改美图等级
     */
    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void editBeautyLevel()
    {
        int id = getParaToInt("id");
        int level = getParaToInt("level");
        Beauty b = Beauty.me.findById(id);
        b.set("level", level);
        b.update();
        message = "修改成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/beautyList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void beautyDelete()
    {
        int id = getParaToInt();
        Beauty b = Beauty.me.findById(id);
        if (!empty(b))
        {
            b.delete();
        }
        message = "删除成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/beautyList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    // ==================================用户和权限===============================================

    /**
     * 后台用户列表
     */
    public void userList()
    {
        String sql = "";
        User searchUser = getModel(User.class, "user");
        setAttr("user", searchUser);
        Page<User> pagelist = null;
        if (!Utility.empty(searchUser.getStr("username")))
        {
            String title = searchUser.getStr("username");
            String usernamelike = "";
            if (Utility.empty(title))
            {
                usernamelike = "'%%'";
            }
            else
            {
                usernamelike = "'%" + title + "%'";
            }
            sql += " and username like " + usernamelike + " ";
        }
        if (!Utility.empty(searchUser.getStr("realname")))
        {
            String title = searchUser.getStr("realname");
            String realnamelike = "";
            if (Utility.empty(title))
            {
                realnamelike = "'%%'";
            }
            else
            {
                realnamelike = "'%" + title + "%'";
            }
            sql += " and realname like " + realnamelike + " ";
        }
        if (!empty(searchUser.getInt("type")))
        {
            sql += " and type=" + searchUser.getInt("type") + " ";
        }

        pagelist = User.me.adminPaginatListUsers(getParaToInt("page", 1), 10,
                sql);
        List<User> users = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (User u : users)
        {
            Map every = new HashMap();
            every.put("id", u.getInt("id"));
            Userrole ur = Userrole.me.findByUserId(u.getInt("id"));
            if (empty(ur))
            {
                every.put("role", "无");
            }
            else
            {
                every.put("role", Role.me.findById(ur.getInt("role_id"))
                        .getStr("role_name"));
            }
            every.put("username", u.getStr("username"));
            every.put("realname", u.getStr("realname"));
            every.put("create_time", u.getDate("create_time"));
            every.put("type", u.getInt("type"));
            results.add(every);
        }
        setAttr("userPage",
                new Page(results, pagelist.getPageNumber(),
                        pagelist.getPageSize(), pagelist.getTotalPage(),
                        pagelist.getTotalRow()));
        render("userList.jsp");
    }

    /**
     * 封禁用户
     */
    public void userDelete()
    {
        int id = getParaToInt("id");
        User u = User.me.findById(id);
        if (u.getStr("username").equals("admin"))
        {
            message = "超级管理员不允许删除";
            setAttr("message", message);
            redirectionUrl = getRequest().getContextPath()
                    + "/admins/userList/";
            setAttr("redirectionUrl", redirectionUrl);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        else
        {

            u.set("deleted", 1);
            u.update();
            message = "封禁用户成功";
            setAttr("message", message);
            redirectionUrl = getRequest().getContextPath()
                    + "/admins/userList/";
            setAttr("redirectionUrl", redirectionUrl);
            renderJsp("/WEB-INF/content/common/result.jsp");
        }
    }

    /**
     * 已封禁的用户
     */

    public void listDeletedUsers()
    {
        String sql = "";
        User searchUser = getModel(User.class, "user");
        setAttr("user", searchUser);
        if (!Utility.empty(searchUser.getStr("username")))
        {
            String title = searchUser.getStr("username");
            String usernamelike = "";
            if (Utility.empty(title))
            {
                usernamelike = "'%%'";
            }
            else
            {
                usernamelike = "'%" + title + "%'";
            }
            sql += " and username like " + usernamelike + " ";
        }
        if (!Utility.empty(searchUser.getStr("realname")))
        {
            String title = searchUser.getStr("realname");
            String realnamelike = "";
            if (Utility.empty(title))
            {
                realnamelike = "'%%'";
            }
            else
            {
                realnamelike = "'%" + title + "%'";
            }
            sql += " and realname like " + realnamelike + " ";
        }
        if (!empty(searchUser.getInt("type")))
        {
            sql += " and type=" + searchUser.getInt("type") + " ";
        }
        Page<User> pagelist = null;
        pagelist = User.me.adminListDeletedUses(getParaToInt("page", 1), 10,
                sql);
        List<User> users = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (User u : users)
        {
            Map every = new HashMap();
            every.put("id", u.getInt("id"));
            every.put("username", u.getStr("username"));
            every.put("realname", u.getStr("realname"));
            every.put("create_time", u.getDate("create_time"));
            every.put("type", u.getInt("type"));
            results.add(every);
        }
        setAttr("userPage",
                new Page(results, pagelist.getPageNumber(),
                        pagelist.getPageSize(), pagelist.getTotalPage(),
                        pagelist.getTotalRow()));
        render("listDeletedUsers.jsp");
    }

    /**
     * 解封用户
     */
    public void userRecover()
    {
        int id = getParaToInt("id");
        User u = User.me.findById(id);

        u.set("deleted", 0);
        u.update();
        message = "解封用户成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath()
                + "/admins/listDeletedUsers/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void userRoleEdit()
    {
        int id = getParaToInt("id");
        User u = User.me.findById(id);
        List<Role> roleList = Role.me.listRole();
        Userrole userrole = Userrole.me.findByUserId(id);
        Map m = new HashMap();
        m.put("id", u.getInt("id"));
        m.put("username", u.getStr("username"));
        m.put("roleList", roleList);
        if (!empty(userrole))
        {
            m.put("userrole", userrole);
        }
        renderJson(m);
    }

    /**
     * 用户角色修改和新建
     */
    public void userRoleSave()
    {
        int userId = getParaToInt("id");
        int roleId = getParaToInt("roleId");
        if (empty(userId) || empty(roleId))
        {
            message = "参数错误";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        Userrole ur = Userrole.me.findByUserId(userId);
        if (empty(ur) && roleId != 0)
        {
            Userrole userrole = new Userrole();
            userrole.set("user_id", userId);
            userrole.set("role_id", roleId);
            userrole.set("create_time", new Date());
            userrole.save();
        }
        if (!empty(ur))
        {
            if (roleId == 0)
            {
                ur.delete();
            }
            else
            {
                ur.set("role_id", roleId);
                ur.update();
            }
        }
        message = "用户角色修改成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/userList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    // ============================视频管理======================================
    public void videoList()
    {
        String sql = "";
        Video searchVideo = getModel(Video.class, "video");
        Page<Video> pagelist = null;
        if (!Utility.empty(searchVideo.getStr("title")))
        {
            String title = searchVideo.getStr("title");
            String titlelike = "";
            if (Utility.empty(title))
            {
                titlelike = "'%%'";
            }
            else
            {
                titlelike = "'%" + title + "%'";
            }
            sql += " and title like " + titlelike + " ";
        }
        String bozhu = getPara("bozhu");
        if (!empty(bozhu))
        {
            setAttr("bozhu", bozhu);
            List<User> userlist = User.me.findByUsername(bozhu);
            if ((!empty(userlist)) && userlist.size() >= 1)
            {
                User u = userlist.get(0);
                sql += " and user_id=" + u.getInt("id") + " ";
            }
        }
        if (!empty(searchVideo.getInt("level")))
        {
            sql += " and level=" + searchVideo.getInt("level") + " ";
        }
        setAttr("video", searchVideo);
        pagelist = Video.me.adminPaginatListVideos(getParaToInt("page", 1), 10,
                sql);
        List<Video> videos = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Video v : videos)
        {
            Map every = new HashMap();
            every.put("id", v.getInt("id"));
            every.put("user_id", v.getInt("user_id"));
            every.put("title", v.getStr("title"));
            every.put("keyword", v.getStr("keyword"));
            every.put("create_time", v.getDate("create_time"));
            every.put("level", v.getInt("level"));
            User videoUser = v.getUser();
            every.put("username", videoUser.getStr("username"));
            results.add(every);
        }
        setAttr("videoPage",
                new Page(results, pagelist.getPageNumber(),
                        pagelist.getPageSize(), pagelist.getTotalPage(),
                        pagelist.getTotalRow()));
        render("videoList.jsp");
    }

    public void toVideoLevel()
    {
        int id = getParaToInt();
        Video v = Video.me.findById(id);
        renderJson(v);
    }

    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void editVideoLevel()
    {
        int id = getParaToInt("id");
        int level = getParaToInt("level");
        Video v = Video.me.findById(id);
        v.set("level", level);
        v.update();
        message = "修改成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/videoList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    @Before(EvictInterceptor.class)
    @CacheName("index")
    public void videoDelete()
    {
        int id = getParaToInt();
        Video v = Video.me.findById(id);
        if (!empty(v))
        {
            v.delete();
        }
        message = "删除成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/videoList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    // =============================友情链接==================================
    public void linkList()
    {
        List<Link> list = Link.me.listAll();
        setAttr("linkList", list);
        render("linkList.jsp");
    }

    public void linkAdd()
    {
        render("linkAdd.jsp");
    }

    public void linkSave()
    {
        getFile();
        Link link = getModel(Link.class, "link");
        link.set("create_time", new Date());
        if (empty(link.getInt("sn")))
        {
            link.set("sn", 1);
            link.save();
            link.set("sn", link.getInt("id"));
            link.update();
        }
        else
        {
            link.save();
        }
        message = "新建成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/linkList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void linkEdit()
    {
        int id = getParaToInt();
        Link link = Link.me.findById(id);
        setAttr("link", link);
        render("linkEdit.jsp");
    }

    public void linkUpdate()
    {
        getFile();
        Link link = getModel(Link.class, "link");
        Link old = Link.me.findById(link.getInt("id"));
        if (empty(link.getInt("sn")))
        {
            link.set("sn", link.getInt("id"));
            link.set("create_time", old.getDate("create_time"));
            link.update();
        }
        else
        {
            link.set("create_time", old.getDate("create_time"));
            link.update();
        }
        message = "编辑成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/linkList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void linkDelete()
    {
        int id = getParaToInt();
        Link.me.deleteById(id);
        message = "删除成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/linkList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void linkRefresh()
    {
        List<Link> list = Link.me.listAll();
        JFinal.me().getServletContext().removeAttribute("systemListLink");
        JFinal.me().getServletContext().setAttribute("systemListLink", list);
        message = "刷新缓存成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/admins/linkList/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }
}
