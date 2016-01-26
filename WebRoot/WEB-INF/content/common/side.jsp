<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="${base}/js/jquery.scrollbox.js"></script>
<style type="text/css">
.taglist {
	padding: 20px 20px 30px 20px;
}

.taglist a {
	padding: 3px;
	display: inline-block;
	white-space: nowrap;
}

a.size1 {
	font-size: 20px;
	padding: 10px;
	color: #804D40;
}

a.size1:hover {
	color: #E13728;
}

a.size2 {
	padding: 7px;
	font-size: 20px;
	color: #B9251A;
}

a.size2:hover {
	color: #E13728;
}

a.size3 {
	padding: 5px;
	font-size: 26px;
	color: #C4876A;
}

a.size3:hover {
	color: #E13728;
}

a.size4 {
	padding: 5px;
	font-size: 15px;
	color: #B46A47;
}

a.size4:hover {
	color: #E13728;
}

a.size5 {
	padding: 5px;
	font-size: 25px;
	color: #E13728;
}

a.size5:hover {
	color: #B46A47;
}

a.size6 {
	padding: 0px;
	font-size: 12px;
	color: #77625E
}

a.size6:hover {
	color: #E13728;
}

a.size7 {
	padding: 0px;
	font-size: 20px;
	color: #FFCCFF
}

a.size7:hover {
	color: #FF6633;
}

.scroll-text {
	width: 100%;
	height: 14em;
	overflow: hidden;
	color: black !important;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	
	/*多彩tag*/
	var tags_a = $("#tagscloud").find("a");
	tags_a.each(function(){
		var x = 9;
		var y = 0;
		var rand = parseInt(Math.random() * (x - y + 1) + y);
		$(this).addClass("size"+rand);
	});
});

</script>
<!--用户登陆信息  -->
<c:if test="${not empty sessionScope.loginUser}">
	<div class="side-box" id="side-userinfo-parent">
		<div class="my-side-title">
			<span class="am-icon-user"> 用户信息</span>
		</div>
		<div class="side-userinfo">
			<c:if test="${fn:contains(sessionScope.loginUser.avatar,'http://') }">
				<img alt="${sessionScope.loginUser.username}"
					src="${sessionScope.loginUser.avatar}"
					onerror="javascript:this.src='${base}/attached/avatar/default.png'">
			</c:if>
			<c:if
				test="${not fn:contains(sessionScope.loginUser.avatar,'http://') }">
				<img alt="${sessionScope.loginUser.username}"
					src="${base}/attached/avatar/${sessionScope.loginUser.avatar}"
					onerror="javascript:this.src='${base}/attached/avatar/default.jpg'">
			</c:if>
			<div class="side-userinfo-info" id="side-userinfo-son">
				<span class="side-userinfo-title">用户名：</span><span
					class="side-userinfo-name">${sessionScope.loginUser.username}</span><br>
				<span class="side-userinfo-title">昵称：</span><span
					class="side-userinfo-name">${sessionScope.loginUser.realname}</span><br>
				<a href="${base}/logoutside"
					class="am-icon-power-off side-userinfo-logout"> 注销登陆</a>
			</div>
		</div>
	</div>
</c:if>

<!-- 站内搜索 -->
<div class="side-box">
	<div class="my-side-title">
		<span class="am-icon-search"> 站内搜索</span>
	</div>
	<div>
		<form class="" action="${base}/index/search/" method="get">
		<div class="am-input-group am-input-group-danger">
	      <input type="text" name="keyword" value="${keyword}" class="am-form-field" placeholder="搜索..." required>
	      <span class="am-input-group-btn">
	        <button class="am-btn am-btn-lg am-btn-danger" type="submit"><span class="am-icon-search"></span></button>
	      </span>
	      </div>
	    </form>
	    
	</div>
</div>
<!-- 博客标签云 -->
<div class="side-box">
	<div class="my-side-title">
		<span class="am-icon-tag"> 博客标签云</span>
	</div>
	<div id="tagscloud">
		<c:forEach items="${cloudcategory}" var="ca" varStatus="num">
			<a href="${base}/blog/categorySearcher?category=${ca.id}"
				class="tagc${num.index%3}">${ca.category}</a>
		</c:forEach>
	</div>
</div>
<a
	href="http://s.click.taobao.com/t?e=m%3D2%26s%3D2lp8ZOlsbh8cQipKwQzePCperVdZeJviEViQ0P1Vf2kguMN8XjClAuEc3mx55Ht5jTj4KK5tHIPQV%2FVTErx%2FQQrV1twKDMTtA1iwpvkxBnvizI5WrLAhtxmIkXBqRClNTcEU%2BDykfuTlSg55GVX5wb6HrfO5Rkxh34mdTsZIUcAD%2Bi4rDfTRpeTIM5d0rdP%2B4UsysfR7j9ghhQs2DjqgEA%3D%3D"
	target="_blank"> <img src="${base}/images/aliyun.gif"
	style="margin-bottom: 15px;" /></a>
<c:if test="${not empty gonggao}">
	<div class="side-box">
		<div class="my-side-title">
			<span><i class="am-icon-spinner am-icon-spin"></i> 滚动播报</span>
		</div>
		<div id="demo2" class="scroll-text">
			<ul>
				<c:forEach items="${gonggao}" var="g" varStatus="vs">
					<li><span class="am-badge am-badge-secondary am-round">${vs.count}</span>&nbsp;<a
						href="${g.url}">${g.content}</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
</c:if>
<div class="side-box" style="margin-top: 15px">
	<div class="am-tabs" data-am-tabs>
		<ul class="am-tabs-nav am-nav am-nav-tabs" style="margin-left: 0px;">
			<li class="am-active"><a href="#tab1">热评文章</a></li>
			<li><a href="#tab2">最新评论</a></li>
			<li><a href="#tab3">最近访客</a></li>
		</ul>

		<div class="am-tabs-bd">
			<div class="am-tab-panel am-fade am-in am-active" id="tab1">
				<!-- 多说热评文章 start -->
				<div class="ds-top-threads" data-range="monthly" data-num-items="5"></div>
				<!-- 多说热评文章 end -->
			</div>
			<div class="am-tab-panel am-fade" id="tab2">
				<!-- 多说最新评论 start -->
				<div class="ds-recent-comments" data-num-items="5"
					data-show-avatars="1" data-show-time="1" data-show-title="1"
					data-show-admin="1" data-excerpt-length="70"></div>
				<!-- 多说最新评论 end -->
			</div>
			<div class="am-tab-panel am-fade" id="tab3" style="width: 95%">
				<ul class="ds-recent-visitors" data-num-items="18" style="margin-right: 0px;"></ul>
			</div>
		</div>
	</div>
</div>
<c:if test="${not isPhone}">
	<!-- 友情链接 -->
	<div class="side-box">
		<div class="my-side-title">
			<span class="am-icon-link"> 友情链接</span>
		</div>
		<div id="youqinglianjie">
			<ul>
				<c:forEach items="${systemListLink }" var="ls">
					<li><a href="${ls.url }" target="_blank">${ls.title}</a></li>
				</c:forEach>
				
			</ul>
		</div>
	</div>
</c:if>
  <c:if test="${not isPhone}">
	<div data-am-sticky="{animation: 'slide-top'}">
		<script type="text/javascript">
			/*300*250 创建于 2015-10-31*/
			var cpro_id = "u2378489";
		</script>
		<script src="http://cpro.baidustatic.com/cpro/ui/c.js"
			type="text/javascript"></script>
	</div>
</c:if> 
<!-- 下面是手机部分 -->
<!-- 是手机就取消浮动 -->
<c:if test="${isPhone}">
	<div>
		<!-- 友情链接 -->
		<div class="side-box">
			<div class="my-side-title">
				<span class="am-icon-link"> 友情链接</span>
			</div>
			<div id="youqinglianjie">
				<ul>
					<c:forEach items="${systemListLink }" var="ls">
					<li><a href="${ls.url }" target="_blank">${ls.title}</a></li>
				</c:forEach>
				</ul>
			</div>
		</div>

	</div>
</c:if>
<script type="text/javascript">
		   $(function(){
			   $('#demo2').scrollbox({
				    linear: true,
				    step: 1,
				    delay: 0,
				    speed: 100
				  });
		   });
	   </script>