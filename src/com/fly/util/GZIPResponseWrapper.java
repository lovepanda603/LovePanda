
package com.fly.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

public class GZIPResponseWrapper extends HttpServletResponseWrapper
{
    private ByteArrayOutputStream buffer;

    private ServletOutputStream stream;

    private PrintWriter writer;

    public GZIPResponseWrapper(HttpServletResponse response)
    {
        super(response);
        this.buffer = new ByteArrayOutputStream(1024);
    }

    public ServletOutputStream getOutputStream() throws IOException
    {
        if (this.writer != null)
        {
            throw new IllegalStateException(
                    "getWriter() has already been called for this response");
        }
        if (this.stream == null)
        {
            this.stream = createOutputStream();
        }
        return this.stream;
    }

    public PrintWriter getWriter() throws IOException
    {
        if (this.writer != null)
        {
            return this.writer;
        }
        if (this.stream != null)
        {
            throw new IllegalStateException(
                    "getOutputStream() has already been called for this response");
        }
        this.stream = createOutputStream();
        this.writer = new PrintWriter(new OutputStreamWriter(this.stream,
                getCharacterEncoding()));
        return this.writer;
    }

    public void finish() throws IOException
    {
        try
        {
            if (this.writer != null)
            {
                this.writer.close();
            }
            if (this.stream != null)
            {
                this.stream.close();
            }
        }
        catch (IOException localIOException)
        {
        }
    }

    public ByteArrayOutputStream getBuffer()
    {
        return this.buffer;
    }

    private ServletOutputStream createOutputStream() throws IOException
    {
        return new GZIPServletOutputStream(this.buffer);
    }
}