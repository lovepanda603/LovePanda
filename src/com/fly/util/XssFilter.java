
package com.fly.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * 拦截请求防止XSS漏洞与SQL注入漏洞
 */
public class XssFilter implements Filter
{
  @Override
  public void destroy()
  {
  }

  @Override
  public void doFilter(ServletRequest request, ServletResponse response,
      FilterChain chain) throws ServletException, IOException
  {
    chain.doFilter(new XssHttpServletRequestWrapper(
        (HttpServletRequest) request), response);
  }

  @Override
  public void init(FilterConfig config) throws ServletException
  {
  }
}