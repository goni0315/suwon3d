<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title> 

<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>

<script type="text/javascript"> 
//http://211.34.105.76:8090/api/fcst_sws.do?init_tm=201601122100&order_by=SM_BASIN_CD
	var reqUrl = "http://211.34.105.76:8090/api/";
	//var reqDataName = "fcst_prcp.do";
	var reqDataName = "fcst_sws.do";
	// var reqDataName = "fcst_aet.do";
	var reqDate = "201601122100";
	var reqBasin = "SM_BASIN_CD";
	var url = reqUrl + reqDataName + "?init_tm=" + reqDate + " &order_by=" + reqBasin;
	
	function sumonReq(){
		
		var today = new Date();
		var year = today.getFullYear();
		var month = today.getMonth()+1;
		var date = today.getDate();
		var hour = today.getHours();
		var basin_List = [];
		var send_basin_List = "";
		
		//alert(year + "" + month + "" + date + "" + hour);
		
		$.support.cors = true;
		$.ajax({
			type : "get",
			crossDomain: true,
			url : url,
			dataType : "json",
			error : function(request, status, error) {
			     //통신 에러 발생시 처리
			     alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			},
			success : function(result){
				 for(var i=0;i<result.DATA_LIST.length;i++){
					 if(reqDate == result.DATA_LIST[i].fc_tm){
						 basin_List[i] = result.DATA_LIST[i].sm_basin_cd;
						 if(basin_List[i] != ""){
							 send_basin_List += basin_List[i] + ",";
						 }
						$("#ajax").append("<div>sws:" + result.DATA_LIST[i].sws + ",sm_basin_cd:" + result.DATA_LIST[i].sm_basin_cd  + ",fc_tm:" + result.DATA_LIST[i].fc_tm + "</div>");
					 }
				 }
				 console.log("send_basin_List : " + send_basin_List);
			}
		});
		
	}
</script>
</head>
<body>
	<input type="button" value="수문요청" onclick="sumonReq()">
	<div id="ajax"></div>
</body>
</html>