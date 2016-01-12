
package com.fly.timer;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimerTask;

import com.jfinal.plugin.activerecord.Db;

public class NFDFlightDataTimerTask extends TimerTask
{

    @Override
    public void run()
    {
        try
        {
            // 定时清理日志
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.WEEK_OF_MONTH, -1);
            Date result = calendar.getTime();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String sql = "delete from resourceslog where create_time<'"
                    + sdf.format(result) + "'";
            Db.update(sql);
            String sql1 = "delete from iplog where create_time<'"
                    + sdf.format(result) + "'";
            Db.update(sql1);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
