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
  <meta name="description" content="我的美图">
  <meta name="keywords" content="博客,blog,我的美图">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>我的美图</title>
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" /> 
  <script src="${base}/baguetteBox/js/baguetteBox.min.js"></script>
  <link rel="stylesheet" href="${base}/baguetteBox/css/baguetteBox.css">
  <style type="text/css">
  	.baguetteBox img{
  		box-sizing: border-box;
		max-width: 100%;
		height: auto;
		vertical-align: middle;
		border: 0;
  		padding-bottom: 20px;
  	}
	.am-badge{
		margin-right: 2px;
		border-radius: 3px;
	}
  </style>

</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
				
	  <div class="am-g am-g-fixed" >
	    <div class="am-u-md-8">
		    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/beauty/">美图</a></li>
			  <li class="am-active">我的美图</li>
			</ol>
			<c:forEach items="${beautyPage.list}" var="l">
				<div class="beauty-inner-box">
					<div class="blog-header">
						<h2><a href="${base}/beauty/detail/${l.id}">${l.title}</a></h2>
					</div>
					<p class="blog-ext">
						<span class="blog-ext-ico">
							<i class="am-icon-user am-icon-sm blog-ext-ico"></i>
							${l.username}
						</span>
						<span class="blog-ext-ico"><i class="am-icon-clock-o am-icon-sm blog-ext-ico"></i><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd"/></span>
						<span class="blog-ext-ico">
							<i class="am-icon-eye am-icon-sm blog-ext-ico"></i>
							${l.view}
						</span>
						<span class="beauty-keyword-show blog-ext-ico">${l.keyword}</span>
						<a class="am-badge am-badge-danger am-round" onclick="myBeautyDelete(${l.id})">删除</a>
					</p>

					<p class="blog-content-show">${l.content}</p>
					<div id="beauty-image-show">
						<c:forEach items="${l.img}" var="i" varStatus="ic">
							<c:if test="${ic.count<=3}">
								<img class="am-radius am_img animated" src="${base}/attached/beauty/s_${i.key}" title="${i.value}" onerror="javascript:this.src='${base}/attached/beauty/showdefault.jpg'" ></<img>
							</c:if>
						</c:forEach>
					</div>
		 		</div>
			</c:forEach>
			<c:set var="currentPage" value="${beautyPage.pageNumber}" />
			<c:set var="totalPage" value="${beautyPage.totalPage}" />
			<c:set var="actionUrl" value="${base}/beauty/myBeauty?page=" />
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
		    		<button type="button" class="am-btn am-btn-primary am-btn-block" onclick="location.href='${base}/beauty/add/'">
			    		<i class="am-icon-pencil"></i>
			    		发布美图
					</button>
					<button type="button" class="am-btn am-btn-primary am-btn-block" onclick="location.href='${base}/beauty/myBeauty/'">
			    		<i class="am-icon-photo"></i>
			    		我的美图
					</button>
				</div>
				</c:if>
	    	 </c:if>
		    <%@ include file="/WEB-INF/content/common/side.jsp"%>
		</div>
	  </div>
	  
	</div>
		
	<!-- 底部 -->	
	<%@ include file="/WEB-INF/content/common/footer.jsp"%>
	<script type="text/javascript">
	$(function(){
	    baguetteBox.run('.baguetteBox', {
	        animation: 'fadeIn'
	    });
	});
	$(function(){
		 $(".beauty-keyword-show").each(function(){
			 var ht=$(this).html();
			 $(this).html('');
			 if(ht!=''&&ht!=undefined&&ht!=' '){
				 var arr = ht.split(" ");
				 for (var i = 0; i < arr.length; i++) {
					 if(arr[i].trim()!=""){
						 $(this).append("<a class='am-badge am-badge-success' href='${base}/index/search?keyword="+arr[i]+"'>"+arr[i]+"</a>");
					 }
			 		}
			}
		 })
	 });
	function myBeautyDelete(id){
		var c=window.confirm("确定要删除该美图吗？");
		if(c){
			location.href="${base}/beauty/delete/"+id;
		}
	};
	//图片滑动效果
	$(".am_img").on('mouseover', function(){
	    $(this).addClass('bounceIn');
	});
	$('.am_img').on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	    $('.am_img').removeClass('bounceIn');
	});
		$("img").lazyload({ effect : 'fadeIn'});
</script>
</body>
</html>