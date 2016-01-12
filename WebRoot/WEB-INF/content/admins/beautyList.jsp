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
   <style type="text/css">
   </style> 
   <script type="text/javascript">
   	function deleteBeauty(id){
   			layer.confirm('确定删除该美图吗？', {
   			    btn: ['确定删除','取消'] //按钮
   			}, function(){
		   		location.href="${base}/admins/beautyDelete/"+id;
   			}, function(){
   			    layer.msg('取消了');
   			});
   	}
   	function editBeautyLevel(id){
		  $.post("${base}/admins/toBeautyLevel/"+id,
				   function(data){
				   //页面层
					var index=layer.open({
					    type: 1,
					    skin: 'layui-layer-rim', //加上边框
					    area: ['420px', '240px'], //宽高
					    btn:['提交'],
					    yes:function(){
					    	$("#beautyleveleditform").submit();
					    },
					    content: $("#beautyleveleditform")
					});
					  layer.title(data.title, index);
				     $("#beautyleveleditform > input[name='id']").val(data.id);
				     $("#beautylevelselect").val(data.level);
				   }, "json");
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
	  <li>美图列表</li>
	</ol>
	
	
    <div class="am-g">
      <div class="am-u-sm-12">
		<form action="${base}/admins/beautyList/" method="get">
				<h3>美图条件检索</h3>
				<table class="am-table">
				  <tr>
				    <th>美图标题</th>
				    <th>
				    	<input type="text" class="am-form-field am-radius" name="beauty.title" value="${beauty.title}" />
				    </th>
				    <th>作者</th>
				    <th>
				    	<input type="text" class="am-form-field am-radius" name="bozhu" value="${bozhu}" />
				    </th>
				  </tr>
				  <tr>
				    <th>美图等级</th>
				    <th>
				    	<select name="beauty.level" value="${beauty.level}">
					    	<c:if test="${empty beauty.level}">
					    		 <option value="" selected="selected">全部</option>
					    		 <option value="0">默认</option>
						         <option value="1">热门</option>
						         <option value="2">推荐</option>
						         <option value="3">置顶</option>
					    	</c:if>
					    	<c:if test="${beauty.level==0}">
					    		 <option value="">全部</option>
					    		 <option value="0" selected="selected">默认</option>
						         <option value="1">热门</option>
						         <option value="2">推荐</option>
						         <option value="3">置顶</option>
					    	</c:if>
					    	<c:if test="${beauty.level==1}">
						         <option value="">全部</option>
						         <option value="0">默认</option>
						         <option value="1" selected="selected">热门</option>
						         <option value="2">推荐</option>
						         <option value="3">置顶</option>
					    	</c:if>
					    	<c:if test="${beauty.level==2}">
						         <option value="">全部</option>
						         <option value="0">默认</option>
						         <option value="1">热门</option>
						         <option value="2" selected="selected">推荐</option>
						         <option value="3">置顶</option>
					    	</c:if>
					    	<c:if test="${beauty.level==3}">
						         <option value="">全部</option>
						         <option value="0">默认</option>
						         <option value="1">热门</option>
						         <option value="2">推荐</option>
						         <option value="3" selected="selected">置顶</option>
					    	</c:if>
				    	</select>
				    </th>
				    <th colspan="2">
				  		<button type="submit" class="am-btn am-btn-primary">搜素</button>
				    </th>
				  </tr>
				</table>
			</form>
			<!-- 分割线 -->
			<hr data-am-widget="divider" style="" class="am-divider am-divider-dashed"/>
	  		<table class="am-table am-table-bordered am-table-striped am-table-hover">
			    <thead>
			        <tr>
			            <th width="30%">美图标题</th>
			            <th width="10%">作者</th>
			            <th width="8%">等级</th>
			            <th width="15%">创建时间</th>
			            <th width="37%">操作</th>
			        </tr>
			    </thead>
			    <tbody>
				    <c:forEach items="${beautyPage.list}" var="l">
				        <tr class="">
				            <td>${l.title}</td>
				            <td>${l.username}</td>
				            <td>
				            	<c:if test="${l.level==0}">
				            		默认
				            	</c:if>
				            	<c:if test="${l.level==1 }">
				            		热门
				            	</c:if>
				            	<c:if test="${l.level==2 }">
				            		推荐
				            	</c:if>
				            	<c:if test="${l.level==3 }">
				            		置顶
				            	</c:if>
				            </td>
				            <td><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				            <td>
				            	<div class="am-btn-toolbar">
				                  <div class="am-btn-group am-btn-group-xs">
				                    <a class="am-btn am-btn-default am-btn-xs am-text-danger" onclick="deleteBeauty(${l.id})"><span class="am-icon-trash-o"></span> 删除</a>
				                    <a class="am-btn am-btn-default am-btn-xs am-text-primary" onclick="editBeautyLevel(${l.id})"></span> 美图等级</a>
				                  </div>
				                </div>
				            </td>
				        </tr>
				    </c:forEach>
			    </tbody>
			</table>
				<c:set var="currentPage" value="${beautyPage.pageNumber}" />
				<c:set var="totalPage" value="${beautyPage.totalPage}" />
				<c:set var="actionUrl" value="${base}/admins/beautyList?beauty.title=${beauty.title}&bozhu=${bozhu}&beauty.level=${beauty.level}&page=" />
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
<form  id="beautyleveleditform" action="${base}/admins/editBeautyLevel/" method="post" style="padding: 20px;display: none;">
      <input type="hidden" name="id" value="">
      <select id="beautylevelselect" name="level">
        <option value="0">默认</option>
        <option value="1">热门</option>
        <option value="2">推荐</option>
        <option value="3">置顶</option>
      </select>
</form>
</html>