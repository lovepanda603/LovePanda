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
</head>
<body>
<%@ include file="/WEB-INF/content/admins/header.jsp"%> 



<div class="am-cf admin-main">
<%@ include file="/WEB-INF/content/admins/side.jsp"%> 

  <!-- content start -->
  <div class="admin-content" id="admin-content">
  	<ol class="am-breadcrumb">
	  <li><a href="${base}/admins/" class="am-icon-home">后台首页</a></li>
	  <li><a href="${base}/admins/gonggaoList/">滚动公告列表</a></li>
	  <li>新建滚动公告</li>
	</ol>
	
    <div class="am-g">
      <div class="am-u-sm-12">
     	<form class="am-form am-form-horizontal" action="${base}/admins/gonggaoUpdate/" method="post" enctype="multipart/form-data">
     	<input type="hidden" name="gonggao.id" value="${gonggao.id}">
		  <div class="am-form-group">
		    <label for="gonggao-edit-content" class="am-u-sm-2 am-form-label">内容</label>
		    <div class="am-u-sm-10">
		      <input type="text" id="gonggao-edit-content" name="gonggao.content"   placeholder="请输入公告内容">
		    </div>
		  </div>
		  
		  <div class="am-form-group">
		    <label for="gonggao-edit-url" class="am-u-sm-2 am-form-label">URL</label>
		    <div class="am-u-sm-10">
		      <input type="text" id="gonggao-edit-url" name="gonggao.url" value="${gonggao.url}" placeholder="请输入公告URL">
		    </div>
		  </div>
		  
		  <div class="am-form-group">
		    <label for="gonggao-edit-sn" class="am-u-sm-2 am-form-label">排序号</label>
		    <div class="am-u-sm-10">
		      <input type="number" id="gonggao-edit-sn"  name="gonggao.sn" value="${gonggao.sn}" placeholder="不填写自动生成，排序号按从小到大自动播放">
		    </div>
		  </div>
		
		  <div class="am-form-group">
		    <div class="am-u-sm-10 am-u-sm-offset-2">
		      <button type="submit" class="am-btn am-btn-default">提交</button>
		      <a type="button" class="am-btn am-btn-default" onclick="javascript:history.back(-2)">返回</a>
		    </div>
		  </div>
		</form>
      </div>
    </div>
  </div>
  <!-- content end -->

</div>

<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
<script type="text/javascript">
	$(function(){
		$("input[name='gonggao.content']").val('${gonggao.content}');
	})
</script>
</body>
</html>
