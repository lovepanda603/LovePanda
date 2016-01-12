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
  <meta name="description" content="新建博客">
  <meta name="keywords" content="新建博客,ueditor">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>新建博客</title>
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" /> 
  <!-- 引入ueditor文件 -->
  <!-- 配置文件 -->
    <script type="text/javascript" src="${base}/ueditor/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="${base}/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" charset="utf-8" src="${base}/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" charset="utf-8" src="${base}/ueditor/lang/en/en.js"></script>
	
</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
				
	  <div class="am-g am-g-fixed">
	    <div class="am-u-md-8" id="blog-main">
		    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/blog">博客</a></li>
			  <li class="am-active">新建</li>
			</ol>
			
			<form class="am-form am-form-horizontal" id="blog-add-form" method="post" action="${base}/blog/save" enctype="multipart/form-data">
				<input type="hidden" name="blog.id" value="${blog.id}">
				<input type="hidden" name="blog.user_id" value="${blog.user_id}">
				<input type="hidden" name="blog.deleted" value="${blog.deleted}">
				<input type="hidden" name="blog.view" value="${blog.view}">
				<input type="hidden" name="blog.type" value="${blog.type}">
				<input type="hidden" name="blog.image" value="${blog.image}">
				<input type="hidden" name="blog.create_time" value="${blog.create_time}">
			    <div class="am-form-group am-form-group-sm">
			      <label class="am-u-sm-2 " for="blog-title">标题</label>
			      <div class="am-u-sm-10">
				      <input type="text"  name="blog.title" value="${blog.title}" id="blog-title" placeholder="输入博客标题"><span class="blog-error">${titleMsg}</span>
			      </div>
			    </div>
			    <div class="am-form-group am-form-group-sm">
			      <label class="am-u-sm-2 " for="blog-keyword">关键字</label>
			      <div class="am-u-sm-10">
				      <input type="text"  name="blog.keyword" value="${blog.keyword}" id="blog-keyword" placeholder="输入关键字，方便搜到你的博客">
			      </div>
			    </div>
			    <div class="am-form-group am-form-group-sm">
			      <label class="am-u-sm-2 " for="blog-ispublic">是否公开</label>
			      <div class="am-u-sm-10">
				      <select  id="blog-ispublic" name="blog.ispublic">
				        <option value="1">公开</option>
				        <option value="0">不公开</option>
				      </select>
				      <span class="blog-error">${ispublicMsg}</span>
			      </div>
			      <span class="am-form-caret"></span>
			    </div>
			    <div class="am-form-group am-form-group-sm">
			      <label class="am-u-sm-2 " for="blog-category">分类</label>
			      <div class="am-u-sm-10">
				      <select class="am-u-sm-10" id="blog-category" name="blog.category">
				        <c:forEach items="${listBlogcategory}" var="c">
				        	<option value="${c.id}">${c.category}</option>
				        </c:forEach>
				      </select>
				      <span class="blog-error">${categoryMsg}</span>
			      </div>
			      <span class="am-form-caret"></span>
			    </div>
			    <div class="am-form-group am-form-file am-form-group-sm">
			    <label class="am-u-sm-2 " for="blog-category">展示图片(可空)</label>
			    <div class="am-u-sm-10">
				  <button type="button" class="am-btn am-btn-danger am-btn-sm">
				    <i class="am-icon-cloud-upload"></i> 选择要上传图片</button>
				  <input id="blog-image" name="upload" type="file" multiple>
					<div id="blog-image-list"></div>
				</div>
				</div>
				<script>
				  $(function() {
				    $('#blog-image').on('change', function() {
				      var fileNames = '';
				      $.each(this.files, function() {
				        fileNames += '<span class="am-badge">' + this.name + '</span> ';
				      });
				      $('#blog-image-list').html(fileNames);
				    });
				  });
				</script>
				<input type="hidden" id="blog-content-show" name="blog.content_show">
			
			    <div class="am-form-group">
			      <label for="blog-content">博客内容</label>
			     <script type="text/plain" id="editor" ></script>
			     <input type="hidden" name="blog.content" id="blog-content">
			     <span class="blog-error">${contentMsg}</span>
			    </div>
			    <a class="am-badge am-badge-primary am-round" href="${base}/blog/changeedit/0">切换为kindeditor编辑器</a>
			    <div class="am-form-group" >
			      <label class="am-radio-inline">
			        <input type="radio"  value="0"  name="blog.zhuanzai" checked="checked" onclick="hidezhuanzaiurl();"> 原创
			      </label>
			      <label class="am-radio-inline">
			        <input type="radio" value="1" name="blog.zhuanzai" onclick="showzhuanzaiurl();">转载
			      </label>
			      <label class="am-radio-inline" id="blog-zhuanzaiurl" style="display: none;">
				      <input type="text"  name="blog.zhuanzaiurl" value="${blog.zhuanzaiurl}" placeholder="输入转载地址" >
			      </label>
			      <span class="blog-error">${zhuanzaiMsg}</span>
			      <span class="blog-error">${zhuanzaiurlMsg}</span>
			       <br/>
			      <label class="am-radio-inline">
			        <input type="radio" value="1" name="blog.showside" checked="checked" onclick="showside();">显示右侧区域
			      </label>
			      <label class="am-radio-inline">
			        <input type="radio" value="0" name="blog.showside" onclick="hideside();">隐藏右侧区域
			      </label>
			    </div>
			    <script type="text/javascript">
			    	function showzhuanzaiurl(){
			    		$("#blog-zhuanzaiurl").show(500);
			    	}
			    	function hidezhuanzaiurl(){
			    		$("#blog-zhuanzaiurl").hide(500);
			    		$("#blog-zhuanzaiurl input[name='blog.zhuanzaiurl']").val("");
			    	}
			    
			    </script>
			    <input type="hidden" name="blog.editortype" value="1">
			    <p><button type="button" onclick="dosubmit();" class="am-btn am-btn-default">提交</button></p>
			</form>			
	    	
	    </div>
	    <div class="am-u-md-4" id="my-side">
	    	<c:if test="${systemEditOpen==1}">
	    	<div class="side-box">
		    	<div class="my-side-title">
					<span class="am-icon-pencil"> 功能区</span> 
		    	</div>
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
	    	<%@ include file="/WEB-INF/content/common/side.jsp"%>
	    </div>
	  </div>
	  <script type="text/javascript">

	    var ue = UE.getEditor('editor',{initialFrameWidth: null });
		function dosubmit(){
			var editstr=ue.getContentTxt().substr(0,150);
			$("#blog-content-show").val(editstr);
			$("#blog-content").val(ue.getContent());
			$("#blog-add-form").submit();
		}
		$(function(){
			 $("#blog-ispublic").find("option[value='${blog.ispublic}']").attr("selected","selected");
			 $("#blog-category").find("option[value='${blog.category}']").attr("selected","selected");
			 $("input:radio[value='${blog.zhuanzai}']").attr("checked","checked");
			 if(${blog.zhuanzai=="1"}){
				 $("#blog-zhuanzaiurl").show(500);
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
		
	
	</div>
	<!-- 底部 -->	
	<%@ include file="/WEB-INF/content/common/footer.jsp"%>
</body>
</html>