<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<style type="">

</style>
<script type="text/javascript">
function rnSearch(sggName){//나라 검색
	$.ajax({
		type:"POST",
		url:"${ctx}/jibunSearch.do",
		data :"&sggName="+sggName ,
		dataType:"json",
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     //통신 에러 발생시 처리
		     //alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : emdList
	});
}
function emdList(arr){
	$("#emdNm").find("option").remove();
	$("#emdNm").append("<option value='0'>전체</option>");
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
function punChange2(value){
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
	parent.writeLog("120000","지번접속"); 
	var frm = document.getElementById("frm");
	var sggNm = $("#sggNm option:selected").val();
	var emdNm = $("#emdNm option:selected").val();
	var bonbun = $("input[name='bonbun']").val();
	var bubun = $("input[name='bubun']").val();
	var sanChk2 = $("#sanChk2").is(":checked") ? '2' : '1';
	var sanChk = sanChk2;

 	punChange(bonbun);
 	punChange2(bubun);
 	
 	if(sggNm == 0){
		alert("시구를 선택해주세요");
		return false;
	}
	if(emdNm == 0){
		alert("읍면동을 선택해주세요"); 	   
		return false;
	}		
	
	if(bonbun.search(/\s/) != -1){
		alert("공백은 입력할 수 없습니다");
		$("#bonbun").focus();
		return false;
	}
	if(bubun.search(/\s/) != -1){
		alert("공백은 입력할 수 없습니다");
		$("#bubun").focus();
		return false;
	}
	var reg = /^[0-9]*$/;
	if(!reg.test(bonbun)){
		alert("숫자만 입력하세요");
		$("#bonbun").focus();
		return false;
	}
	if(!reg.test(bubun)){
		alert("숫자만 입력하세요");
		$("#bubun").focus();
		return false;
	}
	
		
	$("input[name='sanChk']").val(sanChk);

	
	frm.action = '${ctx}/jijukSearch.do';
	frm.target = 'searchList';
	frm.submit();		
	
	
}
function fnc_input_number1(){
	   var e = event.keyCode;
	   window.status = e;
	   if (e>=48 && e<=57) return;
	   if (e>=96 && e<=105) return;
	   if (e>=37 && e<=40) return;
	   if (e==8 || e==9 || e==46) return;
	   if(e==13){
		   
		   setTimeout(function() { document.getElementById('bubun').focus(); }, 10);	
		   return;
		  
	   }
	   event.returnValue = false;
}
function fnc_input_number2(){
	   var e = event.keyCode;
	   window.status = e;
	   if (e>=48 && e<=57) return;
	   if (e>=96 && e<=105) return;
	   if (e>=37 && e<=40) return;
	   if (e==8 || e==9 || e==46) return;
	   if(e==13){
		   
		   jibunSearch();return;
		  
	   }
	   event.returnValue = false;
}



</script>
</head>


<body >
	<form id="frm" action="" method="post" onsubmit="return false">
	<input type="hidden" id="sanChk" name="sanChk" value="" />
	
<div id="panel" class="panel_main">
    <div id="title"> 
        <div id="category" style="height: 100px;">
        <ul>
        <li><label>시구</label><select id="sggNm" name="sggNm" style="width:130px" onChange="rnSearch(this.value)">        
			<option value="0">선택</option>
				<option value="41111">장안구</option>				
				<option value="41113">권선구</option>
				<option value="41115">팔달구</option>
				<option value="41117">영통구</option>								
		</select>
        </li>
        <li>
        <label>읍면동</label>
        <select id="emdNm"  name="emdNm" style="width:130px">
			<option value="0">선택</option>
		</select>
        </li>
        <li>
		<label>번 지</label>
		<input name="sanChk2" id="sanChk2" type="checkbox" align="absmiddle"/>&nbsp;산
			
				        
    	      <input type="text" name="bonbun" id="bonbun"  onkeydown="fnc_input_number1()" style="width:45px; height:20px;padding-left:5px"/>
    		  
			&nbsp;-&nbsp; 
			  <input type="text" name="bubun" id="bubun"  onkeydown="fnc_input_number2()" style="width:45px; height:20px;padding-left:5px"  />        
		  	&nbsp;
		  	</li>
        
        </ul>
			 <img src="${ctx}/images/btn_search.gif" onclick="jibunSearch()" style="position: relative; left: 243px; bottom: 26px; "/>
<%-- <input type="image" src="${ctx}/images/btn_search.gif"   align="absmiddle" onClick="jibunSearch()"/> --%>		           
	  </div>
    </div>
    <div>
        <h4><img src="${ctx}/images/result_title.gif" alt="결과" width="340" height="34" /></h4><!-- onclick="menuUsingLog('100100');" -->
            <iframe id="searchList" name="searchList" src="${ctx}/blinkJibunList.do" frameborder="0" width="340px" height="520px" scrolling="no" />
    </div>
</div>

</form>
</body>
</html>
