<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${resultVo.bod_sub }</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<script>
//쿠키 생성 함수정의
function setCookie(name, value, expiredays ) { 
	var todayDate = new Date(); 
 	todayDate.setDate( todayDate.getDate() + expiredays ); 
 	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
}

function closeWin() {
	//var pop_id = "popup";
	if(document.getElementById("notice").checked) {
		setCookie("pluginUpdate", "done", 7); // 숫자는 지속일수 7:일주일간 안보기
	   	self.close();
  	}else{
  		self.close();
  	}
}
</script>
</head>

<body>
	<div style="width: 350px; height: 200px; border: solid 1px #2c3445;">
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				<img src="${ctx}/images/pop_close.gif" onclick="closeWin;" style="cursor:pointer;"/>
			</p>
			<p class="f_whit_am" title="제목">멀티브라우저 플러그인 다운로드</p>
		</div>
	  <div class="bbsCont"><center>
		<table width="320"  height=180" border="1" class="wps_100">
				
				<tr>
					<td><pre>
  멀티브라우저 플러그인이 업데이트 되었습니다.
  아직 업데이트 받지 않으신 분은 아래의 링크를 클릭하여 
  플러그인을 업데이트 하여 주시기 바랍니다.
 
  <a href="${ctx }/cab/nsXDWorldSetup.exe"><b><font color="blue">[멀티브라우저 플러그인 다운로드]</font></b></a>

  변경된 점은 다음과 같습니다.
    1. 지도 초기화시 서버접속메시지 삭제
    2. 소소한 함수의 오류 수정
					</pre>
					</td>
				</tr>
		</table>
		</center>

		</div>
		<p style="float: right">
		<input type="checkbox" name="notice" id="notice" onclick="javascript:closeWin()"/>일주일동안 보이지 않기</p>
	</div>
</body>
</html>
