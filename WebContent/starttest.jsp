<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript">
/**
 * ajax로 로그 저장하는 함수 
 */
function goPage(num){
	switch(num){
	case 1 :
		location.href="${ctx}/main.jsp?usrid=001000693";		
		break;
	case 2 :
		location.href="${ctx}/main.jsp?usrid=001000331";
		break;
	case 4 :
		location.href="${ctx}/main.jsp?usrid=001001";
		break;		
	case 3 :
		location.href="${ctx}/admin.do?adminUsrid=001000693";
		break;
	case 5 :
		location.href="${ctx}/main.jsp";
		break;	
	}
}

</script>
</head>
<body>
	<input type="button" value="관리자로 지도페이지 이동" onclick="goPage(1)">
	<input type="button" value="랜덤사용자로 지도페이지 이동" onclick="goPage(5)">
	<input type="button" value="일반사용자로 지도페이지 이동" onclick="goPage(2)">
	<input type="button" value="관리자 페이지로 이동" onclick="goPage(3)">
	<input type="button" value="없는 아이디로 이동" onclick="goPage(4)">
</body>
</html>