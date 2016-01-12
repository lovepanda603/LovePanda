<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<article class="am-article">
  <div class="am-article-hd">
    <h1 class="am-article-title">${blog.title}</h1>
    <div class="am_list_author">
    	<a href="javascript:void(0)">
    		<span class="am_list_author_ico" style="background-image: url(${base}/attached/avatar/${bozhu.avatar});background-size:cover;" ></span>
    		<span class="name">${bozhu.username}</span>
    	</a>
    	<span class="am_news_time">&nbsp;•&nbsp;
    		<time class="timeago" title="<fmt:formatDate value="${blog.create_time}" pattern="yyyy-MM-dd"/>" datetime="<fmt:formatDate value="${blog.create_time}" pattern="yyyy-MM-dd"/>"> <fmt:formatDate value="${blog.create_time}" pattern="yyyy-MM-dd"/></time>
    	</span>
    </div>
  </div>

  <div id="blogcontentid" class="am-article-bd" >
    ${blog.content }
    <!-- 分割线 -->
  </div>
	<hr data-am-widget="divider" style="" class="am-divider am-divider-dashed"/>
	 <c:if test="${blog.zhuanzai==1}">
		  <div class="shengming">原文地址：<a href="${blog.zhuanzaiurl}"  target="blank">${blog.zhuanzaiurl}</a></div>
	 </c:if>
	 <c:if test="${blog.zhuanzai!=1}">
		<div class="shengming">声明：若要转载LovePanda中的任何博客请注明转载地址</div>
	 </c:if>
	  <c:if test="${not isPhone}">
	  	<div style="width: 100%;overflow: hidden;">
			<script type="text/javascript">
		    /*博客详情广告*/
			    var cpro_id = "u2355178";
			</script>
			<script src="http://cpro.baidustatic.com/cpro/ui/c.js" type="text/javascript"></script>
	  	</div>
	  </c:if>
	
</article>
<!-- 分割线 -->
<hr data-am-widget="divider" style="" class="am-divider am-divider-dashed"/>

<!-- 多说评论框 start -->
		<div class="ds-thread" data-thread-key="blog_${blog.id}" data-title="${blog.title}" data-url="${siteUrl}/blog/detail/${blog.id}"></div>
	<!-- 多说评论框 end -->
	<!-- 多说分享 -->
	 <div class="ds-share" data-thread-key="blog_${blog.id}" data-title="${blog.title}" data-images="${siteUrl}/attached/blog/${blog.image }" data-content="${blog.content_show }" data-url="${siteUrl}/blog/detail/${blog.id}">
	    <div class="ds-share-aside-left">
	      <div class="ds-share-aside-inner">
	      </div>
	      <div class="ds-share-aside-toggle">分享到</div>
	    </div>
	</div>