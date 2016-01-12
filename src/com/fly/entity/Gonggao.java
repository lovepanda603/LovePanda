
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Gonggao extends Model<Gonggao>
{
    /**
     * 
     */
    private static final long serialVersionUID = 1607801676729504209L;

    public static final Gonggao me = new Gonggao();

    public List<Gonggao> listAll()
    {
        return me.find("select * from gonggao where deleted=0 order by sn asc");
    }
}
