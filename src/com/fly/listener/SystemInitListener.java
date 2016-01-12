
package com.fly.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class SystemInitListener implements ServletContextListener
{

  @Override
  public void contextDestroyed(ServletContextEvent arg0)
  {
    // TODO Auto-generated method stub

  }

  @Override
  public void contextInitialized(ServletContextEvent arg0)
  {
    System.out.println("listener开始.................");
  }
}
