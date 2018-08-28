<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>모델링 라이브러리 목록</title>
</head>
<body>
<%-- <table border="0">
		<tr align="center">
			<td>데이터일련번호</td>
			<td>대분류코드</td>
			<td>대분류명</td>
			<td>중분류코드</td>
			<td>중분류명</td>
			<td>라이브러리명</td>
			<td>라이브러리파일명</td>
			<td>텍스쳐파일명</td>
		</tr>
	<c:forEach var="modelLibInfo" items="${libListVos}">
		<tr align="center">
			<td>${modelLibInfo.lib_seq}</td>
			<td>${modelLibInfo.libl_cde}</td>
			<td>${modelLibInfo.libl_nm}</td>
			<td>${modelLibInfo.libm_cde}</td>
			<td>${modelLibInfo.libm_nm}</td>
			<td>${modelLibInfo.lib_nm}</td>
			<td>${modelLibInfo.lib_file}</td>
			<td>${modelLibInfo.texture_file}</td>
		</tr>
	</c:forEach>
</table> --%>
	<table>
		<tr>
			<c:if test="${not empty modelList}">
				<c:forEach var="model" items="${modelList}"  varStatus="status">
					<td>${model.lib_nm}</td>
				</c:forEach>
			</c:if>
			<c:if test="${empty modelList}">
		   		 <tr>
		       	 	<td colspan=5>검색된 게시물이 없습니다.</td>
		         </tr>	
			</c:if>	
		</tr>	
	</table>
</body>
</html>