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
<title>대피소검색</title>
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
	$("#emdNm").append("<option value=''>전체</option>");
	$.each(arr, function() {
		$("#emdNm").append("<option value='"+this.emd_cd+"'>"+this.emd_nm+"</option>");
		});
}
/* function gradeShelterSearch(){//등급검색
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
} */


function ShelterSearch(){//(최종)전체검색

	document.getElementById("useText").value= $("#use option:selected").text();//성공
	var useText = document.getElementById("useText").value;
	if(useText=="전체"){
		useText="";
	}
	//useText = use;
	//alert(useText);
	var frm = document.getElementById("frm");
	var sggNm = $("#sggNm option:selected").val();
	var emdNm = $("#emdNm option:selected").val();
	var grade = $("#grade option:selected").val();
	var use = $("#use option:selected").val();	
	
	frm.action = '${ctx}/ShelterSearch.do';
	frm.target = 'searchList';
	frm.submit();
}
</script>
</head>

<body >
<form id="frm" action="" method="post">
<input type="hidden" id="useText" name="useText" value=""></input>
<div id="panel">
    <div id="title">
        <div id="category" style="margin-top: 35px;">
       <ul style="width:320px;">
       <li style="float:right;"><a href="shelter_add.jsp" target="left"><img src="${ctx}/images/btn_shelter_add_off.gif" alt="가시권"/></a>
        </li>
        <li style="float:left"><a href="shelter_search.jsp" target="left"><img src="${ctx}/images/btn_shelter_search_on.gif" alt="가시권역"/></a>
        </li>
        <li style=" padding-top:15px;clear:both; "><img src="${ctx}/images/category_SIDE.gif" /></li>
        </ul>
		<fieldset style="padding:5px;">
        <legend class="f_whit_am">대피소 검색</legend>
             <ul>
            <li style="float:left;">
              <label for="textfield">소재지</label><!-- 소재지 -->
	              <select id="sggNm" name="sggNm" style="width:90px" onChange="emdJibunSearch(this.value)" >
					<option value="">시군구</option>				
					<option value="41113">권선구</option>
					<option value="41117">영통구</option>
					<option value="41111">장안구</option>
					<option value="41115">팔달구</option>
		  		  </select>
              <!--  동/번지-->		  		  
		  		 <select id="emdNm"  name="emdNm" style="width:90px">
				 	<option value="">읍면동</option>
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
              <label for="textfield">용도</label>
	              <select id="use" name="use" style="width:90px"> 
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
              <label for="textfield">시설명</label>
            	  <input type="text" name="facNm" id="facNm" style="padding-left:5px;width:120px;"/>
            </li>
            </ul>
        </fieldset>
        <ul>
        <li style="margin:10px 0 10px 0; float:right;"><input type="image" src="${ctx}/images/btn_search.gif" align="absmiddle" onClick="ShelterSearch()"/></li>
<%--         <li style="margin:10px 0 0 3px;"><img src="${ctx}/images/btn_reset.gif" width="62" height="24" /></li> 초기화버튼--%>
        </ul>
	  </div>
    </div>
    <div>
        <h4><img src="${ctx}/images/result_title1.gif" alt="결과" width="340" height="34"/></h4>
<iframe id="searchList" name="searchList" src="${ctx}/shelterBlinkList.do" frameborder="0" width="100%" scrolling="no"  style="height:100%; max-height:600px; min-height:350px;"/>
    </div>
</div>
</form>
</body>
</html>
