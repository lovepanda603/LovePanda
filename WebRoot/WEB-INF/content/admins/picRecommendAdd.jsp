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
	  <li>新建首页图片推荐</li>
	</ol>
	
	
    <div class="am-g">
      <div class="am-u-sm-12">
		<form class="am-form" action="${base}/admins/picRecommendSave/" method="post" enctype="multipart/form-data">
			  <fieldset>
			    <legend>新建首页图片推荐</legend>
			
			
			    <div class="am-form-group">
			      <label for="admin-admin-picRec-form-title">推荐标题</label>
			      <input type="text" class="" id="admin-admin-picRec-form-title" name="pic.title" placeholder="请输入推荐标题">
			    </div>
		
			
			    <div class="am-form-group am-form-file">
			      <label for="admin-admin-picRec-form-image">推荐图片上传</label>
			      <div class="am-form-group am-form-file">
				  <button type="button" class="am-btn am-btn-danger am-btn-sm">
				    <i class="am-icon-cloud-upload"></i> 选择要上传的文件，建议尺寸：631*350</button>
				  <input id="admin-admin-picRec-form-image" type="file" name="upload" multiple>
				</div>
				<div id="file-list"></div>
				<script>
				  $(function() {
				    $('#admin-admin-picRec-form-image').on('change', function() {
				      var fileNames = '';
				      $.each(this.files, function() {
				        fileNames += '<span class="am-badge">' + this.name + '</span> ';
				      });
				      $('#file-list').html(fileNames);
				    });
				  });
				</script>
			    </div>
			    <div class="am-form-group">
			      <label for="admin-admin-picRec-form-url">URL</label>
			      <input type="url" id="doc-vld-url-2" placeholder="请输入网址"  name="pic.url"/>
			    </div>
			     <div class="am-form-group">
			      <label for="admin-admin-picRec-form-sn">排序</label>
			      <input type="number" id="admin-admin-picRec-form-sn" name="pic.sn" placeholder="请输入排序号，不输入默认为其ID" />
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