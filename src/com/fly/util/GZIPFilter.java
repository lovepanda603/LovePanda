
package com.fly.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GZIPFilter implements Filter
{
    public void destroy()
    {
    }

    public void doFilter(ServletRequest req, ServletResponse res,
            FilterChain chain) throws ServletException, IOException
    {
        HttpServletRequest request = (HttpServletRequest) req;
        String acceptEncoding = request.getHeader("Accept-Encoding");
        if ((acceptEncoding != null) && (acceptEncoding.indexOf("gzip") != -1))
        {
            HttpServletResponse response = (HttpServletResponse) res;
            GZIPResponseWrapper wrapper = new GZIPResponseWrapper(response);
            chain.doFilter(request, wrapper);
            wrapper.finish();
            ByteArrayOutputStream buffer = wrapper.getBuffer();
            response.addHeader("Content-Encoding", "gzip");
            response.setContentLength(buffer.size());
            ServletOutputStream output = response.getOutputStream();
            output.write(buffer.toByteArray());
            output.flush();
            output.close();
        }
        else
        {
            chain.doFilter(req, res);
        }
    }

    public void init(FilterConfig config) throws ServletException
    {
    }
}
