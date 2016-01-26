<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!-- <script type="text/javascript">
	    /*120*270 创建于 2015-10-16*/
		var cpro_id = "u2355208";
	</script>
	<script src="http://cpro.baidustatic.com/cpro/ui/f.js" type="text/javascript"></script>

	<script>
		var _hmt = _hmt || [];
		(function() {
		  var hm = document.createElement("script");
		  hm.src = "//hm.baidu.com/hm.js?de4b5110a111541931168560ff853bb2";
		  var s = document.getElementsByTagName("script")[0]; 
		  s.parentNode.insertBefore(hm, s);
		})();
	</script> -->
	<c:if test="${not isPhone}">
		<style type="text/css">
			.side-tool{position:fixed;width:54px;height:350px;right:0;top:35%;}
			.side-tool ul li{width:54px;height:54px;float:right;position:relative;border-bottom:1px solid #444;}
			.side-tool ul li .sidebox{position:absolute;width:54px;height:54px;top:0;right:0;transition:all 0.3s;background:#000;opacity:0.8;filter:Alpha(opacity=80);color:#fff;font:14px/54px "微软雅黑";overflow:hidden;}
			.side-tool ul li .sidetop{width:54px;height:54px;line-height:54px;display:inline-block;background:#000;opacity:0.8;filter:Alpha(opacity=80);transition:all 0.3s;}
			.side-tool ul li .sidetop:hover{background:#ae1c1c;opacity:1;filter:Alpha(opacity=100);}
			.side-tool ul li img{float:left;}
		</style>
		<script type="text/javascript">
			$(document).ready(function(){
				$(".side-tool ul li").hover(function(){
					$(this).find(".sidebox").stop().animate({"width":"124px"},200).css({"opacity":"1","filter":"Alpha(opacity=100)","background":"#e94c4c"})	
				},function(){
					$(this).find(".sidebox").stop().animate({"width":"54px"},200).css({"opacity":"0.8","filter":"Alpha(opacity=80)","background":"#000"})	
				});
				
			});
			function goTop(){
				$('html,body').animate({'scrollTop':0},600);
			}
			function goBottom(){
				$('html,body').animate({'scrollTop':$(document).height()},600);
			}
		</script>
		<div class="side-tool">
			<ul style="list-style-type: none;">
				<li><a href="${base}/index/advice"><div class="sidebox"><img src="${base}/images/side/liuyan.png">意见和留言</div></a></li>
				<li><a href="tencent://message/?uin=1365537920&Site=在线QQ&amp;Menu=yes" ><div class="sidebox"><img src="${base}/images/side/side_icon04.png">QQ联系</div></a></li>
				<li style="border:none;"><a href="javascript:goTop();" class="sidetop"><img src="${base}/images/side/side_icon05.png"></a></li>
				<li style="border:none;"><a href="javascript:goBottom();" class="sidetop"><img src="${base}/images/side/side_icon06bottom.png"></a></li>
			</ul>
		</div>
	</c:if>
	
<footer class="am_footer">
    <div class="am_footer_con">
        <div class="am_footer_link">
            <span>快捷链接</span>
            <ul>
                <li><a href="${base}/">首页</a></li>
                <li><a href="${base}/blog/">博客</a></li>
                <li><a href="${base}/beauty/">美图</a></li>
                <li><a href="${base}/video/">视频</a></li>
            </ul>
        </div>

        <div class="am_footer_don">
            <span>${siteName}</span>
            <dl>
                <dt><img src="${base}/images/footer/64.png" alt=""></dt>
                <dd>LovePanda博客欢迎你常来逛逛，本博客是博主采用java和Amaze UI等技术自主开发而成。本博客支持注册用户发表个人博客，拥有强大的后台管理功能。本博客在博主开发完成后会开源到GIT上。
                    <a href="http://git.oschina.net/lovepanda603/lovepanda" target="_blank" class="footdon_pg ">
                        <div class="foot_d_pg am-icon-git "> Git@OSC</div>
                    </a><a href="https://github.com/lovepanda603/LovePanda" target="_blank" class="footdon_az animated">
                        <div class="foot_d_az am-icon-github"> GitHub</div>
                    </a></dd>

            </dl>
        </div>

        <div class="am_footer_erweima">
            <div class="am_footer_weixin"><img src="${base}/images/footer/aliyun.jpg" alt="">
                <div class="am_footer_d_gzwx am-icon-arrow-right"> 阿里云<br>9折优惠码<br>5LZGW2</div><br>
            </div>
            <div class="am_footer_ddon"><img src="${base}/images/footer/lovepandaerweima.png" alt="">
                <div class="am_footer_d_dxz am-icon-cloud-download"> 手机扫码</div>
            </div>

        </div>

    </div>
    <div class="am_info_line">Copyright(c)2016 <span>${siteName }</span> All Rights Reserved </div>
    <div class="am_info_line-beian">鄂ICP备15010072号</div>
    <c:if test="${isPhone}">
		<div data-am-widget="gotop" class="am-gotop am-gotop-fixed">
		  <a href="#top" title="回到顶部">
		    <span class="am-gotop-title">回到顶部</span>
		    <i class="am-gotop-icon am-icon-chevron-up"></i>
		  </a>
		</div>
	</c:if>
</footer>

<!-- 登陆和注册 -->
 <c:if test="${empty sessionScope.loginUser}">
	<div class="am-modal am-modal-no-btn" tabindex="-1" id="login-modal">
	  <div class="am-modal-dialog">
	    <div class="am-modal-hd">LovePanda登陆
	      <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
	    </div>
	    <div class="am-modal-bd">
	      	<div class="am-tabs" id="login-tabs">
			  <ul class="am-tabs-nav am-nav am-nav-tabs">
			    <li class="am-active"><a href="">登陆</a></li>
			    <c:if test="${systemRegisterOpen==1}">
			    <li><a href="">注册</a></li>
			    </c:if>
			  </ul>
			  <div class="am-tabs-bd">
			    <div  class="am-tab-panel am-fade am-active  am-in ">
			    	<form id="loginform" action="${base}/login" class="am-form" method="post">
			    		<div class="am-form-group">
					      <label for="login-username">用户名</label>
					      <input type="text" class="" name="user.username" id="login-username" placeholder="请输入用户名" required>
					    </div>
					
					    <div class="am-form-group">
					      <label for="login-password">密码</label>
					      <input type="password" class="" name="user.password" id="login-password" placeholder="请输入密码" required>
					    </div>
					    <button type="submit" class="am-btn am-btn-secondary ">提交</button>
			    	</form>
			    </div>
			    <c:if test="${systemRegisterOpen==1}">
			    <div class="am-tab-panel am-fade">
			    	<form id="registerform" data-am-validator action="${base}/register" class="am-form" method="post" enctype="multipart/form-data">
			    		<div class="am-form-group">
					      <label for="login-username">用户名</label>
					      <input type="text" class="" name="user.username" id="login-username" pattern="^[a-zA-Z]\w{2,14}$" placeholder="请输入用户名（3~15位数字字母下划线）" required>
					    </div>
			    		<div class="am-form-group">
					      <label for="login-realname">昵称</label>
					      <input type="text" class="" name="user.realname" id="login-realname" maxlength="6" placeholder="请输入呢称（&lt;=6位任意字符）" required>
					    </div>
						<div class="am-form-group">
					      <label for="login-mail">邮件</label>
					      <input type="email" class="" name="user.mail" id="login-mail"  placeholder="请输入电子邮件" required>
					    </div>
					    <div class="am-form-group">
					      <label for="login-password">密码</label>
					      <input type="password" class="" name="user.password" id="login-password" placeholder="请输入密码" required>
					    </div>
					    <div class="am-form-group">
					      <label for="login-password">重复密码</label>
					      <input type="password" class="" name="password_ag" id="login-password" placeholder="请再次输入密码" required>
					    </div>
					    <button type="submit" class="am-btn am-btn-secondary ">提交</button>
			    	</form>
			    </div>
			    </c:if>
			  </div>
			</div>
			<script>
			  $(function() {
			    $('#login-tabs').tabs();
			  });
			</script>
	    </div>
	  </div>
	</div>
 </c:if>
