<!-- 
	수원시 3차원 활용시스템 관리자페이지 >> 공지사항 >> 공지 글 페이지
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css">
</head>

<body>
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0"
		style="background-image: url(${ctx}/images/admin/title_bg.gif); height: 100%">
		<tr>
			<td width="14" height="35">
			<img src="${ctx}/images/admin/title_left.gif" alt=""></td>
			<td>&nbsp;</td>
			<td width="14"><img src="${ctx}/images/admin/title_right.gif" alt="" width="14" height="35"></td>
		</tr>
		<tr>
			<td	style="background-image: url(${ctx}/images/admin/left_bg.gif); text-align: center;"></td>
			<td valign="top" bgcolor="#FFFFFF">
				<div class="bbsCont">
					<table border="0" cellspacing="0" cellpadding="0" width="100%" summary="알립니다 게시판" style="margin-top: 10px;">
						<caption class="none">알립니다</caption>
						<tr valign="top">
							<td height="30">&nbsp;</td>
							<td align="right">&nbsp;</td>
						</tr>
					</table>
					<table class="wps_100" summary="게시물 자세히보기">
						<caption class="none">게시물 자세히보기</caption>
						<colgroup>
							<col class="w_40" />
							<col class="w_200" />
							<col class="w_40" />
							<col class="w_40" />
						<%-- 	<col class="w_40" /> --%>
						</colgroup>
						<tr>
							<th scope="col">번 호</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">작성일</th>
							<!-- <th scope="col">위치정보</th> -->
						</tr>
						<tr>
						<!-- 번호  -->
							<td class="acenter">${noticeContent.bod_seq}</td>
							
							<!--  제목 -->
							<td class="pad_l10">${noticeContent.bod_sub}</td>
							
							<!-- 관리자 id -->
							<td class="acenter"><b><b>${noticeContent.mng_id }</b>&nbsp; </b></td>
							
							<!-- 작성날짜 -->
							<td class="acenter"><span title='write_day'>${noticeContent.reg_dat }</span></td>
							
							<!--  위치정보?(미구현) -->
							<%-- <td class="acenter"><img src="${ctx}/images/bbs/location.gif" alt="위치정보" width="21" height="21" /></td> --%>
						</tr>
						<!-- 본문 내용 -->
						<tr>
							<td colspan="5" style="padding: 20px; text-align: left;">
								<table border="0" cellspacing="0" cellpadding="0" width="100%"
									style="table-layout: fixed;">
									<col width="100%" />
									<!-- 내용 -->
									<tr>
										<td valign="top">${noticeContent.bod_ctt }</td>
									</tr>
									<%-- <!-- 첨부이미지(미구현) -->
									<tr>
										<td valign="top"><img src="${ctx}/images/bbs/active_photo.jpg" alt="" width="133" height="107" /></td>
									</tr> --%>
								</table>
								<c:if test="${not empty noticeContent.bod_filename1 || not empty noticeContent.bod_filename2}">
								<table border="0" cellspacing="0" cellpadding="0" width="100%" style="table-layout: fixed;">
									<col width="100%" />
									<tr>
										<td></td>
									</tr>
								</table>
								
								<!-- 첨부파일  -->
								
								<p class="line_box">
									<c:if test="${not empty noticeContent.bod_filename1}">
									- 첨부파일  :
									<a href="noticeDownload.do?bod_seq=${noticeContent.bod_seq}&type=1">
									${noticeContent.bod_filename1}</a></c:if>
									<br />
									<c:if test="${not empty noticeContent.bod_filename2}">
									- 첨부파일  :
									<a href="noticeDownload.do?bod_seq=${noticeContent.bod_seq}&type=2">
									${noticeContent.bod_filename2}</a></c:if> 
									<br /> 
								</p>
								</c:if>
								</td>
						</tr>
					</table>
				</div>
				<!-- 페이징 -->
				<div class="bbsNext">
					<table class="wps_100" summary="이전 다음 페이지">
						<caption class="none">이전 다음 페이지</caption>
						<colgroup>
							<col class="w_80" />
							<col />
						</colgroup>
						<c:if test="${not empty prevContent}">
						<tr>
							<th scope="row" class="bbsFrom" name="prevNotice">이전글</th>
							<td><a onfocus=blur() href="noticeSearchCount.do?bod_seq=${prevContent.bod_seq }">${prevContent.bod_sub } </a></td>
						</tr>
						</c:if>
						<c:if test="${not empty nextContent}">
						<tr>
							<th scope="row" class="bbsFrom" name="nextNotice">다음글</th>
							<td><a onfocus=blur() href="noticeSearchCount.do?bod_seq=${nextContent.bod_seq }">${nextContent.bod_sub }</a></td>
						</tr>
						</c:if>
					
					</table>
				</div>
				<div id="bbsBottom">
					<div id="bbsBtnL">
						<a href="noticeUpdate.do?bod_seq=${noticeContent.bod_seq}"><img src="${ctx}/images/bbs/btn_modify.gif" alt="수정" /></a>
						 <a href="noticeDelete.do?bod_seq=${noticeContent.bod_seq}"><img src="${ctx}/images/bbs/btn_delete.gif" alt="삭제" /></a> 
						 <%-- <img src="${ctx}/images/bbs/btn_reply.gif" alt="답글" /> --%>
					</div>
					<div id="bbsBtnR">
					<!-- 목록으로 -->
						<a href="noticeSearch.do?item=${searchItem}&type=${searchType}&pageNum=${pageNum}">
							<img src="${ctx}/images/bbs/btn_list.gif" alt="목록" /></a>
					<!-- 글쓰기 -->
						<a href="noticeWrite.do">
							<img src="${ctx}/images/bbs/btn_write.gif" alt="글쓰기" /></a>
					</div>
				</div> <!-- 컨텐츠 끝 -->
			</td>
			<td style="background-image: url(${ctx}/images/admin/right_bg.gif)">&nbsp;</td>
		</tr>
		<tr style="background-image: url(${ctx}/images/admin/end_bg.gif)">
			<td height="10"><img src="${ctx}/images/admin/end_left.gif" alt=""
				width="14" height="10"></td>
			<td></td>
			<td><img src="${ctx}/images/admin/end_right.gif" alt="" width="14"
				height="10"></td>
		</tr>
	</table>
</body>
</html>
