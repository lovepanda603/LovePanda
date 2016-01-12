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
   	function deleteLink(id){
   			layer.confirm('确定删除该友情链接吗？', {
   			    btn: ['确定删除','取消'] //按钮
   			}, function(){
		   		location.href="${base}/admins/linkDelete/"+id;
   			}, function(){
   			    layer.msg('取消了');
   			});
   	}
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
	  <li>友情链接</li>
	</ol>
	
	
    <div class="am-g">
      <div class="am-u-sm-12">
		<table class="am-table am-table-bordered am-table-striped am-table-hover">
		    <thead>
		        <tr>
		            <th width="10%">id</th>
		            <th width="20%">网站名</th>
		            <th width="20%">url</th>
		            <th width="10%">序号</th>
		            <th width="20%">创建时间</th>
		            <th width="20%">操作</th>
		        </tr>
		    </thead>
		    <tbody>
			    <c:forEach items="${linkList}" var="l">
			        <tr class="">
			            <td>${l.id}</td>
			            <td>${l.title}</td>
			            <td>${l.url}</td>
			            <td>${l.sn}</td>
			            <td><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			            <td>
			            	<a class="am-btn am-btn-success am-btn-xs" href="${base}/admins/linkEdit/${l.id}"><span class="am-icon-edit"></span> 修改</a>
			            	<a class="am-btn am-btn-danger am-btn-xs" onclick="deleteLink(${l.id})"><span class="am-icon-trash-o"></span> 删除</a>
			            </td>
			        </tr>
			    </c:forEach>
		    </tbody>
		</table>
		<div class="am-btn-group am-btn-group-xs">
          <button type="button" class="am-btn am-btn-default" onclick="javascript:location.href='${base}/admins/linkAdd/'"><span class="am-icon-plus"></span> 新增</button>
          <button type="button" class="am-btn am-btn-default" onclick="javascript:location.href='${base}/admins/linkRefresh/'"><i class="am-icon-circle-o-notch am-icon-spin"></i> 刷新缓存</button>
        </div>
 			
      </div>
    </div>
    
    
  </div>
  <!-- content end -->

</div>


<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
</body>
</html>