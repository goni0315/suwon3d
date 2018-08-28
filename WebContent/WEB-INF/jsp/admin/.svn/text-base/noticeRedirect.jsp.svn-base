<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function redirectAction(){
	if((${pageValue}) == 1){
		alert("등록 되었습니다.");
		location.href = "noticeList.do?page=0";
	}else if((${pageValue}) == 2){
		alert("삭제 되었습니다.");
		location.href = "noticeList.do?pageNum=${pageNum}";
	}else if((${pageValue}) == 3){
		alert("수정 되었습니다.");
		location.href = "noticeList.do?pageNum=${pageNum}";
	}else if((${pageValue}) == 4){
		alert("검색 결과가 없습니다.");
		location.href = "noticeList.do?page=0";
	}else if((${pageValue}) == 5){
		alert("더이상 글이 없습니다");
		location.href = 'noticeCount.do?bod_seq=${pageNum}';
	}else if((${pageValue}) == 6){
		alert("업로드 파일 제한은 10mb 입니다");
		location.href = 'noticeWrite.do';
	}else if((${pageValue}) == 7){
		alert("잠못된 파일이거나 파일이 존재하지 않습니다.\n관리자에게 문의하시기 바랍니다.");
		location.href = 'noticeContent.do?bod_seq=${pageNum}';
	}else if((${pageValue}) == 8){
		alert("업로드 파일 제한은 10mb 입니다");
		location.href = 'noticeUpdate.do?bod_seq=${bod_seq}';
	}
}
</script>
</head>

<body onload="redirectAction()">

</body>
</html>