
package com.fly.entity;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class Userrole extends Model<Userrole>
{
    /**
     * 
     */
    private static final long serialVersionUID = -3724933206673873541L;

    public static final Userrole me = new Userrole();

    public User getUser()
    {
        return User.me.findById(getInt("user_id"));
    }

    public Role getRole()
    {
        return Role.me.findById(getInt("role_id"));
    }

    public Userrole findByUserId(int user_id)
    {
        return me.findFirst("select * from userrole  where user_id=?", user_id);
    }

    public Page<Userrole> findByRoleId(int pageNumber, int pageSize,
            int role_id)
    {
        return paginate(pageNumber, pageSize, "select *",
                "from userrole where role_id=?", role_id);
    }

}
