
package com.fly.interceptor;

import com.fly.common.Constants;
import com.fly.entity.User;
import com.fly.util.Utility;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

public class LoginInterceptor implements Interceptor
{

    @Override
    public void intercept(Invocation inv)
    {
        Controller controller = inv.getController();
        User u = Constants.getLoginUser(controller.getSession());
        if (!Utility.empty(u))
        {
            inv.invoke();
        }
        else
        {
            String message = "请先登录再进行操作！";
            controller.setAttr("message", message);
            String redirectionUrl = controller.getRequest().getContextPath()
                    + "/";
            controller.setAttr("redirectionUrl", redirectionUrl);
            controller.renderJsp("/WEB-INF/content/common/result.jsp");
        }
    }
}
