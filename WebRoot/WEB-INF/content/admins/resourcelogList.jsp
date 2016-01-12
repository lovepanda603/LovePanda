<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
</head>
<body>
<%@ include file="/WEB-INF/content/admins/header.jsp"%> 

<div class="am-cf admin-main">
<%@ include file="/WEB-INF/content/admins/side.jsp"%> 

  <!-- content start -->
  <div class="admin-content" id="admin-content">
  
  	<ol class="am-breadcrumb">
	  <li><a href="${base}/admins/" class="am-icon-home">后台首页</a></li>
	  <li>系统监控</li>
	</ol>
	<div class="am-g">
		<div class="am-u-sm-6">
		<form class="am-form-inline" method="post" action="${base}/admins/resourcelogList/">
			<div class="am-form-group">
				查询日期
		       <input type="text" placeholder="日期"  name="day" class="Wdate am-form-field"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value=" <fmt:formatDate value='${day}' pattern='yyyy-MM-dd'></fmt:formatDate>"/>
		    </div>
		    <button class="am-btn am-btn-default am-animation-shake" type="submit">搜索</button>
        </form>
        </div>
        <div class="am-u-sm-6">
        	<div class="am-btn-group am-fr">
				<a class="am-btn am-btn-warning" href="${base}/admins/resourcelogTongji/">
				  <i class="am-icon-line-chart"></i>
				 	 图表统计
				</a>
			</div>
        </div>
     <hr data-am-widget="divider" style="" class="am-divider am-divider-default" />
    </div>
    
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main am-table-bordered .am-scrollable-horizontal">
            <thead>
              <tr>
                <th class="table-title">系统</th>
                <th class="table-title">IP</th>
                <th class="table-title">主机名</th>
                <th class="table-title">CPU数量</th>
                <th class="table-title">CPU使用率</th>
                <th class="table-title">内存总量</th>
                <th class="table-title">空闲内存</th>
                <th class="table-title">硬盘容量</th>
                <th class="table-title">空闲硬盘</th>
                <th class="table-title">JVM总量</th>
                <th class="table-title">JVM空闲</th>
                <th class="table-title">JVM最大</th>
                <th class="table-title">GC总量</th>
                <th class="table-title">创建时间</th>
              </tr>
          </thead>
          <tbody>
          	<c:forEach items="${resourceslogPage.list}" var="g">
	            <tr>
	              <td><span class="am-badge am-badge-secondary am-round">${g.osname}</span></td>
	              <td>${g.ip}</td>
	              <td>${g.hostname}</td>
	              <td><span class="am-badge am-badge-secondary am-round">${g.cpunumber}</span></td>
	              <td><span class="am-badge am-badge-primary am-round">${g.cpuratio}%</span></td>
	              <td><span class="am-badge am-badge-success am-round">${g.phymemory/1000} G</span></td>
	              <td><span class="am-badge am-badge-success am-round">${g.phyfreememory/1000} G</span></td>
	              <td><span class="am-badge am-badge-success am-round">${g.diskmemory/1000} G</span></td>
	              <td><span class="am-badge am-badge-success am-round">${g.diskfreememory/1000} G</span></td>
	              <td><span class="am-badge am-badge-success am-round">${g.jvmtotalmemory/1000} G</span></td>
	              <td><span class="am-badge am-badge-success am-round">${g.jvmfreememory/1000} G</span></td>
	              <td><span class="am-badge am-badge-success am-round">${g.jvmmaxmemory/1000} G</span></td>
	              <td><span class="am-badge am-badge-primary am-round">${g.gccount}</span></td>
	              <td><fmt:formatDate value="${g.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	            </tr>
          	</c:forEach>
          </tbody>
        </table> 
        <c:set var="currentPage" value="${resourceslogPage.pageNumber}" />
		<c:set var="totalPage" value="${resourceslogPage.totalPage}" />
		<c:set var="actionUrl" value="${base}/admins/resourcelogList?day=${dayStr}&page=" />
		<c:set var="urlParas" value=""/>
		<center>
			<%@ include file="/common/_paginate.jsp"%>
		</center>
      </div>
    </div>
    
    
  </div>
  <!-- content end -->

</div>


<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
</body>
</html>