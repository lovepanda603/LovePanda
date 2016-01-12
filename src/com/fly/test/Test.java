
package com.fly.test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Test
{
    public static void main(String[] args)
    {
        String str = "jk__";
        Matcher matcher = Pattern.compile("^[0-9a-zA-Z _-]{3,15}$")
                .matcher(str);
        System.out.println(str.length());
        System.out.println(matcher.find());
    }
}
