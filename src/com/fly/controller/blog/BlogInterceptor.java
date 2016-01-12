
package com.fly.controller.blog;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

/**
 * BlogInterceptor 此拦截器仅做为示例展示，在本 demo 中并不需要
 */
public class BlogInterceptor implements Interceptor
{

  public void intercept(Invocation inv)
  {
    /*
     * 只是一个列子没有具体的功能实现
     */
    inv.invoke();
  }
}
