<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<!-- 引入基本库和js，css文件 --> 
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${siteName}后台管理</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" />
   <%@ include file="/WEB-INF/content/admins/taglib.jsp"%> 
</head>
<body>
<%@ include file="/WEB-INF/content/admins/header.jsp"%> 

<div class="am-cf admin-main">
<%@ include file="/WEB-INF/content/admins/side.jsp"%> 

  <!-- content start -->
  <div class="admin-content" id="admin-content">
	<ol class="am-breadcrumb">
	  <li><a href="${base}/admins/" class="am-icon-home">后台首页</a></li>
	  <li>网站预览</li>
	</ol>

    <div class="am-g">
	    <div class="am-u-md-6">
	         <script type="text/javascript">
				var duoshuoQuery = {short_name:"${duoshuoShortName}"};
					(function() {
						var ds = document.createElement('script');
						ds.type = 'text/javascript';ds.async = true;
						ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.js';
						ds.charset = 'UTF-8';
						(document.getElementsByTagName('head')[0] 
						 || document.getElementsByTagName('body')[0]).appendChild(ds);
					})();
			</script>
	        <div class="am-panel am-panel-default">
	          <div class="am-panel-hd am-cf" data-am-collapse="{target: '#latest-visitor'}">最近访客<span class="am-icon-chevron-down am-fr" ></span></div>
	          <div class="am-panel-bd am-collapse am-in am-cf" id="latest-visitor">
	    		<ul class="ds-recent-visitors" data-num-items="200"></ul>   
	          </div>
	        </div>
	        
	      </div>
	      <div class="am-u-md-6">
	        <div class="am-panel am-panel-default">
	          <div class="am-panel-hd am-cf" data-am-collapse="{target: '#latest-commont'}">最近评论<span class="am-icon-chevron-down am-fr" ></span></div>
	          <div class="am-panel-bd am-collapse am-in am-cf" id="latest-commont">
	    		<div class="ds-recent-comments" data-num-items="10" data-show-avatars="1" data-show-time="1" data-show-title="1" data-show-admin="1" data-excerpt-length="70"></div>
	          </div>
	        </div>
	        
	      </div>
    </div>
	
	
	
	
  </div>
  <!-- content end -->

</div>

<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 

</body>
</html>
