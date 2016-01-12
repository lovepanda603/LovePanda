<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<!-- 引入基本库和js，css文件 -->
<%@ include file="/WEB-INF/content/common/taglib.jsp"%>
    <meta charset="utf-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="description" content="博客列表">
  <meta name="keywords" content="博客,blog,博客列表">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>博客列表</title>
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" /> 
</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
				
	  <div class="am-g am-g-fixed" >
	    <div class="am-u-md-8">
		    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/blog">博客</a></li>
			  <li class="am-active">分类搜索结果</li>
			</ol>
			
				<c:if test="${empty blogPage.list}">
					<img alt="" src="${base}/images/blog/cry.png"><span>您搜索的分类暂时还没有内容！</span>
				</c:if>
			  	<%@ include file="/WEB-INF/content/common/blogcontent.jsp"%>
				<c:set var="currentPage" value="${blogPage.pageNumber}" />
				<c:set var="totalPage" value="${blogPage.totalPage}" />
				<c:set var="actionUrl" value="${base}/blog/categorySearcher?category=${category}&page=" />
				<c:set var="urlParas" value="" />
				<center>
					<%@ include file="/common/_paginate.jsp"%>
				</center>
				
	    	
	    </div>
	    <div class="am-u-md-4" id="my-side">
	    	<c:if test="${not empty sessionScope.loginUser}">
	    	<c:if test="${systemEditOpen==1}">
		     <div class="side-box">
		    	<div class="my-side-title">
					<span class="am-icon-pencil"> 功能区</span> 
		    	</div>
	    		<button type="button" class="am-btn am-btn-primary am-btn-block" onclick="location.href='${base}/blog/add'">
		    		<i class="am-icon-pencil"></i>
		    		写博客
				</button> 
		    	<button type="button" class="am-btn am-btn-primary am-btn-block" onclick="location.href='${base}/blog/myblog'">
		    		<i class="am-icon-user"></i>
		    		我的博客
				</button>
			</div>
			</c:if>
			</c:if>
		    	<%@ include file="/WEB-INF/content/common/side.jsp"%>
		    </div>
	    
	  </div>
	  
<div class="am-modal am-modal-confirm" tabindex="-1" id="bolg-delete-confirm">
  <div class="am-modal-dialog">
    <div class="am-modal-hd">警告！</div>
    <div class="am-modal-bd">
      您确定要删除这条记录吗？
    </div>
    <div class="am-modal-footer">
      <span class="am-modal-btn" data-am-modal-cancel>取消</span>
      <span class="am-modal-btn" data-am-modal-confirm>确定</span>
    </div>
  </div>
</div>
	
<script type="text/javascript">

 function deleteblog(blogid) {
		      $('#bolg-delete-confirm').modal({
		        relatedTarget: this,
		        onConfirm: function(optons) {
		        	location.href="${base}/blog/delete/"+blogid;
		        },
		        onCancel: function() {
		        }
		      });
		    }
 $(function(){
	 $(".blog-keyword-show").each(function(){
		 var ht=$(this).html();
		 $(this).html('');
		 if(ht!=''&&ht!=undefined&&ht!=' '){
			 var arr = ht.split(" ");
			 for (var i = 0; i < arr.length; i++) {
				 $(this).append("<a class='tag' href='${base}/index/search?keyword="+arr[i]+"'>"+arr[i]+"</a>");
		 		}
		}
	 })
 });
 $(".am_img").on('mouseover', function(){
	    $(this).addClass('bounceIn');
	});
	$('.am_img').on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	    $('.am_img').removeClass('bounceIn');
	});
		$("img").lazyload({ effect : 'fadeIn'});
</script>

	</div>
		
	<!-- 底部 -->	
	<%@ include file="/WEB-INF/content/common/footer.jsp"%>
</body>
</html>