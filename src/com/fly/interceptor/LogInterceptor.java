
package com.fly.interceptor;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.fly.entity.Iplog;
import com.fly.util.Utility;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;

public class LogInterceptor implements Interceptor
{
    private Logger logger = Logger.getLogger("");

    @Override
    public void intercept(Invocation inv)
    {
        Controller c = inv.getController();
        HttpServletRequest request = c.getRequest();
        String ip = getIpAddress(request);
        if (!Utility.empty(ip) && !"localhost".equals(ip)
                && (!"127.0.0.1".equals(ip)))
        {
            try
            {
                Iplog iplog = new Iplog();
                iplog.set("ip", ip);
                String url = request.getRequestURL().toString();
                iplog.set("url", url);
                Map<String, String[]> map = request.getParameterMap();
                Set<String> keys = map.keySet();
                List parameterList = new ArrayList();
                for (String key : keys)
                {
                    if (key.equals("_"))
                    {
                        continue;
                    }
                    Map everyParameter = new HashMap();
                    everyParameter.put(key,
                            ((Object[]) map.get(key))[0].toString());
                    parameterList.add(everyParameter);
                }
                iplog.set("params", parameterList.toString());
                iplog.set("create_time", new Date());
                iplog.save();
            }
            catch (Exception e)
            {
                logger.error("ip日志记录异常：" + e.getMessage());
            }
        }
        inv.invoke();
    }

    /**
     * 获得当前Request真实的IP地址
     */
    protected String getIpAddress(HttpServletRequest request)
    {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip))
        {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

}
