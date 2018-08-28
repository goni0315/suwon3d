<!-- 
	수원시 3차원 활용시스템 관리자페이지 >> 관리자 로그 페이지
 -->
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="suwon.web.vo.AdminLogListVo" %>   
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
<!-- <script>
var todayDate = new Date(); 
</script> -->
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
						<form action="adminLogList.do"> 
							<%-- <input id=searchType name="searchType"  type="radio" value="bod_sub"/>제목
							<input id=searchType name="searchType"  type="radio" value="bod_ctt"/>내용
							<input id=searchType name="searchType"  type="radio" value="bod_seq"/>번호
							<input id=searchType name="searchType"  type="radio" value="reg_dat" onclick="datePicker(event, 'searchItem')"/>등록일
												
							<input type="text" id=searchItem name="searchItem" class="input"size="100" title="검색어" /> 
							<input type="image" name="searchSubmit" onclick="javascript:searchFormCheck('searchForm')" align="absmiddle"src="${ctx}/images/bbs/btn_find.gif" alt="검색" /> --%>
							
							<select name="menu">
							
  							<option value="0">전체</option>
  							<option value="1" >공지사항</option>
  							<option value="2" >권한관리</option>
  							<option value="3" >레이어관리</option>
  							<option value="4" >레이어업데이트</option>
  							<option value="5" >접속통계</option>
  							<option value="6" >출력이력</option>
  							<option value="7">관리자접속이력</option>
  							<option value="8">글 열람</option>
  							<option value="9">글 등록</option>
  							<option value="10">글 수정</option>
  							<option value="11">글 삭제</option>
  							
  							
  							</select>
  							
							<!-- 왜 쿼리스트링으로 보내지지 않는가 -->
  							<select name="usrid" style="display: none;">
  							<option value="${usrid}" selected="selected" ></option>
  							</select>
  							
  							<input type="submit" value="조회"/>
							
						</form>
						</td>	
						<!-- 페이징 카운팅 -->
						<td align="right">전체 ${noticeRecord}, 페이지 <fmt:parseNumber value="${pageNum}" type="number" integerOnly="True" /> / ${totalPage}</td>
					</tr>
				</table>
				<div class="bbsCont">
					<table class="wps_100" summary="Q&amp;A 목록">
					
						<thead>
							<tr>
								<th scope="col" width="60px">번 호</th>
								<th scope="col" >작업내용</th>
								<th scope="col" >아이디</th>
								<th scope="col" >아이피</th>
								<th scope="col" >날짜</th>
							</tr>
						
							
							<!--공지사항 리스트 Start -->
								<c:forEach items="${adminLoglist}" var="adminLog" > 
								<input type="hidden" value="${adminLog.logseq}">
															
								<tr>
									<!--  번호 -->
									<td align="center" id="bod_seq" >${adminLog.logseq}</td>
																											
									<!-- 작업내용 -->	
									<td align="left">${adminLog.menuname}</td>
									
									<!--  아이디 -->
									<td align="center"  width="100px">${adminLog.usrid}</td>
									
									<!--  아이피 -->
									<td align="center"  width="100px">${adminLog.conip}</td>
									
									<!--  접속날짜 -->
									<td align="center"  width="200px">${adminLog.regdate}</td>
								
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
	
	<input type="hidden" id="usrid" value="${usrid}"/>
	
	
	



    	
	
</body>
</html>