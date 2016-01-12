<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style type="text/css">
    	.am-topbar, .am-topbar a {
		    color: black;
		}
    </style>
<header class="am-topbar admin-header" style="background:#09C;">
  <div class="am-topbar-brand">
  	<%-- <img alt="" src="${base}/images/lovepandaadmin.png" style="height: 50px"> --%>
  	<p class="am-kai" style="color: white;">${siteName}后台管理</p>
  </div>

  <button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only" data-am-collapse="{target: '#topbar-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>

  <div class="am-collapse am-topbar-collapse" id="topbar-collapse">

    <ul class="am-nav am-nav-pills am-topbar-nav am-topbar-right admin-header-list">
      <li>
        <a><span class="am-icon-users"></span> ${sessionScope.loginUser.username}</a>
      </li>
      <li><a href="${base}/"><span class="am-icon-power-off"></span> 退出后台</a></li>
    </ul>
  </div>
</header>