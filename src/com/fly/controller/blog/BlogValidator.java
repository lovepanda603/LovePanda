
package com.fly.controller.blog;

import com.fly.common.Constants;
import com.fly.entity.Blog;
import com.jfinal.core.Controller;
import com.jfinal.upload.UploadFile;
import com.jfinal.validate.Validator;

/**
 * BlogValidator.
 */
public class BlogValidator extends Validator
{

  protected void validate(Controller controller)
  {
    UploadFile file = controller.getFile("upload");
    validateRequiredString("blog.title", "titleMsg", "博客标题不能为空");
    validateRequiredString("blog.ispublic", "ispublicMsg", "是否公开不能为空");
    validateRequiredString("blog.category", "categoryMsg", "博客分类不能为空");
    validateRequiredString("blog.content", "contentMsg", "博客内容不能为空");
    validateRequiredString("blog.zhuanzai", "zhuanzaiMsg", "转载不能为空");
    if (controller.getParaToInt("blog.zhuanzai") == 1)
    {
      validateUrl("blog.zhuanzaiurl", "zhuanzaiurlMsg", "转载地址格式不对或为空");
    }
  }

  protected void handleError(Controller controller)
  {
    controller.keepModel(Blog.class);

    String actionKey = getActionKey();
    if (actionKey.equals("/blog/save"))
    {
      controller.setAttr("listBlogcategory", Constants.listBlogcategory);
      controller.render("add.jsp");
    }
    else if (actionKey.equals("/blog/update"))
      controller.render("edit.jsp");
  }
}
