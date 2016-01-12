function headfor(url){
	/*$("#admin-content-iframe").attr("src","${base}"+url);*/
	$.post(url,
		   function(data){
			$("#admin-content").html(data);
		   }, "html");
}