<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/content/common/taglib.jsp"%>
<script src="${base}/sucai/jsrop/js/jquery.Jcrop.js"></script>
<script src="${base}/js/jquery-form.js"></script>
<script type="text/javascript">
	var rooturl='${base}';
	var jcrop_api;
  jQuery(function($){
    $('#target').Jcrop({
    	bgColor: 'black',
        bgOpacity: 0.4,
        setSelect: [0, 0, 100,100],  //设定4个角的初始位置
        aspectRatio: 1 / 1,
        onChange: showCoords,   //当裁剪框变动时执行的函数
        onSelect: showCoords,
        minSize:[100,100],
        maxSize:[300,300],
    },function(){
      jcrop_api = this;
    });

  });

  function cahngavatar(){
	  $("#personalInfo-getImage").ajaxSubmit({
		  url:'${base}/user/getImage',
		  type:'post',
		  success:function(data)    
          {    
           	var wi;
           	var he;
            if(data.message!=1){
            	alert(data.message);
            }else{
            	getImageWidth(rooturl+"/attached/temp/"+data.url,function(w,h){
            		if(w!=undefined){
	            		wi=w;
            		}
            		if(h!=undefined){
	            		he=h;
            		}
            		if(w<100||h<100||h>800){
            			layer.alert('图片尺寸不能小于100*100px且图片高度不能大于800', {
            			    skin: 'layui-layer-moilv' //样式类名
            			    ,closeBtn: 0
            			    ,icon:0
            			});
            			 return false;
            		}
            	}
            		);
            
            		if(wi<100||he<100||he>800){
            			layer.alert('图片尺寸不能小于100*100px且图片高度不能大于800', {
            			    skin: 'layui-layer-moilv' //样式类名
            			    ,closeBtn: 0
            			    ,icon:0
            			});
            		}else{
		            	 $("#target").attr("src", rooturl+"/attached/temp/"+data.url);
		            	$("#avatarname").val(data.url);
		             	jcrop_api.setImage(rooturl+"/attached/temp/"+data.url);
		            	 $('#target').Jcrop({
		                    bgColor: 'black',
		                    bgOpacity: 0.4,
		                    setSelect: [0, 0, 100,100],  //设定4个角的初始位置
		                    aspectRatio: 1 / 1,
		                    onChange: showCoords,   //当裁剪框变动时执行的函数
		                    onSelect: showCoords,   //当选择完成时执行的函数
		                    minSize:[100,100],
		                    maxSize:[300,300],
		                },function(){
		                    jcrop_api = this;
		                });
		            	 $(".jcrop-holder").attr("style","width: "+wi+"px; height: "+he+"px; position: relative; background-color: black;");
		            	 $(".jcrop-holder").children("img").attr("style","width:"+wi+"px;height:"+he+"px;");
		            	 $(".jcrop-holder").children(".jcrop-tracker").attr("style","width: "+wi+"px; height: "+he+"px; position: absolute; top: -2px; left: -2px; z-index: 290; cursor: crosshair;");
            		}
            }
          } ,
          dataType:'json'
		  
	  });
	  
  }
//当裁剪框变动时，将左上角相对图片的X坐标与Y坐标，宽度以及高度放到<input type="hidden">中(上传到服务器上裁剪会用到)
  function showCoords(c) {
      $("#p1").text(c.x + "   " + c.y + "   " + c.w + "   " + c.h );
      $("#x1").val(c.x);
      $("#y1").val(c.y);
      $("#cw").val(c.w);
      $("#ch").val(c.h);

  }

  function getImageWidth(url,callback){
  	var img = new Image();
  	img.src = url;
  	
  	// 如果图片被缓存，则直接返回缓存数据
  	if(img.complete){
  	    callback(img.width, img.height);
  	}else{
              // 完全加载完毕的事件
  	    img.onload = function(){
  		callback(img.width, img.height);
  	    }
          }
  	
  }
  function setDefault(){
	  console.info('.........');
	  $("#target").attr("src", rooturl+"/attached/avatar/default.jpg");
  	$("#avatarname").val("default");
  	 $('#target').Jcrop({
          bgColor: 'black',
          bgOpacity: 0.4,
          setSelect: [0, 0, 100,100],  //设定4个角的初始位置
          aspectRatio: 1 / 1,
          onChange: showCoords,   //当裁剪框变动时执行的函数
          onSelect: showCoords,   //当选择完成时执行的函数
          minSize:[100,100],
          maxSize:[300,300],
      },function(){
          jcrop_api = this;
      });
   	jcrop_api.setImage(rooturl+"/attached/avatar/default.jpg");
  }
</script>
<link rel="stylesheet" href="${base}/sucai/jsrop/css/jquery.Jcrop.css" type="text/css" />



<div class="am-container">
	<form id="personalInfo-getImage" action="${base}/user/getImage">
		<div class="am-form-group am-form-file">
		  <button type="button" class="am-btn am-btn-danger am-btn-sm">
		    <i class="am-icon-cloud-upload"></i> 选择要上传头像</button>
		  <input type="file" name="upload" multiple onchange="cahngavatar();">
		</div>
	</form>
 	<form id="FaceUpload" name="FaceUpload" method="post" action="${base}/user/updateAvatar" style="padding-top: 10px">
 		<input type="hidden" name="avatar" id="avatarname" value="${user.avatar}">
        <input type="hidden" id="x1" name="x1" value="0" />
        <input type="hidden" id="y1" name="y1" value="0" />
        <input type="hidden" id="cw" name="cw" value="100" />
        <input type="hidden" id="ch" name="ch" value="100" />
	  	<button type="submit" class="am-btn am-btn-secondary  am-btn-lg"  > <i class="am-icon-check"></i> 提交</button><span style="color: red;">请确定下面的头像调整合适后再提交</span>
    </form>
    <hr>
	
	<div>
		<c:if test="${fn:contains(user.avatar,'http://') }">
	   		<img  alt="${user.username}" id="target" src="${user.avatar}" onerror="setDefault();"/>
	 	</c:if>
	 	<c:if test="${not fn:contains(user.avatar,'http://') }">
	   		<img alt="${user.username}" id="target" src="${base}/attached/avatar/${user.avatar}" onerror="setDefault();"/>
	 	</c:if>
 	</div>
  
</div>




