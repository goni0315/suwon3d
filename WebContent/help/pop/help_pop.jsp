<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>도움말 동영상</title>
</head>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/flowplayer-3.2.11.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript" src="${ctx}/help"></script> 

<%String popUp_path = request.getParameter("popUp_path");%>
<script type="text/javascript">	
$(function (){
	document.getElementById("player").href = top.WEB_SERVER_URL_SB + "/helpVideo/" + '<%=popUp_path%>' + ".flv";
		flowplayer("player", "${ctx}/js/flowplayer-3.2.5.swf", {
				clip: {
					 //url:'Suwon3d/help/video/jibunSearch.flv',
					 autoPlay: true,
					 autoBuffering: true
				}
			 });
}); 

</script>
<body>
<!-- <a href="/Suwon3d/help/video/jibunSearch.avi" id="player"><embed src="/Suwon3d/help/video/jibunSearch.avi" width="1324px" height="750px" id="play" autostart="true" ></embed></a> -->
	<div >
	<a id="player" style="display:block;width:1310px;height:730px;text-align:center;">
	</a> 
	</div>
</body>
</html>