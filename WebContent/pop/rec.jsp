<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script><!-- 조망, 네비 등의 속도 조절 슬라이드바 -->
<script type="text/javascript" src="${ctx}/js/json2.js"></script><!-- 도로개설 -->
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript">
/**
 * 녹화
 */
var file_path;
function doRecordStart(){
	//opener.XDOCX.XDCamRecordStart(10);
	var returnVal = confirm("녹화 기능을 위해 코덱 설치가 필요합니다. \n설치하시려면 '확인', 설치 되어있으면 '취소'를 클릭해주세요.");
	if(returnVal == true){
		location.replace(top.WEB_SERVER_URL_SB + "/StarCodec_20140424.exe");
	}else{
		opener.XDOCX.XDCapAVIIsRecording();
		if(opener.XDOCX.XDCapAVIIsRecording() == true){
			alert("이미 녹화중입니다.");
		}else{
			file_path = opener.XDOCX.XDUIOpenFileDlg(false, "avi");
		}
		
		if(file_path == ""){
			alert("경로가 올바르지 않습니다.");
			return;
		}
		
		if(opener.XDOCX.XDCapAVIRecordStart(file_path, 15) == false){
			alert("현재상태에서는 녹화를 진행 할 수 없습니다.");
		}
	}
}
/**
 * 정지
 */
function doStop(){
	if (opener.XDOCX.XDCapAVIIsRecording() == false){
		alert("녹화가 진행 중이지 않습니다.");
		return;
	}
	opener.XDOCX.XDCapAVIRecordEnd(); 
}
</script>
</head>
<body>
<input type="button" onclick="doRecordStart();" value="녹화시작">
<input type="button" onclick="doStop();" value="정지">
</body>
</html>