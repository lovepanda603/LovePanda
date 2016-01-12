
package com.fly.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.im4java.core.ConvertCmd;
import org.im4java.core.IMOperation;
import org.im4java.core.IdentifyCmd;
import org.im4java.process.ArrayListOutputConsumer;

import com.jfinal.kit.PropKit;

public class ImageMagicUtil
{
    /**
     * 对图片格式进行转换，把CMYK印刷用的图片转为RGB图片
     */
    public static void CMYK2RGB(String src, String dest) throws Exception
    {
        IMOperation op = new IMOperation();
        op.addImage(src);

        IdentifyCmd identify = new IdentifyCmd();
        identify.setSearchPath(PropKit.get("ImageMagickPath"));
        ArrayListOutputConsumer output = new ArrayListOutputConsumer();
        identify.setOutputConsumer(output);
        identify.run(op);

        String text = null;
        ArrayList<String> lines = output.getOutput();
        if (lines.size() > 0)
            text = lines.get(0);

        if (text != null && text.indexOf("CMYK") != -1)
        {
            ConvertCmd convert = new ConvertCmd();
            convert.setSearchPath(PropKit.get("ImageMagickPath"));
            op = new IMOperation();
            op.profile(PropKit.get("CMYKICC"));
            op.colorspace("CMYK");
            op.addImage(src);
            op.profile(PropKit.get("RGBICC"));
            op.colorspace("RGB");
            op.addImage(dest);
            convert.run(op);
        }
    }

    /**
     * 清除图片exif信息，保证图片正确旋转
     */
    public static void strip(String src, String dest) throws Exception
    {
        ConvertCmd convert = new ConvertCmd();
        convert.setSearchPath(PropKit.get("ImageMagickPath"));

        IMOperation op = new IMOperation();
        op.autoOrient();
        op.strip();
        op.addImage(src);
        op.addImage(dest);
        convert.run(op);
    }

    /**
     * 定宽制作缩略图，如果图片原始宽度小于指定宽度，不做改变只做文件复制
     */
    public static void width(String src, String dest, int width)
            throws Exception
    {
        BufferedImage image = ImageIO.read(new File(src));
        if (image != null)
        {
            if (image.getWidth() > width)
            {
                ConvertCmd convert = new ConvertCmd();
                convert.setSearchPath(PropKit.get("ImageMagickPath"));

                IMOperation op = new IMOperation();
                op.resize(width);
                op.addImage(src);
                op.addImage(dest);
                convert.run(op);
            }
            else
            {
                FileUtils.copyFile(new File(src), new File(dest));
            }
            image = null;
        }
    }

    /**
     * 定高定宽制作缩略图，对原图做等比例剪裁
     */
    public static void resize(String src, String dest, int width, int height)
            throws Exception
    {
        BufferedImage image = ImageIO.read(new File(src));
        if (image != null)
        {
            int ow = image.getWidth();
            int oh = image.getHeight();
            double scale = (double) width / height;

            // 计算剪裁坐标
            int cropWidth = ow, cropHeight = oh, x = 0, y = 0;
            if ((double) ow / oh > scale)
            {
                // 高不足，剪裁宽度
                cropWidth = Double.valueOf(oh * scale).intValue();
                cropHeight = oh;
                x = (ow - cropWidth) / 2;
                y = 0;
            }
            if ((double) ow / oh < scale)
            {
                // 宽不足，剪裁高度
                cropHeight = Double.valueOf(ow / scale).intValue();
                cropWidth = ow;
                x = 0;
                y = 0;
            }

            ConvertCmd convert = new ConvertCmd();
            convert.setSearchPath(PropKit.get("ImageMagickPath"));

            IMOperation op = new IMOperation();
            op.addImage(src);
            op.crop(cropWidth, cropHeight, x, y);
            op.addImage(dest);
            convert.run(op);

            op = new IMOperation();
            op.resize(width, height);
            op.addImage(dest);
            op.addImage(dest);
            convert.run(op);

            image = null;
        }
    }

    /**
     * 获得指定图片的宽度和高度，用数组方式返回数据<br/>
     * 数组第一位数据为宽度，第二位数据为高度
     */
    public static int[] getImageWH(String src) throws Exception
    {
        int[] wh = new int[]{0, 0};
        BufferedImage image = ImageIO.read(new File(src));
        if (image != null)
        {
            wh[0] = image.getWidth();
            wh[1] = image.getHeight();
            image = null;
        }
        return wh;
    }

    /**
     * 根据坐标裁剪图片
     * 
     * @param srcPath 要裁剪图片的路径
     * @param newPath 裁剪图片后的路径
     * @param x 起始横坐标
     * @param y 起始纵坐标
     * @param x1 结束横坐标
     * @param y1 结束纵坐标
     */

    public static void cutImage(String srcPath, String newPath, int x, int y,
            int w, int h) throws Exception
    {
        int width = w;
        int height = h;
        ConvertCmd convert = new ConvertCmd();
        convert.setSearchPath(PropKit.get("ImageMagickPath"));
        IMOperation op = new IMOperation();
        op.addImage(srcPath);
        /**
         * width： 裁剪的宽度 height： 裁剪的高度 x： 裁剪的横坐标 y： 裁剪的挫坐标
         */
        op.crop(width, height, x, y);
        op.addImage(newPath);
        convert.run(op);
    }
}
