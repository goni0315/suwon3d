<!-- 
	관리자 > 출력통계
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
			<td width="253" align="center"><img
				src="${ctx}/images/admin/title2.gif" alt=""></td>
			<td width="11"><img src="${ctx}/images/admin/title_side.gif" alt=""
				width="11" height="35"></td>
			<td>&nbsp;</td>
			<td width="14"><img src="${ctx}/images/admin/title_right.gif" alt=""
				width="14" height="35"></td>
		</tr>
		<tr>
			<td style="background-image: url(${ctx}/images/admin/left_bg.gif)"></td>
			<td align="center" valign="top" bgcolor="#FFFFFF"><table
					width="244" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="124">&nbsp;</td>
						<td width="120">&nbsp;</td>
					</tr>
					<tr>
						<td height="35" align="center">시스템명</td>
						<td><label for="select"></label> <select name="select"
							id="select">
						</select></td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35" align="center">기 간</td>
						<td><input type="text" name="textfield" id="textfield"
							style="width: 100px;"> 부터 <input type="text"
							name="textfield" id="textfield" style="width: 100px;"> 까지
						</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35" colspan="2" align="right"><img
							src="${ctx}/images/admin/btn_graph.gif" alt=""><img
							src="${ctx}/images/admin/btn_list.gif" alt=""
							style="margin-left: 5px;"></td>
					</tr>
				</table></td>
			<td style="background-image: url(${ctx}/images/admin/side_bg.gif)">&nbsp;</td>
			<td valign="top" bgcolor="#FFFFFF"><table width="200" border="0"
					cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="bbsCont">
					<table align="center" class="wps_90" summary="목록">
						<colgroup>
							<col />
							<col class="w_150" />
							<col class="w_100" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">부서명</th>
								<th scope="col">교부수</th>
								<th scope="col">교부일</th>
							</tr>
						</thead>
						<tbody>
							<TR align="center">
								<TD>양산(053)</TD>
								<TD>35909053</TD>
								<TD>삼아항업(주)</TD>
							</TR>
							<TR align="center">
								<TD>남원(026)</TD>
								<TD>35710025</TD>
								<TD>삼아항업(주)</TD>
							</TR>
						</tbody>
					</table>
				</div>
				<div class="bbsCont"></div>
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
				</div> <!-- 컨텐츠 끝 --></td>
			<td style="background-image: url(${ctx}/images/admin/right_bg.gif)">&nbsp;</td>
		</tr>
		<tr style="background-image: url(${ctx}/images/admin/end_bg.gif)">
			<td height="10"><img src="${ctx}/images/admin/end_left.gif" alt=""
				width="14" height="10"></td>
			<td align="center"></td>
			<td><img src="${ctx}/images/admin/end_side.gif" alt="" width="11"
				height="10"></td>
			<td></td>
			<td><img src="${ctx}/images/admin/end_right.gif" alt="" width="14"
				height="10"></td>
		</tr>
	</table>
</body>
</html>

