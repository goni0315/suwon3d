<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>건물 정보조회</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function closeWin()
{
   self.close();     
} 
</script>
</head>


<body>
<!--건물 정보조회-->
	<div style="width: 450px; height: 200px; border: solid 1px #2c3445;">
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				<a href='#' onclick='closeWin()'><img src="${ctx}/images/pop_close.gif" /></a>
			</p>
		  <p class="f_whit_am">건물 정보 조회</p>
		</div>
		<div class="bbsCont">
		
			<table width="500" border="1" class="wps_100">
			
				<tr>
					<th width="82">&nbsp;</th>
					<th width="85">&nbsp;</th>
					<th width="70">&nbsp;</th>
					<th width="91">&nbsp;</th>
				</tr>
				<c:if test="${not empty buildList}">
				<c:forEach var="sms" items="${buildList}">
				<tr>
					<th class="bbsFrom">관리번호</th>
					<td>${sms.bul_man_no} </td>
					<th class="bbsFrom">시구</th>
					<td>${sms.sgg_nm} </td>
				</tr>
				<tr>
					<th class="bbsFrom">읍면동</th>
					<td>${sms.emd_nm} </td>
					<th class="bbsFrom">도로명</th>
					<td>${sms.rn} </td>
				</tr>
				<tr>
				  <th class="bbsFrom">건물본번</th>
				  <td>${sms.buld_mnnm}</td>
				  <th class="bbsFrom">건물부번</th>
				  <td>${sms.buld_slno}</td>
			  </tr>
				<tr>
				  <th class="bbsFrom">번지</th>
				  <td>${sms.jibun} </td>
				  <th class="bbsFrom">건물명</th>
				  <td>${sms.buld_nm}</td>
			  </tr>
			  </c:forEach> 
				</c:if>
				
				<c:if test="${empty buildList}" >
					<tr>
						<td></td>
						<td>건물정보가 없습니다.</td>
						<td></td>
						<td></td>
					</tr>
			  </c:if>
			</table>
			
		</div>
	</div>
</body>
</html>