<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<!-- 引入基本库和js，css文件 --> 
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${siteName}后台管理</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" />
   <%@ include file="/WEB-INF/content/admins/taglib.jsp"%>
   <script language="javascript" type="text/javascript" src="${base}/sucai/My97DatePicker/WdatePicker.js"></script>
   <style type="text/css">
   	.layui-layer-content{
   		margin: 10px;
   	}
   </style> 
   <script type="text/javascript">
   </script> 
</head>
<body>
<%@ include file="/WEB-INF/content/admins/header.jsp"%> 



<div class="am-cf admin-main">
<%@ include file="/WEB-INF/content/admins/side.jsp"%> 

  <!-- content start -->
  <div class="admin-content" id="admin-content">
  
  	<ol class="am-breadcrumb">
	  <li><a href="${base}/admins/" class="am-icon-home">后台首页</a></li>
	  <li>编辑友情链接</li>
	</ol>
	
	
    <div class="am-g">
      <div class="am-u-sm-12">
		<form class="am-form" action="${base}/admins/linkUpdate/" method="post" enctype="multipart/form-data">
			<input type="hidden" name="link.id" value="${link.id}"/>
			  <fieldset>
			    <legend>编辑友情链接</legend>
			    <div class="am-form-group">
			      <label for="admin-admin-picRec-form-title">网站名</label>
			      <input type="text" class="" id="admin-admin-picRec-form-title" name="link.title" value="${link.title }" placeholder="请输入网站名" required>
			    </div>
			    <div class="am-form-group">
			      <label for="admin-admin-picRec-form-url">URL</label>
			      <input type="url" id="doc-vld-url-2" placeholder="请输入网址" value="${link.url }"  name="link.url" required/>
			    </div>
			     <div class="am-form-group">
			      <label for="admin-admin-picRec-form-sn">排序</label>
			      <input type="number" id="admin-admin-picRec-form-sn" name="link.sn" value="${link.sn }" placeholder="请输入排序号，不输入默认为其ID" />
			    </div>
			    <p><button type="submit" class="am-btn am-btn-default">提交</button></p>
			  </fieldset>
			</form>
 			
      </div>
    </div>
    
    
  </div>
  <!-- content end -->

</div>


<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
</body>
</html>