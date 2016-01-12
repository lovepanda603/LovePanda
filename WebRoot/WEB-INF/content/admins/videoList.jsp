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
		  <li>视频管理</li>
	  </ol>
  	<script type="text/javascript">
  		function editVideoLevel(id){
  			$.post("${base}/admins/toVideoLevel/"+id,
 				   function(data){
 			  console.info(data);
 					var index=layer.open({
 					    type: 1,
 					    skin: 'layui-layer-rim', 
 					    area: ['420px', '240px'], 
 					    btn:['提交'],
 					    yes:function(){
 					    	$("#videoleveleditform").submit();
 					    },
 					    content: $("#videoleveleditform")
 					});
 					  layer.title(data.title, index);
 				     $("#videoleveleditform > input[name='id']").val(data.id);
 				     $("#videolevelselect").val(data.level);
 				   }, "json");
  		}
  		function deleteVideo(id){
  			
  			 layer.confirm('您确定要删除该视频吗？。', {
  			      btn: ['确定删除','取消'],
  			      title:'删除视频确认对话框'
  			  }, function(){
  			      location.href="${base}/admins/videoDelete/"+id;
  			  }, function(){
  			  });
  		}
	</script>
   	
	  <div class="am-g">
	  	<div class="am-u-sm-12">
	  		<form class="am-form-inline" role="form" action="${base}/admins/videoList/">
			  <div class="am-form-group">
			  	<label for="video-title">标题</label>
			    <input id="video-title" type="text" name="video.title" value="${video.title }" class="am-form-field" placeholder="标题">
			  </div>
			
			  <div class="am-form-group">
			  	<label for="bozhu">博主</label>
			    <input id="bozhu" type="text" name="bozhu" value="${bozhu }" class="am-form-field" placeholder="博主">
			  </div>
			<div class="am-form-group">
		      <label for="video-level">等级</label>
		      <select id="video-level" name="video.level">
		        <c:if test="${empty video.level}">
		    		 <option value="" selected="selected">全部</option>
		    		 <option value="0">默认</option>
			         <option value="1">热门</option>
			         <option value="2">推荐</option>
			         <option value="3">置顶</option>
		    	</c:if>
		    	<c:if test="${video.level==0}">
		    		 <option value="">全部</option>
		    		 <option value="0" selected="selected">默认</option>
			         <option value="1">热门</option>
			         <option value="2">推荐</option>
			         <option value="3">置顶</option>
		    	</c:if>
		    	<c:if test="${video.level==1}">
			         <option value="">全部</option>
			         <option value="0">默认</option>
			         <option value="1" selected="selected">热门</option>
			         <option value="2">推荐</option>
			         <option value="3">置顶</option>
		    	</c:if>
		    	<c:if test="${video.level==2}">
			         <option value="">全部</option>
			         <option value="0">默认</option>
			         <option value="1">热门</option>
			         <option value="2" selected="selected">推荐</option>
			         <option value="3">置顶</option>
		    	</c:if>
		    	<c:if test="${video.level==3}">
			         <option value="">全部</option>
			         <option value="0">默认</option>
			         <option value="1">热门</option>
			         <option value="2">推荐</option>
			         <option value="3" selected="selected">置顶</option>
		    	</c:if>
		      </select>
		      <span class="am-form-caret"></span>
		    </div>
			
			  <button type="submit" class="am-btn am-btn-default">搜索</button>
			</form>
	  	</div>
	  </div>
	  <hr data-am-widget="divider" style="" class="am-divider am-divider-default" />
	  <div class="am-g">
	  	<div class="am-u-sm-12">
	  		<table class="am-table am-table-bordered am-table-striped am-table-hover">
		    <thead>
		        <tr>
		            <th>标题</th>
		            <th>博主</th>
		            <th>等级</th>
		            <th>创建时间</th>
		            <th>操作</th>
		        </tr>
		    </thead>
		    <tbody>
		       <c:forEach items="${videoPage.list }" var="l">
		       	<tr>
		       		<td>${l.title }</td>
		       		<td>${l.username }</td>
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
		       			<a class="am-btn am-btn-default am-btn-xs am-text-danger"  onclick="deleteVideo(${l.id});"><span class="am-icon-trash-o"></span> 删除</a>
				        <a class="am-btn am-btn-default am-btn-xs am-text-secondary" onclick="editVideoLevel(${l.id})"><span class="am-icon-level-up"></span> 视频等级</a>
		       		</td>
		       	</tr>
		       </c:forEach>
		    </tbody>
		</table>
		<c:set var="currentPage" value="${videoPage.pageNumber}" />
		<c:set var="totalPage" value="${videoPage.totalPage}" />
		<c:set var="actionUrl" value="${base}/admins/videoList?video.title=${video.title}&bozhu=${bozhu}&video.level=${video.level}&page=" />
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
<form id="videoleveleditform" action="${base}/admins/editVideoLevel/" method="post" style="padding: 20px;display: none;">
      <input type="hidden" name="id" value="">
      <select id="videolevelselect" name="level">
        <option value="0">默认</option>
        <option value="1">热门</option>
        <option value="2">推荐</option>
        <option value="3">置顶</option>
      </select>
</form>
</html>