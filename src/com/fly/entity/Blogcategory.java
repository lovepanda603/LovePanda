
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Blogcategory extends Model<Blogcategory>
{

    /**
     * 
     */
    private static final long serialVersionUID = -4355578870409504784L;

    public static final Blogcategory me = new Blogcategory();

    public List<Blogcategory> listAll()
    {
        return find("select * from blogcategory");
    }

}
