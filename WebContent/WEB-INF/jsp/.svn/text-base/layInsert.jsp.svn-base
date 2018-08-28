<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>레이어명을 추가하는 페이지</title>
<script type="text/javascript" src="${ctx}/js/jquery-1.7.1.js"></script>
<script type="text/javascript">

function korNmSearch(grpName){//나라 검색

	$.ajax({
		type:"POST",
		url:"${ctx}/listLayer.do",
		data :"&grpName="+grpName,
		dataType:"json",
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     //통신 에러 발생시 처리
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : layerList 
	});
	
}
function layerList(arr){
	$("#codeNm").find("option").remove();	
	$("#codeNm").append("<option value='0'>-----선택-----</option>");	
	$.each(arr, function() {		
		$("#codeNm").append("<option value='"+this.aut_cde+"'>"+this.aut_cde+"</option>");		
	});
}

function addLay(){
	var frm = document.getElementById("frm");
	var grpName = $("#grpName option:selected").val();
	var codeNm = $("#codeNm option:selected").val();
	

	//alert("codeNm"+codeNm);
	frm.action = 'autAddLayer.do';
	//frm.target = 'searchList';
	frm.submit();	
	
} 
</script>
</head>
<body>
	<!-- <form method="get" action="autAddLayer.do">
		<input type="text" id="aut_cde" name="aut_cde"/>
		<input type="text" id="aut_nm" name="aut_nm"/>
		<input type="text" id="lay_mng" name="lay_mng"/>
		<input type = "submit" value="추가">						
	</form> -->
	
<form id="frm" action="" method="post">	
		<select id="grpName" name="grpName" style="width:150px;" onchange="korNmSearch(this.value)">			
			<option value="0">-----레이어 선택-----</option>			
				<c:forEach var="sms" items="${layList}">
					<option  value="${sms.kor_nm}">${sms.kor_nm}</option>
				</c:forEach>				
		</select>
		
		<select id="codeNm" name="codeNm" style="width:150px;">
			<option value="0">-----선택-----</option>
		</select>
		<input type = "button" onclick="addLay();" value="추가">
</form>		
</body>
</html>