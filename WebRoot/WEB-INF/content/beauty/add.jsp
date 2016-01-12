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
  <script src="${base}/baguetteBox/js/baguetteBox.min.js"></script>
  <link rel="stylesheet" href="${base}/baguetteBox/css/baguetteBox.css">
  <link rel="stylesheet" type="text/css" href="${base}/uploadify/uploadify.css">
  <!--引入JS-->
  <script type="text/javascript" src="${base}/uploadify/jquery.uploadify.js"></script>
   <link rel="stylesheet" href="${base}/kindeditor-4.1.10/plugins/code/prettify.css" />
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/kindeditor.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/plugins/code/prettify.js"></script>
  <style type="text/css">
  	.baguetteBox img{
  		box-sizing: border-box;
		max-width: 100%;
		height: auto;
		vertical-align: middle;
		border: 0;
  		padding-bottom: 20px;
  	}
  	textarea {
		border-color: black;
		border-width: 1px;
		border-style:solid;
		width: 100%;
		margin-bottom: 20px;
	}
  </style>
  

</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
				
	  <div class="am-g am-g-fixed" >
	    <div class="am-u-md-8">
		    <ol class="am-breadcrumb">
			  <li><a href="${base}/" class="am-icon-home">首页</a></li>
			  <li><a href="${base}/beauty/">美图</a></li>
			  <li class="am-active">新建</li>
			</ol>
			<div class="am-form-group">
		      <label for="beauty-title">标题</label>
			  <input type="text" id="beauty-title" class="am-form-field am-radius" require placeholder="请输入标题" />
		    </div>
			<div class="am-form-group">
		      <label for="beauty-keyword">关键字</label>
			  <input type="text" id="beauty-keyword" class="am-form-field am-radius" require placeholder="请输入关键字(关键字间以空格分开)" />
		    </div>
		    <div class="am-form-group">
		      <label for="upload_org_code">图片上传（可多选）</label>
			  <input type="file"  name="upload_org_code" id="upload_org_code" /><br/>
		    </div>
             <div class="beauty-content">
             	<div class="baguetteBox">
				</div>
             </div>
             <div class="am-form-group">
		      <label for="beauty-content">内容</label>
             <textarea id="beauty-content" name="beauty-content"  rows="10"></textarea>
		    </div>
			<p><button type="button" class="am-btn am-btn-default" onclick="dosubmit();">提交</button></p>
	    </div>
	    <div class="am-u-md-4" id="my-side">
		    <%@ include file="/WEB-INF/content/common/side.jsp"%>
		</div>
	  </div>
	  
	</div>
		
	<!-- 底部 -->	
	<%@ include file="/WEB-INF/content/common/footer.jsp"%>
  <script type="text/javascript">
  var editor1;
  KindEditor.ready(function(K) {
		editor1 = K.create('textarea[name="beauty-content"]', {
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
  	var imgurl={};
  	var imgcontent={};
  function restart(){
	  baguetteBox.run('.baguetteBox', {
 	        animation: 'fadeIn'
 	    });
	  $(".beauty-textarea").focusout(function() {
		  var areatitle=$(this).attr("title");
		  imgcontent[areatitle]=$(this).val();
		  $("#img_"+areatitle).attr("title",$(this).val());
		  baguetteBox.run('.baguetteBox', {
	 	        animation: 'fadeIn'
	 	    });
	  });
  }
  function beautycancel(id){
	  console.info(id);
	  $("#img_"+id).remove();
	  $("#p_"+id).remove();
	  $("#btn_"+id).remove();
	  $("#area_"+id).remove();
	  imgurl[id]="";
  }
     $(function() {
         $("#upload_org_code").uploadify({
             'height'        : 27,
             'width'         : 80, 
             'buttonText'    : '选择图片',
             'swf'           : '${base}/uploadify/uploadify.swf',
             'uploader'      : '${base}/beauty/saveBeauty/',
             'auto'          : true,
             'multi'         : true,
             'removeCompleted':true,
             'fileTypeExts'  : '*.jpg;*.jpge;*.gif;*.png',
             'fileSizeLimit' : '2MB',
             'onUploadSuccess':function(file,data,response){
            	 var ht="<a id='img_"+file.id+"' href='${base}/attached/beauty/"+data+"' title=''><img src='${base}/attached/beauty/"+data+"'></a>";
            	 ht+="<p id='btn_"+file.id+"'><button class='am-btn am-btn-default' title='"+file.id+"' onclick='beautycancel(&quot;"+file.id+"&quot;)'><i class='am-icon-close'></i>删除该图片</button></p>";
            	 ht+="<p id='p_"+file.id+"'>图片描述（可为空）</p>";
            	 ht+="<textarea class='beauty-textarea' rows='2' id='area_"+file.id+"' title='"+file.id+"'></textarea>";
                $(".baguetteBox").append(ht);
                imgurl[file.id]=data;
                restart();
             },
             //返回一个错误，选择文件的时候触发
             'onSelectError':function(file, errorCode, errorMsg){
                 console.info(11111);
              }
         });
     });
     function dosubmit(){
    	 var beautytitle=$("#beauty-title").val();
    	 if(beautytitle==""){
    		 alert("标题不能为空");
    	 }else{
	    	 var beautycontent=editor1.html();
	    	 var beautykeyword=$("#beauty-keyword").val();
	    	 $.post("${base}/beauty/save/", 
	    			 { "imgurl": JSON.stringify(imgurl),
	    		 		"imgcontent":JSON.stringify(imgcontent),
	    		 		"beautytitle":beautytitle,
	    		 		"beautykeyword":beautykeyword,
	    		 		"beautycontent":beautycontent,
	    		 	 },function(data){
	    			     if(data==1){
	    			    	 location.href="${base}/beauty/";
	    			     }else if(data==2){
	    			    	alert("标题不能为空")
	    			     }else if(data==3){
	    			    	 alert("图片不能为空");
	    			     }else{
	    			    	 alert("未知错误");
	    			     }
	    			   });
    	 }
     }
     
</script>
</body>
</html>