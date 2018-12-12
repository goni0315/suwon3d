<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script type="text/javascript">
var chk = true;

function moveFocus(chk){
	
	if(chk){
	setTimeout(function() { document.getElementById('bubun').focus(); }, 10);	
	this.chk=false;
	return;
	}
	
	this.chk=true;
	return chk;
	
}

function searchCombo(sggName){//시군구 조회 

	$.ajax({
		type:"POST",
		url:"${ctx}/rnChoSearch.do",
		data :"&sggName="+sggName,
		dataType:"json",
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     //통신 에러 발생시 처리
		     //alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success :  setCho
	});
} 

 function rnSearch(r_cho){//도로명 초성조회

	 var sggName = document.getElementById("sggNm").value;
	
	$.ajax({
		type:"POST",
		url:"${ctx}/getRnSearch.do",
		data :"&sggName="+sggName+"&r_cho="+r_cho /* +"&startVal="+startVal+"&endVal="+endVal */,//+"&bonbun="+bonbun+"&bubun="+bubun,
		dataType:"json",
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     //통신 에러 발생시 처리
		     //alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : rnList
	});

} 
function rnList(arr){
	$("#manageNm").find("option").remove();
	$("#manageNm").append("<option value='0'>도로명선택</option>");
	$.each(arr, function() {
		$("#manageNm").append("<option value='"+this.rn_cd+"'>"+this.rn+"</option>");
		});
	
}
//초성을 선택하게 되면 도로명검색 조건에 필요한 값을 생성 후 도로명 초성 검색을 실행한다.
function setCho() {
	document.getElementById("sggName").value = document.getElementById("sggNm").value;

	url="${contextPath}/rnChoSearch.do";
	

}
//항상 저장되어야 할 속성값을 form에 저장하는 함수.
function setAttribute(){
	try{

		document.getElementById("sggName").value = document.getElementById("sggNm").value;
		//document.getElementById("rn").value = document.getElementById("rn").value;
		document.getElementById("r_cho").value = document.getElementById("selcho").value;
		document.getElementById("rn_cd").value = document.getElementById("manageNm").value;
		//document.getElementById("cim_s").value = document.getElementById("textfield5").value;<%--침수시작일--%>
		//document.getElementById("cim_r").value = document.getElementById("select6").value;<%--침수원인--%>	
	}catch(e){}
}

function jibunSearch(){
	document.getElementById("rn_cd").value = document.getElementById("manageNm").value;
	//document.getElementById("rn").value = document.getElementById("rnNm").value; 도로명주소 검색
	var frm = document.getElementById("frm");
	var rnNm = $("input[name='rn']").val();
	var sggNm = $("#sggNm option:selected").val();
	var bonbun = $("input[name='bonbun']").val();
	var bubun = $("input[name='bubun']").val();
	var manageNm = $("#manageNm option:selected").val();		

 	if(sggNm == 0){
		alert("시구를 선택해주세요");
		return false;
	}
	if(manageNm == 0){
		alert("도로명을 선택해주세요"); 	   
		return false;
	}

	if(chk){
	frm.action = '${ctx}/roadSearch.do';
	frm.target = 'searchRn';
	frm.submit();	
	}
	
}
function fnc_input_number1(){
	   var e = event.keyCode;
	   window.status = e;
	   if (e>=48 && e<=57) return;
	   if (e>=96 && e<=105) return;
	   if (e>=37 && e<=40) return;
	   if (e==8 || e==9 || e==46) return;
	   if(e==13){
		   
		   moveFocus(true);
		  
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
		   
		   moveFocus(false);
		  
	   }
	   event.returnValue = false;
}
</script>
</head>

<body >
<form id="frm" action="" method="post" onsubmit="return false">
<input type="hidden" id="buildName" name="buildName" value="" />
<input type="hidden" id="sggName" name="sggName" value="" />
<input type="hidden" id="rn_cd" name="rn_cd" value="" />
<input type="hidden" id="r_cho" name="r_cho" value="" />
<input type="hidden" id="rn" name="rn" value="" />

<div id="panel" class="panel_main">
    <div id="title">
        <div id="category">
        <ul>
        <!-- <li>
            <label>도로명검색</label>
            <input type="text" name="rnNm" id="rnNm"   style="height:22px; border:solid 1px;"/>
        </li> -->
        <li>
        <label>시구</label>
    	<select id="sggNm" name="sggNm" style="width:130px" onChange="searchCombo(this.value)">
			<option value="">선택</option>
				<option value="41111">장안구</option>			
				<option value="41113">권선구</option>
				<option value="41115">팔달구</option>				
				<option value="41117">영통구</option>
		</select>
        </li>
        <li>
        <label>도로명</label>
<!--         <select name="selCho" id="selCho" onchange="setCho(this.value);" style="width:130px"> -->
        <select name="selCho" id="selCho"  onchange="rnSearch(this.value)" style="width:130px">

                		<option value=""> 초 성 선 택 </option>
		            	<option value="a">ㄱ</option>
		            	<option value="b">ㄴ</option>
		            	<option value="c">ㄷ</option>
		            	<option value="d">ㄹ</option>
		            	<option value="e">ㅁ</option>
		            	<option value="f">ㅂ</option>
		            	<option value="g">ㅅ</option>
		            	<option value="h">ㅇ</option>
		            	<option value="i">ㅈ</option>
		            	<option value="j">ㅊ</option>
		            	<option value="k">ㅋ</option>
		            	<option value="l">ㅌ</option>
		            	<option value="m">ㅍ</option>
		            	<option value="n">ㅎ</option>
                </select>
                
        </li>
        <li>
        <label>&nbsp;</label>
     	<select id="manageNm" style="width:130px">
			<option value="">도로명선택</option>
		</select>
        </li>
        <li>
		<label>건물번호</label>
		<input type="text" id="bonbun" name="bonbun" onKeyDown="fnc_input_number1()" style="width:60px;height:20px;padding-left:5px"/> 
		&nbsp;-&nbsp; 
		<input type="text" id="bubun" name="bubun" onKeyDown="fnc_input_number2()"  style=" width:60px;height:20px;padding-left:5px"/>
		&nbsp;	
			<input type="image" src="${ctx}/images/btn_search.gif"   align="absmiddle"  onclick="jibunSearch()"/>
        </li>
        </ul>
	  </div>
    </div>
    <div>
        <h4><img src="${ctx}/images/result_title.gif" alt="결과" width="340" height="34"/></h4>
	  <iframe id="searchRn" name="searchRn" src="${ctx}/RnblinkList.do" frameborder="0" width="100%" height="520px" scrolling="no" /> 
    </div>
</div>
<label for="radio"></label>
</form>
</body>
</html>
