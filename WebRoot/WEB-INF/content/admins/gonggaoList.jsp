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
</head>
<body>
<%@ include file="/WEB-INF/content/admins/header.jsp"%> 



<div class="am-cf admin-main">
<%@ include file="/WEB-INF/content/admins/side.jsp"%> 

  <!-- content start -->
  <div class="admin-content" id="admin-content">
  
  	<ol class="am-breadcrumb">
	  <li><a href="${base}/admins/" class="am-icon-home">后台首页</a></li>
	  <li>滚动公告列表</li>
	</ol>
	
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main am-table-bordered">
            <thead>
              <tr>
                <th class="table-id">ID</th>
                <th class="table-title">内容</th>
                <th class="table-type">链接</th>
                <th class="table-author">排序号</th>
                <th class="table-date">修改日期</th>
                <th class="table-set">操作</th>
              </tr>
          </thead>
          <tbody>
          	<c:forEach items="${gonggaoList}" var="g">
	            <tr>
	              <td>${g.id}</td>
	              <td>${g.content }</td>
	              <td>${g.url}</td>
	              <td>${g.sn }</td>
	              <td><fmt:formatDate value="${g.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	              <td>
	                <div class="am-btn-toolbar">
	                  <div class="am-btn-group am-btn-group-xs">
	                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${base}/admins/gonggaoEdit?id=${g.id}"><span class="am-icon-pencil-square-o"></span> 编辑</a>
	                    <a class="am-btn am-btn-default am-btn-xs am-text-danger" href="${base}/admins/gonggaoDelete?id=${g.id}" onclick="return confirm('您确定要删除该公告吗？');"></span> 删除</a>
	                  </div>
	                </div>
	              </td>
	            </tr>
          	</c:forEach>
          </tbody>
        </table>
        <div class="am-btn-group am-btn-group-xs">
          <button type="button" class="am-btn am-btn-default" onclick="javascript:location.href='${base}/admins/gonggaoAdd/'"><span class="am-icon-plus"></span> 新增</button>
          <button type="button" class="am-btn am-btn-default" onclick="javascript:location.href='${base}/admins/refreshGonggao/'"><i class="am-icon-circle-o-notch am-icon-spin"></i> 刷新缓存</button>
        </div>
        <div class="am-cf">
			  共 ${fn:length(gonggaoList)} 条记录
		</div>
      </div>
    </div>
    
    
  </div>
  <!-- content end -->

</div>


<%@ include file="/WEB-INF/content/admins/footer.jsp"%> 
</body>
</html>