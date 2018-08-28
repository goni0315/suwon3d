<!-- 
	수원시 3차원 활용시스템 관리자페이지 >> 공지사항 >> 공지사항 검색리스트 페이지
 -->
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="suwon.web.vo.NoticeVo" %>   
<%@ page import="java.util.List" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctx}/js/date_picker.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/noticeFormCheck.js"></script>
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
			<td style="background-image: url(${ctx}/images/admin/left_bg.gif); text-align: center;"></td>
			<td valign="top" bgcolor="#FFFFFF">
				<table border="0" cellspacing="0" cellpadding="0" width="100%"
					summary="알립니다 게시판" style="margin-top: 10px;">
					<caption class="none">알립니다</caption>
					<tr valign="top">
						<td height="30">
						
						<!-- 검색기능  -->
						<form id=searchForm name="searchForm" method="post"> 
							<input id=searchType name="searchType"  type="radio" value="bod_sub"/>제목
							<input id=searchType name="searchType"  type="radio" value="bod_ctt"/>내용
							<input id=searchType name="searchType"  type="radio" value="bod_seq"/>번호
							<input id=searchType name="searchType"  type="radio" value="reg_dat" onclick="datePicker(event, 'searchItem')"/>등록일
												
							<input type="text" id=searchItem name="searchItem" value="" class="input"size="100" title="검색어" /> 
							<input type="image" name="searchSubmit" onclick="javascript:searchFormCheck('searchForm')" align="absmiddle"src="${ctx}/images/bbs/btn_find.gif" alt="검색" /></td>
						</form>
						<!-- 페이징 카운팅 -->
						<td align="right">전체 ${noticeRecord}, 페이지 <fmt:parseNumber value="${pageNum}" type="number" integerOnly="True" /> / ${totalPage}</td>
					</tr>
				</table>
				<div class="bbsCont">
				검색결과
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
							<!-- 긴급사항 먼저 뿌려주기 -->
							<c:forEach items="${impNoticeList}" var="notice"> 
							<tr>
								<!--  번호 -->
									<td align="center" id="bod_seq">
									<img src="${ctx}/images/bbs/notice_head.gif" alt="" /> 
									</td>
									
									<!-- 제목 -->
									<td class="list_subject" nowrap="nowrap" align="left">
									<img src="${ctx}/images/bbs/head.gif" alt="" border="0" align="absmiddle" />
										&nbsp;<a href='noticeSearchCount.do?bod_seq=${notice.bod_seq}'>
										<strong>[긴급] ${notice.bod_sub}</strong>
										<%-- <img src="${ctx}/images/bbs/point_new.gif" alt="" width="19" height="9" /> --%></a></td>
										
									<!-- 관리자ID -->	
									<td align="center">${notice.mng_id}</td>
									
									<!--  작성날짜 -->
									<td align="center"><span title='writeday'>${notice.reg_dat}</span></td>
									
									<!-- 첨부 (미구현) -->
									<td align="center">
										<c:if test="${not empty notice.bod_filename1}">
										<a href="noticeDownload.do?bod_seq=${notice.bod_seq}&type=1">
										<img src="${ctx}/images/bbs/icon_file.gif" alt="" width="16" height="16" /></a>
									</c:if>
									<c:if test="${not empty notice.bod_filename2}">
										<a href="noticeDownload.do?bod_seq=${notice.bod_seq}&type=2">
										<img src="${ctx}/images/bbs/icon_file.gif" alt="" width="16" height="16" /></a>
									</c:if>
									</td>
									
									<!-- 조회 -->
									<td align="center">${notice.bod_cnt }</td>
							</tr>
							</c:forEach> 
			
							<!--검색 리스트 Start -->
								<c:forEach items="${searchNotice}" var="notice"> 
								<%-- <input type="hidden" value="${notice.imp_typ}"> --%>
								<tr>
									<!--  번호 -->
									<td align="center" id="bod_seq">${notice.bod_seq}</td>
									
									<!-- 제목 -->
									<td class="list_subject" nowrap="nowrap" align="left">
									
									<img src="${ctx}/images/bbs/head.gif" alt="" border="0" align="absmiddle" />
										&nbsp;<a href='noticeSearchCount.do?bod_seq=${notice.bod_seq}'>
										<!-- 긴급사항 검사 -->
										<c:if test="${notice.imp_typ == '상'}">
										[공지]
										</c:if>
										<!-- 중요사항 검사 -->
										<c:if test="${notice.imp_typ == '중'}">
										[중요]
										</c:if>
										<c:if test="${notice.imp_typ == '긴'}">
										[긴급]
										</c:if>
										${notice.bod_sub}
										<%-- <img src="${ctx}/images/bbs/point_new.gif" alt="" width="19" height="9" /> --%>
										</a></td>
									
									<!-- 관리자ID -->	
									<td align="center">${notice.mng_id}</td>
									
									<!--  작성날짜 -->
									<td align="center"><span title='writeday'>${notice.reg_dat}</span></td>
									
									<!-- 첨부 (미구현) -->
									<td align="center">
										<c:if test="${not empty notice.bod_filename1}">
										<a href="noticeDownload.do?bod_seq=${notice.bod_seq}&type=1">
										<img src="${ctx}/images/bbs/icon_file.gif" alt="" width="16" height="16" /></a>
									</c:if>
									<c:if test="${not empty notice.bod_filename2}">
										<a href="noticeDownload.do?bod_seq=${notice.bod_seq}&type=2">
										<img src="${ctx}/images/bbs/icon_file.gif" alt="" width="16" height="16" /></a>
									</c:if>
									</td>
									
									<!-- 조회 -->
									<td align="center">${notice.bod_cnt }</td>
								</tr>
						 	</c:forEach> 
						</thead>
					</table>
				</div>
			 <!-- 페이징 -->
			
				<div id="bbsBottom">
					
					<ul id="bbsPaging">
						<!-- 페이징 리스트 -->
						<span height="30" style="font-size: 12px">${pageIndexList}</span>
					
					</ul>	
					<font style="font-size: 8pt"><font style="font-size: 8pt">
						<font style="font-size: 8pt"><font style="font-size: 8pt">
							<font style="font-size: 8pt"><font style="font-size: 8pt">
								<font style="font-size: 8pt"><font style="font-size: 8pt">
									<font style="font-size: 8pt">
										 <div id="bbsBottom2">
											 <div id="bbsBtnL"></div>
												<div id="bbsBtnR">
												<!-- 목록으로 --><!--  -->
													<a href="noticeList.do?page=0">
														<img src="${ctx}/images/bbs/btn_list.gif" alt="목록" /></a>
											<!------- 글쓰기 btn --------->
													<a href="noticeWrite.do">
														<img src="${ctx}/images/bbs/btn_write.gif" alt="글쓰기" /></a>
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

