
package com.fly.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Collection;
import java.util.Map;

/**
 * 实用工具类，静态函数库 <br>
 */
public class Utility
{
    /** 18位身份证号码的校验加权因子数组 */
    private static final int[] ID_CARD_WI = new int[]{7, 9, 10, 5, 8, 4, 2, 1,
            6, 3, 7, 9, 10, 5, 8, 4, 2};

    /** 18位身份证号码的校验码数组 */
    private static final char[] ID_CARD_CHECK_CODE = new char[]{'1', '0', 'X',
            '9', '8', '7', '6', '5', '4', '3', '2'};

    /** 十六进制数字字符数组 */
    private static final char[] HEX_DIGIT = new char[]{'0', '1', '2', '3', '4',
            '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

    private static final int BUFFER_SIZE = 8192;

    /**
     * String到int的类型转换
     * 
     * @param str 要转换的字符串
     * @return 返回转换结果int，如果在转换过程中发生异常，将返回默认值0
     */
    public static int stringToInt(String str)
    {
        return stringToInt(str, 0);
    }

    /**
     * String到int的类型转换
     * 
     * @param str 要转换的字符串
     * @param defaultValue 如果转换时出现异常，返回的默认值
     * @return 返回转换结果int，如果在转换过程中发生异常，将返回给定的默认值
     */
    public static int stringToInt(String str, int defaultValue)
    {
        try
        {
            return Integer.parseInt(str);
        }
        catch (NumberFormatException nfe)
        {
            return defaultValue;
        }
    }

    /**
     * 修正字符串空指针，如果字符串为null，则返回默认值空字符串
     * 
     * @param src 待处理的字符串对象
     * @return 如果原字符串为null，返回空字符串，否则返回原字符串
     */
    public static String fixString(String src)
    {
        return fixString(src, "");
    }

    /**
     * 修正字符串空指针，如果字符串为null，则返回给定的默认值
     * 
     * @param src 待处理的字符串对象
     * @param defaultString 给定的默认值
     * @return 如果原字符串为null，返回给定的默认值，否则返回原字符串
     */
    public static String fixString(String src, String defaultString)
    {
        if (src == null)
            return defaultString;
        else
            return src;
    }

    /**
     * 转义XML/HTML字符
     */
    public static String escapeXml(String s)
    {
        if (s == null)
            return null;

        StringBuilder sb = new StringBuilder();
        char[] chars = s.toCharArray();
        for (char c : chars)
        {
            if (c == '&')
                sb.append("&amp;");
            else if (c == '<')
                sb.append("&lt;");
            else if (c == '>')
                sb.append("&gt;");
            else if (c == '"')
                sb.append("&quot;");
            else if (c == '\'')
                sb.append("&#x27");
            else if (c == '/')
                sb.append("&#x2F");
            else
                sb.append(c);
        }
        return sb.toString();
    }

    /**
     * 修正SQL语句中字符串存在单引号“'”，主要是Insert语句
     */
    public static String SQLEncode(String s)
    {
        if (s == null || s.length() == 0)
            return s;

        StringBuffer sb = new StringBuffer();
        char c;
        for (int i = 0; i < s.length(); i++)
        {
            c = s.charAt(i);
            if (c == '\'')
                sb.append(c);
            sb.append(c);
        }
        return sb.toString();
    }

    /**
     * 转换字符编码为指定的编码
     */
    public static String convertEncoding(String str, String encodingFrom,
            String encodingTo)
    {
        try
        {
            return new String(str.getBytes(encodingFrom), encodingTo);
        }
        catch (UnsupportedEncodingException e)
        {
            throw new RuntimeException(e.getMessage());
        }
    }

    /**
     * 转换字符编码为当前操作系统的默认编码
     */
    public static String convertEncoding(String str, String encodingFrom)
    {
        try
        {
            return new String(str.getBytes(encodingFrom));
        }
        catch (UnsupportedEncodingException e)
        {
            throw new RuntimeException(e.getMessage());
        }
    }

    /**
     * byte类型转换成十六进制的ASCII表示
     * 
     * @param b 要转换的byte
     * @return 十六进制的ASCII表示
     */
    public static String byteHEX(byte b)
    {
        char[] c = new char[2];
        c[0] = HEX_DIGIT[(b >>> 4) & 0X0F];
        c[1] = HEX_DIGIT[b & 0X0F];
        return new String(c);
    }

    /**
     * 对给定的字符串进行MD5变换
     * 
     * @param src 要进行MD5变换的字符串
     * @return 变换后的十六进制ASCII表示结果
     * @throws RuntimeException 如果当前JDK中不存在MD5变换算法，抛出运行时异常。
     */
    public static String MD5(String src)
    {
        if (src == null)
            return null;

        MessageDigest md = null;
        try
        {
            md = MessageDigest.getInstance("MD5");
        }
        catch (NoSuchAlgorithmException e)
        {
            throw new RuntimeException(e.getMessage());
        }

        StringBuffer sb = new StringBuffer();
        byte[] b = md.digest(src.getBytes());
        for (int i = 0, m = b.length; i < m; i++)
        {
            sb.append(HEX_DIGIT[(b[i] >>> 4) & 0X0F]);
            sb.append(HEX_DIGIT[b[i] & 0X0F]);
        }
        return sb.toString();
    }

    /**
     * 对18位的公民身份证号码进行合法性校验
     * 
     * @param id_card 要进行校验的18位身份证号码，15位旧的身份证号码不能进行校验，将返回false
     * @return true 18位身份证号码合法，false 校验未通过，可能的原因为号码不合法或位数不正确。
     */
    public static boolean isIDCard18Valid(String id_card)
    {
        boolean result = false;
        if (id_card.length() == 18)
        {
            // 校验位为身份证号码的第18位
            char checkBit = id_card.charAt(17);

            // 计算身份证号码前十七位数字本体码加权求和
            int sum = 0;
            for (int i = 0; i < 17; i++)
                sum += Character.getNumericValue(id_card.charAt(i))
                        * ID_CARD_WI[i];

            // 用加权和对11取模，计算出校验码的索引号
            int index = sum % 11;
            if (index == 2)
            {
                if ('X' == checkBit || 'x' == checkBit)
                    result = true;
            }
            else if (ID_CARD_CHECK_CODE[index] == checkBit)
                result = true;
        }
        return result;
    }

    /**
     * 把对象数组转换为一个按照分隔符分割元素的字符串
     * 
     * @param array
     * @param separator
     * @return 按照分隔符分割元素的字符串
     */
    public static String arrayToString(Object[] array, String separator)
    {
        StringBuffer s = new StringBuffer();
        if (array != null && array.length != 0)
            for (int i = 0, m = array.length - 1; i <= m; i++)
            {
                if (array[i] != null)
                    s.append(array[i].toString());
                if (i != m)
                    s.append(separator);
            }
        return s.toString();
    }

    /**
     * 文件保存到磁盘
     * 
     * @param in 文件输入流
     * @param filename 目标文件名（包含完整路径）
     */
    public static void saveFile(InputStream in, String filename)
    {
        // 创建目录
        File file = new File(filename);
        File parent = file.getParentFile();
        if (parent != null && !parent.exists())
            parent.mkdirs();

        OutputStream out = null;
        try
        {
            out = new FileOutputStream(file);
            int bytesRead = 0;
            byte[] buffer = new byte[BUFFER_SIZE];
            while ((bytesRead = in.read(buffer, 0, BUFFER_SIZE)) != -1)
                out.write(buffer, 0, bytesRead);
            in.close();
        }
        catch (IOException e)
        {
            throw new RuntimeException(e);
        }
        finally
        {
            if (out != null)
            {
                try
                {
                    out.close();
                }
                catch (IOException e)
                {
                    throw new RuntimeException(e);
                }
            }
        }
    }

    /**
     * 文件复制
     * 
     * @param source 源文件
     * @param destination 目的文件
     * @throws IOException
     */
    public static void copyFile(String source, String destination)
            throws IOException
    {
        InputStream in = new FileInputStream(source);
        saveFile(in, destination);
    }

    /**
     * 判断一个对象是否为null或空 <br>
     * 如果对象为null返回true <br>
     * 如果对象为空String、空Array、空Map、空Collection返回true <br>
     * 否则返回false
     * 
     * @param o
     * @return
     */
    public static boolean empty(Object o)
    {
        if (o == null)
            return true;
        else if (o instanceof String)
            return ((String) o).length() == 0;
        else if (o instanceof Collection)
            return ((Collection) o).size() == 0;
        else if (o instanceof Map)
            return ((Map) o).size() == 0;
        else if (o instanceof Object[])
            return ((Object[]) o).length == 0;
        else
            return false;
    }
}