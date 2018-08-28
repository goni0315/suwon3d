<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>레이어정보 조회페이지</title>
<script>
</script>
</head>
<body>
	<form>
	<table id = "layInfo">
	<tr><td><input type = "button" onclick="test()"><td></tr>
	<c:if test="${not empty layInfoList}">
		<script>
		${layInfoList}
		</script>
		<%-- <c:forEach var="sms" items="${layInfoList}"  >		     
			<tr>
				<td id="kk" >${layInfoList}${sms.grp_nm} ${sms.file_nm} ${sms.hide_low} ${sms.hide_high} ${sms.eng_nm} ${sms.kor_nm}
				</td>
			</tr>
		<br>
		</c:forEach>
		 --%></c:if>
	</table>
	</form>
</body>
</html>