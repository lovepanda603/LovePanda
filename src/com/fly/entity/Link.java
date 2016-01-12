
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Link extends Model<Link>
{
    private static final long serialVersionUID = -703312427086503277L;

    public static final Link me = new Link();

    public List<Link> listAll()
    {
        return me.find("select * from link order by sn");
    }

}
