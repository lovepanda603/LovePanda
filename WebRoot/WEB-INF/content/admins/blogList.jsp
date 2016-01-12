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
		  <li>博客管理</li>
	  </ol>
  	<script type="text/javascript">
	  function blogtitlesearch(){
		  var title=$("input[name=admin-blog-title-search]").val();
			  location.href="${base}/admins/blogList?title="+title;
	  }
	  function editBlogLevel(id){
		  $.post("${base}/admins/toBlogLevel/"+id,
				   function(data){
			  console.info(data);
				   //页面层
					var index=layer.open({
					    type: 1,
					    skin: 'layui-layer-rim', //加上边框
					    area: ['420px', '240px'], //宽高
					    btn:['提交'],
					    yes:function(){
					    	$("#blogleveleditform").submit();
					    },
					    content: $("#blogleveleditform")
					});
					  layer.title(data.title, index);
				     $("#blogleveleditform > input[name='id']").val(data.id);
				     $("#bloglevelselect").val(data.level);
				   }, "json");
	  }
	  function deleteBlog(id){
		//询问框
		  layer.confirm('您确定要删除该博客吗？可在删除列表中恢复，如果要永久删除请在删除列表中永久删除即可。', {
		      btn: ['确定删除','取消'],
		      title:'删除博客确认对话框'//按钮
		  }, function(){
		      location.href="${base}/admins/blogDelete?id="+id;
		  }, function(){
		  });
	  }
	</script>
   	
	  <div class="am-g">
	  	<div class="am-u-sm-12">
			<form action="${base}/admins/blogList/" method="get">
				<table class="am-table">
				  <tr>
				    <th>博客标题</th>
				    <th>
				    	<input type="text" class="am-form-field am-radius" name="blog.title" value="${blog.title}" />
				    </th>
				    <th>博主</th>
				    <th>
				    	<input type="text" class="am-form-field am-radius" name="bozhu" value="${bozhu}" />
				    </th>
				  </tr>
				  <tr>
				    <th>是否公开</th>
				    <th>
				    	<select name="blog.ispublic" value="${blog.ispublic}">
				    		<c:if test="${empty blog.ispublic}">
					    		<option value="" selected="selected">全部</option>
					    		<option value="0">个人</option>
					    		<option value="1">公开</option>
				    		</c:if>
				    		<c:if test="${blog.ispublic==0}">
					    		<option value="">全部</option>
					    		<option value="0" selected="selected">个人</option>
					    		<option value="1">公开</option>
				    		</c:if>
				    		<c:if test="${blog.ispublic==1}">
					    		<option value="">全部</option>
					    		<option value="0">个人</option>
					    		<option value="1" selected="selected">公开</option>
				    		</c:if>
				    	</select>
				    </th>
				    <th>博客等级</th>
				    <th>
				    	<select name="blog.level" value="${blog.level}">
					    	<c:if test="${empty blog.level}">
					    		 <option value="" selected="selected">全部</option>
					    		 <option value="0">默认</option>
						         <option value="1">热门</option>
						         <option value="2">推荐</option>
						         <option value="3">置顶</option>
					    	</c:if>
					    	<c:if test="${blog.level==0}">
					    		 <option value="">全部</option>
					    		 <option value="0" selected="selected">默认</option>
						         <option value="1">热门</option>
						         <option value="2">推荐</option>
						         <option value="3">置顶</option>
					    	</c:if>
					    	<c:if test="${blog.level==1}">
						         <option value="">全部</option>
						         <option value="0">默认</option>
						         <option value="1" selected="selected">热门</option>
						         <option value="2">推荐</option>
						         <option value="3">置顶</option>
					    	</c:if>
					    	<c:if test="${blog.level==2}">
						         <option value="">全部</option>
						         <option value="0">默认</option>
						         <option value="1">热门</option>
						         <option value="2" selected="selected">推荐</option>
						         <option value="3">置顶</option>
					    	</c:if>
					    	<c:if test="${blog.level==3}">
						         <option value="">全部</option>
						         <option value="0">默认</option>
						         <option value="1">热门</option>
						         <option value="2">推荐</option>
						         <option value="3" selected="selected">置顶</option>
					    	</c:if>
				    	</select>
				    </th>
				  </tr>
				  <tr>
				  	<td colspan="4">
				  		<button type="submit" class="am-btn am-btn-primary">搜索</button>
				  	</td>
				  </tr>
				</table>
			</form>
	  		<table class="am-table am-table-bordered am-table-striped am-table-hover">
			    <thead>
			        <tr>
			            <th width="30%">博客名称</th>
			            <th width="10%">博主</th>
			            <th width="8%">公开</th>
			            <th width="8%">等级</th>
			            <th width="15%">创建时间</th>
			            <th width="37%">操作</th>
			        </tr>
			    </thead>
			    <tbody>
				    <c:forEach items="${blogPage.list}" var="l">
				        <tr class="">
				            <td>${l.title}</td>
				            <td>${l.username}</td>
				            <td>
				            	<c:if test="${l.ispublic==0}">
				            		个人
				            	</c:if>
				            	<c:if test="${l.ispublic==1 }">
				            		公开
				            	</c:if>
				            </td>
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
				           		<a class="am-btn am-btn-default am-btn-xs am-text-danger"  onclick="deleteBlog(${l.id});"><span class="am-icon-trash-o"></span> 删除</a>
				            	<a class="am-btn am-btn-default am-btn-xs am-text-secondary" onclick="editBlogLevel(${l.id})"><span class="am-icon-level-up"></span> 博客等级</a>
				            </td>
				        </tr>
				    </c:forEach>
			    </tbody>
			</table>
				<c:set var="currentPage" value="${blogPage.pageNumber}" />
				<c:set var="totalPage" value="${blogPage.totalPage}" />
				<c:set var="actionUrl" value="${base}/admins/blogList?blog.title=${blog.title}&bozhu=${bozhu}&blog.ispublic=${blog.ispublic}&blog.level=${blog.level}&page=" />
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
<form id="blogleveleditform" action="${base}/admins/editBlogLevel/" method="post" style="padding: 20px;display: none;">
      <input type="hidden" name="id" value="">
      <select id="bloglevelselect" name="level">
        <option value="0">默认</option>
        <option value="1">热门</option>
        <option value="2">推荐</option>
        <option value="3">置顶</option>
      </select>
</form>
</html>