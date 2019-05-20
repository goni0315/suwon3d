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
<script type="text/javascript">
function emdJibunSearch(sgg_cd){//읍면동 검색
	$.ajax({
		type:"POST",
		url:"${ctx}/shelterjibunSearch.do",
		data :"&sgg_cd="+sgg_cd ,
		dataType:"json",
		contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     //통신 에러 발생시 처리
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : emdList
	});
}
function emdList(arr){//읍면동 검색결과조회
	$("#emdNm").find("option").remove();
	$("#emdNm").append("<option value=''>   전체   </option>");
	$.each(arr, function() {
		$("#emdNm").append("<option value='"+this.emd_nm+"'>"+this.emd_nm+"</option>");
		});
}
</script>


<script type="text/javascript">
function writeFormCheck(){
	if($("#fac_nm").val() == null || $("#fac_nm").val() == ""){
		alert("대피소명을 입력해주세용!");
		$("#fac_nm").focus();
		return false;
	}
}

function shelterAdd(){

	var frm = document.getElementById("frm");
	var fac_nm = frm.document.getElementById("fac_nm").value;

	var sggNm = $("#sggNm option:selected").text();
	document.getElementById("def_grd").value = $("#grade option:selected").text();
	document.getElementById("use_nm").value = $("#use option:selected").text();
	var emdNm = $("#emdNm option:selected").val();
	var bonbun = $("input[name='bonbun']").val();
	var bubun = $("input[name='bubun']").val();	
	var sanChk2 = $("#sanChk2").is(":checked") ? '산' : '';
	var sanChk = sanChk2;
	var dep_addr = sggNm+ " " +emdNm+ " " +sanChk + bonbun + "-" + bubun;
	$("input[name='dep_addr']").val(dep_addr);
	$("input[name='sanChk']").val(sanChk);
	
	if(fac_nm == ""){
		alert("대피소명을 입력해주세용!");
		$("#fac_nm").focus();
		return false;
	}
	
	if($("#sggNm").val() == null || $("#sggNm").val() == ""){
		alert("시군구를 선택해주세요!");
		$("#sggNm").focus();
		return false;
	}
	
	if($("#emdNm").val() == null || $("#emdNm").val() == ""){
		alert("읍면동을 선택해주세용!");
		$("#emdNm").focus();
		return false;
	}	

	if($("#use_nm").val() == "전체"){
		alert("시설용도 입력해주세용!");
		$("#use_nm").focus();
		return false;
	}
	if($("#dep_size").val() == null || $("#dep_size").val() == ""){
		alert("대피소규모 입력해주세용!");
		$("#dep_size").focus();
		return false;
	}
	if($("#apt_year").val() == null || $("#apt_year").val() == ""){
		alert("대피소 지정년도 입력해주세용!");
		$("#dep_addr").focus();
		return false;
	}
	if($("#emb_cnt").val() == null || $("#emb_cnt").val() == ""){
		alert("대피소 수용가능인원 입력해주세용!");
		$("#dep_addr").focus();
		return false;
	}
	if($("#def_grd").val() =="전체"){
		alert("대피소 방호등급 입력해주세용!");
		$("#dep_addr").focus();
		return false;
	}
	if($("#fac_equ").val() == null || $("#fac_equ").val() == ""){
		alert("대피소 시설내역 입력해주세용!");
		$("#dep_addr").focus();
		return false;
	}
	
	frm.action = '${ctx}/ShelterAdd.do';
	//frm.target = 'searchList';
	frm.submit();
	alert("등록되었습니다.");	
}
function punChange(value){
	var i = value.length;
	if(i == 1){
		value = '000'+value;
	}else if(i == 2){
		value = '00'+value;
	}else if(i == 3){
		value = '0'+value;
	}else{
		
	}
	return value;
}

</script>
</head>

<body style="background:url(${ctx}/images/category_bg1.gif)">
<form id="frm" action="" method="post" onSubmit="return writeFormCheck()">
	<input type="hidden" id="use_nm" name="use_nm" value=""/> 
	<input type="hidden" id="def_grd" name="def_grd" value="" />
	<input type="hidden" id="dep_addr" name="dep_addr" value="" />	
<div id="panel">
    <div id="title">
        <div id="category1" style="margin-top: 35px;">
       <ul style="width:320px;">
       <li style="float:right;"><a href="shelter_add.jsp" target="left"><img src="${ctx}/images/btn_shelter_add_on.gif" alt="침수 지역 등록"/></a>
        </li>
        <li style="float:left"><a href="shelter_search.jsp" target="left"><img src="${ctx}/images/btn_shelter_search_off.gif" alt="침수 지역 검색" border="0"/></a>
        </li>
        <li style=" padding-top:15px;clear:both; "><img src="${ctx}/images/category_SIDE.gif" /></li>
        </ul>
		<fieldset style="padding:5px;">
        <legend class="f_whit_am">대피소등록</legend>
             <ul>
            <li style="float:left;">
              <label for="textfield">대피소명</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >
		            <input type="text" name="fac_nm" id="fac_nm" value=""style="padding-left:5px;width:120px;"/> 
            	</span>
            </li>
            <li style=" clear:both;">
              <label for="textfield">대피소위치</label>
	              <select id="sggNm" name="sggNm" style="width:90px" onChange="emdJibunSearch(this.value)">
					<option value="">시군구</option>				
					<option value="41113">권선구</option>
					<option value="41117">영통구</option>
					<option value="41111">장안구</option>
					<option value="41115">팔달구</option>
		  		  </select>
              <!--  동/번지-->		  		  
		  		 <select id="emdNm"  name="emdNm" style="width:90px;">
				 	<option value="">읍면동</option>
		     	 </select>		  		  
            </li>
            <li style=" clear:both;">
              <label for="textfield">번지</label>
				     산 
				     <input name="sanChk2" id="sanChk2" type="checkbox"   align="absmiddle"/>         
          			 <input type="text" name="bonbun" id="bonbun"   style="height:20px; border:solid 1px; width:45px;"/> 
					 - 
					 <input type="text" name="bubun" id="bubun"   style="height:20px; border:solid 1px; width:45px;"/> 
            </li>            
            <li style=" clear:both;">
              <label for="textfield">시설용도</label>
	              <select id="use" name="use" style="width:90px" > 
						<option value="">전체</option>		              
						<option value="1">강의실</option>
						<option value="2">골프연습장</option>
						<option value="3">공연장</option>
						<option value="4">교육실</option>
						<option value="5">교육장</option>		              
						<option value="6">노래방</option>
						<option value="7">다방</option>
						<option value="8">대피소</option>
						<option value="9">백화점</option>
						<option value="10">병원</option>		              
						<option value="11">볼링장</option>
						<option value="12">사무실</option>
						<option value="13">상가</option>
						<option value="14">서고</option>
						<option value="15">식당</option>
						<option value="16">약품실</option>
						<option value="17">연회장</option>
						<option value="18">유치원</option>
						<option value="19">음식점</option>
						<option value="20">일반음식점</option>
						<option value="21">조리실</option>
						<option value="22">종교시설</option>
						<option value="23">주차장</option>		              
						<option value="24">지하식당</option>
						<option value="25">지하실</option>
						<option value="26">지하주차장</option>
						<option value="27">지하창고</option>
						<option value="28">창고</option>		              
						<option value="29">체육시설</option>
						<option value="30">탁구장</option>
						<option value="31">학원</option>
						<option value="32">헬스클럽</option>
						<option value="33">회의실</option>
						<option value="34">휴게실</option>
						<option value="35">휴게음식점</option>
	              </select>  
            </li>
            <li style=" clear:both;">
              <label for="textfield">등급</label>
	              <select id="grade" name="grade" style="width:90px"><!--onchange="gradeShelterSearch(this.value)"  -->
						<option value="">전체</option>		              
						<option value="1">1등급</option>
						<option value="2">2등급</option>
						<option value="3">3등급</option>
						<option value="4">4등급</option>		              						
	              </select>
            </li>            
            <li style=" clear:both;">
              <label for="textfield">대피소규모</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >
	              <input type="text" name="dep_size" id="dep_size" style="padding-left:5px;width:120px;"/>
				</span>
            </li>
            <li style=" clear:both;">
              <label for="textfield">지정년도</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >
	              <input type="text" name="apt_year" id="apt_year" style="padding-left:5px;width:120px;"/>
				</span>
            </li>
            <li style=" clear:both;">
              <label for="textfield">수용인원</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >
	              <input type="text" name="emb_cnt" id="emb_cnt" style="padding-left:5px;width:120px;" />
              	</span>
            </li>
            <li style=" clear:both;">
              <label for="textfield">시설내역</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >
	              <input type="text" name="fac_equ" id="fac_equ" style="padding-left:5px;width:120px;" />
              	</span>
            </li>            
            </ul>
        </fieldset>
        <ul>
        <li style="float:left; margin-top:10px;">
        <a href="#" onClick="shelterAdd()">
        <img src="${ctx}/images/btn_input.gif" width="96" height="24" />
        </a>
        </li>
        <li style="float:left;margin:10px 0 0 3px;">
        <a href="javascript:frm.reset()">
        <img src="${ctx}/images/btn_reset.gif" width="62" height="24" />
        </a>
        </li>
        </ul>
        <%-- <iframe id="searchList" name="searchList" src="${ctx}/shelterBlinkList.do" frameborder="0" width="100%" height="800px" scrolling="no" /> --%>                                  	        
	  </div>
    </div>
</div>
</form>
</body>
</html>
