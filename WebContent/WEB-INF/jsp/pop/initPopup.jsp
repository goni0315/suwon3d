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
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script>
window.onload = function() {          //모든리소스(이미지포함) 로딩 후
    PopupAutoResize("popUp"); //팝업리사이즈  contentId
};

//쿠키 생성 함수정의
function setCookie(name, value, expiredays ) { 
	var todayDate = new Date(); 
 	todayDate.setDate( todayDate.getDate() + expiredays ); 
 	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";";
}

//팝업창 닫기
function closeWin(bod_seq) {
	var pop_id = "popup_"+bod_seq;
	if(document.getElementById("notice").checked) { //일주일간 안보기 체크확인
		setCookie(pop_id, "done", 7); //쿠키 설정   숫자는 지속일수 7:일주일간 안보기
	   	self.close();
  	}else{
  		self.close();
  	}
}

</script> 
<style>
body{overflow:hidden}
</style> 
</head>
<body>
	<div id="popUp" style="width: 100%; height: 100%; border: solid 1px #2c3445; "><!-- width: 320px; height: 510px; -->
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				<img src="${ctx}/images/pop_close.gif" style="cursor:pointer" onclick="javascript:closeWin();"/>
			</p>
			<p class="f_whit_am" title="제목">${resultVo.bod_sub }</p>
		</div>
	  <div class="bbsCont">
		<table  border="1" class="wps_100" table-layout="fixed">	<!-- width="300" height="460" -->
				<tr>
					<td valign="top" style="padding:5px 10px 0px 10px">${resultVo.bod_ctt }</td>
				</tr>
				<c:if test="${not empty resultVo.bod_filename1 || not empty resultVo.bod_filename2}">
				<tr><td valign="top" align="center">				
					<p class="line_box" style="width:90%; align:left; padding-left: 10px;">
					<c:if test="${not empty resultVo.bod_filename1}">
					- 첨부파일 :
					<a href="noticeDownload.do?bod_seq=${resultVo.bod_seq}&type=1">
					${resultVo.bod_filename1}</a></c:if>
					<br/>
					<c:if test="${not empty resultVo.bod_filename2}">
					- 첨부파일 :
					<a href="noticeDownload.do?bod_seq=${resultVo.bod_seq}&type=2">
					${resultVo.bod_filename2}</a></c:if> 
					<br /> 
					</p></td>	
				</tr>
				</c:if>
				<tr><td style="float: right; margin-right: 5px">
				<input type="checkbox" name="notice" id="notice" onclick="javascript:closeWin(${resultVo.bod_seq});"/>&nbsp;&nbsp;일주일동안 보이지 않기&nbsp;&nbsp;</td></tr>
		</table>
		</div>	
	</div>
</body>
</html>
