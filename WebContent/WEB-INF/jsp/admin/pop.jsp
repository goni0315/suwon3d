<!-- 
	수원시 3차원 활용시스템 메인 >> 검색기능 >> 도로명검색 결과 페이지
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="${ctx}/css/default.css" rel="stylesheet" type="text/css">
</head>

<body>
	<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td><table border="0" cellpadding="0" cellspacing="0">
					<tr
						style="background-image:url(${ctx}/images/pop/pop_title_bg.gif)">
						<td><img src="${ctx}/images/admin/pop_title.gif" alt=""
							width="132" height="35"></td>
						<td align="right"><img
							src="${ctx}/images/pop/pop_title_end.gif" alt="" width="134"
							height="35"></td>
						<td align="right"><img
							src="${ctx}/images/pop/pop_title_cclose.gif" alt="" width="44"
							height="35"></td>
					</tr>
				</table></td>
		</tr>
		<tr>
			<td height="150" align="center"><table width="262" border="0"
					cellpadding="0" cellspacing="0">
					<tr>
						<td width="67" height="40">사용자명</td>
						<td width="195"><label for="select3"></label> 홍길동</td>
					</tr>
					<tr>
						<td height="40">부서</td>
						<td><label for="select">개발팀</label></td>
					</tr>
					<tr>
						<td height="40">권한</td>
						<td><label for="textfield"></label> <select name="select"
							id="select">
						</select></td>
					</tr>
					<tr>
						<td height="40" colspan="2" align="center"><img
							src="${ctx}/images/admin/btn_ok.gif" width="48" height="20">&nbsp;<img
							src="${ctx}/images/admin/btn_close.gif" width="48" height="20"></td>
					</tr>
				</table></td>
		</tr>
	</table>
</body>
</html>
