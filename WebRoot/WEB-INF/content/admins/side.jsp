  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!-- sidebar start -->
  <div class="admin-sidebar" id="admin-sidebar">
    <ul class="am-list admin-sidebar-list">
      <li><a href="${base}/admins/"><span class="am-icon-home"></span> 首页</a></li>
      <li class="admin-parent">
        <a class="am-cf" data-am-collapse="{target: '#shouye-nav'}"><span class="am-icon-tree"></span> 首页管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
        <ul class="am-list am-collapse admin-sidebar-sub" id="shouye-nav">
          <li><a class="am-cf" href="${base}/admins/gonggaoList/"><span><i class="am-icon-spinner am-icon-spin"></i> 滚动公告</span></a></li>
          <li><a class="am-cf" href="${base}/admins/picRecommend/"><span><i class="am-icon-picture-o"></i> 首页图片推荐</span></a></li>
        </ul>
      </li>
      <li class="admin-parent">
        <a class="am-cf" data-am-collapse="{target: '#blog-nav'}"><span class="am-icon-file-word-o"></span> 博客管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
        <ul class="am-list am-collapse admin-sidebar-sub" id="blog-nav">
          <li><a class="am-cf" href="${base}/admins/blogList/"><span class="am-icon-list-alt"></span> 博客列表</a></li>
          <li><a href="${base}/admins/blogDeletedList/"><span class="am-icon-trash-o"></span> 已删除的博客</a></li>
        </ul>
      </li>
      <li class="admin-parent">
        <a class="am-cf" data-am-collapse="{target: '#beauty-nav'}"><span class="am-icon-file-image-o"></span> 美图管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
        <ul class="am-list am-collapse admin-sidebar-sub" id="beauty-nav">
          <li><a class="am-cf" href="${base}/admins/beautyList/"><span class="am-icon-list-alt"></span> 美图列表</a></li>
        </ul>
      </li>
      <li class="admin-parent">
        <a class="am-cf" data-am-collapse="{target: '#video-nav'}"><span class="am-icon-file-video-o"></span> 视频管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
        <ul class="am-list am-collapse admin-sidebar-sub" id="video-nav">
          <li><a class="am-cf" href="${base}/admins/videoList/"><span class="am-icon-list-alt"></span> 视频列表</a></li>
        </ul>
      </li>
      <li class="admin-parent">
        <a class="am-cf" data-am-collapse="{target: '#user-nav'}"><span class="am-icon-users"></span> 用户管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
        <ul class="am-list am-collapse admin-sidebar-sub" id="user-nav">
          <li><a class="am-cf" href="${base}/admins/userList/"><span class="am-icon-list-alt"></span> 用户列表</a></li>
          <li><a href="${base}/admins/listDeletedUsers/"><span class="am-icon-trash-o"></span> 封禁的用户</a></li>
        </ul>
      </li>
      <li class="admin-parent">
        <a class="am-cf" data-am-collapse="{target: '#system-nav'}"><span class="am-icon-cog"></span> 系统管理 <span class="am-icon-angle-right am-fr am-margin-right"></span></a>
        <ul class="am-list am-collapse admin-sidebar-sub" id="system-nav">
          <li><a class="am-cf" href="${base}/admins/iplogList/"><span class="am-icon-server"></span> IP日志</a></li>
          <li><a class="am-cf" href="${base}/admins/resourcelogList/"><span class="am-icon-area-chart"></span> 系统监控</a></li>
	       <li><a href="${base}/admins/adviceList/"><span class="am-icon-comments-o"></span> 意见和建议</a></li>
	       <li><a href="${base}/admins/linkList/"><span class="am-icon-link"></span> 友情链接</a></li>
        </ul>
      </li>
      <li><a  onclick="adminslogout();"><span class="am-icon-sign-out" ></span> 注销</a></li>
    </ul>
    
    <div class="am-panel am-panel-secondary admin-sidebar-panel">
      <div class="am-panel-hd">
      	<span class="am-icon-drupal"></span> 欢迎!
      </div>
      <div class="am-panel-bd">
        <p>欢迎使用${siteName}</p>
      </div>
    </div>
    <div class="am-panel am-panel-warning admin-sidebar-panel">
      <div class="am-panel-hd">
      	<span class="am-icon-warning"></span> 提示
      </div>
      <div class="am-panel-bd">
        <p>博客后台主要采用Amaze UI作为UI框架，提示层采用layer。</p>
        <p>由于后台一般数据量较大，表格数据较多，所以不支持手机操作，PC端尽量适应1366*768分辨率及以上屏幕。</p>
      </div>
    </div>

  </div>
  <!-- sidebar end -->
  <script type="text/javascript">
   	function adminslogout(id){
   			layer.confirm('您确定要注销吗？', {
   			    btn: ['确定注销','取消'] 
   			}, function(){
		   		location.href="${base}/index/logoutside/";
   			}, function(){
   			    layer.msg('取消了');
   			});
   	}
   </script> 
 