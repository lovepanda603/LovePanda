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
	  <li>意见和建议</li>
	</ol>
	
    <div class="am-g">
      <div class="am-u-sm-12">
          <table class="am-table am-table-striped am-table-hover table-main am-table-bordered">
            <thead>
              <tr>
                <th class="table-id">ID</th>
                <th class="table-title">关联用户</th>
                <th class="table-type">内容</th>
                <th class="table-author">姓名</th>
                <th class="table-date">联系方式</th>
                <th class="table-date">创建时间</th>
                <th class="table-set" width="230px">操作</th>
              </tr>
          </thead>
          <tbody>
          	<c:forEach items="${advicePage.list}" var="g">
	            <tr>
	              <td>${g.id}</td>
	              <td>${g.username }</td>
	              <td>${g.content_show}</td>
	              <td>${g.name}</td>
	              <td>${g.contact}</td>
	              <td><fmt:formatDate value="${g.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	              <td>
	                <div class="am-btn-toolbar">
	                  <div class="am-btn-group am-btn-group-xs">
	                    <a class="am-btn am-btn-default am-btn-xs am-text-secondary" href="${base}/admins/adviceDetail?id=${g.id}"><span class="am-icon-pencil-square-o"></span>详情</a>
	                    <a class="am-btn am-btn-default am-btn-xs am-text-danger" href="${base}/admins/adviceDelete?id=${g.id}" onclick="return confirm('您确定要删除该意见和建议吗？');"><span class="am-icon-trash-o"></span> 删除</a>
	                    <c:if test="${g.isread==0}">
	                    	<a class="am-btn am-btn-default am-btn-xs am-text-success" href="${base}/admins/adviceRead?id=${g.id}"> 标记为已读</a>
	                    </c:if>
	                    <c:if test="${g.isread==1}">
	                    	<a class="am-btn am-btn-default am-btn-xs am-text-success am-disabled">已读</a>
	                    </c:if>
	                  </div>
	                </div>
	              </td>
	            </tr>
          	</c:forEach>
          </tbody>
        </table>
        <c:set var="currentPage" value="${advicePage.pageNumber}" />
				<c:set var="totalPage" value="${advicePage.totalPage}" />
				<c:set var="actionUrl" value="${base}/admins/adviceList?page=" />
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