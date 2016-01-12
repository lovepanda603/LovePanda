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
  <meta name="description" content="${blog.title}">
  <meta name="keywords" content="${blog.title},${blog.keyword},博客详情">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${blog.title}</title>
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" /> 
     <script type="text/javascript" src="${base}/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="${base}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" charset="utf-8" src="${base}/ueditor/lang/en/en.js"></script>
    <link rel="stylesheet" type="text/css" href="${base}/ueditor/third-party/SyntaxHighlighter/shCoreDefault.css"/> 
	<script type="text/javascript" src="${base}/ueditor/third-party/SyntaxHighlighter/shCore.js"></script>
	<script type="text/javascript" charset="utf-8" src="${base}/ueditor/ueditor.parse.js"></script>
    <script type="text/javascript">
    $(function(){
		SyntaxHighlighter.all(); //执行代码高亮
		uParse('#blogcontentid', {
	    rootPath: '../'});
    });
    $(function(){
		if(${blog.showside==0}){
			 hideside();
		 }
	});
	function showside(){
		$("#blog-main").removeClass("am-u-md-12");
		$("#blog-main").addClass("am-u-md-8");
		$("#my-side").addClass("am-u-md-4");
		$("#my-side").show(500);
	}
	function hideside(){
		$("#blog-main").removeClass("am-u-md-8");
		$("#blog-main").addClass("am-u-md-12");
		$("#my-side").removeClass("am-u-md-4");
		$("#my-side").hide(500);
	}
	</script>

</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
				
	  <div class="am-g am-g-fixed">
	    <div class="am-u-md-8" id="blog-main">
		    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/blog">博客</a></li>
			  <li class="am-active">详情</li>
			</ol>
			<%@ include file="/WEB-INF/content/common/blogdetail.jsp"%>
	    </div>
	    <div class="am-u-md-4" id="my-side">
		    <c:if test="${not empty sessionScope.loginUser}">
		    <c:if test="${systemEditOpen==1}">
			    <div class="side-box">
		    		<span class="my-side-title">功能区</span>
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