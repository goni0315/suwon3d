<!-- 
	운영자시스템 > 레이어관리 > 리스트
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
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script><!-- 조망, 네비 등의 속도 조절 슬라이드바 -->
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script language="javascript">
	function getLayerInfo(seq){
		ajaxRequest('${ctx}/admin/layerInfo.do', "seq="+seq, function(vo){
			var layerInfo = vo;
			document.getElementById("kor_nm").value=vo.kor_nm;
			document.getElementById("eng_nm").innerHTML=vo.eng_nm;
			document.getElementById("viewMin").value=vo.hide_low==""?0:vo.hide_low;
			document.getElementById("viewMax").value=vo.hide_high==""?0:vo.hide_high;
			var onOff=vo.f_view;
			var grp_cd = vo.grp_cde;
			setGroupBox(grp_cd);
			setfirstView(onOff);
			var selBox = document.getElementById("grp_nm");
			selBox.disabled="";
			document.getElementById("updateSeq").value=seq;
		},'post');
	}
	function setGroupBox(value){
		var selBox = document.getElementById("grp_nm");
		var cnt = selBox.options.length;
		for(var i=0 ; i<cnt ; i++){
			var opt = selBox.options[i];
			if(opt.value==value){
				opt.selected="true";
			}
		}
	}
	function setfirstView(value){
	 	var onOff=value;
		switch(onOff){
		case "Y" :
			document.getElementById("layOnOff_0").checked='true';
			break;
		case "N" :
			document.getElementById("layOnOff_1").checked='true';
			break;
		}
	}

	/**
		널 체크
		return : true - 값이 없음.
	*/
	function nullCheck(value, msg){
		var return_value=false;
		if(value==null || value=="" || value==undefined){
			return_value=true;
			alert(msg);
		}	
	}
	/**
		레이어 상세정보 업데이트
	*/	
	function doUpdate(){
		var kor_nm = document.getElementById("kor_nm").value;
		var selBox = document.getElementById("grp_nm");
		var grp_cde = selBox.value;
		var grp_nm = selBox.options[selBox.selectedIndex ].text;
		var f_view = document.getElementById("layOnOff_0").checked==true?"Y":"N";
		var hide_low = document.getElementById("viewMin").value;
		var hide_high = document.getElementById("viewMax"	).value;
		var seq = document.getElementById("updateSeq").value;
		
		if(nullCheck(kor_nm, "한글명이 비어있습니다.")){
			document.getElementById("kor_nm").focus();
			return;
		}else if(nullCheck(hide_low, "최소거리가 비어있습니다.")){
			document.getElementById("viewMin").focus();
			return;
		}else if(nullCheck(hide_low, "최대거리가 비어있습니다.")){
			document.getElementById("viewMax").focus();
			return;
		}else if(nullCheck(grp_cde, "그룹이 선택되지 않았습니다.")){
			document.getElementById("grp_nm").focus();
			return;
		}
		var param="";
		param +="kor_nm="+kor_nm;
		param +="&grp_cde="+grp_cde;
		param +="&grp_nm="+grp_nm;
		param +="&f_view="+f_view;
		param +="&hide_low="+hide_low;
		param +="&hide_high="+hide_high;
		param +="&lay_seq="+seq;

		ajaxRequest('${ctx}/admin/layerInfoUpdate.do', param, function(msg){
			
			alert(msg);
			
		},'post');
	}
	
	/**
		레이어그룹으로 레이어검색
	*/
	function doSearch(){
		var frm = document.getElementById("searchFrm");
	//	alert(searchLayGroup);
		frm.action = "${ctx}/admin/layerList.do?chk=1";
		frm.submit();
	}
	function onload(keyWord){
		var selBox = document.getElementById("searchLayGroup");
		var cnt = selBox.options.length;
		for(var i=0 ; i<cnt ; i++){
			var opt = selBox.options[i];
			if(opt.value==keyWord){
				opt.selected="true";
			}
		}
	}
</script>
</head>

<body onload="onload(${keyWord});">
	<table width="100%" height="100%" border="0" cellspacing="0"
		cellpadding="0"
		style="background-image: url(${ctx}/images/admin/title_bg.gif); height: 100%">
		<tr>
			<td width="14" height="35"><img
				src="${ctx}/images/admin/title_left.gif" alt="" width="14" height="35"></td>
			<td width="253" align="center"><img
				src="${ctx}/images/admin/title.gif" alt="" width="82" height="35"></td>
			<td width="11"><img src="${ctx}/images/admin/title_side.gif" alt=""
				width="11" height="35"></td>
			<td>&nbsp;</td>
			<td width="14"><img src="${ctx}/images/admin/title_right.gif" alt=""
				width="14" height="35"></td>
		</tr>
		<tr>
			<td rowspan="2"
				style="background-image: url(${ctx}/images/admin/left_bg.gif)"></td>
			<td rowspan="2" align="center" valign="top" bgcolor="#FFFFFF">
			<form id="searchFrm" name="searchFrm" method="post" target="_self">
			<table width="244" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="110">&nbsp;</td>
						<td width="134">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">레이어 그룹선택</td>
						<td><SELECT id="searchLayGroup" name="searchLayGroup">
										
										<c:if test="${not empty resultMap.groupList }">
											<c:forEach var="item" items="${resultMap.groupList }" varStatus="status">
												<option value="${item.grp_cde }">${item.grp_nm }</option>
											</c:forEach>
										</c:if>
						</SELECT></td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">&nbsp;</td>
						<td align="right">
						<a href="#" onclick="doSearch()">
							<img src="${ctx}/images/admin/search.gif"	alt="" width="48" height="20">
						</a>
						</td>
					</tr>
				</table></form></td>
			<td rowspan="2"
				style="background-image: url(${ctx}/images/admin/side_bg.gif)">&nbsp;</td>
			<td valign="top" bgcolor="#FFFFFF"><table width="200" border="0"
					cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="bbsCont">
					<table align="center" class="wps_90" summary="목록">
						<thead>
							<tr>
								<th width="50%" scope="col">레이어 영문명</th>
								<th width="50%" scope="col">레이어 한글명</th>
							</tr>
						</thead>
						<tbody>
			              <c:if test="${not empty resultMap.resultList}">
			              <c:forEach var="l_list" items="${resultMap.resultList}"  varStatus="status">						
							<TR align="center" style="cursor:pointer;" onmouseup="getLayerInfo(${l_list.lay_seq})">
								<TD>${l_list.eng_nm}</TD>
								<TD>${l_list.kor_nm }</TD>
							</TR>
							</c:forEach>
							</c:if>
							<c:if test="${empty resultMap.resultList}">
								<tr>
									<td colspan=2>검색된 게시물이 없습니다.</td>
								</tr>
							</c:if>							
						</tbody>
					</table>
				</div>
				<div class="bbsCont"></div>
				<div id="bbsBottom">
					<c:if test="${total_dataCount != 0}">
						<div align="center">
							<span height="30" style="font-size: 12px">${pageIndexList}</span>
						</div>
					</c:if>
				</div> <!-- 컨텐츠 끝 --></td>
			<td rowspan="2"
				style="background-image: url(${ctx}/images/admin/right_bg.gif)">&nbsp;</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><div align="center">
			<form id="infoFrm" name="infoFrm">
			
			<!-- <input type="hidden" name="chk" value="1"/> -->
			<input type="hidden" id="updateSeq" name="updateSeq" />
					<table width="767" class="type1 wps_90" summary="목록">

						<thead>
							<tr>
								<th colspan="6" scope="col">상세정보</th>
							</tr>
						</thead>
						<tbody>
							<TR align="center">
								<Th width="79">한글명</Th>
								<TD width="140"><label for="kor_nm"></label> <input
									type="text" name="kor_nm" id="kor_nm"></TD>
								<Th width="73">영문명</Th>
								<TD width="164"><span id="eng_nm" name="eng_nm" style="width:100%;"></span></TD>
								<Th width="88">그룹</Th>
								<Td><label for="grp_nm"></label> 
								<select name="grp_nm" id="grp_nm"  disabled="disabled">
										<option>----선택하세요.-----</option>
										<c:if test="${not empty resultMap.groupList }">
											<c:forEach var="item" items="${resultMap.groupList }" varStatus="status">
											<option value="${item.grp_cde }">${item.grp_nm }</option>
											</c:forEach>
										</c:if>
										
								</select></Td>
							</TR>
							<TR align="center">
								<Th>초기가시여부</Th>
								<TD><p>
										<label> <input name="layOnOff" type="radio"
											id="layOnOff_0" value="0" checked> on
										</label> <label> <input type="radio" name="layOnOff"
											value="1" id="layOnOff_1"> off
										</label> <br>
									</p></TD>
								<Th>가시높이</Th>
								<TD><input name="viewMin" type="text" id="viewMin"
									style="width: 60px;" value="0"> ~ <input
									name="viewMax" type="text" id="viewMax"
									style="width: 60px;" value="1000"></TD>
								<Th>보기권한</Th>
								<TD>공통,관리자,도시계획,상/하수도</TD>
							</TR>
						</tbody>
					</table>
					</form>
					<div class="wps_90" style="margin-top: 10px;">
						<a href="#" onclick="doUpdate()">
						<img src="${ctx}/images/admin/btn_update.gif" style="float: right;">
						</a>
						<div class="f_orange">반영된 수정사항을 확인하시려면 3차원 화면을 새로고침해주시기
							바랍니다.</div>
					</div>
				</div></td>
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

