
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Role extends Model<Role>
{
    /**
     * 
     */
    private static final long serialVersionUID = -2209344199232075312L;

    public static final Role me = new Role();

    public List<Role> listRole()
    {
        return me.find("select * from role");
    }

    public Role findByRoleName(String role_name)
    {
        return me.findFirst("select * from role where role_name=?", role_name);
    }
}
