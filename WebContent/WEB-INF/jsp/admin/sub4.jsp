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
				<table border="0" cellspacing="0" cellpadding="0" width="100%"
					summary="알립니다 게시판" style="margin-top: 10px;">
					<caption class="none">알립니다</caption>
					<tr valign="top">
						<td height="30"><select name="select2" id="select2">
						</select> <select name="select2" id="select3">
						</select> <input type="text" name="keyword" value="" class="input"
							size="13" title="검색어" /> <input type="image" align="absmiddle"
							src="${ctx}/images/bbs/btn_find.gif" alt="검색" /></td>
						<td align="right">전체 132, 페이지 1 / 14</td>
					</tr>
				</table>
				<div class="bbsCont">
					<table class="wps_100" summary="Q&amp;A 목록">
						<colgroup>
							<col class="w_60" />
							<col />
							<col class="w_60" />
							<col class="w_80" />
							<col class="w_60" />
							<col class="w_50" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번 호</th>
								<th scope="col">제 목</th>
								<th scope="col">작성자</th>
								<th scope="col">작성일</th>
								<th scope="col">첨부</th>
								<th scope="col">조회</th>
							</tr>
							<!--검색결과 리스트 Start-->
							<tr>
								<td align="center"><img src="${ctx}/images/bbs/notice_head.gif"
									alt="" /></td>
								<td class="list_subject" nowrap="nowrap" align="left"><img
									src="${ctx}/images/bbs/head.gif" alt="" border="0" align="absmiddle" />
									&nbsp;<a href="sub4_v.jsp">공지사항<img
										src="${ctx}/images/bbs/point_new.gif" alt="" width="19" height="9" /></a></td>
								<td align="center">황태군</td>
								<td align="center"><span title='writeday'>2011-10-12</span></td>
								<td align="center"><img src="${ctx}/images/bbs/icon_excel.gif"
									alt="" width="16" height="16" /></td>
								<td align="center">39</td>
							</tr>
							<!--검색결과 리스트 Start-->
							<tr>
								<td align="center">3</td>
								<td class="list_subject" nowrap="nowrap" align="left"><img
									src="${ctx}/images/bbs/head.gif" alt="" border="0" align="absmiddle" />
									&nbsp;어쩌고 저쩌고</td>
								<td align="center">황태군</td>
								<td align="center"><span title='writeday'>2011-10-12</span></td>
								<td align="center"><img src="${ctx}/images/bbs/icon_hwp.gif"
									alt="" width="16" height="16" /></td>
								<td align="center">94</td>
							</tr>
							<!--검색결과 리스트 Start-->
							<tr>
								<td align="center">2</td>
								<td class="list_subject" nowrap="nowrap" align="left"><img
									src="${ctx}/images/bbs/lock.gif" alt="" border="0" align="absmiddle" />
									&nbsp;비밀글</td>
								<td align="center">황태군</td>
								<td align="center"><span title='writeday'>2011-10-12</span></td>
								<td align="center"><img src="${ctx}/images/bbs/icon_img.gif"
									alt="" width="16" height="16" /></td>
								<td align="center">461</td>
							</tr>
							<!--검색결과 리스트 Start-->
							<tr>
								<td align="center">&nbsp;</td>
								<td class="list_subject" nowrap="nowrap" align="left">&nbsp;<img
									src='${ctx}/images/bbs/ico_board_reply.gif' alt="" width='25'
									height='10' align='absmiddle' />다음글의 답변은요!
								</td>
								<td align="center">황태군</td>
								<td align="center"><span title='writeday'>2011-9-30</span></td>
								<td align="center"><img src="${ctx}/images/bbs/icon_movie.gif"
									alt="" width="16" height="16" /></td>
								<td align="center">61</td>
							</tr>
						</thead>
					</table>
				</div>
				<div id="bbsBottom">
					<ul id="bbsPaging">
						<li><img src="${ctx}/images/admin/page_first.gif" alt="" /></li>
						<li><img src="${ctx}/images/admin/page_prev.gif" alt="" /></li>
						<strong>1</strong>  [2][3][4][5]...[68]
						<li><img src="${ctx}/images/admin/page_next.gif" alt=""
							width="22" height="15" /></li>
						<li><img src="${ctx}/images/admin/page_last.gif" alt=""
							width="22" height="15" /></li>
					</ul>
					<font style="font-size: 8pt"><font style="font-size: 8pt"><font
							style="font-size: 8pt"><font style="font-size: 8pt"><font
									style="font-size: 8pt"><font style="font-size: 8pt"><font
											style="font-size: 8pt"><font style="font-size: 8pt"><font
													style="font-size: 8pt">
														<div id="bbsBottom2">
															<div id="bbsBtnL"></div>
															<div id="bbsBtnR">
																<img src="${ctx}/images/bbs/btn_list.gif" alt="목록" /><a
																	href="sub4_w.jsp"> <img
																	src="${ctx}/images/bbs/btn_write.gif" alt="글쓰기" /></a>
															</div>
														</div>
												</font></font></font></font></font></font></font></font></font>
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

