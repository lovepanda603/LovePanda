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
<div class="am-cf am-g admin-main">
<%@ include file="/WEB-INF/content/admins/side.jsp"%> 

  <!-- content start -->
  <div class="admin-content" id="admin-content">
	  <ol class="am-breadcrumb">
		  <li><a href="${base}/admins/" class="am-icon-home">后台首页</a></li>
		  <li>封禁的用户</li>
	  </ol>
  	<script type="text/javascript">
		function recoverUser(id){
			layer.confirm('确定解封该用户吗？', {
   			    btn: ['确定解封','取消'] //按钮
   			}, function(){
		   		location.href="${base}/admins/userRecover?id="+id;
   			}, function(){
   			    layer.msg('取消了');
   			});
		}
	</script>
   	
	  <div class="am-g">
	  	<div class="am-u-sm-12">
			<form action="${base}/admins/listDeletedUsers/" method="get">
				<h3>用户条件检索</h3>
				<table class="am-table">
				  <tr>
				    <th>用户名</th>
				    <th>
				    	<input type="text" class="am-form-field am-radius" name="user.username" value="${user.username}" />
				    </th>
				    <th>昵称</th>
				    <th>
				    	<input type="text" class="am-form-field am-radius" name="user.realname" value="${user.realname}" />
				    </th>
				  </tr>
				  <tr>
				    <th>类型</th>
				    <th>
				    	<select name="user.type" value="${user.type}">
				    		<c:if test="${empty user.type}">
					    		<option value="" selected="selected">全部</option>
					    		<option value="0">注册用户</option>
					    		<option value="1">QQ互联用户</option>
				    		</c:if>
				    		<c:if test="${user.type==0}">
					    		<option value="">全部</option>
					    		<option value="0" selected="selected">注册用户</option>
					    		<option value="1">QQ互联用户</option>
				    		</c:if>
				    		<c:if test="${user.type==1}">
					    		<option value="">全部</option>
					    		<option value="0">注册用户</option>
					    		<option value="1" selected="selected">QQ互联用户</option>
				    		</c:if>
				    	</select>
				    </th>
				    <th colspan="2">
				    	<button type="submit" class="am-btn am-btn-primary">搜索</button>
				    </th>
				  </tr>
				</table>
			</form>
			<!-- 分割线 -->
			<hr data-am-widget="divider" style="" class="am-divider am-divider-dashed"/>
	  		<table class="am-table am-table-bordered am-table-striped am-table-hover">
			    <thead>
			        <tr>
			            <th width="25%">用户名</th>
			            <th width="25%">昵称</th>
			            <th width="15%">类型</th>
			            <th width="15%">创建时间</th>
			            <th width="20%">操作</th>
			        </tr>
			    </thead>
			    <tbody>
				    <c:forEach items="${userPage.list}" var="l">
				        <tr class="">
				            <td>${l.username}</td>
				            <td>${l.realname}</td>
				            <td>
				            	<c:if test="${l.type==0}">
				            		注册用户
				            	</c:if>
				            	<c:if test="${l.type==1 }">
				            		QQ互联用户
				            	</c:if>
				            </td>
				            <td><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				            <td>
				            	<div class="am-btn-toolbar">
				                  <div class="am-btn-group am-btn-group-xs">
				                    <a class="am-btn am-btn-default am-btn-xs am-text-primary" onclick="recoverUser(${l.id})"><span class="am-icon-hand-o-right"></span> 解封</a>
				                  </div>
				                </div>
				            </td>
				        </tr>
				    </c:forEach>
			    </tbody>
			</table>
				<c:set var="currentPage" value="${userPage.pageNumber}" />
				<c:set var="totalPage" value="${userPage.totalPage}" />
				<c:set var="actionUrl" value="${base}/admins/listDeletedUsers?user.username=${user.username}&user.realname=${user.realname}&user.type=${user.type}&page=" />
				<c:set var="urlParas" value=""/>
				<center>
					<%@ include file="/common/_paginate.jsp"%>
				</center>
	    </div>
	 </div>
		
  </div>
  <!-- content end -->
</div>

<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
</body>
</html>