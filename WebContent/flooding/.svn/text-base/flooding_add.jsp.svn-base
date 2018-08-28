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
function floodAdd(){

	document.getElementById("flo_year").value= $("#year option:selected").text();//성공
	document.getElementById("flo_sot").value= $("#sort option:selected").text();	
	var flo_year = document.getElementById("flo_year").value;
	var flo_sot = document.getElementById("flo_sot").value;	
	var frm = document.getElementById("frm");	
	var flo_loc = $("input[name='flo_loc']").val();
	var dmg_are = $("input[name='dmg_are']").val();	
	var str_year = $("input[name='str_year']").val();	
	var end_year = $("input[name='end_year']").val();	
	var flo_hour = $("input[name='flo_hour']").val();	
	var dmg_nm = $("input[name='dmg_nm']").val();	
	var flo_cau = $("input[name='flo_cau']").val();	
	
	if($("#flo_year").val() == "전체"){
		alert("침수년도 지정년도 입력해주세요!");
		$("#flo_year").focus();
		return false;
	}
	
	if($("#flo_loc").val() == "전체"){
		alert("침수지구명을 입력해주세요!");
		$("#flo_loc").focus();
		return false;
	}
	if($("#dmg_are").val() == null || $("#dmg_are").val() == ""){
		alert("피해면적을 입력해주세요!");
		$("#dmg_are").focus();
		return false;
	}

	if($("#str_year").val() == null || $("#str_year").val() == ""){
		alert("침수시작일을 입력해주세요!");
		$("#str_year").focus();
		return false;
	}
	if($("#end_year").val() ==null || $("#end_year").val() == ""){
		alert("침수종료일을 입력해주세요!");
		$("#end_year").focus();
		return false;
	}
	if($("#flo_hour").val() == null || $("#flo_hour").val() == ""){
		alert("침수시간을 입력해주세요!");
		$("#flo_hour").focus();
		return false;
	}
	if($("#dmg_nm").val() == null || $("#dmg_nm").val() == ""){
		alert("재해명을 입력해주세요!");
		$("#dmg_nm").focus();
		return false;
	}
	if($("#flo_cau").val() == null || $("#flo_cau").val() == ""){
		alert("침수원인을 입력해주세요!");
		$("#flo_cau").focus();
		return false;
	}
	if($("#flo_sot").val() =="전체"){
		alert("침수형태를 입력해주세요!");
		$("#flo_sot").focus();
		return false;
	}	
			
	frm.action = '${ctx}/FloodAdd.do';
	//frm.target = 'searchList';
	frm.submit();
	alert("등록되었습니다.");
}
</script>
</head>

<body >
<form id="frm" action="" method="post">
<input type="hidden" id="flo_year" name="flo_year" value=""></input>
<input type="hidden" id="flo_sot" name="flo_sot" value=""></input>
<div id="panel">
    <div id="title">
        <div id="category">
       <ul style="width:320px;">
       <li style="float:right;"><a href="${ctx}/flooding/flooding_add.jsp" target="left"><img src="${ctx}/images/btn_flooding_add_on.gif" alt="침수 지역 등록"/></a>
        </li>
        <li style="float:left"><a href="${ctx}/flooding/flooding_search.jsp" target="left"><img src="${ctx}/images/btn_flooding_search_off.gif" alt="침수 지역 검색" border="0"/></a>
        </li>
        <li style=" padding-top:15px;clear:both; "><img src="${ctx}/images/category_SIDE.gif" /></li>
        </ul>
        <hr />
        <fieldset >
        <legend class="f_whit_am">침수지역등록</legend>
             <ul  style="padding:5px;">
            <li>
              <label for="textfield">침수년도</label>
              <select name="year" id="year" style="width:130px">
              	<option value="">전체</option>
                <option value="1">2014</option>
                <option value="2">2015</option>
                <option value="3">2016</option>
                <option value="4">2017</option>
                <option value="5">2018</option>
                <option value="6">2019</option>
                <option value="7">2020</option>
                <option value="8">2021</option>
                <option value="9">2022</option>
                <option value="10">2023</option>
                <option value="11">2024</option>
                </select>
            </li>
            <li style=" clear:both;">
              <label for="textfield">침수지구</label>
	             <span  style="width:130px; height:15px; display:inline-block; border:1px;" >
		            <input type="text" name="flo_loc" id="flo_loc" style="padding-left:5px;width:120px;"/>
	             </span>&nbsp;ex)평동지구
            </li>
            <li style=" clear:both;">
              <label for="textfield">피해면적</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >
	              <input type="text" name="dmg_are" id="dmg_are" style="padding-left:5px;width:120px;"/>  
              	</span>&nbsp;m²
            </li>
            <li style=" clear:both;">
              <label for="textfield">침수시작일</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >              
	              <input type="text" name="str_year" id="str_year"style="padding-left:5px;width:120px;" />
              	</span>&nbsp;ex)20120705
            </li>
            <li style=" clear:both;">
              <label for="textfield">침수종료일</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >              
	              <input type="text" name="end_year" id="end_year"style="padding-left:5px;width:120px;" />
              	</span>&nbsp;ex)20120706
            </li>
            <li style=" clear:both;">
              <label for="textfield">침수시간</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >               
	              <input type="text" name="flo_hour" id="flo_hour" style="padding-left:5px;width:120px;"/>
              	</span>&nbsp;ex)8시간
            </li>
            <li style=" clear:both;">
              <label for="textfield">재해명</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >              
	              <input type="text" name="dmg_nm" id="dmg_nm" style="padding-left:5px;width:120px;"/>
              	</span>
            </li>
            <li style=" clear:both;">
              <label for="textfield">침수원인</label>
              	<span  style="width:130px; height:15px; display:inline-block; border:1px;" >                
	              <input type="text" name="flo_cau" id="flo_cau"style="padding-left:5px;width:120px;" />
              	</span>
            </li>
            <li style=" clear:both;">
              <label for="textfield">침수형태</label>              
              <select id="sort" name="sort" style="width:130px">
              	<option value="">전체</option>
              	<option value="1">재방붕괴</option>
              	<option value="2">집중호우</option>
              	<option value="3">태풍</option>
              </select>
            </li>      
            </ul>
        </fieldset>
        <ul>
        <li style="float:left; margin-top:10px;"><a href="#"><img src="${ctx}/images/btn_input.gif" width="96" height="24" onClick="floodAdd()"/></a>
        </li>       
        <li style=" float:left;margin:10px 0 0 3px;">
        <a href="javascript:frm.reset()"><img src="${ctx}/images/btn_reset.gif" width="62" height="24" /></a>
        </li>		
        </ul>
	  </div>
    </div>
</div>
</form>
</body>
</html>
