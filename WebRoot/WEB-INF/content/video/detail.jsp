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
  <meta name="description" content="${video.title}">
  <meta name="keywords" content="${video.title},${video.keyword},博客详情">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${video.title}</title>
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" /> 
    <link rel="stylesheet" href="${base}/kindeditor-4.1.10/plugins/code/prettify.css" />
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/kindeditor.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/plugins/code/prettify.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
				
	  <div class="am-g am-g-fixed">
	    <div class="am-u-md-8" id="blog-main">
		    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/video/">视频</a></li>
			  <li class="am-active">详情</li>
			</ol>
			<article class="am-article">
			 <div class="am-article-hd">
			    <h1 class="am-article-title">${video.title}</h1>
			    <div class="am_list_author">
			    	<a href="javascript:void(0)">
			    		<span class="am_list_author_ico" style="background-image: url(${base}/attached/avatar/${bozhu.avatar});background-size:cover;" ></span>
			    		<span class="name">${bozhu.username}</span>
			    	</a>
			    	<span class="am_news_time">&nbsp;•&nbsp;
			    		<time class="timeago" title="<fmt:formatDate value="${video.create_time}" pattern="yyyy-MM-dd"/>" datetime="<fmt:formatDate value="${video.create_time}" pattern="yyyy-MM-dd"/>"> <fmt:formatDate value="${video.create_time}" pattern="yyyy-MM-dd"/></time>
			    	</span>
			    </div>
			 </div>
			 <div class="video-div">
			 	${video.pre}
			 </div>
			 <div id="beauty-detail-body" class="am-article-bd" >
				<c:if test="${(not empty video.content)&&video.content!=''}">
					<div>
						${video.content}
					</div>
				</c:if>
				<hr data-am-widget="divider" style="" class="am-divider am-divider-dashed"/>
				<div class="shengming">声明：本站视频均来自网络收集，如有侵权，请联系管理员，我们将在第一时间删除。</div>
				<script type="text/javascript">
				    /*博客详情广告*/
				    var cpro_id = "u2355178";
				</script>
				<script src="http://cpro.baidustatic.com/cpro/ui/c.js" type="text/javascript"></script>
			 </div>
			 </article>
			 <!-- 多说评论框 start -->
			 <div class="ds-thread" data-thread-key="video_${video.id}" data-title="${video.title}" data-url="${siteUrl}/video/detail/${video.id}"></div>
			 <!-- 多说评论框 end -->
			<!-- 多说分享 -->
			 <div class="ds-share" data-thread-key="video_${video.id}" data-title="${video.title}" data-url="${siteUrl}/video/detail/${video.id}">
			    <div class="ds-share-aside-left">
			      <div class="ds-share-aside-inner">
			      </div>
			      <div class="ds-share-aside-toggle">分享到</div>
			    </div>
			</div>
			
			
			
	    </div>
	    <div class="am-u-md-4" id="my-side">
	    	 <c:if test="${not empty sessionScope.loginUser}">
	    	 <c:if test="${systemEditOpen==1}">
			     <div class="side-box">
			    	<div class="my-side-title">
						<span class="am-icon-pencil"> 功能区</span> 
			    	</div>
		    		<button type="button" class="am-btn am-btn-primary am-btn-block" onclick="location.href='${base}/video/add'">
			    		<i class="am-icon-pencil"></i>
			    		发布视频
					</button> 
					<button type="button" class="am-btn am-btn-primary am-btn-block" onclick="location.href='${base}/video/myVideo/'">
			    		<i class="am-icon-photo"></i>
			    		我的视频
					</button>
				</div>
				</c:if>
	    	 </c:if>
		    <%@ include file="/WEB-INF/content/common/side.jsp"%>
		</div>
	  </div>
	  
	<script>
	prettyPrint();
	</script>
	</div>
	
	<!-- 底部 -->	
	<%@ include file="/WEB-INF/content/common/footer.jsp"%>
	<script>
	(function(){
	    var bp = document.createElement('script');
	    bp.src = '//push.zhanzhang.baidu.com/push.js';
	    var s = document.getElementsByTagName("script")[0];
	    s.parentNode.insertBefore(bp, s);
	})();
	</script>
</body>
</html>