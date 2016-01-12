
package com.fly.interceptor;

import javax.servlet.http.HttpSession;

import com.fly.common.Constants;
import com.fly.entity.Role;
import com.fly.entity.User;
import com.fly.entity.Userrole;
import com.fly.util.Utility;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;

public class EditOpenInterceptor implements Interceptor
{

    @Override
    public void intercept(Invocation inv)
    {
        if (!"1".equals(PropKit.get("systemEditOpen")))
        {
            HttpSession session = inv.getController().getSession();
            User u = Constants.getLoginUser(session);
            Userrole ur = Userrole.me.findByUserId(u.getInt("id"));
            Controller controller = inv.getController();
            if (Utility.empty(ur))
            {
                String message = "此模块暂时未对普通用户开放";
                controller.setAttr("message", message);
                controller.renderJsp("/WEB-INF/content/common/result.jsp");
            }
            else
            {
                Role r = Role.me.findById(ur.getInt("role_id"));
                if (Utility.empty(r)
                        || (!"administrator".equals(r.getStr("role_name"))))
                {
                    String message = "此模块暂时未对普通用户开放";
                    controller.setAttr("message", message);
                    controller.renderJsp("/WEB-INF/content/common/result.jsp");
                }
                else
                {
                    inv.invoke();
                }
            }
        }
        else
        {
            inv.invoke();
        }
    }

}
