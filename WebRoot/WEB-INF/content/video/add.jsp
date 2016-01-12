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
  <meta name="description" content="美图">
  <meta name="keywords" content="博客,blog,美图,新建">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>新建美图</title>
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" /> 
  <!--引入JS-->
   	<link rel="stylesheet" href="${base}/kindeditor-4.1.10/plugins/code/prettify.css" />
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/kindeditor.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/plugins/code/prettify.js"></script>
  <style type="text/css">
  	textarea {
		border-color: black;
		border-width: 1px;
		border-style:solid;
		width: 100%;
		margin-bottom: 20px;
	}
  </style>
  <script type="text/javascript">
  	function loadpre(){
  		var pre=$("#video-pre").val();
  		if(pre!=""){
  			var iframeflag1=pre.startWith("<iframe");
  			var iframeflag2=pre.endWith("iframe>");
  			var endflag=pre.endWith("/>");
  			var embedflag1=pre.startWith("<embed");
  			var embedflag2=pre.endWith("embed>");
  			if((iframeflag1&&iframeflag2)||(iframeflag1&&endflag)||(embedflag1&&embedflag2)||(embedflag1&&endflag)){
	  			$("#video-div").html("<i class='am-icon-spinner am-icon-pulse'></i>视频预览<br><br>"+pre);
	  			return true;
  			}else{
  				alert("视频格式错误，请重新填写");
  				return false;
  			}
  		}else{
  			$("#video-div").html("");
  			return false;
  		}
  	}
  		String.prototype.endWith=function(str){
  		if(str==null||str==""||this.length==0||str.length>this.length)
  		  return false;
  		if(this.substring(this.length-str.length)==str)
  		  return true;
  		else
  		  return false;
  		return true;
  		}
  		String.prototype.startWith=function(str){
  		if(str==null||str==""||this.length==0||str.length>this.length)
  		  return false;
  		if(this.substr(0,str.length)==str)
  		  return true;
  		else
  		  return false;
  		return true;
  		}
  </script>

</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
				
	  <div class="am-g am-g-fixed" >
	    <div class="am-u-md-8">
		    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/video/">视频</a></li>
			  <li class="am-active">新建</li>
			</ol>
			
			<form action="${base}/video/save/" method="post" enctype="multipart/form-data" data-am-validator onsubmit="return loadpre()">
				<div class="am-form-group">
			      <label for="video-title">标题</label>
				  <input type="text" id="video-title" name="video.title" class="am-form-field am-radius" required placeholder="请输入标题" />
			    </div>
				<div class="am-form-group">
			      <label for="video-keyword">关键字</label>
				  <input type="text" id="video-keyword" name="video.keyword" class="am-form-field am-radius"  placeholder="请输入关键字(关键字间以空格分开)" />
			    </div>
	             <div class="am-form-group">
			      <label for="video-pre">视频代码<a class="am-badge am-badge-warning am-round">目前只支持embed或iframe标签代码</a></label>
	             <textarea id="video-pre" name="video.pre"  rows="5" onblur="loadpre();" required></textarea>
			    </div>
			    <div id="video-div" class="video-div">
			    	
			    
			    </div>
			     <div class="am-form-group am-form-file am-form-group-sm">
			    <label  for="video-image-div">展示图片</label>
			    <div  id="video-image-div">
				  <button type="button" class="am-btn am-btn-danger am-btn-sm">
				    <i class="am-icon-cloud-upload"></i> 选择要上传图片</button>
				  <input id="video-image" name="upload" type="file" multiple required>
					<div id="video-image-list"></div>
				</div>
				</div>
				<script>
				  $(function() {
				    $('#video-image').on('change', function() {
				      var fileNames = '';
				      $.each(this.files, function() {
				        fileNames += '<span class="am-badge">' + this.name + '</span> ';
				      });
				      $('#video-image-list').html(fileNames);
				    });
				  });
				</script>
			    <div class="am-form-group">
				      <label for="vedio-content">内容（描述一下该视频吧！）</label>
				      <textarea id="video-content" name="video.content"  rows="15" required></textarea>
				</div>
				    <script type="text/javascript">
					    var editor1;
					    KindEditor.ready(function(K) {
							editor1 = K.create('textarea[name="video.content"]', {
								cssPath : '${base}/kindeditor-4.1.10/plugins/code/prettify.css',
								uploadJson : '${base}/kindeditor-4.1.10/jsp/upload_json.jsp',
								fileManagerJson : '${base}/kindeditor-4.1.10/jsp/file_manager_json.jsp',
								allowFileManager : true,
								items : ['source','fontname','fontsize','forecolor','preview','selectall','justifyleft','justifycenter','justifyright','emoticons','link','unlink','image'],
								afterCreate : function() {
									var self = this;
									K.ctrl(document, 13, function() {
										self.sync();
										document.forms['example'].submit();
									});
									K.ctrl(self.edit.doc, 13, function() {
										self.sync();
										document.forms['example'].submit();
									});
								}
							});
							prettyPrint();
						});
				    </script>
				<p><button type="submit" class="am-btn am-btn-default">提交</button></p>
			</form>
	    </div>
	    <div class="am-u-md-4" id="my-side">
		    <%@ include file="/WEB-INF/content/common/side.jsp"%>
		</div>
	  </div>
	  
	</div>
	<!-- 底部 -->	
	<%@ include file="/WEB-INF/content/common/footer.jsp"%>
</body>
</html>