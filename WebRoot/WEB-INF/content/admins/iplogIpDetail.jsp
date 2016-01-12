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
   <style type="text/css">
   	.layui-layer-content{
   		margin: 10px;
   	}
   </style>
   <script type="text/javascript">
   	function ipSearch(ipstr){
   		$.getScript('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip='+ipstr, 
   				function(_result){  
		   			if (remote_ip_info.ret == '1'){   
		   				layer.open({
		   				    type: 1,
		   				 	shadeClose:true, 
		   				    skin: 'layui-layer-rim', //加上边框
		   				    area: ['420px', '300px'], //宽高
		   				    content: "IP："+ipstr+"<br>国家："+remote_ip_info.country+"<BR>省份："+remote_ip_info.province+"<br>城市："+remote_ip_info.city+"<br>区："+remote_ip_info.district+"<br>ISP："+remote_ip_info.isp+"<br>类型："+remote_ip_info.type+"<br>其他："+remote_ip_info.desc
		   				});
		   			} else {   
		
		   			alert('错误', '没有找到匹配的 IP 地址信息！');   
		
		   			}
   				});
   	}
   </script> 
</head>
<body>
<%@ include file="/WEB-INF/content/admins/header.jsp"%> 



<div class="am-cf admin-main">
<%@ include file="/WEB-INF/content/admins/side.jsp"%> 

  <!-- content start -->
  <div class="admin-content" id="admin-content">
  
  	<ol class="am-breadcrumb">
	  <li><a href="${base}/admins/" class="am-icon-home">后台首页</a></li>
	  <li><a href="${base}/admins/iplogList/">Ip日志</a></li>
	  <li>Ip详情</li>
	</ol>
	<div class="am-g">
		<div class="am-u-sm-12">
		<form class="am-form-inline" method="post" action="${base}/admins/iplogIpDetail/">
			<input type="hidden" name="ip" value="${ip}">
			<div class="am-form-group">
				开始时间
		       <input type="text" placeholder="开始时间"  name="start" class="Wdate am-form-field"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value=" <fmt:formatDate value='${startDate}' pattern='yyyy-MM-dd'></fmt:formatDate>"/>
		    </div>
			<div class="am-form-group">
				结束时间
		       <input type="text" placeholder="结束时间"  name="end" class="Wdate am-form-field"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value=" <fmt:formatDate value='${endDate}' pattern='yyyy-MM-dd'></fmt:formatDate>"/>
		    </div>
		    <button class="am-btn am-btn-default am-animation-shake" type="submit">搜索</button>
        </form>
        </div>
    </div>
    <div class="am-g">
		<div class="am-u-sm-12">
		    <span>总数 </span><a class="am-badge am-badge-warning am-round">${fn:length(Ips)}</a>
		</div>
	</div>
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main am-table-bordered">
            <thead>
              <tr>
                <th class="table-id">ID</th>
                <th class="table-title">IP</th>
                <th class="table-type">url</th>
                <th class="table-author">参数</th>
                <th class="table-date">创建时间</th>
                <th class="table-title">计数</th>
              </tr>
          </thead>
          <tbody>
          	<c:forEach items="${Ips}" var="g" varStatus="s">
	            <tr>
	              <td>${g.id}</td>
	              <td>${g.ip}</td>
	              <td>${g.url}</td>
	              <td>${g.params}</td>
	              <td><fmt:formatDate value="${g.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	              <td>${s.count}</td>
	            </tr>
          	</c:forEach>
          </tbody>
        </table>
      </div>
    </div>
    
    
  </div>
  <!-- content end -->

</div>


<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
</body>
</html>