
package com.fly.controller.blog;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fly.common.Constants;
import com.fly.controller.BaseController;
import com.fly.entity.Blog;
import com.fly.entity.Blogcategory;
import com.fly.entity.User;
import com.fly.interceptor.EditOpenInterceptor;
import com.fly.interceptor.LoginInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.upload.UploadFile;

@Before(BlogInterceptor.class)
public class BlogController extends BaseController
{

    public void index()
    {
        String rankType = getPara("ranktype");
        Page<Blog> pagelist = null;
        if (!empty(rankType) && "latest".equals(rankType))
        {
            pagelist = Blog.me.paginateLatest(getParaToInt("page", 1), 10);
            setAttr("ranktype", "latest");
        }
        else if (!empty(rankType) && "hot".equals(rankType))
        {
            pagelist = Blog.me.paginateHot(getParaToInt("page", 1), 10);
            setAttr("ranktype", "hot");
        }
        else
        {
            pagelist = Blog.me.paginate(getParaToInt(0, 1), 10);
            setAttr("ranktype", "default");
        }
        List<Blog> blogs = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Blog b : blogs)
        {
            Map every = new HashMap();
            every.put("id", b.getInt("id"));
            every.put("user_id", b.getInt("user_id"));
            every.put("title", b.getStr("title"));
            String content_show = b.getStr("content_show");
            if (!empty(content_show) && content_show.length() > 100)
            {
                content_show = content_show.substring(0, 100);
            }
            every.put("content_show", content_show);
            every.put("keyword", b.getStr("keyword"));
            every.put("category", b.getInt("category"));
            every.put("view", b.getInt("view"));
            every.put("image", b.getStr("image"));
            every.put("create_time", b.getDate("create_time"));
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
        render("blog.jsp");
    }

    @Before(LoginInterceptor.class)
    public void myblog()
    {
        User u = Constants.getLoginUser(getSession());
        Page<Blog> pagelist = Blog.me.paginateMyBlog(getParaToInt(0, 1), 10,
                u.getInt("id"));
        List<Blog> blogs = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Blog b : blogs)
        {
            Map every = new HashMap();
            every.put("id", b.getInt("id"));
            every.put("user_id", b.getInt("user_id"));
            every.put("title", b.getStr("title"));
            String content_show = b.getStr("content_show");
            if (!empty(content_show) && content_show.length() > 100)
            {
                content_show = content_show.substring(0, 100);
            }
            every.put("content_show", content_show);
            every.put("keyword", b.getStr("keyword"));
            every.put("category", b.getInt("category"));
            every.put("view", b.getInt("view"));
            every.put("image", b.getStr("image"));
            every.put("create_time", b.getDate("create_time"));
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
        renderJsp("myblog.jsp");
    }

    @Before({LoginInterceptor.class, EditOpenInterceptor.class})
    public void add()
    {
        setAttr("listBlogcategory", Constants.listBlogcategory);
        if (empty(getSession().getAttribute(Constants.BLOGEDITORTYPE))
                || (Integer.valueOf(
                        getSession().getAttribute(Constants.BLOGEDITORTYPE)
                                .toString()) == 0))
        {
            render("add.jsp");
            return;
        }
        else if (Integer.valueOf(getSession()
                .getAttribute(Constants.BLOGEDITORTYPE).toString()) == 1)
        {
            render("addueditor.jsp");
            return;
        }
        render("add.jsp");
    }

    @Before({LoginInterceptor.class, BlogValidator.class,
            EditOpenInterceptor.class})
    public void save()
    {
        User user = Constants.getLoginUser(getSession());
        if (empty(user))
        {
            redirect("/index");
            return;
        }
        Blog b = getModel(Blog.class);
        UploadFile file = getFile("upload");
        try
        {
            if (!empty(file))
            {
                String uploadContentType = file.getContentType();
                if (!uploadContentType.equals("image/png")
                        && !uploadContentType.equals("image/jpeg")
                        && !uploadContentType.equals("image/pjpeg")
                        && !uploadContentType.equals("image/x-png"))
                {
                    message = "上传文件类型不符合要求，暂时只支持png和jpg的图片。";
                    setAttr("message", message);
                    renderJsp("/WEB-INF/content/common/result.jsp");
                    return;
                }
                else
                {
                    String[] suffixarr = file.getFileName().split("\\.");
                    String suffix = suffixarr[suffixarr.length - 1];
                    String filename = UUID() + "." + suffix;
                    file.getFile().renameTo(new File(PathKit.getWebRootPath()
                            + "/attached/blog/" + filename));
                    b.set("image", filename);
                }
            }

        }
        catch (Exception e)
        {
            message = "文件上传发生异常，请排除原因后再试";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        finally
        {
            if (!empty(file))
            {
                File oldfile = file.getFile();
                if (oldfile.exists())
                {
                    oldfile.delete();
                }
            }
        }
        b.set("create_time", new Date());
        b.set("user_id", user.get("id"));
        b.set("view", 0);
        b.set("type", 0);
        b.set("deleted", 0);
        b.set("type", 0);
        if (b.getInt("zhuanzai") == 0)
        {
            b.set("zhuanzaiurl", "");
        }
        b.save();
        redirect("/blog/myblog");
    }

    @Before({LoginInterceptor.class})
    public void edit()
    {
        Blog b = Blog.me.findById(getParaToInt());
        User u = Constants.getLoginUser(getSession());
        if (b.getInt("user_id").intValue() != u.getInt("id").intValue())
        {
            message = "您进行了非法操作！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        setAttr("listBlogcategory", Constants.listBlogcategory);
        setAttr("blog", b);
        if (b.getInt("editortype") == 1)
        {
            renderJsp("editueditor.jsp");
            return;
        }
        render("edit.jsp");
    }

    public void detail()
    {
        Blog b = Blog.me.findById(getParaToInt());
        User u = Constants.getLoginUser(getSession());
        User bozhu = User.me.findById(b.getInt("user_id"));
        if (empty(u))
        {
            if (b.getInt("ispublic") == 0)
            {
                message = "您进行了非法操作！";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
        }
        else
        {
            if (b.getInt("ispublic") == 0 && u.getInt("id").intValue() != b
                    .getInt("user_id").intValue())
            {
                message = "您进行了非法操作！";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
        }
        if (b.getInt("deleted") == 1)
        {
            message = "您进行了非法操作！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        setAttr("blog", b);
        String avatar = bozhu.getStr("avatar");
        if (empty(avatar))
        {
            avatar = "default.jpg";
        }
        else
        {
            File f = new File(
                    PathKit.getWebRootPath() + "/attached/avatar/" + avatar);
            if (!f.exists())
            {
                avatar = "default.jpg";
            }
        }
        bozhu.set("avatar", avatar);
        setAttr("bozhu", bozhu);
        int view = 0;
        if (!empty(b.getInt("view")))
        {
            view = b.getInt("view");
        }
        b.set("view", view + 1);
        b.update();
        if (b.getInt("editortype") == 1)
        {
            renderJsp("detailueditor.jsp");
            return;
        }
        else
        {
            renderJsp("detail.jsp");
            return;
        }

    }

    @Before({LoginInterceptor.class, BlogValidator.class})
    public void update()
    {
        Blog b = getModel(Blog.class);
        User u = Constants.getLoginUser(getSession());
        if (b.getInt("user_id").intValue() != u.getInt("id").intValue())
        {
            message = "您进行了非法操作！";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        UploadFile file = getFile("upload");
        try
        {
            if (!empty(file))
            {
                String uploadContentType = file.getContentType();
                if (!uploadContentType.equals("image/png")
                        && !uploadContentType.equals("image/jpeg")
                        && !uploadContentType.equals("image/pjpeg")
                        && !uploadContentType.equals("image/x-png"))
                {
                    message = "上传文件类型不符合要求，暂时只支持png和jpg的图片。";
                    setAttr("message", message);
                    renderJsp("/WEB-INF/content/common/result.jsp");
                    return;
                }
                else
                {
                    String[] suffixarr = file.getFileName().split("\\.");
                    String suffix = suffixarr[suffixarr.length - 1];
                    String filename = UUID() + "." + suffix;
                    file.getFile().renameTo(new File(PathKit.getWebRootPath()
                            + "/attached/blog/" + filename));
                    b.set("image", filename);
                }
            }

        }
        catch (Exception e)
        {
            message = "文件上传发生异常，请排除原因后再试";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        finally
        {
            if (!empty(file))
            {
                File oldfile = file.getFile();
                if (oldfile.exists())
                {
                    oldfile.delete();
                }
            }
        }
        b.update();
        redirect("/blog");
    }

    @Before({LoginInterceptor.class})
    public void delete()
    {
        Blog b = Blog.me.findById(getParaToInt(0));
        User u = Constants.getLoginUser(getSession());
        if (b.getInt("user_id").intValue() != u.getInt("id").intValue())
        {
            message = "您进行了非法操作！请尝试重新登录后再操作。";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        b.delete();
        redirect("/blog/myblog");
    }

    public void categorySearcher()
    {
        int category = getParaToInt("category");
        Page<Blog> pagelist = Blog.me
                .paginateBycategory(getParaToInt("page", 1), 10, category);
        List<Blog> blogs = pagelist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Blog b : blogs)
        {
            Map every = new HashMap();
            every.put("id", b.getInt("id"));
            every.put("user_id", b.getInt("user_id"));
            every.put("title", b.getStr("title"));
            every.put("content_show", b.getStr("content_show"));
            every.put("keyword", b.getStr("keyword"));
            every.put("category", b.getInt("category"));
            every.put("view", b.getInt("view"));
            every.put("image", b.getStr("image"));
            every.put("create_time", b.getDate("create_time"));
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
        setAttr("category", category);
        return;
    }

    @Before({LoginInterceptor.class})
    public void changeedit()
    {

        setAttr("listBlogcategory", Constants.listBlogcategory);
        int editortype = getParaToInt(0);
        if (editortype == 0)
        {
            if (empty(getSession().getAttribute(Constants.BLOGEDITORTYPE)))
            {
                getSession().setAttribute(Constants.BLOGEDITORTYPE, 0);
            }
            else
            {
                getSession().removeAttribute(Constants.BLOGEDITORTYPE);
                getSession().setAttribute(Constants.BLOGEDITORTYPE, 0);
            }
            renderJsp("add.jsp");
            return;
        }
        else
        {
            if (empty(getSession().getAttribute(Constants.BLOGEDITORTYPE)))
            {
                getSession().setAttribute(Constants.BLOGEDITORTYPE, 1);
            }
            else
            {
                getSession().removeAttribute(Constants.BLOGEDITORTYPE);
                getSession().setAttribute(Constants.BLOGEDITORTYPE, 1);
            }
            renderJsp("addueditor.jsp");
            return;
        }
    }
}
