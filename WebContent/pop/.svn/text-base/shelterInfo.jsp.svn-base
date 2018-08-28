<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<title>대피소 팝업창</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<style type="text/css">

</style>
<script type="text/javascript">
function closeWin()
{
   self.close();     
}
</script>
</head>
<body>
	<div style="width: 450px; height:190px; border: solid 1px #2c3445;">
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				<a href='#' onclick='closeWin()'><img src="${ctx}/images/pop_close.gif" /></a>
			</p>
		  <p class="f_whit_am">대피소 정보 조회</p>
		</div>
		<div class="bbsCont">
			<table border="1" class="wps_100">
			<c:if test="${not empty shelterInfoPopUpList}">
            <c:forEach var="sms" items="${shelterInfoPopUpList}">
				<tr>
					<th width="85">대피소명</th>
					<th width="89">&nbsp;</th>
					<th width="85">${sms.fac_nm}</th>
					<th width="93">&nbsp;</th>
				</tr>            
				<tr>
					<th class="bbsFrom">대피소주소</th>
					<td>${sms.dep_addr}</td>
					<th class="bbsFrom" >시설용도</th>
					<td >${sms.use_nm}</td>
				</tr>
				<tr>
					<th class="bbsFrom">등급</th>
					<td>${sms.def_grd}</td>
					<th class="bbsFrom">대피소규모</th>
					<td>${sms.dep_size}</td>
				</tr>
				<tr>
					<th class="bbsFrom">지정년도</th>
					<td>${sms.apt_year}</td>
					<th class="bbsFrom">수용인원</th>					
					<td>${sms.emb_cnt}</td>
			  </tr>
				<tr>
					<th class="bbsFrom">시설내역</th>
					<td colspan="3">${sms.fac_equ}</td>				
			  </tr>

			  </c:forEach>
			  </c:if>			  
			</table>
		</div>
	</div>

</body>
</html>