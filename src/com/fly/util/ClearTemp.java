
package com.fly.util;

import java.io.File;

import com.jfinal.kit.PathKit;

public class ClearTemp
{
    public static void clear()
    {
        String tempfo = PathKit.getWebRootPath() + "/attached/temp/";
        File temp = new File(tempfo);
        deleteDir(temp);
    }

    /**
     * 递归删除目录下的所有文件及子目录下所有文件
     * 
     * @param dir 将要删除的文件目录
     * @return boolean Returns "true" if all deletions were successful. If a
     *         deletion fails, the method stops attempting to delete and returns
     *         "false".
     */
    private static boolean deleteDir(File dir)
    {
        if (dir.isDirectory())
        {
            String[] children = dir.list();
            for (int i = 0; i < children.length; i++)
            {
                boolean success = deleteDir(new File(dir, children[i]));
            }
        }
        return true;
    }
}
