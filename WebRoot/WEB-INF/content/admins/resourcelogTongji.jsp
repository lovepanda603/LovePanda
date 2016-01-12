<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<!-- 引入基本库和js，css文件 --> 
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${siteName}后台管理</title>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <meta name="renderer" content="webkit">
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" />
   <%@ include file="/WEB-INF/content/admins/taglib.jsp"%> 
   <script language="javascript" type="text/javascript" src="${base}/sucai/My97DatePicker/WdatePicker.js"></script>
   <script type="text/javascript">
   		function nextTongji(va){
   			var time=$("input[name=day]").val();
   			if(time==undefined||time==""||time==" "){
   				layer.msg('参数错误，请检查时间是否正确');
   			}else{
   				location.href="${base}/admins/resourcelogTongji?day="+time+"&next="+va;
   			}
   		}
   </script>
</head>
<body>
<%@ include file="/WEB-INF/content/admins/header.jsp"%> 



<div class="am-cf am-g admin-main">
<%@ include file="/WEB-INF/content/admins/side.jsp"%> 

  <!-- content start -->
  <div class="admin-content" id="admin-content">
	  <ol class="am-breadcrumb">
		  <li><a href="${base}/admins/" class="am-icon-home">后台首页</a></li>
		  <li><a href="${base}/admins/resourcelogList/">系统监控</a></li>
		  <li>系统监控统计</li>
	  </ol>
  	<script type="text/javascript">
	</script>
   	
	  <div class="am-g">
	  	<div class="am-u-sm-12">
	  	<form class="am-form-inline" method="post" action="${base}/admins/resourcelogTongji/">
			<div class="am-form-group">
				查询时间
		       <input type="text" placeholder="日期" readonly="readonly"  name="day" class="Wdate am-form-field"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH'})" value=" <fmt:formatDate value='${day}' pattern='yyyy-MM-dd HH'></fmt:formatDate>"/>
		    </div>
		    <button class="am-btn am-btn-secondary am-animation-shake" type="submit">搜索</button>
		    <button class="am-btn am-btn-primary am-animation-shake" type="button" onclick="nextTongji(-1);"> <i class="am-icon-chevron-circle-left"></i>上一时间段</button>
		    <button class="am-btn am-btn-primary am-animation-shake" type="button" onclick="nextTongji(1);"> <i class="am-icon-chevron-circle-right"></i>下一时间段</button>
        </form>
         <hr data-am-widget="divider" style="" class="am-divider am-divider-default" />
		 <div id="main-cpu" style="height:350px;width:100%"></div>
	    <script src="${base}/echarts-2.2.3/build/dist/echarts.js"></script>
	    <script type="text/javascript">
	        require.config({
	            paths: {
	                echarts: '${base}/echarts-2.2.3/build/dist'
	            }
	        });
	        require(
	            [
	                'echarts',
	                'echarts/chart/line'
	            ],
	            function (ec) {
	                var myChartcpu = ec.init(document.getElementById('main-cpu')); 
	                var option = ${cpuTJ};
	                myChartcpu.setOption(option); 
	            }
	        );
	    </script>
	    <div id="main-phy" style="height:350px;width:100%"></div>
	    <script type="text/javascript">
	        require.config({
	            paths: {
	                echarts: '${base}/echarts-2.2.3/build/dist'
	            }
	        });
	        require(
	            [
	                'echarts',
	                'echarts/chart/line'
	            ],
	            function (ec) {
	                var myChartphy = ec.init(document.getElementById('main-phy')); 
	                var option = ${phyTJ};
	                myChartphy.setOption(option); 
	            }
	        );
	    </script>
	    <div id="main-disk" style="height:350px;width:100%"></div>
	    <script type="text/javascript">
	        require.config({
	            paths: {
	                echarts: '${base}/echarts-2.2.3/build/dist'
	            }
	        });
	        require(
	            [
	                'echarts',
	                'echarts/chart/line'
	            ],
	            function (ec) {
	                var myChartphy = ec.init(document.getElementById('main-disk')); 
	                var option = ${diskTJ};
	                myChartphy.setOption(option); 
	            }
	        );
	    </script>
	    <div id="main-jvm" style="height:350px;width:100%"></div>
	    <script type="text/javascript">
	        require.config({
	            paths: {
	                echarts: '${base}/echarts-2.2.3/build/dist'
	            }
	        });
	        require(
	            [
	                'echarts',
	                'echarts/chart/line'
	            ],
	            function (ec) {
	                var myChartphy = ec.init(document.getElementById('main-jvm')); 
	                var option = ${jvmTJ};
	                myChartphy.setOption(option); 
	            }
	        );
	    </script>
	    <div id="main-gc" style="height:350px;width:100%"></div>
	    <script type="text/javascript">
	        require.config({
	            paths: {
	                echarts: '${base}/echarts-2.2.3/build/dist'
	            }
	        });
	        require(
	            [
	                'echarts',
	                'echarts/chart/line'
	            ],
	            function (ec) {
	                var myChartphy = ec.init(document.getElementById('main-gc')); 
	                var option = ${gcTJ};
	                myChartphy.setOption(option); 
	            }
	        );
	    </script>

	    </div>
	 </div>
		
  </div>
  <!-- content end -->
</div>

<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
</body>
</html>
