
package com.fly.controller;

import java.util.UUID;

import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.fly.util.Utility;
import com.jfinal.core.Controller;

public class BaseController extends Controller
{
    protected String message = "";

    protected String redirectionUrl = "";

    protected String UUID()
    {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

    protected boolean empty(Object o)
    {
        return Utility.empty(o);
    }

    /**
     * 获得当前Request真实的IP地址
     */
    protected String getIpAddress()
    {
        HttpServletRequest request = getRequest();

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

    /**
     * 获得未被XSS过滤器处理过的原始参数值
     */
    protected String getOriginalParameter(String name)
    {
        HttpServletRequest request = getRequest();
        ServletRequest r = request;
        while (r instanceof HttpServletRequestWrapper)
        {
            r = ((HttpServletRequestWrapper) r).getRequest();
        }
        return r.getParameter(name);
    }

    /**
     * 按照名称获得Cookie中存储的值
     */
    protected String getCookieValue(String name)
    {
        HttpServletRequest request = getRequest();
        Cookie[] cookies = request.getCookies();
        String value = null;
        if (cookies != null)
        {
            for (Cookie cookie : cookies)
            {
                if (name.equals(cookie.getName()))
                {
                    value = cookie.getValue();
                    break;
                }
            }
        }
        return value;
    }

    /**
     * 判断当前访问设备是否是手机
     */
    protected boolean isPhone()
    {
        HttpServletRequest request = getRequest();
        String agent = request.getHeader("user-agent");
        if (agent != null)
        {
            agent = agent.toLowerCase();
            return agent.indexOf("iphone") != -1
                    || agent.indexOf("android") != -1;
        }
        else
            return false;
    }

}
