
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

@SuppressWarnings("serial")
public class User extends Model<User>
{
    public static final User me = new User();

    /**
     * 所有 sql 与业务逻辑写在 Model 或 Service 中，不要写在 Controller 中，养成好习惯，有利于大型项目的开发与维护
     */
    public Page<User> paginate(int pageNumber, int pageSize)
    {
        return paginate(pageNumber, pageSize, "select *",
                "from user order by id asc");
    }

    public List<User> findByUsername(String username)
    {
        return User.me.find("select * from user where username = ?", username);
    }

    // admin包下的
    public Page<User> adminPaginatListUsers(int pageNumber, int pageSize,
            String sql)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from user  where deleted=0 " + sql + " order by create_time");
    }

    public Page<User> adminListDeletedUses(int pageNumber, int pageSize,
            String sql)
    {
        return paginate(pageNumber, pageSize, "select *",
                "from user where deleted=1 " + sql + " order by create_time");
    }
}
