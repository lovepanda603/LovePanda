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
  <meta name="description" content="美图">
  <meta name="keywords" content="博客,blog,美图,${beauty.title}">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${beauty.title}</title>
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" /> 
  <script src="${base}/baguetteBox/js/baguetteBox.min.js"></script>
  <link rel="stylesheet" href="${base}/baguetteBox/css/baguetteBox.css">
  <link rel="stylesheet" href="${base}/kindeditor-4.1.10/plugins/code/prettify.css" />
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/kindeditor.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/plugins/code/prettify.js"></script>
  <style type="text/css">
  	.baguetteBox img{
  		box-sizing: border-box;
		max-width: 100%;
		height: auto;
		vertical-align: middle;
		border: 0;
  		padding-bottom: 20px;
  	}
  </style>
</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="beauty-main">
				
	  <div class="am-g am-g-fixed" >
	    <div class="am-u-md-8">
		    <ol class="am-breadcrumb" style="margin-bottom: 0">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/beauty/">美图</a></li>
			  <li class="am-active">详情</li>
			</ol>
			<article class="am-article">
			 <div class="am-article-hd">
			    <h1 class="am-article-title">${beauty.title}</h1>
			    <div class="am_list_author">
			    	<a href="javascript:void(0)">
			    		<span class="am_list_author_ico" style="background-image: url(${base}/attached/avatar/${bozhu.avatar});background-size:cover;" ></span>
			    		<span class="name">${bozhu.username}</span>
			    	</a>
			    	<span class="am_news_time">&nbsp;•&nbsp;
			    		<time class="timeago" title="<fmt:formatDate value="${beauty.create_time}" pattern="yyyy-MM-dd"/>" datetime="<fmt:formatDate value="${beauty.create_time}" pattern="yyyy-MM-dd"/>"> <fmt:formatDate value="${beauty.create_time}" pattern="yyyy-MM-dd"/></time>
			    	</span>
			    </div>
			 </div>
			 <div id="beauty-detail-body" class="am-article-bd" >
				<div class="baguetteBox">
					 <c:forEach items="${beautyImg}" var="b">
					    <a href="${base}/attached/beauty/${b.key}" title="${b.value}"><img  src="${base}/attached/beauty/${b.key}" onerror="javascript:this.src='${base}/attached/beauty/default.jpg'"></a>
					    <p>${b.value}</p>
					 </c:forEach>
				</div>
				<c:if test="${(not empty beauty.content)&&beauty.content!=''}">
					<hr data-am-widget="divider" style="" class="am-divider am-divider-dashed"/>
					<div>
						${beauty.content}
					</div>
				</c:if>
				<hr data-am-widget="divider" style="" class="am-divider am-divider-dashed"/>
				<div class="shengming">声明：若要转载LovePanda中的任何美图请注明转载地址</div>
				<script type="text/javascript">
				    /*博客详情广告*/
				    var cpro_id = "u2355178";
				</script>
				<script src="http://cpro.baidustatic.com/cpro/ui/c.js" type="text/javascript"></script>
			 </div>
			 </article>
			 <!-- 多说评论框 start -->
			 <div class="ds-thread" data-thread-key="beauty_${beauty.id}" data-title="${beauty.title}" data-url="${siteUrl}/beauty/detail/${beauty.id}"></div>
			 <!-- 多说评论框 end -->
			<!-- 多说分享 -->
			 <div class="ds-share" data-thread-key="beauty_${beauty.id}" data-title="${beauty.title}" data-url="${siteUrl}/beauty/detail/${beauty.id}">
			    <div class="ds-share-aside-left">
			      <div class="ds-share-aside-inner">
			      </div>
			      <div class="ds-share-aside-toggle">分享到</div>
			    </div>
			</div>
	    </div>
	    <div class="am-u-md-4" id="my-side">
		    <%@ include file="/WEB-INF/content/common/side.jsp"%>
		</div>
	  </div>
	  
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
	<script type="text/javascript">
	$(function(){
	    baguetteBox.run('.baguetteBox', {
	        animation: 'fadeIn'
	    });
	});
	prettyPrint();
	</script>
</body>
</html>