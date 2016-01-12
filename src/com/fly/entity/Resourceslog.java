
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class Resourceslog extends Model<Resourceslog>
{
    /**
     * 
     */
    private static final long serialVersionUID = -3484851443854356853L;

    public static final Resourceslog me = new Resourceslog();

    public List<Resourceslog> list(String sql)
    {
        return find("select * from resourceslog where " + sql
                + " order by create_time asc");
    }

    public List<Resourceslog> listTongji(String sql)
    {
        return find("select * from resourceslog where 1=1 " + sql);
    }

    public Page<Resourceslog> paginate(int pageNumber, int pageSize, String sql)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from resourceslog where " + sql + " order by create_time asc");
    }
}
