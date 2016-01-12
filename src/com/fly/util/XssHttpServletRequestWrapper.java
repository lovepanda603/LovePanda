
package com.fly.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * 包装 Request 对象，过滤参数值中的XML字符
 */
@SuppressWarnings("unchecked")
public class XssHttpServletRequestWrapper extends HttpServletRequestWrapper
{
    private static final String[] EMPTY_STRING_ARRAY = new String[]{};

    private Map params;

    public XssHttpServletRequestWrapper(HttpServletRequest request)
    {
        super(request);
        params = new HashMap();

        // 对所有请求参数的name和value做字符编码并缓存
        Map rm = request.getParameterMap();
        Iterator iterator = rm.entrySet().iterator();
        while (iterator.hasNext())
        {
            Map.Entry entry = (Map.Entry) iterator.next();
            Object key = entry.getKey();
            String[] value = (String[]) entry.getValue();
            if (value != null && value.length > 0)
            {
                String[] newValue = new String[value.length];
                for (int i = 0, m = value.length; i < m; i++)
                    newValue[i] = Utility.escapeXml(value[i]);
                params.put(Utility.escapeXml(key.toString()), newValue);
            }
            else
                params.put(Utility.escapeXml(key.toString()),
                        EMPTY_STRING_ARRAY);
        }
    }

    @Override
    public String getParameter(String name)
    {
        String[] value = (String[]) params.get(name);
        if (value != null)
            if (value.length > 0)
                return value[0];
            else
                return "";
        else
            return null;
    }

    @Override
    public Map getParameterMap()
    {
        return params;
    }

    @Override
    public String[] getParameterValues(String name)
    {
        return (String[]) params.get(name);
    }
}