
package com.fly.controller.beauty;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.fly.common.Constants;
import com.fly.controller.BaseController;
import com.fly.entity.Beauty;
import com.fly.entity.User;
import com.fly.interceptor.EditOpenInterceptor;
import com.fly.interceptor.LoginInterceptor;
import com.fly.util.ClearTemp;
import com.fly.util.HtmlUtil;
import com.fly.util.ImageUtil;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.jfinal.aop.Before;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.upload.UploadFile;

public class BeautyController extends BaseController
{
    public void index()
    {
        Page<Beauty> beautylist = null;

        beautylist = Beauty.me.paginate(getParaToInt("page", 1), 10);
        setAttr("ranktype", "default");
        List<Beauty> beautys = beautylist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Beauty b : beautys)
        {
            Map every = new HashMap();
            every.put("id", b.getInt("id"));
            every.put("user_id", b.getInt("user_id"));
            every.put("title", b.getStr("title"));
            every.put("keyword", b.getStr("keyword"));
            every.put("view", b.getInt("view"));
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
                        HtmlUtil.Decode(b.getStr("content")), 100);
            }
            every.put("content", content_show);
            results.add(every);
        }
        setAttr("beautyPage",
                new Page(results, beautylist.getPageNumber(),
                        beautylist.getPageSize(), beautylist.getTotalPage(),
                        beautylist.getTotalRow()));
        render("beauty.jsp");
    }

    @Before({LoginInterceptor.class, EditOpenInterceptor.class})
    public void add()
    {
        render("add.jsp");
    }

    @Before({LoginInterceptor.class, EditOpenInterceptor.class})
    public void save()
    {
        Gson g = new GsonBuilder().create();
        String imgurl = getPara("imgurl").replaceAll("&quot;", "\"");
        Map<String, String> imgurlMap = g.fromJson(imgurl, Map.class);
        String imgcontent = getPara("imgcontent").replaceAll("&quot;", "\"");
        Map<String, String> imgcontentMap = g.fromJson(imgcontent, Map.class);
        String beautytitle = getPara("beautytitle");
        if (empty(beautytitle))
        {
            renderJson(2);
            return;
        }
        String beautykeyword = getPara("beautykeyword");
        String beautycontent = getPara("beautycontent");
        Map<String, String> imgRes = new LinkedHashMap<String, String>();
        for (Map.Entry<String, String> entry : imgurlMap.entrySet())
        {
            if (empty(entry.getValue()))
            {
                continue;
            }
            else
            {
                String con = imgcontentMap.get(entry.getKey());
                if (empty(con))
                {
                    con = "";
                }
                imgRes.put(entry.getValue(), con);
            }
        }
        if (imgRes.size() == 0)
        {
            renderJson(3);
            return;
        }
        List<String> list = new ArrayList<String>();
        Beauty beauty = new Beauty();
        beauty.set("user_id",
                Constants.getLoginUser(getSession()).getInt("id"));
        beauty.set("title", beautytitle);
        beauty.set("img", g.toJson(imgRes));
        beauty.set("content", beautycontent);
        beauty.set("view", 0);
        beauty.set("level", 0);
        beauty.set("create_time", new Date());
        beauty.set("keyword", beautykeyword);
        beauty.save();
        renderJson(1);
    }

    public void saveBeauty()
    {
        UploadFile uploadFile = getFile();
        Map<String, String> map = new HashMap<String, String>();
        String[] suffixarr = uploadFile.getFileName().split("\\.");
        String suffix = suffixarr[suffixarr.length - 1];
        String fileNmae = UUID() + "." + suffix;
        File des = new File(
                PathKit.getWebRootPath() + "/attached/beauty/" + fileNmae);
        uploadFile.getFile().renameTo(des);
        ClearTemp.clear();
        String path = PathKit.getWebRootPath() + "/attached/beauty/";
        String saveFilename = path + fileNmae;
        try
        {
            ImageUtil.resize(180, 150, saveFilename, path + "s_" + fileNmae);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        renderJson(fileNmae);
    }

    public void detail()
    {
        int id = getParaToInt();
        Beauty beauty = Beauty.me.findById(id);
        beauty.set("view", beauty.getInt("view") + 1);
        beauty.update();
        beauty.set("content", HtmlUtil.Decode(beauty.getStr("content")));
        User bozhu = User.me.findById(beauty.getInt("user_id"));
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
        setAttr("beauty", beauty);
        String img = beauty.getStr("img");
        Gson g = new GsonBuilder().create();
        Map<String, String> m = g.fromJson(img, Map.class);
        setAttr("beautyImg", m);
        render("detail.jsp");
    }

    @Before({LoginInterceptor.class})
    public void myBeauty()
    {
        Page<Beauty> beautylist = null;
        User user = Constants.getLoginUser(getSession());
        beautylist = Beauty.me.myBeautyPaginate(getParaToInt("page", 1), 10,
                user.getInt("id"));
        setAttr("ranktype", "default");
        List<Beauty> beautys = beautylist.getList();
        List<Map> results = new ArrayList<Map>();
        for (Beauty b : beautys)
        {
            Map every = new HashMap();
            every.put("id", b.getInt("id"));
            every.put("user_id", b.getInt("user_id"));
            every.put("title", b.getStr("title"));
            every.put("keyword", b.getStr("keyword"));
            every.put("view", b.getInt("view"));
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
                        HtmlUtil.Decode(b.getStr("content")), 100);
            }
            every.put("content", content_show);
            results.add(every);
        }
        setAttr("beautyPage",
                new Page(results, beautylist.getPageNumber(),
                        beautylist.getPageSize(), beautylist.getTotalPage(),
                        beautylist.getTotalRow()));
        render("myBeauty.jsp");
    }

    public void delete()
    {
        int id = getParaToInt();
        Beauty beauty = Beauty.me.findById(id);
        if (empty(id) || empty(beauty))
        {
            message = "参数错误";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        User user = Constants.getLoginUser(getSession());
        if (user.getInt("id").intValue() != beauty.getInt("user_id").intValue())
        {
            message = "非法操作";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        Beauty.me.deleteById(id);
        message = "删除成功";
        setAttr("message", message);
        redirectionUrl = getSession().getServletContext().getContextPath()
                + "/beauty/myBeauty/";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
        return;
    }
}
