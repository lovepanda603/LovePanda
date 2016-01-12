<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <header class="am-topbar am-topbar-inverse">
    <div class="am-container">
        <h1 class="am-topbar-brand">
            <a href="${base}/" class="am-topbar-logo">
                <img src="${base}/images/lovepanda.png" alt=LovePanda"">
            </a>
        </h1>
        <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only"
                data-am-collapse="{target: '#doc-topbar-collapse-5'}">
            <span class="am-sr-only">
                	导航切换
            </span>
            <span class="am-icon-bars">
            </span>
        </button>
        <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse-5">
            <ul class="am-nav am-nav-pills am-topbar-nav">
                <li id="header-index">
                    <a href="${base}/" >
                        	首页
                    </a>
                </li>
                <li class="am-dropdown" data-am-dropdown="" id="header-blog">
                    <a class="am-dropdown-toggle" id="header-blog-first"  data-am-dropdown-toggle=""  href="javascript:;">
                       	博客
                        <span class="am-icon-caret-down">
                        </span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li>
                            <a href="${base}/blog/">
                               	博客列表
                            </a>
                        </li>
                        <li>
                            <a href="${base}/blog?ranktype=latest">
                               	 最新博客
                            </a>
                        </li>
                        <li>
                            <a href="${base}/blog?ranktype=hot">
                               	 最热博客
                            </a>
                        </li>
                    </ul>
                </li>
                <li id="header-beauty">
                    <a href="${base}/beauty/" >
                       	 美图
                    </a>
                </li>
                <li id="header-video">
                    <a href="${base}/video/" >
                       	 视频
                    </a>
                </li>
               
                <li id="header-liuyanban">
                    <a href="${base}/liuyanban/" >
                        	留言板
                    </a>
                </li>
                <li class="am-dropdown am-right" data-am-dropdown="">
                    <a class="am-dropdown-toggle" data-am-dropdown-toggle="" href="javascript:;">
                      	系统
                        <span class="am-icon-caret-down">
                        </span>
                    </a>
                    <ul class="am-dropdown-content">
                        <li>
                            <a href="javascript:void(0)" onclick="logout();">
                                	注销
                            </a>
                        </li>
                        <li>
                            <a href="${base}/admins/">
                               	 后台
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
		     <c:if test="${not empty sessionScope.loginUser}">
		     	<div class="am-topbar-right" >
	              	<a id="header-user" class="am-btn am-btn-secondary am-topbar-btn am-btn-sm" href="${base}/user/personalInfo/"">个人主页</a>
                </div>
		   	 </c:if>
             <c:if test="${empty sessionScope.loginUser}">
	           <div class="am-topbar-right">
	              	<button class="am-btn am-btn-secondary am-topbar-btn am-btn-sm" data-am-modal="{target: '#login-modal'}">登录</button>
	              	<a href="${base}/qqlogin" style="display:inline-block"><img alt="QQ互联登陆" src="${base}/images/index/Connect_logo_7.png" style="padding-top: 8px;"></a>
	          </div>
	       </c:if>
        </div>
    </div>
</header>
<script type="text/javascript">
	function logout(){
		$.post("${base}/logout",{},
				   function(data){
					if(data==1){
						layer.alert('注销成功',{closeBtn: 0},function(){
							location.href="${base}/index";
						});
					}else{
						layer.alert('您未登陆或session超时');
					}
					
				   }, "json");
	}
    $(function(){
    	var paurl=window.location.pathname;
    	var blogflag=paurl.indexOf("blog");
    	var userflag=paurl.indexOf("user");
    	var liuyanbanflag=paurl.indexOf("liuyanban");
    	var beautyflag=paurl.indexOf("beauty");
    	var videoflag=paurl.indexOf("video");
    	if(blogflag!=-1){
    		$("#header-blog").attr("style","background-color:#454648");
    		$("#header-blog-first").attr("style","color:white");
    	}else if(userflag!=-1){
    		$("#header-user").addClass("am-active");
    	}else if(liuyanbanflag!=-1){
    		$("#header-liuyanban").addClass("am-active");
    	}else if(beautyflag!=-1){
    		$("#header-beauty").addClass("am-active");
    	}else if(videoflag!=-1){
    		$("#headervideo").addClass("am-active");
    	}else{
    		var indexflag=paurl.indexOf("index");
    		if(indexflag==1){
        		$("#header-index").addClass("am-active");
        	}else{
        		$("#header-index").addClass("am-active");
        	}
    	}
    	 $('img').lazyload({
    	        effect:'fadeIn'
    	      });
    });
    /*多说配置*/
	var duoshuoQuery = {short_name:"${duoshuoShortName}"};
		(function() {
			var ds = document.createElement('script');
			ds.type = 'text/javascript';ds.async = true;
			ds.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//static.duoshuo.com/embed.unstable.js';
			ds.charset = 'UTF-8';
			(document.getElementsByTagName('head')[0] 
			 || document.getElementsByTagName('body')[0]).appendChild(ds);
		})();
</script>
