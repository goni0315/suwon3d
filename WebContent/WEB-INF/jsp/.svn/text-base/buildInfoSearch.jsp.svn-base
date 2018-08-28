<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>건물 상세정보 페이지</title>
</head>
<script>
/* function test(bul_man_no)	{
if(bul_man_no !=null){
	var w=window.open("http://localhost:8080/Suwon3d/buildInfoSearch.do?bul_man_no="+bul_man_no,"_blank","width=500px,height=200px");
	var winxpos = (window.screen.width-1250)/2;
	var winypos = (window.screen.height-685)/2;
	w.moveTo(winxpos,winypos);		
	}
} */
</script>
<body>
<form action ="buildInfoSearch.do" method ="get">
	 	
	<input type="text" id="bul_man_no" name="bul_man_no"  value="12385">
	<input type="submit"   value="검색" onclick="test()">			
	
	<c:forEach var="sms" items="${buildList}">
		<tr>
			<td> ${sms.bul_man_no} ${sms.sgg_nm } ${sms.emd_nm } ${sms.rn}
			${sms.buld_mnnm} ${sms.buld_slno} ${sms.jibun} ${sms.buld_nm} ${sms.bdtyp_cd} </td> 
		</tr>		
	</c:forEach>
</form>
</body>
</html>