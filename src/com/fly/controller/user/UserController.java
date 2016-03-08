
package com.fly.controller.user;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.fly.common.Constants;
import com.fly.controller.BaseController;
import com.fly.entity.Beauty;
import com.fly.entity.Blog;
import com.fly.entity.Role;
import com.fly.entity.User;
import com.fly.entity.Userrole;
import com.fly.entity.Video;
import com.fly.interceptor.LoginInterceptor;
import com.fly.util.ImageUtil;
import com.fly.util.Utility;
import com.jfinal.aop.Before;
import com.jfinal.kit.PathKit;
import com.jfinal.upload.UploadFile;

public class UserController extends BaseController
{
    @Before(LoginInterceptor.class)
    public void personalInfo()
    {
        User u = Constants.getLoginUser(getSession());
        User oldUser = User.me.findById(u.getInt("id"));
        setAttr("user", oldUser);
        int blogSum = 0;
        List<Blog> listBlog = Blog.me.findUserBlogNum(u.getInt("id"));
        if (!empty(listBlog))
        {
            blogSum = listBlog.size();
        }
        int beautySum = 0;
        List<Beauty> lsitBeauty = Beauty.me.findUserBeautyNum(u.getInt("id"));
        if (!empty(lsitBeauty))
        {
            beautySum = lsitBeauty.size();
        }
        int videoSum = 0;
        List<Video> lsitVideo = Video.me.findUserVideoNum(u.getInt("id"));
        if (!empty(lsitVideo))
        {
            videoSum = lsitVideo.size();
        }
        Userrole ur = Userrole.me.findByUserId(u.getInt("id"));
        if (!empty(ur))
        {
            Role role = Role.me.findById(ur.getInt("role_id"));
            if ("administrator".equals(role.get("role_name")))
            {
                setAttr("is_admin", 1);
            }
        }
        setAttr("videoSum", videoSum);
        setAttr("beautySum", beautySum);
        setAttr("blogSum", blogSum);
        renderJsp("personalInfo.jsp");
    }

    @Before(LoginInterceptor.class)
    public void update()
    {
        getFile();
        User u = getModel(User.class, "user");
        User loginUser = Constants.getLoginUser(getSession());
        User oldUser = User.me.findById(loginUser.getInt("id"));
        String username = u.getStr("username");
        if (empty(username))
        {
            String message = "用户名不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        else
        {
            Matcher matcher = Pattern.compile("^[0-9a-zA-Z _-]{3,15}$")
                    .matcher(username);
            if (!matcher.find())
            {
                String message = "用户名格式错误，只能输入3~15位数字，字母，下划线";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
        }
        List<User> old = User.me.findByUsername(u.getStr("username"));
        if ((!empty(old)) && (!oldUser.getStr("username").equals(username)))
        {
            String message = "该用户名已被注册";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if ((!username.equals(oldUser.getStr("username"))
                && username.startsWith("qq_")))
        {
            String message = "您的用户名用到了系统保留字段";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        if ((!username.equals(oldUser.getStr("username"))
                && username.contains("admin")))
        {
            String message = "您的用户名用到了系统保留字段";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        u.set("id", oldUser.getInt("id"));
        u.set("uuid", oldUser.getStr("uuid"));
        u.set("password", oldUser.getStr("password"));
        u.set("avatar", oldUser.getStr("avatar"));
        u.set("create_time", oldUser.getDate("create_time"));
        u.set("login_time", oldUser.getDate("login_time"));
        u.set("deleted", oldUser.getInt("deleted"));
        u.set("type", oldUser.getInt("type"));
        u.update();
        getSession().removeAttribute(Constants.LOGINUSER);
        getSession().setAttribute(Constants.LOGINUSER, u);
        redirect("/user/personalInfo");
    }

    @Before(LoginInterceptor.class)
    public void toEditAvatar()
    {
        User u = Constants.getLoginUser(getSession());
        User oldUser = User.me.findById(u.getInt("id"));
        setAttr("user", oldUser);
        renderJsp("avatar.jsp");
    }

    @Before(LoginInterceptor.class)
    public void getImage()
    {
        UploadFile file = getFile("upload");
        try
        {
            if (empty(file))
            {
                Map<String, String> m = new HashMap<String, String>();
                m.put("message", "文件不能为空");
                renderJson(m);
                return;
            }
            else
            {
                String uploadContentType = file.getContentType();
                if (!uploadContentType.equals("image/png")
                        && !uploadContentType.equals("image/jpeg")
                        && !uploadContentType.equals("image/pjpeg")
                        && !uploadContentType.equals("image/x-png"))
                {
                    Map<String, String> m = new HashMap<String, String>();
                    m.put("message", "文件格式不支持，目前只支持png,jpg");
                    renderJson(m);
                    return;
                }
                else
                {
                    String[] suffixarr = file.getFileName().split("\\.");
                    String suffix = suffixarr[suffixarr.length - 1];
                    if ((!suffix.equals("jpg")) && (!suffix.equals("png")))
                    {
                        Map<String, String> m = new HashMap<String, String>();
                        m.put("message", "请检查文件后缀名是否为jpg或png");
                        renderJson(m);
                        return;
                    }
                    String filename = UUID() + "." + suffix;
                    file.getFile().renameTo(new File(PathKit.getWebRootPath()
                            + "/attached/temp/" + filename));
                    Map<String, String> m = new HashMap<String, String>();
                    m.put("message", "1");
                    m.put("url", filename);
                    renderJson(m);
                    return;
                }
            }

        }
        catch (Exception e)
        {
            Map<String, String> m = new HashMap<String, String>();
            m.put("message", "文件处理发生异常");
            renderJson(m);
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
    }

    @Before(LoginInterceptor.class)
    public void updateAvatar() throws Exception
    {
        int x = getParaToInt("x1");
        int y = getParaToInt("y1");
        int w = getParaToInt("cw");
        int h = getParaToInt("ch");
        String avatar = getPara("avatar");
        String src = "";
        String dest = "";
        User loginUser = Constants.getLoginUser(getSession());
        User oldUser = User.me.findById(loginUser.getInt("id"));
        if (empty(avatar))
        {
            message = "头像文件不能为空";
            setAttr("message", message);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        String[] suffixarr = avatar.split("\\.");
        String suffix = suffixarr[suffixarr.length - 1];
        if ("default".equals(avatar))
        {
            src = PathKit.getWebRootPath() + "/attached/avatar/default.jpg";
            String newavatar = UUID() + ".jpg";
            dest = PathKit.getWebRootPath() + "/attached/avatar/" + newavatar;
            try
            {
                ImageUtil.cutImage(src, dest, x, y, w, h, "jpg");
            }
            catch (Exception e)
            {
                message = "头像文件裁剪异常";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            oldUser.set("avatar", newavatar);
            oldUser.update();
            getSession().removeAttribute(Constants.LOGINUSER);
            getSession().setAttribute(Constants.LOGINUSER, oldUser);
            message = "头像上传成功";
            setAttr("message", message);
            redirectionUrl = getRequest().getContextPath()
                    + "/user/personalInfo";
            setAttr("redirectionUrl", redirectionUrl);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
        else
        {
            if (avatar.equals(oldUser.getStr("avatar")))
            {
                src = PathKit.getWebRootPath() + "/attached/avatar/" + avatar;
            }
            else
            {
                src = PathKit.getWebRootPath() + "/attached/temp/" + avatar;
            }
            String newavatar = UUID() + ".jpg";
            dest = PathKit.getWebRootPath() + "/attached/avatar/" + newavatar;
            if (!new File(src).exists())
            {
                message = "头像原文件不存在，请重新上传";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            System.out.println(1);
            // ImageUtil.cutImage(src, dest, x, y, w, h, suffix);
            ImageUtil.cutImage(src, dest, x, y, w, h, "jpg");
            // try
            // {
            // }
            // catch (Exception e)
            // {
            // message = "头像文件裁剪异常,请重新上传";
            // setAttr("message", message);
            // redirectionUrl = getRequest().getContextPath()
            // + "/user/personalInfo";
            // setAttr("redirectionUrl", redirectionUrl);
            // renderJsp("/WEB-INF/content/common/result.jsp");
            // return;
            // }
            // finally
            // {
            // File o = new File(src);
            // if (o.exists())
            // {
            // o.delete();
            // }
            // }
            oldUser.set("avatar", newavatar);
            oldUser.update();
            getSession().removeAttribute(Constants.LOGINUSER);
            getSession().setAttribute(Constants.LOGINUSER, oldUser);
            message = "头像上传成功";
            setAttr("message", message);
            redirectionUrl = getRequest().getContextPath()
                    + "/user/personalInfo";
            setAttr("redirectionUrl", redirectionUrl);
            renderJsp("/WEB-INF/content/common/result.jsp");
            return;
        }
    }

    @Before(LoginInterceptor.class)
    public void updatePassword()
    {
        getFile();
        User u = Constants.getLoginUser(getSession());
        User loginUser = User.me.findById(u.getInt("id"));
        String newpwd = getPara("newpwd");
        String newpwdag = getPara("newpwd_ag");
        if (loginUser.getInt("type") == 0 || ((loginUser.getInt("type") == 1)
                && (!empty(loginUser.getStr("password")))))
        {
            String oldpwd = getPara("oldpwd");
            if (empty(oldpwd) || empty(newpwd) || empty(newpwdag))
            {
                message = "原密码或新密码或重复密码不能为空";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            if (!Utility.MD5(loginUser.getStr("uuid") + oldpwd)
                    .equals(loginUser.getStr("password")))
            {
                message = "原密码不正确";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
            if (!newpwd.equals(newpwdag))
            {
                message = "两次新密码输入不相同";
                setAttr("message", message);
                renderJsp("/WEB-INF/content/common/result.jsp");
                return;
            }
        }
        else
        {
            if (empty(loginUser.getStr("password")))
            {
                if (!newpwd.equals(newpwdag))
                {
                    message = "两次新密码输入不相同";
                    setAttr("message", message);
                    renderJsp("/WEB-INF/content/common/result.jsp");
                    return;
                }
            }
        }
        loginUser.set("password",
                Utility.MD5(loginUser.getStr("uuid") + newpwd));
        loginUser.update();
        getSession().removeAttribute(Constants.LOGINUSER);
        getSession().setAttribute(Constants.LOGINUSER, loginUser);
        message = "密码修改成功";
        setAttr("message", message);
        redirectionUrl = getRequest().getContextPath() + "/user/personalInfo";
        setAttr("redirectionUrl", redirectionUrl);
        renderJsp("/WEB-INF/content/common/result.jsp");
    }
}
