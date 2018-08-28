<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>천연가스배관 정보조회</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!--천연가스배관 정보조회-->
	<div style="width: 450px; height: 200px; border: solid 1px #2c3445;">
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				<img src="${ctx}/images/pop_close.gif" />
			</p>
		  <p class="f_whit_am">천연가스배관 정보 조회</p>
		</div>
		<div class="bbsCont">
		
			<table width="450" border="1" class="wps_100">
			
				<tr>
					<th width="70">&nbsp;</th>
					<th width="100">&nbsp;</th>
					<th width="62">&nbsp;</th>
					<th width="96">&nbsp;</th>
				</tr>
				<c:if test="${not empty GasPipeInfoList}">
				<c:forEach var="sms" items="${GasPipeInfoList}">
				<tr>
					<th class="bbsFrom">관리번호</th>
					<td>${sms.ftr_idn} </td>
					<th class="bbsFrom">설치일자</th>
					<td>${sms.ist_ymd} </td>
				</tr>
				<tr>
					<th class="bbsFrom">압력</th>
					<td>${sms.sga_nam} </td>
					<th class="bbsFrom">관재질</th>
					<td>${sms.mop_nam} </td>
				</tr>
				<tr>
				  <th class="bbsFrom">관경</th>
				  <td>${sms.std_dip}mm </td>
				  <th class="bbsFrom">관라벨</th>
				  <td>${sms.pip_lbl} </td>
			  </tr>
				<tr>
				  <th class="bbsFrom">깊이</th>
				  <td>${sms.std_dep} </td>
				  <th class="bbsFrom">길이</th>
				  <td>${sms.std_len} </td>
			  </tr>
			  </c:forEach> 
				</c:if>
				
				<c:if test="${ empty GasPipeInfoList}">
				<tr>
					<th class="bbsFrom">관리번호</th>
					<td>8080785412</td>
					<th class="bbsFrom">설치일자</th>
					<td>2005/05/05</td>
				</tr>
				<tr>
					<th class="bbsFrom">하수관용도</th>
					<td>오수관</td>
					<th class="bbsFrom">관재질</th>
					<td>폴리에틸렌관</td>
				</tr>
				<tr>
				  <th class="bbsFrom">관경</th>
				  <td>300</td>
				  <th class="bbsFrom">관라벨</th>
				  <td>2005/pt/300</td>
			  </tr>
				<tr>
				  <th class="bbsFrom">깊이</th>
				  <td>1</td>
				  <th class="bbsFrom">길이</th>
				  <td>1</td>
			  </tr>
			  </c:if>
			</table>
			
		</div>
	</div>
</body>
</html>