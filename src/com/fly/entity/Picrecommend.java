
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Picrecommend extends Model<Picrecommend>
{
    /**
     * 
     */
    private static final long serialVersionUID = 9160601585945143893L;

    public static final Picrecommend me = new Picrecommend();

    public List<Picrecommend> listAll()
    {
        return find("select * from picrecommend order by sn");
    }

    public List<Picrecommend> listIndex()
    {
        return find(
                "select * from picrecommend where deleted=0 order by sn,id");
    }

}
