
package com.fly.entity;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

public class Iplog extends Model<Iplog>
{
    /**
     * 
     */
    private static final long serialVersionUID = -2919489427432936198L;

    public static final Iplog me = new Iplog();

    public Page<Iplog> paginate(int pageNumber, int pageSize, String sql)
    {
        return paginate(pageNumber, pageSize, "select * ",
                "from iplog where 1=1 " + sql + " order by create_time asc");
    }

    public List<Record> listIps(String sql)
    {
        return Db
                .find("SELECT p.* FROM(SELECT ip,COUNT(ip)AS sumip FROM iplog WHERE 1=1 "
                        + sql + " GROUP BY ip)p ORDER BY p.sumip DESC");
    }

    public List<Iplog> listIplogIpDetail(String ip, String sql)
    {
        return find("select * from iplog where ip=? " + sql, ip);
    }
}
