
package com.fly.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.zip.GZIPOutputStream;

import javax.servlet.ServletOutputStream;

public class GZIPServletOutputStream extends ServletOutputStream
{
    private GZIPOutputStream gzip;

    public GZIPServletOutputStream(ByteArrayOutputStream buffer)
            throws IOException
    {
        this.gzip = new GZIPOutputStream(buffer);
    }

    public void write(int b) throws IOException
    {
        this.gzip.write(b);
    }

    public void close() throws IOException
    {
        this.gzip.finish();
        this.gzip.close();
    }
}
