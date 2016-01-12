
package com.fly.interceptor;

import javax.servlet.http.HttpServletRequest;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

public class PhoneInterceptor implements Interceptor
{

  @Override
  public void intercept(Invocation inv)
  {
    Controller c = inv.getController();
    boolean isPhone = isPhone(c);
    c.getSession().setAttribute("isPhone", isPhone);
    inv.invoke();

  }

  protected boolean isPhone(Controller c)
  {
    HttpServletRequest request = c.getRequest();
    String agent = request.getHeader("user-agent");
    if (agent != null)
    {
      agent = agent.toLowerCase();
      return agent.indexOf("iphone") != -1 || agent.indexOf("android") != -1;
    }
    else
      return false;
  }
}
