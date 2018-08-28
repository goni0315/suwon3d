<!-- 
	수원시 3차원 활용시스템 관리자 >> 공지사항 >> 공지글 작성 페이지
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript" src="${ctx}/js/date_picker.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/noticeFormCheck.js"></script>
<script type="text/javascript" src="${ctx}/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
<%-- <script type="text/javascript" src="${ctx}/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"></script> --%>
<% 
	session.setAttribute("bod_sub", request.getParameter("bod_sub"));
   	session.setAttribute("bod_ctt", request.getParameter("bod_ctt"));
   	
   	session.setAttribute("bod_yn", request.getParameter("bod_yn"));
   	session.setAttribute("bod_start", request.getParameter("bod_start")); 
   	session.setAttribute("bod_end", request.getParameter("bod_end"));
   	
   	session.setAttribute("imp_typ", request.getParameter("imp_typ"));
   	
 %>
<script type="text/javascript">
//관리자 체크
function usrCheck(){
	var usrInfo = top.getUserInfo();
	var usrName = usrInfo.usrname;
	document.getElementById("mng_id").value = usrName;
}
//스마트 에디터
function submitContents() {
    // 에디터의 내용이 textarea에 적용된다.
    oEditors.getById["bod_ctt"].exec("UPDATE_CONTENTS_FIELD", []);
    
    /*/물음표 오류 해결팁(임시방편)//////////
    var sIR = document.getElementById("bod_ctt").value; 
  	//sIR = sIR.replace(unescape("%uFEFF"), ""); 
   	sIR = sIR.replace(/\?/gi, ""); 
    document.getElementById("bod_ctt").value = sIR;
    /////////////////////*/
   	try {
     //  elClickedObj.form.submit();
      writeFormCheck('writeform','bod_start','bod_end','write');
    } catch(e) {}
}
<%-- 
//textArea에 이미지 첨부
function pasteHTML(filepath){
    var sHTML = '<img src="<%=request.getSession().getServletContext().getRealPath("/upload")+'/'%>'+filepath+'">';
    oEditors.getById["bod_ctt"].exec("PASTE_HTML", [sHTML]);
}
 --%>
</script>
</head>

<body onload="usrCheck()">
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0"
		style="background-image: url(${ctx}/images/admin/title_bg.gif); height: 100%">
		<tr>
			<td width="14" height="35"><img
				src="${ctx}/images/admin/title_left.gif" alt=""></td>
			<td>&nbsp;</td>
			<td width="14"><img src="${ctx}/images/admin/title_right.gif" alt="" width="14" height="35"></td>
		</tr>
		<form id=writeform name="writeform" method="post" enctype="multipart/form-data" autocomplete="on"> 
		<tr>
			<td	style="background-image: url(${ctx}/images/admin/left_bg.gif); text-align: center;"></td>
			<td valign="top" bgcolor="#FFFFFF"><div class="bbsCont">
					<table border="0" cellspacing="0" cellpadding="0" width="100%"
						summary="알립니다 게시판" style="margin-top: 10px;">
						<caption class="none">알립니다</caption>
						<tr valign="top">
							<td height="30">&nbsp;</td>
							<td align="right">&nbsp;</td>
						</tr>
					</table>
					<table class="wps_100" summary="글쓰기">
						<caption class="none">글쓰기</caption>
						<colgroup>
							<col class="w_120" />
							<col />
						</colgroup>
						<tr>
							<th colspan="2">글 등록하기</th>
						</tr>
						<tr>
							<th scope="row" class="bbsFrom">제목
							</td>
							<td class="pad_l10" align="left">
							<input type="hidden" id=mng_id name="mng_id" value=""/>
							<c:if test="${bod_sub == null }">
								<input type="text" id=bod_sub name="bod_sub" value="" size=60 style="width: 400px;" maxlength="100" class=input></td>
							</c:if>
							<c:if test="${bod_sub != null }">
								<input type="text" id=bod_sub name="bod_sub" value="<%=(String)session.getAttribute("bod_sub") %>" size=60 style="width: 400px;" maxlength="100" class=input></td>
							</c:if>
						</tr>
						<tr>
							<th scope="row" class="bbsFrom">팝업설정
							<td class="pad_l10" align="left">
							<c:if test="${bod_yn == 1 }">
								<input type=checkbox id=bod_yn checked=check name=bod_yn value=1 onclick="javascript:popupCheck('bod_yn','popset','bod_start','bod_end')"></input>
								<div id=popset style="display:inline">
								<input type="text" id=bod_start onclick="datePicker(event, 'bod_start')" name=bod_start value="<%=(String)session.getAttribute("bod_start") %>" size=60 style="width: 100px;" class=input readonly ></input>
								 ~ <input type="text" id=bod_end  onclick="datePicker(event, 'bod_end')" onpropertychange="javascript:dateCheck('bod_start', 'bod_end')" name=bod_end value="<%=(String)session.getAttribute("bod_end") %>" size=60 style="width: 100px;" class=input readonly ></input></div></td>
								  <!-- onpropertychange IE 전용 이벤트 함수 -->
								  </c:if>
							<c:if test="${bod_yn != 1 }">
								<input type=checkbox id=bod_yn name=bod_yn value=1 onclick="javascript:popupCheck('bod_yn','popset','bod_start','bod_end')"></input>
								<div id=popset style="display:none">
								<input type="text" id=bod_start onclick="datePicker(event, 'bod_start')" name=bod_start value="" size=60 style="width: 100px;" class=input readonly ></input>
								 ~ <input type="text" id=bod_end  onclick="datePicker(event, 'bod_end')" onpropertychange="javascript:dateCheck('bod_start', 'bod_end')" name=bod_end value="" size=60 style="width: 100px;" class=input readonly ></input></div></td>
								  <!-- onpropertychange IE 전용 이벤트 함수 -->
							 </c:if>
						</tr>
						<tr>
							<th scope="row" class="bbsFrom">중요도 
							<td class="pad_l10" align="left">
							<c:if test="${imp_typ == '하' || imp_typ == null }">
								<select name="imp_typ" style="width:70px" onchange="">        
									<option selected value="하">선택</option>				
									<option value="상">공지</option>
									<option value="중">중요</option>
									<option value="긴">긴급</option>
								</select>
								</c:if>
								<c:if test="${imp_typ == '중'}">
								<select name="imp_typ" style="width:70px" onchange="">        
									<option value="하">선택</option>				
									<option value="상">공지</option>
									<option selected value="중">중요</option>
									<option value="긴">긴급</option>
								</select>
								</c:if>
								<c:if test="${imp_typ == '상' }">
								<select name="imp_typ" style="width:70px" onchange="">        
									<option value="하">선택</option>				
									<option selected  value="상">공지</option>
									<option value="중">중요</option>
									<option value="긴">긴급</option>
								</select>
								</c:if>
								<c:if test="${imp_typ == '긴' }">
								<select name="imp_typ" style="width:70px" onchange="">        
									<option value="하">선택</option>				
									<option value="상">공지</option>
									<option value="중">중요</option>
									<option selected  value="긴">긴급</option>
								</select>
								</c:if>
							</td>
						</tr>  
						<tr>
							<th scope="row" class="bbsFrom">내용
							</td>
							<td class="pad_l10" align="left">
							<c:if test="${bod_sub == null }">
							<textarea name="bod_ctt" id="bod_ctt" rows="10" cols="100"
								style="width: 95%; height: 240px; padding: 5px; line-height: 160%;"></textarea>
							</c:if>
							<c:if test="${bod_sub != null }">
							<textarea name="bod_ctt" id="bod_ctt" rows="10" cols="100"
								style="width: 95%; height: 240px; padding: 5px; line-height: 160%;"><%=(String)session.getAttribute("bod_ctt") %></textarea>
							</c:if>	
							</td> 
						</tr>
<script type="text/javascript">
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "bod_ctt",
    sSkinURI: "${ctx}/se2/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
});
</script>
						<tr>
							<th colspan="2">파일첨부 -업로드 파일 제한은 10mb 입니다. 
							</th>
						</tr>
						<tr>
							<th scope="row" class="bbsFrom">파일첨부 1
							</th>
							<td class="pad_l10">
							<input name="file1" type="file"	id="fileField" onchange="" size="50" maxlength="255" /></td>	
						</tr>
						<tr>
							<th scope="row" class="bbsFrom">파일첨부 2
							</th>
							<td class="pad_l10">
							<input name="file2" type="file"	id="fileField"  size="50" maxlength="255" /></td>				
						</tr> 
						
					</table>
				</div>
				<div id="bbsBottom">
					<div id="bbsBtnC">
					<!-- 공지글 submit    -->
						<input type="image" name="submit" onclick="submitContents()"  src="${ctx}/images/bbs/btn_write_big.gif" alt="글등록" />
						<!--  공지글 취소 -->
						<a href="noticeList.do?pageNum=${pageNum}">
						<img src="${ctx}/images/bbs/btn_cancel_big.gif" alt="취소" /></a>
					</div>
				</div> <!-- 컨텐츠 끝 --></td>	
			<td style="background-image: url(${ctx}/images/admin/right_bg.gif)">&nbsp;</td>
		</tr>
	</form>
		<tr style="background-image: url(${ctx}/images/admin/end_bg.gif)">
			<td height="10"><img src="${ctx}/images/admin/end_left.gif" alt=""
				width="14" height="10"></td>
			<td></td>
			<td><img src="${ctx}/images/admin/end_right.gif" alt="" width="14" height="10"></td>
		</tr>
	</table>
</body>

</html>

