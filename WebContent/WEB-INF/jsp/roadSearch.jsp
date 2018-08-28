<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도로명주소 검색페이지</title>
<script type="text/javascript" src="${ctx}/js/jquery-1.7.1.js"></script>
<script type="text/javascript">
function rnSearch(sggName){//나라 검색
	$.ajax({
		type:"POST",
		url:"${ctx}/rnSearch.do",
		data :"&sggName="+sggName ,
		dataType:"json",
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     //통신 에러 발생시 처리
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : rnList
	});
}
function rnList(arr){
	$("#manageNm").find("option").remove();
	$("#manageNm").append("<option value='0'>-----선택-----</option>");
	$.each(arr, function() {
		$("#manageNm").append("<option value='"+this.sig_cd+"'>"+this.rn+"</option>");
		});
}
/* function punChange(value){
	var i = value.length;
	if(i == 1){
		value = '___'+value;
	}else if(i == 2){
		value = '__'+value;
	}else if(i == 3){
		value = '_'+value;
	}else{
		
	}
	return value;
} */
function jibunSearch(){
	var frm = document.getElementById("frm");
	var sggNm = $("#sggNm option:selected").val();
	var emdNm = $("#emdNm option:selected").val();
	var bonbun = $("input[name='bonbun']").val();
	var bubun = $("input[name='bubun']").val();

	/* var buildName =  bonbun + bubun;
	
	$("input[name='buildName']").val(buildName); 
	alert("buildName"+buildName); */
	frm.action = 'roadSearch.do';
	frm.target = 'searchList';
	frm.submit();	
	
}
function fnc_input_number(){
	   var e = event.keyCode;
	   window.status = e;
	   if (e>=48 && e<=57) return;
	   if (e>=96 && e<=105) return;
	   if (e>=37 && e<=40) return;
	   if (e==8 || e==9 || e==13 || e==46) return;
	   event.returnValue = false;
} 
</script>
</head>
<body>

<form id="frm" action="" method="post">
		<input type="hidden" id="buildName" name="buildName" value="" />
		<select id="sggNm" name="sggNm" style="width:150px;" onchange="rnSearch(this.value)">
			<option value="0">-----선택-----</option>
				<option value="41117">영통구</option>
				<option value="41113">권선구</option>
				<option value="41111">장안구</option>
				<option value="41115">팔달구</option>
		</select>
		<select id="manageNm" style="width:150px;">
			<option value="0">-----도로명-----</option>
		</select>
			 	
		<input type="text" id="bonbun" name="bonbun" onkeydown="fnc_input_number()" >-<input type="text" id="bubun" name="bubun" onkeydown="fnc_input_number()">	
		<input type="button"  onclick="jibunSearch();" value="검색">
		
		<iframe id="searchList" name="searchList" src="${ctx}/RnblinkList.do" frameborder="0" width="297" style="height:430px" scrolling="no" />
</form>		
	
</body>
</html>