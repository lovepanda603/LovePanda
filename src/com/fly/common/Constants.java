
package com.fly.common;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.fly.entity.Blogcategory;
import com.fly.entity.Link;
import com.fly.entity.User;

public class Constants
{
    // 登陆用户
    public static final String LOGINUSER = "loginUser";

    // 博客编辑器类型
    public static final String BLOGEDITORTYPE = "blogEditorType";

    public static User getLoginUser(HttpSession session)
    {
        return (User) session.getAttribute(LOGINUSER);

    }

    public static List<Blogcategory> listBlogcategory;

    public static List<Link> listLink;

    public static List<Link> getListLink()
    {
        return listLink;
    }

    public static void setListLink(List<Link> listLink)
    {
        Constants.listLink = listLink;
    }

    public static List<Blogcategory> getListBlogcategory()
    {
        return listBlogcategory;
    }

    public static void setListBlogcategory(List<Blogcategory> listBlogcategory)
    {
        Constants.listBlogcategory = listBlogcategory;
    }

}
