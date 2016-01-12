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
  <meta name="description" content="${siteName}建议和留言">
  <meta name="keywords" content="${siteName}建议和留言">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>${siteName}建议和留言</title>
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" />
   <!-- 引入kindeditor文件 -->
     <link rel="stylesheet" href="${base}/kindeditor-4.1.10/plugins/code/prettify.css" />
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/kindeditor.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/lang/zh_CN.js"></script>
	<script charset="utf-8" src="${base}/kindeditor-4.1.10/plugins/code/prettify.js"></script>

</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
	  <div class="am-g am-g-fixed">
	    <div class="am-u-md-8">
			 <form class="am-form" action="${base}/index/saveAdvice" method="post" enctype="multipart/form-data">
			  <fieldset>
			    <legend>意见或留言</legend>
			    <div class="am-form-group">
			      <label for="advice-content">请输入您的意见或留言</label>
			      <textarea id="advice-content" name="advice.content"  rows="25"></textarea>
			    </div>
			    <script type="text/javascript">
				    var editor1;
				    KindEditor.ready(function(K) {
						editor1 = K.create('textarea[name="advice.content"]', {
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
				 <c:if test="${empty sessionScope.loginUser}">
					 <div class="am-checkbox">
				      <label>
				        <input id="index-advice-checkbox" type="checkbox" onclick="niming();"> 匿名
				      </label>
				    </div>
				    <script type="text/javascript">
				    	function niming(){
				    		if($('#index-advice-checkbox').is(':checked')){
				    			$("#index-advice-userinputinfo").hide();
				    		}else{
				    			$("#index-advice-userinputinfo").show();
				    		}
				    	}
				    </script>
				 	<div id="index-advice-userinputinfo">
					 	<div class="am-input-group am-input-group-primary">
						  <span class="am-input-group-label"><i class="am-icon-user am-icon-fw"></i></span>
						  <input type="text" name="advice.name" class="am-form-field" placeholder="请输入您的姓名">
						</div>
						<div class="am-input-group am-input-group-secondary">
						  <span class="am-input-group-label"><i class="am-icon-comments-o am-icon-fw"></i></span>
						  <input type="text" name="advice.contact" class="am-form-field" placeholder="请输入您的联系方式">
						</div>
					</div>
				 </c:if>
			
			    <p><button type="submit" class="am-btn am-btn-default">提交</button></p>
			  </fieldset>
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