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
  <meta name="description" content="柳云飞的个人博客，主要是分享java和HTML相关的知识。本站采用java的JFinal框架和Amaze UI前端UI框架自主开发而成，网站会不定时更新新的模块和功能。当功能完善后会考虑开源。">
  <meta name="keywords" content="lovepanda,柳云飞,柳云飞的博客,java博客,amazeui博客，lovepanda博客">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${siteName}</title>
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" />
  <script src="${base}/js/jquery.scrollbox.js"></script>   
	<style type="text/css">
	.am-slider-desc{
		position: fixed;
		bottom: 0px;
	}
	#picrecommenddiv img{
		width: 100%;
		height: 100%;
	}
	.am-badge{
		margin-right: 2px;
		border-radius: 3px;
	}
	.scroll-img {
		height: 125px;
		overflow: hidden;
		font-size: 0;
		text-align: center;
	}
	.scroll-img ul {
		width:100%;
		height: 600px;
		margin: 0;
	}
	.scroll-img ul li {
		display: inline-block;
		margin: 7px 0 5px 5px;
	}
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	
	<div class="am-container " id="main">
	  <div class="am-g am-g-fixed">
	    <div class="am-u-md-8">
		    <c:if test="${fn:length(picRecommendList)>=1}">
			     <div id="picrecommenddiv" data-am-widget="slider" class="am-slider am-slider-c3" data-am-slider='{&quot;controlNav&quot;:false}' >
				  <ul class="am-slides">
				  	<c:forEach items="${picRecommendList}" var="pic" varStatus="picS">
				      <li>
				        	<img src="${base}/attached/picrecommend/${pic.image}" onerror="javascript:this.src='${base}/attached/picrecommend/picrecommenddefault.jpg'" alt="pic.title">
				          <div class="am-slider-desc">
				          	<div class="am-slider-counter">
				          		<span class="am-active">${picS.count}</span>/${fn:length(picRecommendList)}
				          	</div>
				          	<a href="${pic.url}" style="color: white;">${pic.title}</a>
				          </div>
				      </li>
				  	</c:forEach>
				  </ul>
				</div>
		    </c:if>
		    
			<c:forEach items="${blogList}" var="l">
			  	<c:if test="${not empty l.image}">
			  		<div class="inner-box blog-img am-gallery-item ">
			  			<div class="am-g">
				  			<div class="am-u-sm-3">
								<a class="blog-a-curse" href="${base}/blog/detail/${l.id}">
									<img class="am_img animated" alt="${l.title}" src="${base}/images/index/loading.gif" data-original="${base}/attached/blog/${l.image}" >
								</a>
				  			</div>
				  			<div class="am-u-sm-9">
								<div class="blog-header">
						  			<span class="index-label index-label-blog">博客</span>
									<a href="${base}/blog/categorySearcher?category=${l.category}" class="blog-category">${l.categorystr }</a>
									<h2><a href="${base}/blog/detail/${l.id}">${l.title}</a></h2>
								</div>
								<p class="blog-ext">
									<span class="blog-ext-ico">
										<i class="am-icon-user  blog-ext-ico"></i>
										${l.username}
									</span>
									<span class="blog-ext-ico"><i class="am-icon-clock-o blog-ext-ico"></i><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd"/></span>
									<span class="blog-ext-ico">
										<i class="am-icon-eye blog-ext-ico"></i>
										${l.view}
									</span>
								</p>
								<p class="blog-content-show">${l.content_show}...<br>
								</p>
								<span class="blog-keyword-show">${l.keyword}</span>
				  			</div>
			  			</div>
			 		</div>
			  	</c:if>
			  	<c:if test="${empty l.image}">
				  	<div class="inner-box blog-img ">
						<div class="blog-header">
							<a href="${base}/blog/categorySearcher?category=${l.category}" class="blog-category">${l.categorystr }</a>
							<span class="index-label index-label-blog">博客</span>
							<h2><a href="${base}/blog/detail/${l.id}">${l.title}</a></h2>
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
						</p>
						<p class="blog-content-show">${l.content_show}...<br>
						<span class="blog-keyword-show">${l.keyword}</span>
						</p>
			 		</div>
			  	</c:if>
			</c:forEach>
			
			<c:if test="${fn:length(blogList)>0}">
				<div class="wygg">
			        <dd>更多精彩<s></s></dd>
					<ul>
						<li><a href="${base}/blog/">阅读更多博客请进入博客频道，点我进入 !</a></li>
					</ul>
				 </div>
			</c:if>
			
			<!-- 视频 -->
			<c:if test="${fn:length(videoList)>0}">
			<div class="index-video-box">
				<h2 class="index-video-box-heading"><span>视频</span>
					<a href="${base }/video/">+更多</a>
				</h2>
				 <div id="demo4" class="scroll-img">
			      <ul>
			      	<c:forEach items="${videoList}" var="v"> 
				        <li><a href="${base}/video/detail/${v.id}" data-am-popover="{content: '${v.title}', trigger: 'hover focus'}"><img src="${base}/attached/video/s_${v.image}" alt="${v.title}" onerror="javascript:this.src='${base}/images/video/videoloading.gif'" /></a></li>
			      	</c:forEach>
			      </ul>
			    </div>
		    </div>
		    </c:if>
		    
			<!-- 美图 -->
			<c:forEach items="${beautyList}" var="bl">
				<c:if test="${fn:length(bl.img)==1}">
					<div class="beauty-inner-box ">
						<div class="am-g">
							<div class="am-u-sm-3">
								<c:forEach items="${bl.img}" var="i" varStatus="ic">
									<c:if test="${ic.count==1}">
										<img class="am-radius am_img animated" src="${base}/images/index/loading.gif" data-original="${base}/attached/beauty/s_${i.key}" title="${i.value}" style="width: 100%;height: 100%"></<img>
									</c:if>
								</c:forEach>
							</div>
							<div class="am-u-sm-9">
								<div class="blog-header">
									<span class="index-label index-label-beauty">美图</span>
									<h2><a href="${base}/beauty/detail/${bl.id}">${bl.title}</a></h2>
								</div>
								<p class="blog-ext">
									<span class="blog-ext-ico">
										<i class="am-icon-user  blog-ext-ico"></i>
										${bl.username}
									</span>
									<span class="blog-ext-ico"><i class="am-icon-clock-o  blog-ext-ico"></i><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd"/></span>
									<span class="blog-ext-ico">
										<i class="am-icon-eye  blog-ext-ico"></i>
										${bl.view}
									</span>
									<span class="beauty-keyword-show blog-ext-ico">${bl.keyword}</span>
								</p>
								<p class="beauty-content-show">${bl.content}...</p>
							</div>
						</div>
				 	</div>
				</c:if>
				<c:if test="${fn:length(bl.img)!=1}">
					<div class="beauty-inner-box ">
						<div class="blog-header">
							<span class="index-label index-label-beauty">美图</span>
							<h2><a href="${base}/beauty/detail/${bl.id}">${bl.title}</a></h2>
						</div>
						<p class="blog-ext">
							<span class="blog-ext-ico">
								<i class="am-icon-user  blog-ext-ico"></i>
								${bl.username}
							</span>
							<span class="blog-ext-ico"><i class="am-icon-clock-o  blog-ext-ico"></i><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd"/></span>
							<span class="blog-ext-ico">
								<i class="am-icon-eye  blog-ext-ico"></i>
								${bl.view}
							</span>
							<span class="beauty-keyword-show blog-ext-ico">${bl.keyword}</span>
						</p>
						<p class="beauty-content-show">${bl.content}...</p>
						<div id="beauty-image-show">
							<c:forEach items="${bl.img}" var="i" varStatus="ic">
								<c:if test="${ic.count<=3}">
									<img class="am-radius am_img animated" src="${base}/images/index/loading.gif" data-original="${base}/attached/beauty/s_${i.key}" title="${i.value}"></<img>
								</c:if>
							</c:forEach>
						</div>
			 		</div>
				</c:if>
			</c:forEach>
			
				
	    </div>
	    <div class="am-u-md-4" id="my-side">
	    	<%@ include file="/WEB-INF/content/common/side.jsp"%>
	    </div>
	  </div>

	</div>
		<!-- 底部 -->	
		<%@ include file="/WEB-INF/content/common/footer.jsp"%>
	<script type="text/javascript">
	<!--视频推荐区图片的滚动-->
	$(function(){
		$('#demo4').scrollbox({
			switchItems: 1,//一次只滚动一张
		    distance: 120
		  });
	});
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
	 $(function(){
		 $(".beauty-keyword-show").each(function(){
			 var ht=$(this).html();
			 $(this).html('');
			 if(ht!=''&&ht!=undefined&&ht!=' '){
				 var arr = ht.split(" ");
				 for (var i = 0; i < arr.length; i++) {
					 if(arr[i].trim()!=""){
						 $(this).append("<a class='am-badge am-badge-secondary' href='${base}/index/search?keyword="+arr[i]+"'>"+arr[i]+"</a>");
					 }
			 		}
			}
		 })
	 });
	//图片滑动效果
	$(".am_img").on('mouseover', function(){
	    $(this).addClass('swing');
	});
	$('.am_img').on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
	    $('.am_img').removeClass('swing');
	});
	$("img").lazyload({ effect : 'fadeIn'});
  	
	</script>
</body>
</html>