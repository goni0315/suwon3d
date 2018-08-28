<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공간검색</title>
</head>
<body>
<form action="spaceSearch.do" method="get">
검색반경 <input type ="text" name="space_area" id="space_area">m
      <input type="submit" value="검색"><br><br><br>
	<c:forEach var="sms" items="${spaceList}">
<br><br>
		<tr>
			<td>${sms.sgg_nm}, ${sms.rn}, ${sms.buld_mnnm}, ${sms.buld_slno}</td>
		</tr><br><br>
		<tr>
			<td>${sms.sgg_nm},${sms.spaceSrcList} </td>	
		</tr><br><br><br>
	</c:forEach>
	
	<select>
		<option></option>
	</select>
	
</form>
</body>
</html>