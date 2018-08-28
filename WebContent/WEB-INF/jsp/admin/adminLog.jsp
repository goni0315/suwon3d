<!-- 
	관리자 > 관리자로그
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
<link type="text/css" href="${ctx}/css/jquery-ui.css" rel="stylesheet" />

<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> -->
<!-- <script type="text/javascript" src="${ctx}/js/jquery/jquery-1.11.0.min.js"></script>  -->

<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.18.custom.min.js"></script>



</head>
<body>

<table width="100%" height="100%" border="0" cellspacing="0"
		cellpadding="0"
		style="background-image: url(${ctx}/images/admin/title_bg.gif); height: 100%">
		<tr>
			<td width="14" height="35"><img
				src="${ctx}/images/admin/title_left.gif" alt="" width="14" height="35"></td>
			<td width="253" align="center"><img
				src="${ctx}/images/admin/title2.gif" alt="" width="92" height="35"></td>
			<td width="11"><img src="${ctx}/images/admin/title_side.gif" alt=""
				width="11" height="35"></td>
			<td>&nbsp;</td>
			<td width="14"><img src="${ctx}/images/admin/title_right.gif" alt=""
				width="14" height="35"></td>
		</tr>
		<tr>
			<td style="background-image: url(${ctx}/images/admin/left_bg.gif)"></td>
			<td align="center" valign="top" bgcolor="#FFFFFF"><table
					width="244" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="124">&nbsp;&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35" align="center" style="text-align:center">메 뉴</td>
						<td><LABEL> <SELECT name="menuOp" id="menuOp">
							<option value="103600">화면저장</option>
							<option value="103700">화면인쇄</option>
							
						</SELECT>
						</LABEL></td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="37px" align="center" style="text-align:center">기 간</td>
						<td>
							<input type="text" name="datepicker1" id="datepicker1" style="width: 100px;"> 부터
							<input type="text" name="datepicker2" id="datepicker2" style="width: 100px;"> 까지
						</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">&nbsp;</td>
						<td>
							<INPUT id="chkMonth" onClick="" value="month"  type="radio" name="rad1"> 월별
							<INPUT id="chkDay" onClick="" value="day" type="radio" name="rad1" CHECKED> 일별
						</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">&nbsp;</td>
						<td align="right">
							<img src="${ctx}/images/admin/btn_graph.gif" id="graphImg" onclick="fn_setVisibleType(this.id)" style="cursor:pointer;">
							<img src="${ctx}/images/admin/search.gif" alt="" style="margin-left: 5px;cursor:pointer;"  onclick="fn_getConnList();">
						</td>
					</tr>
				</table></td>
			<td style="background-image: url(${ctx}/images/admin/side_bg.gif)">&nbsp;</td>
			<td valign="top" bgcolor="#FFFFFF"><table width="200" border="0"
					cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div id="graph" style="display:none">
				<div class="bbsCont">
					<table align="center" class="wps_90" summary="목록">
						<thead>
							<tr>
								<th scope="col">접속이력통계 그래프</th>
							</tr>
						</thead>
						<tbody>
							<TR align="center">
								<TD><div id="container" style="height: 70%; width:70%;margin-top: 0px; margin-right: auto; margin-bottom: 0px; margin-left: auto; min-width: 310px;" data-highcharts-chart="0"></div></TD>
							</TR>
						</tbody>
					</table>
				</div>
				<div class="bbsCont"></div> 
				</div>
				<div id="listdiv">
					<div class="bbsCont">
						<table align="center" class="wps_90" summary="목록">
							<colgroup>
								<col class="w_50" />
								<col class="w_100" />
								<col class="w_400" />
								<col class="w_300" />
								<col class="w_250" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">NO</th>
									<th scope="col">사용자명</th>
									<th scope="col">부서</th>
									<th scope="col">사용메뉴</th>
									<th scope="col">접속시간</th>
								</tr>
							</thead>
							<tbody id="userListTBody">
							<tr>
								<td colspan="5" style="text-align:center; align:center">검색 해주세요.</td>
							</tr>
							</tbody>
						</table>
					</div>
					<br />
					<div align="center">
						<span style="font-size: 12px;height:40px" id="pageSpan"></span><span  style="float:right;padding-right:70px;" id="exceldown"></span>
					</div>
			 <!-- 컨텐츠 끝 -->
				</div>
			<!-- 컨텐츠 끝 --></td>	
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
	<iframe id="tempFrm" name="tempFrm" frameborder=0 width="0" height="0" />

</body>
</html>