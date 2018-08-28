<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pnu코드 조회</title>
<script type="text/javascript" src="${ctx}/js/jquery-1.7.1.js"></script>
<script type="text/javascript">
function emdSearch(sggName){//나라 검색
	$.ajax({
		type:"POST",
		url:"${ctx}/jibunSearch.do",
		data :"&sggName="+sggName ,
		dataType:"json",
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     //통신 에러 발생시 처리
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : emdList
	});
}
function emdList(arr){
	$("#emdNm").find("option").remove();
	$("#emdNm").append("<option value='0'>-----선택-----</option>");
	$.each(arr, function() {
		$("#emdNm").append("<option value='"+this.emd_cd+"'>"+this.emd_nm+"</option>");
		});
}
function punChange(value){
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
}
function jibunSearch(){
	writeLog("100100","지번접속"); //접속 로그 기록
	var frm = document.getElementById("frm");
	var sggNm = $("#sggNm option:selected").val();
	var emdNm = $("#emdNm option:selected").val();
	var bonbun = $("input[name='bonbun']").val();
	var bubun = $("input[name='bubun']").val();
	var sanChk = $("#sanChk").is(":checked") ? '00_' : '001';
	var pnuCode = emdNm + sanChk + punChange(bonbun) + punChange(bubun);
/* 	if(SggNm == 0){
		alert("ê²ìëë ë°ì´í°ëì´ ë§ìµëë¤. ì/êµ°/êµ¬ë¥¼ ì íí´ì£¼ì¸ì");
		return false;
	}
	if(embNm == 0){
		alert("ê²ìëë ë°ì´í°ëì´ ë§ìµëë¤. ì/ë©´/ëë¥¼ ì íí´ì£¼ì¸ì");
		return false;
	}		*/
	
	$("input[name='pnuCode']").val(pnuCode); 
	//alert("pnu"+pnuCode);
	frm.action = 'jijukSearch.do';
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
	<input type="hidden" id="pnuCode" name="pnuCode" value="" />
		<select id="sggNm" name="sggNm" style="width:150px;" onchange="emdSearch(this.value)">
			<option value="0">-----선택-----</option>
				<option value="41117">영통구</option>
				<option value="41113">권선구</option>
				<option value="41111">장안구</option>
				<option value="41115">팔달구</option>
				
		</select>
		<select id="emdNm" style="width:150px;">
			<option value="0">-----읍면동-----</option>
		</select>
	
		
	 
	
	<%-- <form action="cbnd.do" method="get">
	<!--시공구로 읍면동 검색  -->
		 <select id="keyword" name="keyword"  >
		 <option>선택</option>
  	<c:forEach var="sms" items="${sggList}">
  		<option id="keyword" name="keyword" value="${sms.sgg_cd}" >${sms.sgg_nm}</option>
	</c:forEach>						 
		 </select>
		 
	<!--읍면동으로 지번검색  -->
		<select >
		<option>선택</option>
  	<c:forEach var="sms" items="${emdList}">
  		<option id="keyword2" name="keyword2" value="${sms.emd_cd}" >${sms.emd_nm}</option>
	</c:forEach>						 
		 </select>
	<!--산체크  -->	 
		 <input type="checkbox" id="keywordSan" checked value="${sms.pnu}" onclick="keywordSan">산
	<!--본번,부번으로 검색  -->
	
	
	<input type="submit" value="검색">
	<br><br><br>
	
	 <c:forEach var="sms" items="${cbndList}">
	<tr>
		<td>${sms.pnu}, ${sms.jibun}, ${sms.addr}</td><br/>
	</tr>
	</c:forEach> 
	</form> --%>		
<!-- </form>
<form action="jijukSearch.do" method="get"> -->
<input type="checkbox" name="sanChk"  id="sanChk">산		 	
<input type="text" id="bonbun" name="bonbun" onkeydown="fnc_input_number()" >-<input type="text" id="bubun" name="bubun" onkeydown="fnc_input_number()">	
	<input type="button"  onclick="jibunSearch();" value="검색">			
<%-- 	<c:forEach var="sms" items="${jibunList}">
	<tr>
		<td> ${sms.sgg_nm} ${sms.emd_nm} ${sms.jibun} ${sms.pnu}</td>
	</tr>
	</c:forEach> --%>
	<iframe id="searchList" name="searchList" src="${ctx}/blinkList.do" frameborder="0" width="297" style="height:430px" scrolling="no" />
	
</form>

</body>
</html>