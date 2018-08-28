<!-- 
	수원시 3차원 활용시스템 메인 >> 검색기능 >> 도로명검색 결과 페이지 >> 로드뷰
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%@page import="java.net.URLDecoder"%>
<%
	request.setCharacterEncoding("UTF-8");

	String pLng = (String)(request.getParameter("lng")!=null?request.getParameter("lng"):"1");
	String pLat = (String)(request.getParameter("lat")!=null?request.getParameter("lat"):"1");
	
	String pApiKey = (String)(request.getParameter("apiKey"));
	
	String apiKey= URLDecoder.decode(pApiKey, "UTF-8");
	String lng= URLDecoder.decode(pLng, "UTF-8");
	String lat= URLDecoder.decode(pLat, "UTF-8");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>수원시 로드뷰 서비스</title> 
<!-- LOCALHOST -->
<script type="text/javascript" src="http://apis.daum.net/maps/maps3.js?apikey=<%=apiKey%>" charset="utf-8"></script>
<!-- 평촌 -->
<!--  <script type="text/javascript" src="http://apis.daum.net/maps/maps3.js?apikey=5a7d9170dde11d40745450f0c640b37c58cfdcad" charset="utf-8"></script>  -->
 
<!-- 파주시청  -->
<!-- <script type="text/javascript" src="http://apis.daum.net/maps/maps3.js?apikey=afa6b6bd9f64b292983119150becd99c30cae01d" charset="utf-8"></script>  -->


<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript">
pid="";
function setPid(id){
	if(id==null){
		alert("해당지점엔 로드뷰 정보가 없습니다.");
		self.close();
	}else{
		this.pid = id;
	}
	
};
function getPid(){
	return this.pid;
}
	
/**
 * 로드뷰 생성
 */
	var rv = "";
	function makeP(){
		
			//var p = new daum.maps.LatLng(37.53729488297613, 127.00551022687515);
			var p = new daum.maps.LatLng(<%=lat%>,<%=lng%>);
			
			var rc = new daum.maps.RoadviewClient();
			//rc.getNearestPanoId(p, 100, setPid);
			
			rv = new daum.maps.Roadview(document.getElementById("roadview"));
			
			
			
			rc.getNearestPanoId(p, 50, function(panoid) {
				
				if(panoid!=null){
					document.getElementById("roadview").style.display="block";
					rv.setPanoId(panoid, p);
					// rv.relayout(); 프레임 변경시 적용해야 하는 함수 - 
				}else{
					document.getElementById("roadview").style.display="none";
					document.getElementById("noroadview").style.display="block";
					/* alert("해당위치는 RoadView정보가 없습니다.");
					parent.frameCont(false); */
				}
				
			});
			/* daum.maps.event.addListener(rv,"position_changed",function() {
				
				var roadviewLat = rv.getPosition().getLat();
				var roadviewLng = rv.getPosition().getLng();
				
				parent.pointSet(roadviewLng,roadviewLat); //lng, lat
			});
			
			daum.maps.event.addListener(rv,"viewpoint_changed",function() {
				var Viewpoint = rv.getViewpoint();
				var realTilt = Viewpoint.pan + 190;
				top.SOPPlugin.getViewCamera().setDirect(realTilt);
			}); */
		
	}
</script>
<style type="text/css">
<!--

body{
	margin-left:0;
	margin-right:0;
	margin-top:0;
	margin-bottom:0;
	}
div{
	margin-left:0;
	margin-right:0;
	margin-top:0;
	margin-bottom:0;
	}

-->
</style>
</head>
<body style="margin: 0 0 0 0;" onload="makeP()">
<!-- div 스타일의 크기를 %로 넣으면 안된다 -->
	<div id="roadview" style="position:absolute;width:600px;height:480px;background-color:black;display:none"></div>
	<div id="noroadview" style="position:absolute;width:600px;height:480px; display:none;background-color:white">
		<center>
			<br /><br />
			<img src="${ctx}/images/potal/noimg2.jpg"><br>
			<h5>해당지역엔 로드뷰 정보가</h5><br>
			<h5>존재하지 않습니다</h5><br>
		</center>
	</div>
</body>
</html>
