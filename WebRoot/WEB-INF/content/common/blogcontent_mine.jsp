<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach items="${blogPage.list}" var="l">
  	<c:if test="${not empty l.image}">
  		<div class="inner-box blog-img ">
  			<div class="am-g">
	  			<div class="am-u-sm-3">
					<a class="blog-a-curse" href="${base}/blog/detail/${l.id}"><img alt="" class="am_img animated" src="${base}/images/index/loading.gif" data-original="${base}/attached/blog/${l.image}" ></a>
				</div>
				<div class="am-u-sm-9">
					<div class="blog-header">
						<a href="${base}/blog/categorySearcher?category=${l.category}" class="blog-category">${l.categorystr }</a>
						<h2><a href="${base}/blog/detail/${l.id}">${l.title}</a></h2>
					</div>
					<p class="blog-ext">
						<span class="blog-ext-ico">
							<i class="am-icon-user  blog-ext-ico"></i>
							${l.username}
						</span>
						<span class="blog-ext-ico"><i class="am-icon-clock-o  blog-ext-ico"></i><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
						<span class="blog-ext-ico">
							<i class="am-icon-eye  blog-ext-ico"></i>
							${l.view}
						</span>
					</p>
					<p class="blog-content-show">${l.content_show}...</p>
					<div class="am-fr">
					<button type="button" class="am-badge am-badge-danger am-round " onclick="deleteblog(${l.id})">删除</button>
					<button type="button" class="am-badge am-badge-success am-round " onclick="location.href='${base}/blog/edit/${l.id}'">修改</button>
					</div>
				</div>
			</div>
 		</div>
  	</c:if>
  	<c:if test="${empty l.image}">
	  	<div class="inner-box blog-img ">
			<div class="blog-header">
				<a href="${base}/blog/categorySearcher?category=${l.category}" class="blog-category">${l.categorystr }</a>
				<h2><a href="${base}/blog/detail/${l.id}">${l.title}</a></h2>
			</div>
			<p class="blog-ext">
				<span class="blog-ext-ico">
					<i class="am-icon-user  blog-ext-ico"></i>
					${l.username}
				</span>
				<span class="blog-ext-ico"><i class="am-icon-clock-o  blog-ext-ico"></i><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
				<span class="blog-ext-ico">
					<i class="am-icon-eye  blog-ext-ico"></i>
					${l.view}
				</span>
			</p>
			<p class="blog-content-show">${l.content_show}...</p>
			<div class="am-fr">
			<button type="button" class="am-badge am-badge-danger am-round" onclick="deleteblog(${l.id})">删除</button>
			<button type="button" class="am-badge am-badge-success am-round" onclick="location.href='${base}/blog/edit/${l.id}'">修改</button>
			</div>
 		</div>
  	</c:if>
</c:forEach>