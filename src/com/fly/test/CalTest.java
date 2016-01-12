package com.fly.test;

import java.util.Calendar;

public class CalTest
{
    public static void main(String[] args)
    {
        Calendar calendar=Calendar.getInstance();
        System.out.println(calendar.get(Calendar.HOUR_OF_DAY));
    }
}
