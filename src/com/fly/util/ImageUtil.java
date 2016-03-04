
package com.fly.util;

import java.awt.Image;
import java.awt.Rectangle;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;
import net.coobird.thumbnailator.geometry.Positions;

/**
 * @author lovepanda 图片工具类
 */
public class ImageUtil
{
    /*
     * 根据尺寸图片居中裁剪
     */
    public static void cutCenterImage(String src, String dest, int w, int h)
            throws IOException
    {
        Iterator iterator = ImageIO.getImageReadersByFormatName("jpg");
        ImageReader reader = (ImageReader) iterator.next();
        InputStream in = new FileInputStream(src);
        ImageInputStream iis = ImageIO.createImageInputStream(in);
        reader.setInput(iis, true);
        ImageReadParam param = reader.getDefaultReadParam();
        int imageIndex = 0;
        Rectangle rect = new Rectangle((reader.getWidth(imageIndex) - w) / 2,
                (reader.getHeight(imageIndex) - h) / 2, w, h);
        param.setSourceRegion(rect);
        BufferedImage bi = reader.read(0, param);
        ImageIO.write(bi, "jpg", new File(dest));

    }

    /*
     * 图片裁剪二分之一
     */
    public static void cutHalfImage(String src, String dest) throws IOException
    {
        Iterator iterator = ImageIO.getImageReadersByFormatName("jpg");
        ImageReader reader = (ImageReader) iterator.next();
        InputStream in = new FileInputStream(src);
        ImageInputStream iis = ImageIO.createImageInputStream(in);
        reader.setInput(iis, true);
        ImageReadParam param = reader.getDefaultReadParam();
        int imageIndex = 0;
        int width = reader.getWidth(imageIndex) / 2;
        int height = reader.getHeight(imageIndex) / 2;
        Rectangle rect = new Rectangle(width / 2, height / 2, width, height);
        param.setSourceRegion(rect);
        BufferedImage bi = reader.read(0, param);
        ImageIO.write(bi, "jpg", new File(dest));
    }

    /*
     * 图片裁剪通用接口
     */

    public static void cutImage(String src, String dest, int x, int y, int w,
            int h, String formatName) throws IOException
    {
        Iterator iterator = ImageIO.getImageReadersByFormatName(formatName);
        ImageReader reader = (ImageReader) iterator.next();
        InputStream in = new FileInputStream(src);
        ImageInputStream iis = ImageIO.createImageInputStream(in);
        reader.setInput(iis, true);
        ImageReadParam param = reader.getDefaultReadParam();
        Rectangle rect = new Rectangle(x, y, w, h);
        param.setSourceRegion(rect);
        BufferedImage bi = reader.read(0, param);
        ImageIO.write(bi, formatName, new File(dest));

    }

    /*
     * 图片缩放
     */
    public static void zoomImage(String src, String dest, int w, int h)
            throws Exception
    {
        double wr = 0, hr = 0;
        File srcFile = new File(src);
        File destFile = new File(dest);
        BufferedImage bufImg = ImageIO.read(srcFile);
        Image Itemp = bufImg.getScaledInstance(w, h, bufImg.SCALE_SMOOTH);
        wr = w * 1.0 / bufImg.getWidth();
        hr = h * 1.0 / bufImg.getHeight();
        AffineTransformOp ato = new AffineTransformOp(
                AffineTransform.getScaleInstance(wr, hr), null);
        Itemp = ato.filter(bufImg, null);
        try
        {
            ImageIO.write((BufferedImage) Itemp,
                    dest.substring(dest.lastIndexOf(".") + 1), destFile);
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }
    }

    /**
     * @author lovepanda 2016年3月4日16:36:30 图片缩略图
     *         如果图片小于你要求的图片，会对图片缩放后在裁剪，图片的不会拉伸，保证图片的真实性
     * @param with
     * @param height
     * @param src
     * @param dest
     * @throws IOException
     */
    public static void resize(int with, int height, String src, String dest)
            throws IOException
    {
        String imagePath = src;

        BufferedImage image = ImageIO.read(new File(imagePath));

        Builder<BufferedImage> builder = null;

        int imageWidth = image.getWidth();

        int imageHeitht = image.getHeight();

        if ((float) with / height != (float) imageWidth / imageHeitht)
        {

            if (imageWidth > imageHeitht)
            {

                image = Thumbnails.of(imagePath)
                        .height(height)
                        .asBufferedImage();

            }
            else
            {

                image = Thumbnails.of(imagePath).width(with).asBufferedImage();

            }

            builder = Thumbnails.of(image)
                    .sourceRegion(Positions.CENTER, with, height)
                    .size(with, height);

        }
        else
        {

            builder = Thumbnails.of(image).size(with, height);

        }

        builder.toFile(dest);
    }

    public static void main(String[] args) throws IOException
    {
        ImageUtil.resize(300, 400, "E:/ls/gifcs2.gif", "E:/ls/s_gifcs2.gif");
        System.out.println("success");
    }
}
