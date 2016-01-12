
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class Beauty extends Model<Beauty>
{
    /**
     * 
     */
    private static final long serialVersionUID = -503838622896045124L;

    public static final Beauty me = new Beauty();

    public Page<Beauty> paginate(int pageNumber, int pageSize)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from beauty where deleted=0  order by level desc, create_time desc");
    }

    public User getUser()
    {
        return User.me.findById(getInt("user_id"));
    }

    public Page<Beauty> myBeautyPaginate(int pageNumber, int pageSize,
            int userId)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from beauty where deleted=0 and user_id=?  order by create_time desc",
                userId);
    }

    // admin包下的
    public Page<Beauty> adminPaginatListBeautys(int pageNumber, int pageSize,
            String sql)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from beauty b where b.deleted=0 " + sql
                        + " order by  b.create_time desc");
    }

    // admin包下的
    public Page<Beauty> adminPaginatBeautyDeleted(int pageNumber, int pageSize,
            String sql)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from beauty b where b.deleted=1 " + sql
                        + " order by  b.create_time desc");
    }

    public List<Beauty> indexCache()
    {
        return find(
                "select * from beauty  where level=3 and deleted=0  order by create_time desc");
    }

    public List<Beauty> findUserBeautyNum(int user_id)
    {
        return Beauty.me.find(
                "select * from beauty where user_id=? and deleted=0", user_id);
    }
}
