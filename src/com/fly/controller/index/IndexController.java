
package com.fly.controller.index;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import com.fly.common.Constants;
import com.fly.controller.BaseController;
import com.fly.entity.Advice;
import com.fly.entity.Beauty;
import com.fly.entity.Blog;
import com.fly.entity.Blogcategory;
import com.fly.entity.Picrecommend;
import com.fly.entity.Qquser;
import com.fly.entity.Role;
import com.fly.entity.User;
import com.fly.entity.Userlogininfo;
import com.fly.entity.Userrole;
import com.fly.entity.Video;
import com.fly.util.HtmlUtil;
import com.fly.util.Utility;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;
import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.oauth.Oauth;

/**
 * IndexController
 */
public class IndexController extends BaseController
{
    public void index()
    {
        List<Map> blogList = CacheKit.get("index", "blogList");
        if (empty(blogList))
        {
            blogList = new ArrayList<Map>();
            List<Blog> blogs = Blog.me.indexCache();
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
                blogList.add(every);
            }
            CacheKit.put("index", "blogList", blogList);
        }
        setAttr("blogList", blogList);
        // 美图
        List<Map> beautyList = CacheKit.get("index", "beautylist");
        if (empty(beautyList))
        {
            beautyList = new ArrayList<Map>();
            List<Beauty> beautys = Beauty.me.indexCache();
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
                beautyList.add(every);
            }
            CacheKit.put("index", "beautylist", beautyList);
        }
        setAttr("beautyList", beautyList);
        // 首页图片推荐

        List<Picrecommend> listPicRecommend = CacheKit.get("index",
                "picRecommendList");
        if (empty(listPicRecommend))
        {
            listPicRecommend = Picrecommend.me.listIndex();
            CacheKit.put("index", "picRecommendList", listPicRecommend);
        }
        setAttr("picRecommendList", listPicRecommend);
        // 首页视频推荐
        List<Video> videoList = CacheKit.get("index", "videoList");
        if (empty(videoList))
        {
            videoList = Video.me.indexCache();
            CacheKit.put("index", "videoList", videoList);
        }
        setAttr("videoList", videoList);
        render("index.jsp");
    }

    public void qqlogin()
    {

        try
        {
            redirect(new Oauth().getAuthorizeURL(getRequest()));
        }
        catch (QQConnectException e)
        {
            e.printStackTrace();
        }
    }

    public void qqcallback()
    {
        HttpServletRequest request = getRequest();
        try
        {
            AccessToken accessTokenObj = (new Oauth())
                    .getAccessTokenByRequest(request);

            String accessToken = null, openID = null;
            long tokenExpireIn = 0L;

            if (accessTokenObj.getAccessToken().equals(""))
            {
                // 我们的网站被CSRF攻击了或者用户取消了授权
                // 做一些数据统计工作
                setAttr("islogin", "0");
                setAttr("errormsg", "没有获取到响应参数");
                render("index.jsp");
                return;
            }
            else
            {
                accessToken = accessTokenObj.getAccessToken();
                tokenExpireIn = accessTokenObj.getExpireIn();

                request.getSession().setAttribute("demo_access_token",
                        accessToken);
                request.getSession().setAttribute("demo_token_expirein",
                        String.valueOf(tokenExpireIn));

                // 利用获取到的accessToken 去获取当前用的openid -------- start
                OpenID openIDObj = new OpenID(accessToken);
                openID = openIDObj.getUserOpenID();
                request.getSession().setAttribute("useropenid", openID);
                Qquser qquser = new Qquser();
                qquser = Qquser.me.findFirst(
                        "select * from qquser where openid=?", openID);
                if (qquser == null)
                {
                    if (!"1".equals(PropKit.get("systemRegisterOpen")))
                    {
                        message = "本站暂时不开放新用户注册和登陆";
                        setAttr("message", message);
                        renderJsp("/WEB-INF/content/common/result.jsp");
                        return;
                    }
                    UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
                    UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
                    User user = new User();
                    User maxuser = User.me.findFirst(
                            "select * from user where id=(select max(id) from user)");
                    int max = 0;
                    if (maxuser != null)
                    {
                        max = maxuser.getInt("id");
                    }
                    user.set("username", "qq_" + (1000 + max + 1));
                    user.set("uuid",
                            UUID.randomUUID().toString().replaceAll("-", ""));
                    user.set("create_time", new Date());
                    user.set("deleted", 0);
                    user.set("type", 1);
                    // ----------------------------
                    if (!empty(userInfoBean.getNickname()))
                    {
                        if (userInfoBean.getNickname().length() > 6)
                        {
                            user.set("realname",
                                    userInfoBean.getNickname().substring(0, 6));
                        }
                        else
                        {
                            user.set("realname", userInfoBean.getNickname());
                        }
                    }
                    user.set("avatar",
                            userInfoBean.getAvatar().getAvatarURL100());

                    int sex = 0;
                    String sexstr = userInfoBean.getGender();
                    if (!"".equals(sexstr))
                    {
                        if ("男".equals(sexstr))
                        {
                            sex = 0;
                        }
                        else if ("女".equals(sexstr))
                        {
                            sex = 1;
                        }
                    }
                    user.set("sex", sex);
                    user.save();
                    Role role = Role.me.findByRoleName("user");
                    if (!empty(role))
                    {
                        Userrole userrole = new Userrole();
                        userrole.set("user_id", user.getInt("id"));
                        userrole.set("role_id", role.getInt("id"));
                        userrole.set("create_time", new Date());
                        userrole.save();
                    }
                    Qquser newqquser = new Qquser();
                    newqquser.set("openid", openID);
                    newqquser.set("user_id", user.getInt("id"));
                    newqquser.save();
                    // 存到session中
                    getSession().setAttribute(Constants.LOGINUSER, user);
                    message = "QQ登陆成功，请先完善一下自己的资料吧！<br/>(*＾-＾*)";
                    setAttr("message", message);
                    redirectionUrl = getRequest().getContextPath()
                            + "/user/personalInfo";
                    setAttr("redirectionUrl", redirectionUrl);
                    renderJsp("/WEB-INF/content/common/result.jsp");
                    return;
                }
                else
                {
                    User loginUser = User.me.findById(qquser.getInt("user_id"));
                    loginUser.set("login_time", new Date());
                    loginUser.update();
                    Userlogininfo userlogininfo = new Userlogininfo();
                    userlogininfo.set("user_id", loginUser.getInt("id"));
                    userlogininfo.set("login_time", new Date());
                    String ip = getIpAddress();
                    userlogininfo.set("login_ip", ip);
                    userlogininfo.save();
                    getSession().setAttribute(Constants.LOGINUSER, loginUser);
                    message = "QQ登陆成功";
                    setAttr("message", message);
                    redirectionUrl = getRequest().getContextPath() + "/";
                    setAttr("redirectionUrl", redirectionUrl);
                    renderJsp("/WEB-INF/content/common/result.jsp");
                    return;
                }

            }
        }
        catch (QQConnectException e)
        {
            render("index.jsp");
            return;
        }
    }

    public void logout()
    {

        if (getSession().getAttribute(Constants.LOGINUSER) != null)
        {
            // 暂时存放的是字符串，真实项目中应该是登陆用户的User实体类
            removeSessionAttr(Constants.LOGINUSER);
            renderJson(1);
            return;
        }
        else
        {
            renderJson(0);
            return;
        }

    }

    public void logoutside()
    {
        if (getSession().getAttribute(Constants.LOGINUSER) != null)
        {
            // 暂时存放的是字符串，真实项目中应该是登陆用户的User实体类
            removeSessionAttr(Constants.LOGINUSER);
            redirect("/index");
            return;
        }
        else
        {
            redirect("/index");
            return;
        }
    }

    public void login()
    {
        User user = getModel(User.class, "user");
        if (empty(user.getStr("username")))
        {
            String message = "用户名不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (empty(user.getStr("password")))
        {
            String message = "密码不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        User oldUser = new User();
        oldUser = User.me.findFirst("select * from user where username=?",
                user.getStr("username"));
        if (empty(oldUser))
        {
            String message = "不存在该用户";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (!Utility.MD5(oldUser.getStr("uuid") + user.getStr("password"))
                .equals(oldUser.getStr("password")))
        {
            String message = "用户密码错误";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (oldUser.getInt("deleted") == 1)
        {
            String message = "您的账号已被冻结，请联系管理员解封";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        getSession().setAttribute(Constants.LOGINUSER, oldUser);
        Userlogininfo userlogininfo = new Userlogininfo();
        oldUser.set("login_time", new Date());
        oldUser.update();
        userlogininfo.set("user_id", oldUser.getInt("id"));
        userlogininfo.set("login_time", new Date());
        String ip = getIpAddress();
        userlogininfo.set("login_ip", ip);
        userlogininfo.save();
        String message = "登陆成功";
        String redirectionUrl = getRequest().getContextPath() + "/index";
        setAttr("message", message);
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");

    }

    public void register()
    {
        getFile();
        if (!"1".equals(PropKit.get("systemRegisterOpen")))
        {
            message = "本站暂时不开放新用户注册和登陆";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        User user = getModel(User.class, "user");
        if (empty(user.getStr("username")))
        {
            String message = "用户名不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        else
        {
            Matcher matcher = Pattern.compile("^[0-9a-zA-Z _-]{3,15}$")
                    .matcher(user.getStr("username"));
            if (!matcher.find())
            {
                String message = "用户名格式错误，只能输入3~15位数字，字母，下划线";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            if ((user.getStr("username").startsWith("qq_")))
            {
                String message = "您的用户名用到了系统保留字段";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            if ((user.getStr("username").contains("admin")))
            {
                String message = "您的用户名用到了系统保留字段";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
        }
        if (empty(user.getStr("realname")))
        {
            String message = "昵称不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (user.getStr("realname").length() > 6)
        {
            String message = "昵称长度不能大于6位";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (empty(user.getStr("mail")))
        {
            String message = "邮件不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (empty(user.getStr("password")))
        {
            String message = "密码不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (empty(getPara("password_ag")))
        {
            String message = "重复密码密码不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if (!user.getStr("password").equals(getPara("password_ag")))
        {
            String message = "两次输入密码不一致";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        List<User> old = User.me.findByUsername(user.getStr("username"));
        if (!empty(old))
        {
            String message = "该用户名已被注册";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        String uuid = UUID();
        user.set("uuid", uuid);
        user.set("password", Utility.MD5(uuid + user.getStr("password")));
        user.set("create_time", new Date());
        user.set("deleted", 0);
        user.set("avatar", "default.png");
        user.set("type", 0);
        user.save();
        Role role = Role.me.findByRoleName("user");
        if (!empty(role))
        {
            Userrole userrole = new Userrole();
            userrole.set("user_id", user.getInt("id"));
            userrole.set("role_id", role.getInt("id"));
            userrole.set("create_time", new Date());
            userrole.save();
        }
        String message = "注册成功，您的用户名为：" + user.getStr("username") + "，请登陆";
        setAttr("redirectionUrl", getRequest().getContextPath() + "/");
        setAttr("message", message);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void advice()
    {
        renderJsp("advice.jsp");
    }

    public void saveAdvice()
    {
        getFile();
        Advice a = getModel(Advice.class, "advice");
        if (empty(a.getStr("content")))
        {
            message = "建议或留言内容不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        User u = Constants.getLoginUser(getSession());
        if (!empty(u))
        {
            a.set("user_id", u.getInt("id"));
        }
        a.set("create_time", new Date());
        a.set("isread", 0);
        a.save();
        message = "感谢您的建议或留言";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/index";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }

    public void search()
    {
        String keyword = getPara("keyword");
        String rank = getPara("rank");
        String type = getPara("type");
        String rankBack = rank;
        if (empty(keyword))
        {
            message = "关键字不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if ("1".equals(rank))
        {
            rank = "create_time";
        }
        else
        {
            rank = "view";
        }
        if (!"all".equals(type) || !"blog".equals(type)
                || !"beauty".equals(type) || !"video".equals(type))
        {
            type = "all";
        }
        setAttr("keyword", keyword);
        setAttr("rank", rankBack);
        setAttr("type", type);
        render("search.jsp");
        // List<Record> allList = new LinkedList<>();
        // List<Record> blogRec = Db
        // .find("SELECT
        // b.title,u.username,b.view,b.create_time,b.content_show,b.id,u.avatar
        // FROM blog b JOIN USER u ON b.user_id=u.id"
        // + " WHERE (b.ispublic=1 and b.title LIKE '%" + keyword
        // + "%') OR (b.ispublic=1 and b.keyword LIKE '%" + keyword
        // + "%') ORDER BY b." + rank + " DESC;");
        // List<Record> blogList = new ArrayList<>();
        // for (Record r : blogRec)
        // {
        // String contentShow = r.getStr("content_show");
        // if (!empty(contentShow) && contentShow.length() > 150)
        // {
        // contentShow = contentShow.substring(0, 149);
        // }
        // if (empty(r.getStr("avatar")))
        // {
        // r.set("avatar", "default.jpg");
        // }
        // r.set("show", contentShow);
        // r.set("type", "blog");
        // blogList.add(r);
        // allList.add(r);
        // }
        // List<Record> beautyRec = Db
        // .find("SELECT
        // b.title,u.username,b.view,b.create_time,b.content,b.id,u.avatar FROM
        // beauty b JOIN USER u ON b.user_id=u.id"
        // + " WHERE b.title LIKE '%" + keyword
        // + "%' OR b.keyword LIKE '%" + keyword + "%' ORDER BY b."
        // + rank + " DESC;");
        // List<Record> beautyList = new ArrayList<>();
        // for (Record r : beautyRec)
        // {
        // String contentShow = "";
        // if (!empty(r.getStr("content")))
        // {
        // contentShow = HtmlUtil.getNoHTMLString(
        // HtmlUtil.Decode(r.getStr("content")), 150);
        // if (!empty(contentShow) && contentShow.length() > 150)
        // {
        // contentShow = contentShow.substring(0, 149);
        // }
        // }
        // if (empty(r.getStr("avatar")))
        // {
        // r.set("avatar", "default.jpg");
        // }
        // r.set("show", contentShow);
        // r.set("type", "beauty");
        // beautyList.add(r);
        // allList.add(r);
        // }
        // List<Record> videoRec = Db
        // .find("SELECT
        // v.title,u.username,v.view,v.create_time,v.content,v.id,u.avatar FROM
        // video v JOIN USER u ON v.user_id=u.id"
        // + " WHERE v.title LIKE '%" + keyword
        // + "%' OR v.keyword LIKE '%" + keyword + "%' ORDER BY v."
        // + rank + " DESC;");
        // List<Record> videoList = new ArrayList<>();
        // for (Record r : videoRec)
        // {
        // String contentShow = "";
        // if (!empty(r.getStr("content")))
        // {
        // contentShow = HtmlUtil.getNoHTMLString(
        // HtmlUtil.Decode(r.getStr("content")), 150);
        // if (!empty(contentShow) && contentShow.length() > 150)
        // {
        // contentShow = contentShow.substring(0, 149);
        // }
        // }
        // if (empty(r.getStr("avatar")))
        // {
        // r.set("avatar", "default.jpg");
        // }
        // r.set("show", contentShow);
        // r.set("type", "video");
        // videoList.add(r);
        // allList.add(r);
        // }
        // if ("1".equals(rankBack))
        // {
        // allList.sort(new CompareTime());
        // }
        // else
        // {
        // allList.sort(new CompareView());
        // }

    }

    public void getSearchJson()
    {
        String keyword = getPara("keyword");
        String rank = getPara("rank");
        String type = getPara("type");
        if ("1".equals(rank))
        {
            rank = "create_time";
        }
        else
        {
            rank = "view";
        }
        Gson g = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        if ("all".equals(type))
        {
            Page<Record> list = Db.paginate(getParaToInt("page", 1), 10,
                    "SELECT * ",
                    "FROM(SELECT bl.id,bl.title,bl.keyword,bl.view,bl.content_show AS content,bl.user_id,bl.create_time,u1.username,u1.avatar,1 AS TYPE FROM blog bl JOIN USER u1 ON bl.user_id=u1.id  WHERE bl.title LIKE '%"
                            + keyword
                            + "%' AND bl.ispublic=1 AND bl.deleted=0 OR bl.keyword LIKE '%"
                            + keyword
                            + "%' AND bl.ispublic=1 AND bl.deleted=0 UNION SELECT be.id,be.title,be.keyword,be.view,be.content,be.user_id,be.create_time,u2.username,u2.avatar,2 AS TYPE FROM beauty be JOIN USER u2 ON be.user_id=u2.id  WHERE be.title LIKE '%"
                            + keyword
                            + "%' AND be.deleted=0 OR be.keyword LIKE '%"
                            + keyword
                            + "%' AND be.deleted=0 UNION SELECT vi.id,vi.title,vi.keyword,vi.view,vi.content,vi.user_id,vi.create_time,u3.username,u3.avatar,3 AS TYPE FROM video vi JOIN USER u3 ON vi.user_id=u3.id WHERE vi.title LIKE '%"
                            + keyword + "%' OR vi.keyword LIKE '%" + keyword
                            + "%' )al ORDER BY al." + rank + " DESC");
            List<Record> result = new ArrayList();
            for (Record r : list.getList())
            {
                String contentShow = "";
                if (!empty(r.getStr("content")))
                {
                    contentShow = HtmlUtil.getNoHTMLString(
                            HtmlUtil.Decode(r.getStr("content")), 100);
                    if (!empty(contentShow) && contentShow.length() > 100)
                    {
                        contentShow = contentShow.substring(0, 99);
                    }
                    r.set("content", contentShow);
                }
                if (empty(r.getStr("avatar")))
                {
                    r.set("avatar", "default.jpg");
                }
                result.add(r);
            }
            Page<Record> resultPage = new Page(result, list.getPageNumber(),
                    list.getPageSize(), list.getTotalPage(),
                    list.getTotalRow());
            renderJson(g.toJson(list));
            return;
        }
        else if ("blog".equals(type))
        {
            Page<Record> list = Db.paginate(getParaToInt("page", 1), 10,
                    "SELECT * ",
                    "FROM(SELECT bl.id,bl.title,bl.keyword,bl.view,bl.content_show AS content,bl.user_id,bl.create_time,u1.username,u1.avatar,1 AS TYPE FROM blog bl JOIN USER u1 ON bl.user_id=u1.id  WHERE bl.title LIKE '%"
                            + keyword
                            + "%' AND bl.ispublic=1 AND bl.deleted=0 OR bl.keyword LIKE '%"
                            + keyword
                            + "%' AND bl.ispublic=1 AND bl.deleted=0)al ORDER BY al."
                            + rank + " DESC");
            List<Record> result = new ArrayList();
            for (Record r : list.getList())
            {
                String contentShow = "";
                if (!empty(r.getStr("content")))
                {
                    contentShow = HtmlUtil.getNoHTMLString(
                            HtmlUtil.Decode(r.getStr("content")), 100);
                    if (!empty(contentShow) && contentShow.length() > 100)
                    {
                        contentShow = contentShow.substring(0, 99);
                    }
                    r.set("content", contentShow);
                }
                if (empty(r.getStr("avatar")))
                {
                    r.set("avatar", "default.jpg");
                }
                result.add(r);
            }
            Page<Record> resultPage = new Page(result, list.getPageNumber(),
                    list.getPageSize(), list.getTotalPage(),
                    list.getTotalRow());
            renderJson(g.toJson(list));
            return;
        }
        else if ("beauty".equals(type))
        {
            Page<Record> list = Db.paginate(getParaToInt("page", 1), 10,
                    "SELECT * ",
                    "FROM(SELECT be.id,be.title,be.keyword,be.view,be.content,be.user_id,be.create_time,u2.username,u2.avatar,2 AS TYPE FROM beauty be JOIN USER u2 ON be.user_id=u2.id  WHERE be.title LIKE '%"
                            + keyword
                            + "%' AND be.deleted=0 OR be.keyword LIKE '%"
                            + keyword + "%' AND be.deleted=0 )al ORDER BY al."
                            + rank + " DESC");
            List<Record> result = new ArrayList();
            for (Record r : list.getList())
            {
                String contentShow = "";
                if (!empty(r.getStr("content")))
                {
                    contentShow = HtmlUtil.getNoHTMLString(
                            HtmlUtil.Decode(r.getStr("content")), 100);
                    if (!empty(contentShow) && contentShow.length() > 100)
                    {
                        contentShow = contentShow.substring(0, 99);
                    }
                    r.set("content", contentShow);
                }
                if (empty(r.getStr("avatar")))
                {
                    r.set("avatar", "default.jpg");
                }
                result.add(r);
            }
            Page<Record> resultPage = new Page(result, list.getPageNumber(),
                    list.getPageSize(), list.getTotalPage(),
                    list.getTotalRow());
            renderJson(g.toJson(list));
            return;
        }
        else if ("video".equals(type))
        {
            Page<Record> list = Db.paginate(getParaToInt("page", 1), 10,
                    "SELECT * ",
                    "FROM(SELECT vi.id,vi.title,vi.keyword,vi.view,vi.content,vi.user_id,vi.create_time,u3.username,u3.avatar,3 AS TYPE FROM video vi JOIN USER u3 ON vi.user_id=u3.id WHERE vi.title LIKE '%"
                            + keyword + "%' OR vi.keyword LIKE '%" + keyword
                            + "%' )al ORDER BY al." + rank + " DESC");
            List<Record> result = new ArrayList();
            for (Record r : list.getList())
            {
                String contentShow = "";
                if (!empty(r.getStr("content")))
                {
                    contentShow = HtmlUtil.getNoHTMLString(
                            HtmlUtil.Decode(r.getStr("content")), 100);
                    if (!empty(contentShow) && contentShow.length() > 100)
                    {
                        contentShow = contentShow.substring(0, 99);
                    }
                    r.set("content", contentShow);
                }
                if (empty(r.getStr("avatar")))
                {
                    r.set("avatar", "default.jpg");
                }
                result.add(r);
            }
            Page<Record> resultPage = new Page(result, list.getPageNumber(),
                    list.getPageSize(), list.getTotalPage(),
                    list.getTotalRow());
            renderJson(g.toJson(list));
            return;
        }
        else
        {
            renderJson(0);
        }
    }

}
