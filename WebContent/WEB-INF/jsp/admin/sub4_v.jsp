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
<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css">
</head>

<body>
	<table width="100%" height="100%" border="0" cellspacing="0"
		cellpadding="0"
		style="background-image: url(${ctx}/images/admin/title_bg.gif); height: 100%">
		<tr>
			<td width="14" height="35"><img
				src="${ctx}/images/admin/title_left.gif" alt=""></td>
			<td>&nbsp;</td>
			<td width="14"><img src="${ctx}/images/admin/title_right.gif" alt=""
				width="14" height="35"></td>
		</tr>
		<tr>
			<td
				style="background-image: url(${ctx}/images/admin/left_bg.gif); text-align: center;"></td>
			<td valign="top" bgcolor="#FFFFFF">
				<div class="bbsCont">
					<table border="0" cellspacing="0" cellpadding="0" width="100%"
						summary="알립니다 게시판" style="margin-top: 10px;">
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
							<col class="w_40" />
						</colgroup>
						<tr>
							<th scope="col">번 호</th>
							<th scope="col">제목</th>
							<th scope="col">글쓴이</th>
							<th scope="col">작성일</th>
							<th scope="col">위치정보</th>
						</tr>
						<tr>
							<td class="acenter">1452</td>
							<td class="pad_l10">제목이라네..제목이 아주 길어야 겠지</td>
							<td class="acenter"><b><b>관리자</b>&nbsp; </b></td>
							<td class="acenter"><span title='2011년 11월 03일 23시 05분 23초'>2011/11/03</span></td>
							<td class="acenter"><img src="${ctx}/images/bbs/location.gif"
								alt="위치정보" width="21" height="21" /></td>
						</tr>
						<tr>
							<td colspan="5" style="padding: 20px; text-align: left;"><table
									border="0" cellspacing="0" cellpadding="0" width="100%"
									style="table-layout: fixed;">
									<col width="100%" />
									<tr>
										<td></td>
									</tr>
									<tr>
										<td valign="top"><img src="${ctx}/images/bbs/active_photo.jpg"
											alt="" width="133" height="107" /></td>
									</tr>
								</table>
								<table border="0" cellspacing="0" cellpadding="0" width="100%"
									style="table-layout: fixed;">
									<col width="100%" />
									<tr>
										<td></td>
									</tr>
									<tr>
										<td valign="top">본문내용</td>
									</tr>
								</table>
								<p class="line_box">
									- 첨부파일 1 : 첨부1<br /> - 첨부파일 2 : 첨부1<br />
								</p></td>
						</tr>
					</table>
				</div>
				<div class="bbsNext">
					<table class="wps_100" summary="이전 다음 페이지">
						<caption class="none">이전 다음 페이지</caption>
						<colgroup>
							<col class="w_80" />
							<col />
						</colgroup>
						<tr>
							<th scope="row" class="bbsFrom">이전글</th>
							<td><a onfocus=blur() href=''>이전글 </a></td>
						</tr>
						<tr>
							<th scope="row" class="bbsFrom">다음글</th>
							<td><a onfocus=blur() href=''>다음글</a></td>
						</tr>
					</table>
				</div>
				<div id="bbsBottom">
					<div id="bbsBtnL">
						<a href="sub4_w.jsp"><img src="${ctx}/images/bbs/btn_modify.gif"
							alt="수정" /></a> <img src="${ctx}/images/bbs/btn_delete.gif" alt="삭제" /> <img
							src="${ctx}/images/bbs/btn_reply.gif" alt="답글" />
					</div>
					<div id="bbsBtnR">
						<a href="sub4.jsp"><img src="${ctx}/images/bbs/btn_list.gif"
							alt="목록" /></a><a href="notice_w.jsp"> <img
							src="${ctx}/images/bbs/btn_write.gif" alt="글쓰기" /></a>
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
