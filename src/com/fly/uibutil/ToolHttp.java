
package com.fly.uibutil;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.log4j.Logger;

/**
 * HTTP请求相关
 * 
 * @author 董华健
 */
@SuppressWarnings("deprecation")
public class ToolHttp
{

    private static Logger log = Logger.getLogger(ToolHttp.class);

    /**
     * 原生方式请求
     * 
     * @param isHttps 是否https
     * @param requestUrl 请求地址
     * @param requestMethod 请求方式（GET、POST）
     * @param outputStr 提交的数据
     * @return
     */
    public static String httpRequest(boolean isHttps, String requestUrl,
            String requestMethod, String outputStr)
    {
        HttpURLConnection conn = null;

        OutputStream outputStream = null;
        OutputStreamWriter outputStreamWriter = null;
        PrintWriter printWriter = null;

        InputStream inputStream = null;
        InputStreamReader inputStreamReader = null;
        BufferedReader bufferedReader = null;

        try
        {
            URL url = new URL(requestUrl);
            conn = (HttpURLConnection) url.openConnection();
            if (isHttps)
            {
                HttpsURLConnection httpsConn = (HttpsURLConnection) conn;
                // 创建SSLContext对象，并使用我们指定的信任管理器初始化
                TrustManager[] tm = {new X509TrustManager()
                {
                    @Override
                    public void checkClientTrusted(X509Certificate[] chain,
                            String authType) throws CertificateException
                    {
                        // 检查客户端证书
                    }

                    public void checkServerTrusted(X509Certificate[] chain,
                            String authType) throws CertificateException
                    {
                        // 检查服务器端证书
                    }

                    public X509Certificate[] getAcceptedIssuers()
                    {
                        // 返回受信任的X509证书数组
                        return null;
                    }
                }};
                SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
                sslContext.init(null, tm, new java.security.SecureRandom());
                SSLSocketFactory ssf = sslContext.getSocketFactory();// 从上述SSLContext对象中得到SSLSocketFactory对象
                httpsConn.setSSLSocketFactory(ssf);
                conn = httpsConn;
            }

            // 超时设置，防止 网络异常的情况下，可能会导致程序僵死而不继续往下执行
            conn.setConnectTimeout(30000);
            conn.setReadTimeout(30000);

            // 设置是否向httpUrlConnection输出，因为这个是post请求，参数要放在
            // http正文内，因此需要设为true, 默认情况下是false;
            conn.setDoOutput(true);

            // 设置是否从httpUrlConnection读入，默认情况下是true;
            conn.setDoInput(true);

            // Post 请求不能使用缓存
            conn.setUseCaches(false);

            // 设定传送的内容类型是可序列化的java对象
            // (如果不设此项,在传送序列化对象时,当WEB服务默认的不是这种类型时可能抛java.io.EOFException)
            conn.setRequestProperty("Content-type",
                    "application/x-www-form-urlencoded");

            // 设置请求方式（GET/POST），默认是GET
            conn.setRequestMethod(requestMethod);

            // 连接，上面对urlConn的所有配置必须要在connect之前完成，
            conn.connect();

            // 当outputStr不为null时向输出流写数据
            if (null != outputStr)
            {
                outputStream = conn.getOutputStream();
                outputStreamWriter = new OutputStreamWriter(outputStream,
                        "UTF-8");
                printWriter = new PrintWriter(outputStreamWriter);
                printWriter.write(outputStr);
                printWriter.flush();
                printWriter.close();
            }

            // 从输入流读取返回内容
            inputStream = conn.getInputStream();
            inputStreamReader = new InputStreamReader(inputStream,
                    ToolString.encoding);
            bufferedReader = new BufferedReader(inputStreamReader);
            String str = null;
            StringBuilder buffer = new StringBuilder();
            while ((str = bufferedReader.readLine()) != null)
            {
                buffer.append(str).append("\n");
            }

            return buffer.toString();
        }
        catch (ConnectException ce)
        {
            log.error("连接超时：{}", ce);
            return null;

        }
        catch (Exception e)
        {
            log.error("https请求异常：{}", e);
            return null;

        }
        finally
        { // 释放资源
            if (null != outputStream)
            {
                try
                {
                    outputStream.close();
                }
                catch (IOException e)
                {
                    log.error("outputStream.close()异常", e);
                }
                outputStream = null;
            }

            if (null != outputStreamWriter)
            {
                try
                {
                    outputStreamWriter.close();
                }
                catch (IOException e)
                {
                    log.error("outputStreamWriter.close()异常", e);
                }
                outputStreamWriter = null;
            }

            if (null != printWriter)
            {
                printWriter.close();
                printWriter = null;
            }

            if (null != bufferedReader)
            {
                try
                {
                    bufferedReader.close();
                }
                catch (IOException e)
                {
                    log.error("bufferedReader.close()异常", e);
                }
                bufferedReader = null;
            }

            if (null != inputStreamReader)
            {
                try
                {
                    inputStreamReader.close();
                }
                catch (IOException e)
                {
                    log.error("inputStreamReader.close()异常", e);
                }
                inputStreamReader = null;
            }

            if (null != inputStream)
            {
                try
                {
                    inputStream.close();
                }
                catch (IOException e)
                {
                    log.error("inputStream.close()异常", e);
                }
                inputStream = null;
            }

            if (null != conn)
            {
                conn.disconnect();
                conn = null;
            }
        }
    }

    public static void main(String[] args)
    {
        // System.out.println(get("http://127.0.0.1:89/jf/platform/login"));
        // System.out.println(post("http://127.0.0.1:89/jf/platform/login",
        // null, null));

        // System.out.println(get("http://littleant.duapp.com/msg"));

        /*
         * String returnMsg = "<xml>"; returnMsg +=
         * "<ToUserName><![CDATA[dongcb678]]></ToUserName>"; returnMsg +=
         * "<FromUserName><![CDATA[jiu_guang]]></FromUserName>"; returnMsg +=
         * "<CreateTime>"+ToolDateTime.getDateByTime()+"</CreateTime>";
         * returnMsg += "<MsgType><![CDATA[text]]></MsgType>"; returnMsg +=
         * "<Content><![CDATA[你好]]></Content>"; returnMsg += "</xml>";
         */

        /*
         * String returnMsg = "<xml>"; returnMsg +=
         * " <ToUserName><![CDATA[jiu_guang]]></ToUserName>"; returnMsg +=
         * " <FromUserName><![CDATA[dongcb678]]></FromUserName> "; returnMsg +=
         * " <CreateTime>1348831860</CreateTime>"; returnMsg +=
         * " <MsgType><![CDATA[text]]></MsgType>"; returnMsg +=
         * " <Content><![CDATA[this is a test]]></Content>"; returnMsg +=
         * " <MsgId>1234567890123456</MsgId>"; returnMsg += " </xml>";
         */

        // System.out.println(post("http://127.0.0.1:88/msg", returnMsg,
        // "application/xml"));
        // System.out.println(post("http://littleant.duapp.com/msg", returnMsg,
        // "application/xml"));

        // System.out.println(post(true,
        // "https://www.oschina.net/home/login?goto_page=http%3A%2F%2Fwww.oschina.net%2F",
        // null, "application/text"));
        System.out.println(httpRequest(false,
                "https://passport.csdn.net/account/login", "GET", null));
    }
}
