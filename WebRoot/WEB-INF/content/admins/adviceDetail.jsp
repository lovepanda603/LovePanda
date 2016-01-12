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
  <link rel="stylesheet" href="${base}/kindeditor-4.1.10/plugins/code/prettify.css" />
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/kindeditor.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/plugins/code/prettify.js"></script>
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
	  <li><a href="${base}/admins/adviceList/">意见和建议列表</a></li>
	  <li>意见和建议详情</li>
	</ol>
	
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table">
          	<tr>
          		<td width="150px">意见和建议</td>
          		<td>
          			${advice.content}
          		</td>
          	</tr>
          	<tr>
          		<td>关联用户</td>
          		<td>
          			${advice.username}
          		</td>
          	</tr>
          	<tr>
          		<td>姓名</td>
          		<td>
          			${advice.name}
          		</td>
          	</tr>
          	<tr>
          		<td>联系方式</td>
          		<td>
          			${advice.contact}
          		</td>
          	</tr>
          	<tr>
          		<td>创建时间</td>
          		<td>
          			<fmt:formatDate value="${advice.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
          		</td>
          	</tr>
          	<tr>
          		<td><a type="button" class="am-btn am-btn-default" onclick="javascript:history.back(-2)">返回</a></td>
          		<td></td>
          	</tr>
          </table>
      </div>
    </div>
    
    
  </div>
  <!-- content end -->

</div>

<script>
	prettyPrint();
</script>
<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
</body>
</html>