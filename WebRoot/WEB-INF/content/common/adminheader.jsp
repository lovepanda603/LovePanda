<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <script type="text/javascript">

    </script>
    <div id="my-header">
		<header class="am-container am-topbar am-topbar-inverse">
		  <h1 class="am-topbar-brand">
		    <a href="${base}/admin/"><img alt="" src="${base}/images/lovepandaadmin.png" style="width: 150px;position: relative;top:0px"></a>
		  </h1>
		  <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#doc-topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>
		
		  <div class="am-collapse am-topbar-collapse" id="doc-topbar-collapse">
		    <ul class="am-nav am-nav-pills am-topbar-nav">
		      <li id="header-index"><a href="${base }/">前台</a></li>
		      <li id="header-blog"><a href="javascript:void(0)" class="doc-oc-js" data-rel="open">侧边栏</a></li>
		    </ul>

		
		    <div class="am-topbar-right">
		      <div class="am-dropdown" data-am-dropdown="{boundary: '.am-topbar'}">
		        <button class="am-btn am-btn-secondary am-topbar-btn am-btn-sm am-dropdown-toggle" data-am-dropdown-toggle>其他 <span class="am-icon-caret-down"></span></button>
		        <ul class="am-dropdown-content">
		          <li><a href="javascript:void(0)" onclick="logout();">注销</a></li>
		          <li><a href="${base}/admin/">后台管理</a></li>
		        </ul>
		      </div>
		    </div>
		<script type="text/javascript">
				function logout(){
					$.post("${base}/logout",{},
							   function(data){
								if(data==1){
									alert("注销成功");
									location.href="${base}/index";
								}else{
									alert("您未登陆或session超时");
								}
								
							   }, "json");
				}
		</script>
		    
		  </div>
		</header>
	</div>
		