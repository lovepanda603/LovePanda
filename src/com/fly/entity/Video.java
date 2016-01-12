
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class Video extends Model<Video>
{
    /**
     * 
     */
    private static final long serialVersionUID = -1561659911877304269L;

    public static final Video me = new Video();

    public Page<Video> paginate(int pageNumber, int pageSize)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from video order by level desc, create_time desc");
    }

    public User getUser()
    {
        return User.me.findById(getInt("user_id"));
    }

    public Page<Video> paginateMyVideo(Integer pageNumber, int pageSize,
            int userId)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from video where user_id=? order by level desc, create_time desc",
                userId);
    }

    public List<Video> findUserVideoNum(int user_id)
    {
        return Video.me.find("select * from video where user_id=?", user_id);
    }

    // ============admin=============
    public Page<Video> adminPaginatListVideos(int pageNumber, int pageSize,
            String sql)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from video  where 1=1 " + sql + " order by  create_time desc");
    }

    // 首页推荐
    public List<Video> indexCache()
    {
        return find("select * from video where level=3");
    }
}
