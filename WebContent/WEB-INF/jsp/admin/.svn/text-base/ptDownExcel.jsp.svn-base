<%@ page language="java" contentType="application/vnd.ms-excel; name='excel', text/html; charset=UTF-8" 
        pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	response.setHeader("Content-Disposition", "attachment; filename= connStat.xls");
	response.setHeader("Content-Description","JSP Generated Data");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
</script>
</head>

<body>
<!--검색결과 : S-->
	<table align="center" border="1">
		<thead>
			<tr>
				<td colspan="5" align="center" style="font-color:blue" bgcolor="#d9d9d9">출력통계</td>
			</tr>
			<tr>
				<th bgcolor="#b8cce4">NO</th>
				<th bgcolor="#b8cce4">사용자명</th>
				<th bgcolor="#b8cce4">부서</th>
				<th bgcolor="#b8cce4">사용메뉴</th>
				<th bgcolor="#b8cce4">출력일</th>
			</tr>
		</thead>
		<c:if test="${not empty l_list}">
					<c:forEach var="sms" items="${l_list}" varStatus="status">
						<TR align="center">
							<TD>${sms.logseq}</TD>
							<TD>${sms.usrname}</TD>
							<TD>${sms.deptname}</TD>
							<TD>${sms.menuname}</TD>
							<TD>${sms.wdate}</TD>
						</tr>
					</c:forEach>
				</c:if>
			<c:if test="${empty l_list}">
				<tr>
					<td colspan=5>검색된 게시물이 없습니다.</td>
				</tr>
			</c:if>
	</table>
</body>
</html>
