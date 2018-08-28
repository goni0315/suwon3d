<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>insert</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.7.1.js"></script>
<script type="text/javascript">
	function writeFormCheck() {
		if($("#ADF_NM").val() == null || $("#ADF_NM").val() == ""){
			alert("첨부파일명을 입력해주세용!");
			$("#ADF_NM").focus();
			return false;
		}
		
		if($("#ADF_TYP").val() == null || $("#ADF_TYP").val() == ""){
			alert("첨부파일 확장명을 입력해주세용!");
			$("#ADF_TYP").focus();
			return false;
		}		
		return true;
	}
</script>
</head>
<body>
<div>	
	<h3>새 글 쓰기</h3>
	<form action="write.do" method="post" onsubmit="return writeFormCheck()">	
	<table>	
		<tr>
			<th><label for="subject">제목</label></th>
			<td>
				<input type="text" id="ADF_NM" name="ADF_NM"/>
				<input type="text" id="ADF_TYP" name="ADF_TYP"/>
			</td>			
		</tr>
		
	</table>
	<br />
	<input type="reset" value="재작성"/>
	<input type="submit" value="확인"/>	
	</form>	
</div>
<div>
	<form action="write3.do" >
	<table>
		<tr>
			<td>
				<input type="submit" value=" 입력한 사용자ID에 해당하는 시스템권한 값을 얻어오는 쿼리">
			</td>
		</tr>
	</table>
	</form>
	<br>
</div>
</body>
</html>