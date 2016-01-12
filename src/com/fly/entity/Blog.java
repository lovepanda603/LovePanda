
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class Blog extends Model<Blog>
{
    public static final Blog me = new Blog();

    public Blogcategory getBlogcategory()
    {
        return Blogcategory.me.findById(getInt("category"));
    }

    public User getUser()
    {
        return User.me.findById(getInt("user_id"));
    }

    /**
     * 博客和首页默认博客列表
     */
    public Page<Blog> paginate(int pageNumber, int pageSize)
    {
        return paginate(
                pageNumber,
                pageSize,
                "select * ",
                "from blog where ispublic=1 and level !=0 and deleted=0  order by level desc, create_time desc");
    }

    /**
     * 最新博客
     * 
     * @param pageNumber
     * @param pageSize
     * @return
     */
    public Page<Blog> paginateLatest(int pageNumber, int pageSize)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from blog where ispublic=1 and deleted=0  order by create_time desc");
    }

    /**
     * 最热博客
     * 
     * @param pageNumber
     * @param pageSize
     * @return
     */
    public Page<Blog> paginateHot(int pageNumber, int pageSize)
    {
        return paginate(
                pageNumber,
                pageSize,
                "select * ",
                "from blog b where b.ispublic=1 and b.deleted=0 order by b.view desc, b.create_time desc");
    }

    public Page<Blog> paginateMyBlog(int pageNumber, int pageSize, int user_id)
    {
        return paginate(
                pageNumber,
                pageSize,
                "select * ",
                "from blog where user_id=? and deleted=0 order by create_time desc",
                user_id);
    }

    public Page<Blog> paginateBycategory(int pageNumber, int pageSize,
            int category)
    {
        return paginate(
                pageNumber,
                pageSize,
                "select * ",
                "from blog where category=? and ispublic=1 and deleted=0 order by create_time desc",
                category);
    }

    public Page<Blog> paginateBykeyword(int pageNumber, int pageSize,
            String keyword)
    {
        return paginate(
                pageNumber,
                pageSize,
                "select * ",
                "from blog where (title like "
                        + keyword
                        + " or keyword like "
                        + keyword
                        + ") and ispublic=1 and deleted=0 order by create_time desc");
    }

    public List<Blog> findUserBlogNum(int user_id)
    {
        return Blog.me.find("select * from blog where user_id=? and deleted=0",
                user_id);
    }

    // admin包下的
    public Page<Blog> adminPaginatListBlogs(int pageNumber, int pageSize,
            String sql)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from blog b where b.deleted=0 " + sql
                        + " order by  b.create_time desc");
    }

    public Page<Blog> adminPaginatListdeletedBlogs(int pageNumber,
            int pageSize, String sql)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from blog b where b.deleted=1 " + sql
                        + " order by  b.create_time desc");
    }

    public void adminBlogDelete(int id)
    {

    }

    // 首页缓存博客
    public List<Blog> indexCache()
    {
        return find("select * from blog where ispublic=1 and level=3 and deleted=0  order by  create_time desc");
    }
}
