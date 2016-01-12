<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
// 如下参数需要在 include 该页面的地方被赋值才能使用，以下是示例
/*  
	<c:set var="currentPage" value="${blogPage.pageNumber}" />
	<c:set var="totalPage" value="${blogPage.totalPage}" />
	<c:set var="actionUrl" value="/blog/" />
	<c:set var="urlParas" value="" />
*/
%>
<link rel="stylesheet" href="${base}/css/pagination.css">
<c:if test="${urlParas == null}">
	<c:set var="urlParas" value="" />
</c:if>
<c:if test="${(totalPage > 0) && (currentPage <= totalPage)}">
	<c:set var="startPage" value="${currentPage - 2}" />
	<c:if test="${startPage < 1}" >
		<c:set var="startPage" value="1" />
	</c:if>
	<c:set var="endPage" value="${currentPage + 2}" />
	<c:if test="${endPage > totalPage}" >
		<c:set var="endPage" value="totalPage" />
	</c:if>
	
	<ul  class="pagination paginationB">
		<c:if test="${currentPage <= 4}">
			<c:set var="startPage" value="1" />
		</c:if>
		
		<c:if test="${(totalPage - currentPage) < 4}">
			<c:set var="endPage" value="${totalPage}" />
		</c:if>
		
		<c:choose>
			<c:when test="${currentPage == 1}">
				  <li>
				    <a  class="disabled">上一页</a>
				  </li>
			</c:when>
			<c:otherwise>
			  <li class="am-pagination-prev ">
			    <a href="${actionUrl}${currentPage - 1}${urlParas}" class="">上一页</a>
			  </li>
			</c:otherwise>
		</c:choose>
		
		<c:if test="${currentPage > 4}">
			  <li>
			    <a href="${actionUrl}${1}${urlParas}" class="">${1}</a>
			  </li>
			  <li>
			    <a class="dot">…</a>
			  </li>
		</c:if>
		
		<c:forEach begin="${startPage}" end="${endPage}" var="i">
			<c:choose>
				<c:when test="${currentPage == i}">
					<li>
						<a class="current">${i}</a>
					</li>
				</c:when>
				<c:otherwise>
				  <li class="">
				    <a href="${actionUrl}${i}${urlParas}" class="">${i}</a>
				  </li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${(totalPage - currentPage) >= 4}">
			  <li class="">
			    <a class="dot">…</a>
			  </li>
			   <li class="">
			    <a href="${actionUrl}${totalPage}${urlParas}" class="">${totalPage}</a>
			  </li>
		</c:if>
		
		<c:choose>
			<c:when test="${currentPage == totalPage}">
				  <li>
				    <a class="disabled">下一页</a>
				  </li>
			</c:when>
			<c:otherwise>
			  <li class="next ">
			    <a href="${actionUrl}${currentPage + 1}${urlParas}" class="">下一页</a>
			  </li>
			</c:otherwise>
		</c:choose>
	</ul>
</c:if>