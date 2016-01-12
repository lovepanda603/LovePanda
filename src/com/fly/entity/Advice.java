
package com.fly.entity;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class Advice extends Model<Advice>
{
  private static final long serialVersionUID = 6495781850243518615L;

  public static final Advice me = new Advice();

  public Page<Advice> paginate(int pageNumber, int pageSize)
  {
    return paginate(pageNumber, pageSize, "select * ",
        "from advice order by id desc");
  }
}
