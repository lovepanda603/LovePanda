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
  <meta name="keywords" content="">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>LovePanda</title>
  <meta property="qc:admins" content="17257406576415156651636" />
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">

  <!-- No Baidu Siteapp-->
  <meta http-equiv="Cache-Control" content="no-siteapp"/>

  <link rel="icon" type="image/png" href="${base}/amazeui/{{assets}}i/favicon.png">

  <!-- Add to homescreen for Chrome on Android -->
  <meta name="mobile-web-app-capable" content="yes">
  <link rel="icon" sizes="192x192" href="${base}/amazeui/{{assets}}i/app-icon72x72@2x.png">

  <!-- Add to homescreen for Safari on iOS -->
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="black">
  <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
  <link rel="apple-touch-icon-precomposed" href="${base}/amazeui/assets/i/app-icon72x72@2x.png">

  <!-- Tile icon for Win8 (144x144 + tile color) -->
  <meta name="msapplication-TileImage" content="${base}/amazeui/assets/i/app-icon72x72@2x.png">
  <meta name="msapplication-TileColor" content="#0e90d2">
  <style type="text/css">
  	.layui-layer-ico0{
  		background-image: url("${base}/images/ico/32.png");
  	}
  </style>
 <script type="text/javascript">
	$(function(){
		if("${message}"!=null||"${message}"!=""){
			/* $("#result-alert").modal('open'); */
			layer.alert('${message}', {
			    skin: 'layui-layer-moilv' //样式类名
			    ,closeBtn: 0
			    ,icon:0
			}, function(){
				if("${redirectionUrl}"==null||"${redirectionUrl}"==""){
					history.back();
				}else{
					location.href = "${redirectionUrl}";
				}
			});
			/* $("#result-alert-confirm").click(function(){
				if("${redirectionUrl}"==null||"${redirectionUrl}"==""){
					history.back();
				}else{
					location.href = "${redirectionUrl}";
				}
			}); */
		}else{
			if("${redirectionUrl}"==null||"${redirectionUrl}"==""){
				history.back();
			}else{
				location.href = "${redirectionUrl}";
			}
		}
	})
</script>

</head>
<body>

<%-- <div class="am-modal am-modal-alert" tabindex="-1" id="result-alert">
  <div class="am-modal-dialog">
    <div class="am-modal-hd">提示</div>
    <div class="am-modal-bd">
      ${message}
    </div>
    <div class="am-modal-footer">
      <span class="am-modal-btn" id="result-alert-confirm">确定</span>
    </div>
  </div>
</div> --%>
</body>
</html>
