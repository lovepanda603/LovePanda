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
  <meta name="keywords" content="${keyword}">
  <meta name="viewport"
        content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
  <title>搜索结果：${keyword}</title>
  <!-- Set render engine for 360 browser -->
  <meta name="renderer" content="webkit">  
  <link rel="icon" href="${base}/favicon.ico" type="image/x-icon" />   
	<style type="text/css">
	.am-list-main{
		padding: 5px;
	}
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/content/common/header.jsp"%>
	<div class="am-container " id="main">
	  <div class="am-g am-g-fixed">
	  	<div class="banner_navbg">
	    	<div class="am-g">
			  	<div class="am-u-md-12">
	        	<div class="banner_nav">
	        		<span class="am-icon-caret-right">
	        			筛选：
	        		</span>
	        		<c:if test="${rank eq '1'}">
		        		<a href="${base}/index/search?keyword=${keyword}&rank=0">人气最高</a>
		        		<a href="${base}/index/search?keyword=${keyword}&rank=1" class="banner_hover">最新发布</a>
	        		</c:if>
	        		<c:if test="${rank ne '1'}">
		        		<a href="${base}/index/search?keyword=${keyword}&rank=0" class="banner_hover">人气最高</a>
		        		<a href="${base}/index/search?keyword=${keyword}&rank=1" >最新发布</a>
	        		</c:if>
	        	</div>
	        	</div>
		    </div>
		</div>
	    <div class="am-u-md-8">
			<div data-am-widget="tabs" class="am-tabs am-tabs-d2 am_news_tab">
			  <ul class="am-tabs-nav am-cf am_cf">
			    <li class="" id="search-all-li">
			      <a href="[data-tab-panel-0]" onclick="">全部</a>
			    </li>
			    <li class="" id="search-blog-li">
			      <a href="[data-tab-panel-1]" onclick="blogSearch(0);">博客</a>
			    </li>
			    <li class="" id="search-beauty-li">
			      <a href="[data-tab-panel-2]" onclick="beautySearch(0);">美图</a>
			    </li>
			    <li class="" id="search-video-li">
			      <a href="[data-tab-panel-3]" onclick="videoSearch(0);">视频</a>
			    </li>
			  </ul>
			  <div class="am-tabs-bd">
			    <div data-tab-panel-0 class="am-tab-panel" id="search-all-div">
				 </div>
			    <div data-tab-panel-1 class="am-tab-panel" id="search-blog-div">
			    </div>
				<div data-tab-panel-2 class="am-tab-panel " id="search-beauty-div">
			 	</div>
				<div data-tab-panel-3 class="am-tab-panel " id="search-video-div">
			 	</div>
			  </div>
			</div>
				
	    	</div>
	    <div class="am-u-md-4" id="my-side">
	    	<%@ include file="/WEB-INF/content/common/side.jsp"%>
	    </div>
	  </div>

	</div>
		<!-- 底部 -->	
		<%@ include file="/WEB-INF/content/common/footer.jsp"%>
	<script type="text/javascript">
		var keyword='${keyword}';
		var rank='${rank}';
		var type='${type}';
		var url='${base}';
		$(function(){
			allSearch(1);
		});
		function allSearch(allpage){
			$.post(url+"/index/getSearchJson/", 
					{ "keyword": keyword,
						"type":type,
						"rank":rank,
						"page":allpage
					},
					   function(data){
				    	  var html="";
				    	  html+="<div class='am-list-news-bd am_news_list_all'><ul class='am-list'>"
			    		  if(data.pageNumber>1){
				    		  var pageminus=parseInt(data.pageNumber)-1;
				    		minus="<div class='am_news_load'><a href='#' onclick='allSearch("+pageminus+")'><span><i class='am-icon-spinner am-icon-spin'></i>查看前页</span></a></div>";
				    		html+=minus;
				    	  }
					    $.each( data.list, function(i, n){
					    	html+="<li class='am-g am-list-item-desced am_list_li'>";
					    	html+=" <div class='am-list-main'>";
					    	html+="<h3 class='am-list-item-hd am_list_title am_list_title_s'>";
					    	if(n.columns.TYPE=="1"){
					    		html+="<a href='"+url+"/blog/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
					    	}
					    	if(n.columns.TYPE=="2"){
					    		html+="<a href='"+url+"/beauty/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
					    	}
					    	if(n.columns.TYPE=="3"){
					    		html+="<a href='"+url+"/video/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
					    	}
					    	html+="</h3>";
					    	html+="<div class='am_list_author'>";
					    	html+="<span class='am-badge am-badge-secondary'>";
					    	if(n.columns.TYPE=="1"){
					    		html+="博客";
					    	}
					    	if(n.columns.TYPE=="2"){
					    		html+="美图";
					    	}
					    	if(n.columns.TYPE=="3"){
					    		html+="视频";
					    	}
					    	html+="</span>";
					    	html+="<a href='javascript:void(0)'>";
					    	html+="<span class='am_list_author_ico' style='background-image: url("+url+"/attached/avatar/"+n.columns.avatar+");'></span>";
					    	html+="<span class='name'>"+n.columns.username+"</span>";
					    	html+=" </a>";
					    	html+=" <span class='am_news_time'><i class='am-icon-clock-o'></i><time class='timeago'> "+n.columns.create_time+"</time>";
					    	html+=" </span>";
					    	html+="<span class='am_news_time'><i class='am-icon-eye'></i><span>"+n.columns.view+"</span>";
					    	html+="</span>";
					    	html+="</div>";
					    	html+="<div class='am-list-item-text am_list_item_text'>";
					    	var contentshow=n.columns.content;
					    	if(contentshow==undefined){
					    		contentshow="";
					    	}
					    	html+=contentshow;
					    	html+="</div>";
					    	html+="</div>";
					    	html+="</li>";
					    	});
				    	  var more="";
				    	  if(data.totalPage>data.pageNumber){
				    		  var page=parseInt(data.pageNumber)+1;
				    		more="<div class='am_news_load'><a href='#' onclick='allSearch("+page+")'><span><i class='am-icon-spinner am-icon-spin'></i>查看更多</span></a></div>";
				    	  }
				    	  html+=more;
				    	  html+="</ul>";
				    	  html+="</div>";
				    	  $("#search-all-div").html(html);
					   }, 
					   "json");
		}
		function blogSearch(blogpage){
			var oldhtml= $("#search-blog-div").html();
			if(($.trim(oldhtml)==""&&blogpage==0)||blogpage!=0){
				if(blogpage==0){
					blogpage=1;
				}
				$.post(url+"/index/getSearchJson/", 
						{ "keyword": keyword,
							"type":"blog",
							"rank":rank,
							"page":blogpage
						},
						   function(data){
					    	  var html="";
					    	  html+="<div class='am-list-news-bd am_news_list_all'><ul class='am-list'>"
				    		  if(data.pageNumber>1){
					    		  var pageminus=parseInt(data.pageNumber)-1;
					    		minus="<div class='am_news_load' onclick='blogSearch("+pageminus+")'><a href='#' ><span><i class='am-icon-spinner am-icon-spin'></i>查看前页</span></a></div>";
					    		html+=minus;
					    	  }
						    $.each( data.list, function(i, n){
						    	html+="<li class='am-g am-list-item-desced am_list_li'>";
						    	html+=" <div class='am-list-main'>";
						    	html+="<h3 class='am-list-item-hd am_list_title am_list_title_s'>";
						    	if(n.columns.TYPE=="1"){
						    		html+="<a href='"+url+"/blog/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	if(n.columns.TYPE=="2"){
						    		html+="<a href='"+url+"/beauty/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	if(n.columns.TYPE=="3"){
						    		html+="<a href='"+url+"/video/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	html+="</h3>";
						    	html+="<div class='am_list_author'>";
						    	html+="<span class='am-badge am-badge-secondary'>";
						    	if(n.columns.TYPE=="1"){
						    		html+="博客";
						    	}
						    	if(n.columns.TYPE=="2"){
						    		html+="美图";
						    	}
						    	if(n.columns.TYPE=="3"){
						    		html+="视频";
						    	}
						    	html+="</span>";
						    	html+="<a href='javascript:void(0)'>";
						    	html+="<span class='am_list_author_ico' style='background-image: url("+url+"/attached/avatar/"+n.columns.avatar+");'></span>";
						    	html+="<span class='name'>"+n.columns.username+"</span>";
						    	html+=" </a>";
						    	html+=" <span class='am_news_time'><i class='am-icon-clock-o'></i><time class='timeago'> "+n.columns.create_time+"</time>";
						    	html+=" </span>";
						    	html+="<span class='am_news_time'><i class='am-icon-eye'></i><span>"+n.columns.view+"</span>";
						    	html+="</span>";
						    	html+="</div>";
						    	html+="<div class='am-list-item-text am_list_item_text'>";
						    	var contentshow=n.columns.content;
						    	if(contentshow==undefined){
						    		contentshow="";
						    	}
						    	html+=contentshow;
						    	html+="</div>";
						    	html+="</div>";
						    	html+="</li>";
						    	});
					    	  var more="";
					    	  if(data.totalPage>data.pageNumber){
					    		  var page=parseInt(data.pageNumber)+1;
					    		more="<div class='am_news_load' onclick='blogSearch("+page+")'><a href='#' ><span><i class='am-icon-spinner am-icon-spin'></i>查看更多</span></a></div>";
					    	  }
					    	  html+=more;
					    	  html+="</ul>";
					    	  html+="</div>";
					    	  $("#search-blog-div").html(html);
						   }, 
						   "json");
				
			}
		}
		function beautySearch(beautypage){
			var oldhtml= $("#search-beauty-div").html();
			if(($.trim(oldhtml)==""&&beautypage==0)||beautypage!=0){
				if(beautypage==0){
					beautypage=1;
				}
				$.post(url+"/index/getSearchJson/", 
						{ "keyword": keyword,
							"type":"beauty",
							"rank":rank,
							"page":beautypage
						},
						   function(data){
					    	  var html="";
					    	  html+="<div class='am-list-news-bd am_news_list_all'><ul class='am-list'>"
				    		  if(data.pageNumber>1){
					    		  var pageminus=parseInt(data.pageNumber)-1;
					    		minus="<div class='am_news_load' onclick='beautySearch("+pageminus+")'><a href='#' ><span><i class='am-icon-spinner am-icon-spin'></i>查看前页</span></a></div>";
					    		html+=minus;
					    	  }
						    $.each( data.list, function(i, n){
						    	html+="<li class='am-g am-list-item-desced am_list_li'>";
						    	html+=" <div class='am-list-main'>";
						    	html+="<h3 class='am-list-item-hd am_list_title am_list_title_s'>";
						    	if(n.columns.TYPE=="1"){
						    		html+="<a href='"+url+"/blog/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	if(n.columns.TYPE=="2"){
						    		html+="<a href='"+url+"/beauty/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	if(n.columns.TYPE=="3"){
						    		html+="<a href='"+url+"/video/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	html+="</h3>";
						    	html+="<div class='am_list_author'>";
						    	html+="<span class='am-badge am-badge-secondary'>";
						    	if(n.columns.TYPE=="1"){
						    		html+="博客";
						    	}
						    	if(n.columns.TYPE=="2"){
						    		html+="美图";
						    	}
						    	if(n.columns.TYPE=="3"){
						    		html+="视频";
						    	}
						    	html+="</span>";
						    	html+="<a href='javascript:void(0)'>";
						    	html+="<span class='am_list_author_ico' style='background-image: url("+url+"/attached/avatar/"+n.columns.avatar+");'></span>";
						    	html+="<span class='name'>"+n.columns.username+"</span>";
						    	html+=" </a>";
						    	html+=" <span class='am_news_time'><i class='am-icon-clock-o'></i><time class='timeago'> "+n.columns.create_time+"</time>";
						    	html+=" </span>";
						    	html+="<span class='am_news_time'><i class='am-icon-eye'></i><span>"+n.columns.view+"</span>";
						    	html+="</span>";
						    	html+="</div>";
						    	html+="<div class='am-list-item-text am_list_item_text'>";
						    	var contentshow=n.columns.content;
						    	if(contentshow==undefined){
						    		contentshow="";
						    	}
						    	html+=contentshow;
						    	html+="</div>";
						    	html+="</div>";
						    	html+="</li>";
						    	});
					    	  var more="";
					    	  if(data.totalPage>data.pageNumber){
					    		  var page=parseInt(data.pageNumber)+1;
					    		more="<div class='am_news_load' onclick='beautySearch("+page+")'><a href='#' ><span><i class='am-icon-spinner am-icon-spin'></i>查看更多</span></a></div>";
					    	  }
					    	  html+=more;
					    	  html+="</ul>";
					    	  html+="</div>";
					    	  $("#search-beauty-div").html(html);
						   }, 
						   "json");
				
			}
		}
		function videoSearch(videopage){
			var oldhtml= $("#search-video-div").html();
			if(($.trim(oldhtml)==""&&videopage==0)||videopage!=0){
				if(videopage==0){
					videopage=1;
				}
				$.post(url+"/index/getSearchJson/", 
						{ "keyword": keyword,
							"type":"video",
							"rank":rank,
							"page":videopage
						},
						   function(data){
					    	  var html="";
					    	  html+="<div class='am-list-news-bd am_news_list_all'><ul class='am-list'>"
				    		  if(data.pageNumber>1){
					    		  var pageminus=parseInt(data.pageNumber)-1;
					    		minus="<div class='am_news_load' onclick='videoSearch("+pageminus+")'><a href='#' ><span><i class='am-icon-spinner am-icon-spin'></i>查看前页</span></a></div>";
					    		html+=minus;
					    	  }
						    $.each( data.list, function(i, n){
						    	html+="<li class='am-g am-list-item-desced am_list_li'>";
						    	html+=" <div class='am-list-main'>";
						    	html+="<h3 class='am-list-item-hd am_list_title am_list_title_s'>";
						    	if(n.columns.TYPE=="1"){
						    		html+="<a href='"+url+"/blog/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	if(n.columns.TYPE=="2"){
						    		html+="<a href='"+url+"/beauty/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	if(n.columns.TYPE=="3"){
						    		html+="<a href='"+url+"/video/detail/+"+n.columns.id+"' class=''>"+n.columns.title+"</a>";
						    	}
						    	html+="</h3>";
						    	html+="<div class='am_list_author'>";
						    	html+="<span class='am-badge am-badge-secondary'>";
						    	if(n.columns.TYPE=="1"){
						    		html+="博客";
						    	}
						    	if(n.columns.TYPE=="2"){
						    		html+="美图";
						    	}
						    	if(n.columns.TYPE=="3"){
						    		html+="视频";
						    	}
						    	html+="</span>";
						    	html+="<a href='javascript:void(0)'>";
						    	html+="<span class='am_list_author_ico' style='background-image: url("+url+"/attached/avatar/"+n.columns.avatar+");'></span>";
						    	html+="<span class='name'>"+n.columns.username+"</span>";
						    	html+=" </a>";
						    	html+=" <span class='am_news_time'><i class='am-icon-clock-o'></i><time class='timeago'> "+n.columns.create_time+"</time>";
						    	html+=" </span>";
						    	html+="<span class='am_news_time'><i class='am-icon-eye'></i><span>"+n.columns.view+"</span>";
						    	html+="</span>";
						    	html+="</div>";
						    	html+="<div class='am-list-item-text am_list_item_text'>";
						    	var contentshow=n.columns.content;
						    	if(contentshow==undefined){
						    		contentshow="";
						    	}
						    	html+=contentshow;
						    	html+="</div>";
						    	html+="</div>";
						    	html+="</li>";
						    	});
					    	  var more="";
					    	  if(data.totalPage>data.pageNumber){
					    		  var page=parseInt(data.pageNumber)+1;
					    		more="<div class='am_news_load' onclick='videoSearch("+page+")'><a href='#' ><span><i class='am-icon-spinner am-icon-spin'></i>查看更多</span></a></div>";
					    	  }
					    	  html+=more;
					    	  html+="</ul>";
					    	  html+="</div>";
					    	  $("#search-video-div").html(html);
						   }, 
						   "json");
				
			}
		}
	</script>
</body>
</html>