<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="../css/gislayout.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
</head>

<body >
<div id="panel">
    <div id="title">
        <div id="category">
       <ul style="width:320px;">
       <li style="float:left;"><a href="left3.html" target="left"><img src="../images/btn_R_search_off.gif"/></a>
        </li>
        <li style="float:right"><a href="left31.html" target="left"><img src="../images/btn_A_search_on.gif"/></a>
        </li>
        <li style=" padding-top:15px;clear:both; "><img src="../images/category_SIDE.gif" /></li>
        <li class="f_whit_am">반경 위치 설정</li>
        <li style="float:left;"><img src="../images/btn_A_set.gif" width="96" height="24" /></li>
        <li style="margin:0 0 0 3px;"><img src="../images/btn_A_reset.gif" width="96" height="24" /></li>

        </br>
		<fieldset >
        <legend class="f_whit_am">반경검색 옵션</legend>
             <ul>
            <li style=" clear:both; float:left;">
              <label for="textfield">건물 분류</label>
              <select name="bldgType" id="bldgType">
              	<option value="blank">전체</option>
              	<option value="0">공동주택</option>
              	<option value="1">일반주택</option>
              	<option value="2">산업시설</option>
              	<option value="3">공공기관</option>
              	<option value="4">서비스시설</option>
              	<option value="5">의료/복지시설</option>
              	<option value="5">문화/교육시설</option>              	
				<option value="6">기타시설</option>
              </select>
            </li>
            <li style=" clear:both; float:left;">
              <label for="textfield">검색어</label>
              <input type="text" name="textfield2" id="textfield2" />
            </li>
            </ul>
        </fieldset>

        <hr />
        <li style="margin:10px 0 10px 0; float:right;"><img src="../images/btn_search.gif"/></li>
        </ul>
	  </div>
    </div>
    <div>
        <h4><img src="../images/result_title1.gif" alt="결과" width="340" height="34"/></h4>
        <iframe id="searchResult" name="searchResult" src="${ctx}/region/reseult.do" frameborder="0" width="100%" style="height: 100%; max-height:520px; min-height:350px;" scrolling="no" />
    </div>
</div>
</body>
</html>
