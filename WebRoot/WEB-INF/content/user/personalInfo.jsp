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
  <meta name="description" content="">
  <meta name="keywords" content="LovePanda">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${user.username}个人主页</title>
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" />  
  <script type="text/javascript">
  	function editavatar(){
  		$.post("${base}/user/toEditAvatar",
  			   function(data){
		  		$("#personalInfo-editavatardiv").html(data);
		  		$("#personalInfo-editavatardiv").height(800);
  			   }, "HTML");
  	}
  </script> 

</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container" id="main">
	  <div class="am-g am-g-fixed">
	    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/user/personalInfo">个人主页</a></li>
			  <li class="am-active">详情</li>
			</ol>
		
	    <div class="am-u-md-4 persionalInfo-userinfo">
			<div data-am-widget="intro" class="am-intro am-cf am-intro-default">
				  <div class="am-g am-intro-bd">
				    <div class="am-intro-left am-u-sm-4">
					    <c:if test="${fn:contains(user.avatar,'http://') }">
					    	<img alt="${user.username}" src="${sessionScope.loginUser.avatar}" onerror="javascript:this.src='${base}/attached/avatar/default.jpg'">
	   		 			</c:if>
	   		 			<c:if test="${not fn:contains(user.avatar,'http://') }">
					    	<img alt="${user.username}" src="${base}/attached/avatar/${sessionScope.loginUser.avatar}" onerror="javascript:this.src='${base}/attached/avatar/default.jpg'">
	   		 			</c:if>
				    </div>
				    <div class="am-intro-right am-u-sm-8" style="margin-top: 10px;font-size: 18px;font-weight: 500;line-height: 1.1;" >
				      	<p><span data-am-popover="{content: '用户名', trigger: 'hover focus'}">${user.username}</span></p>
				      	<p><span data-am-popover="{content: '昵称', trigger: 'hover focus'}">${user.realname}</span></p>
				    </div>
				  </div>
				</div>
				<!-- 其他信息 -->
				<ul class="am-list am-list-static am-list-border">
				  <li>
				    <i class="am-icon-pencil"></i>
				   	 您的博客
				   	 <button class="am-btn am-badge-warning am-btn-xs am-fr" data-am-popover="{content: '点我管理您的博客', trigger: 'hover focus'}" onclick="javascript:location.href='${base}/blog/myblog/'">${blogSum}</button>
				  </li>
				  <li>
				    <i class="am-icon-photo"></i>
				   	您的美图 
				   	<button class="am-btn am-badge-warning am-btn-xs am-fr" data-am-popover="{content: '点我管理您的美图', trigger: 'hover focus'}" onclick="javascript:location.href='${base}/beauty/myBeauty/'">${beautySum}</button>
				  </li>
				  <li>
				    <i class="am-icon-play-circle-o"></i>
				   	 您的视频
				   	 <button class="am-btn am-badge-warning am-btn-xs am-fr" data-am-popover="{content: '点我管理您的视频', trigger: 'hover focus'}" onclick="javascript:location.href='${base}/video/myVideo/'">${videoSum}</button>
				  </li>
				  <c:if test="${not empty is_admin && is_admin==1}">
				  <li>
				   <i class="am-icon-hand-o-right"></i>
				   	 快捷入口
					<div class="am-btn-group am-btn-group-xs am-fr">
			          <button type="button" class="am-btn am-btn-secondary" onclick="javascript:location.href='${base}/blog/add/'"> 写博客</button>
			          <button type="button" class="am-btn am-btn-secondary" onclick="javascript:location.href='${base}/beauty/add/'"> 传美图</button>
			          <button type="button" class="am-btn am-btn-secondary" onclick="javascript:location.href='${base}/video/add/'">发视频</button>
			        </div>
				  </li>
				  </c:if>
				</ul>
				<div class="am-alert am-alert-secondary">
				<p class="am-text-xl">尊敬的<c:if test="${not empty is_admin && is_admin==1}">管理员</c:if><c:if test="${empty is_admin}">用户</c:if>您好！</p>
				<p>注意用户名是您登陆系统的重要信息，昵称提供相关模块展示的作用。用户名不能与系统中的其他用户相同且不能用系统保留字段。</p>
				</div>
				
	    </div>
	    <div class="am-u-md-8">
	    
			<div data-am-widget="tabs" class="am-tabs am-tabs-default">
			  <ul class="am-tabs-nav am-cf">
			   <li class="">
			      <a href="[data-tab-panel-0]">我的资料</a>
			    </li>
			    <li class="">
			      <a href="[data-tab-panel-1]">资料修改</a>
			    </li>
			    <li class="">
			      <a href="[data-tab-panel-2]" onclick="editavatar();">头像修改</a>
			    </li>
			    <li class="">
			      <a href="[data-tab-panel-3]">密码修改</a>
			    </li>
			  </ul>
			  <div class="am-tabs-bd">
			  <div data-tab-panel-0 class="am-tab-panel">
			  		<table class="am-table am-table-bordered am-table-striped am-table-hover">
			  			<thead>
			  				<tr>
			  					<th width="20%">类别</th>
			  					<th width="80%">内容</th>
			  				</tr>
			  			</thead>
					    <tbody>
					        <tr>
					            <td>用户名</td>
					            <td>${user.username}</td>
					        </tr>
					        <tr>
					            <td>昵称</td>
					            <td>${user.realname}</td>
					        </tr>
					        <tr>
					            <td>性别</td>
					            <c:if test="${empty user.sex}">
					            	<td></td>
					            </c:if>
					            <c:if test="${not empty user.sex && user.sex==0}">
						            <td>男</td>
					            </c:if>
					             <c:if test="${not empty user.sex && user.sex==1}">
						            <td>女</td>
					            </c:if>
					        </tr>
					        <tr>
					        	<td>年龄</td>
					        	<td>${user.age}</td>
					        </tr>
					        <tr>
					            <td>民族</td>
					            <td>${user.folk}</td>
					        </tr>
					        <tr>
					            <td>邮箱</td>
					            <td>${user.mail}</td>
					        </tr>
					        <tr>
					            <td>手机</td>
					            <td>${user.mobile}</td>
					        </tr>
					        <tr>
					            <td>QQ</td>
					            <td>${user.qq}</td>
					        </tr>
					        <tr>
					            <td>地址</td>
					            <td>${user.address}</td>
					        </tr>
					        <tr>
					            <td>职业和工作</td>
					            <td>${user.job}</td>
					        </tr>
					        <tr>
					            <td>创建时间</td>
					            <td><fmt:formatDate value="${user.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					        </tr>
					         <tr>
					            <td>最后登陆时间</td>
					            <td><fmt:formatDate value="${user.login_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					        </tr>
					        <tr>
					            <td>类型</td>
					            <c:if test="${user.type==0}">
						            <td>注册用户</td>
					            </c:if>
					             <c:if test="${user.type==1}">
						            <td>QQ互联用户</td>
					            </c:if>
					        </tr>
					    </tbody>
					</table>
			  </div>
			  	<!-- 资料修改tab -->
			    <div data-tab-panel-1 class="am-tab-panel" >
			    	<form class="am-form" data-am-validator action="${base}/user/update" method="post" enctype="multipart/form-data">
					  <fieldset>
					   	<div class="am-form-group">
					      <label for="persionalInfo-username">用户名 <span style="color: red;">*</span></label>
					      <input type="text" id="persionalInfo-username" name="user.username" value="${user.username}" pattern="^[a-zA-Z]\w{2,14}$" placeholder="请输入用户名（3~15位数字字母下划线)" required/>
					    </div>
					    <div class="am-form-group">
					      <label for="persionalInfo-username">昵称 </label>
					      <input type="text" id="persionalInfo-username" name="user.realname" value="${user.realname }"  maxlength="6" placeholder="请输入呢称（&lt;=6位任意字符)" required/>
					    </div>
					    <div class="am-form-group">
					      <label for="persionalInfo-sex">性别</label>
					      <select id="persionalInfo-sex" name="user.sex">
					      	<c:if test="${empty user.sex}">
						        <option value="0">男</option>
						        <option value="1">女</option>
					      	</c:if>
					      	<c:if test="${not empty user.sex && user.sex==0 }">
					      		<option value="0" selected="selected">男</option>
						        <option value="1">女</option>
					      	</c:if>
					      	<c:if test="${not empty user.sex && user.sex==1 }">
					      		<option value="0">男</option>
						        <option value="1" selected="selected">女</option>
					      	</c:if>
					      </select>
					      <span class="am-form-caret"></span>
					    </div>
					    <div class="am-form-group">
					    	<label for="persionalInfo-age">年龄</label>
					    	<input type="number" name="user.age" value="${user.age }" id="persionalInfo-age" max="100" placeholder="请输入年龄" >
					    </div>
					    	<div class="am-form-group">
					      <label for="persionalInfo-folk">民族</label>
					      <input type="text" id="persionalInfo-folk" name="user.folk" value="${user.folk }" placeholder="请输入民族全称"/>
					    </div>
					    
					    <div class="am-form-group">
					      <label for="persionalInfo-mail">邮件</label>
					      <input type="email" name="user.mail" value="${user.mail }" id="persionalInfo-mail" placeholder="请输入电子邮件" required>
					    </div>
					    <div class="am-form-group">
					    	<label for="persionalInfo-mobile">手机</label>
					    	<input type="number" name="user.mobile" value="${user.mobile }" id="persionalInfo-mobile" maxlength="11" placeholder="请输入手机" >
					    </div>
					     <div class="am-form-group">
					    	<label for="persionalInfo-qq">QQ</label>
					    	<input type="number" name="user.qq" value="${user.qq }" id="persionalInfo-qq" maxlength="20" placeholder="请输入QQ" >
					    </div>
					    <div class="am-form-group">
					    	<label for="persionalInfo-address">地址</label>
					    	<input type="text" name="user.address" value="${user.address }" id="persionalInfo-address"  placeholder="请输入地址" >
					    </div>
					  	<div class="am-form-group">
					      <label for="persionalInfo-job">职业和工作</label>
					      <input type="text" id="persionalInfo-job" name="user.job" value="${user.address }"  maxlength="10" placeholder="请输入职业和工作)"/>
					    </div>
					    <p><button type="submit" class="am-btn am-btn-default">提交</button></p>
					  </fieldset>
					</form>
			    </div>
			    <!-- 头像修改pannel -->
			    <div id="personalInfo-editavatardiv" data-tab-panel-2 class="am-tab-panel">
			    	
			    </div>
			    <!-- 密码修改pannel -->
			    <div data-tab-panel-3 class="am-tab-panel">
			    	<div class="am-g">
					  <div class="am-u-md-8 am-u-sm-centered">
					    <form class="am-form" enctype="multipart/form-data" method="post" action="${base}/user/updatePassword">
					      <fieldset class="am-form-set">
					      	<c:if test="${not empty user.password}">
						        <input type="password" name="oldpwd" placeholder="原密码">
					      	</c:if>
					        <input type="password" name="newpwd" placeholder="新密码">
					        <input type="password" name="newpwd_ag" placeholder="重复密码">
					      </fieldset>
					      <button type="submit" class="am-btn am-btn-primary am-btn-block">提交</button>
					    </form>
					  </div>
					</div>
			    </div>
			  </div>
			</div>

	    </div>
	    
	  </div>

	</div>
		<!-- 底部 -->	
		<%@ include file="/WEB-INF/content/common/footer.jsp"%>
	
</body>
</html>