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
  <meta name="description" content="视频">
  <meta name="keywords" content="视频">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" /> 
  <script src="${base}/baguetteBox/js/baguetteBox.min.js"></script>
  <link rel="stylesheet" href="${base}/baguetteBox/css/baguetteBox.css">
</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
				
	  <div class="am-g am-g-fixed" >
	    <div class="am-u-md-8">
		    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/video/">视频</a></li>
			  <li class="am-active">我的视频</li>
			</ol>

			<ul data-am-widget="gallery" class="am-gallery am-avg-sm-1
  				am-avg-md-1 am-avg-lg-2 am-gallery-default">
  				<c:forEach items="${videoPage.list}" var="l">
			        <li>
			            <div class="am-gallery-item am_list_block">
			            	<div>
				                <a href="${base}/video/detail/${l.id}" class="video-a" >
					                <img class="am-radius " src="${base}/images/video/videoloading.gif" data-original="${base}/attached/video/s_${l.image}" title="${l.title}"></<img>
					                <span class="play-button"></span>
				                </a>
			                </div>
			                <div class="am_listimg_info">
			                	<a href="${base}/video/detail/${l.id}"><i class="am-icon-play"></i><span> ${l.title}</span></a><br>
			                	<a href="${base}/video/delete/${l.id}" onclick="return confirm('您确定要删除【${l.title}】吗？');" class="am-badge am-badge-danger">删除</a>
			                	<a href="${base}/video/edit/${l.id}" class="am-badge am-badge-primary">修改</a>
			                	<span class="am-icon-eye"> ${l.view }</span>
			                    <span class="am_imglist_time"><fmt:formatDate value="${l.create_time}" pattern="yyyy-MM-dd"/></span>
			                </div>
			            </div>
			        </li>
  				</c:forEach>
    		</ul>

			<c:set var="currentPage" value="${videoPage.pageNumber}" />
			<c:set var="totalPage" value="${videoPage.totalPage}" />
			<c:set var="actionUrl" value="${base}/video/myVideo?page=" />
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
	  
	</div>
		
	<!-- 底部 -->	
	<%@ include file="/WEB-INF/content/common/footer.jsp"%>
	<script type="text/javascript">
	</script>
</body>
</html>