<!-- 
	수원시 3차원 활용시스템 메인 >> 검색기능 >> 공간검색 >> 반경검색 결과
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>도로명검색결과</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />

<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>



<script>
/*KLIS 한국토지 정보 시스템연계 링크걸기(부동산 정보 열람) */
function jibunInfo(pnu){
// 	var w=window.open("http://klis.gg.go.kr/sis/main.do","_blank","width=100px,height=100px");
// 	var url="http://klis.gg.go.kr/sis/info/baseInfo/baseInfo.do?";
// 	url+="service=baseInfo&landcode="+pnu+"&gblDivName=baseInfo&scale=0&gyujae=0";
// 	var win="";
// 	try{
// 		win=window.open(url,"addrInfoWin","");
// 		w.close();
// 	}catch(e){
// 		if(w!='null'){
// 			w.close();
// 		}
// 	}	
	var winform = window.open("${ctx}/realEstateCadastre.do?pnu=" + pnu,"대장정보조회","toolbar=no, status=no, scrollbars=no, location=no, menubar=no, width=909px, height=370px");
	winform.moveTo(screen.availWidth/2-1220/2,screen.availHeight/2 - 680/2);
	winform.focus();
}
function listPage(page){
	var form = parent.document.getElementById('frm');
	form.pageNum.value = page;
	form.submit();
}
/*
 * 좌표이동
 */
function doView(layer, keycode){
//	var layerLen = substring(layer-3, layer);
	var pos = top.XDOCX.XDSrcObjPosition(layerLen, keycode, false);
 	pos = pos.split(',');
 	//	var fileNM = pos[1].split("."); 
	//alert(fileNM[0]);
	top.searchXDPointPosition(pos[0], pos[2]);
	
}
</script>
</head>
<!--  건물검색어 입력 항목과 검색결과가 나타나는 페이지 -->
<body>

	<div id="bbsCont"
		style="height: 100%; width: 320px; overflow-y: auto; ">
		<table border="0" cellpadding="0" cellspacing="0" class="wps_100"
			title="list" summary="list">
			<col class="w_40" />
			<col />
			<col class="w_60" />
			<thead>
				<tr>
					<th>No</th>
					<th>수원시 DB 검색결과</th>
					<th>정보</th>
				</tr>
				<c:if test="${not empty result_list}">
					<c:forEach var="sms" items="${result_list}" varStatus="status">
						<tr>
							<td rowspan="2" align="center" class="f_dblue_b">${status.count}</td>
							<td class="f_orange_b" onclick="doView('KO3D_PL_BBND', '<c:out value="${sms.pnu}"></c:out>')" style="cursor: pointer;">
								${sms.buld_nm}<c:if test="${not empty sms.buld_nm_dc}"><span class="f_olive">(${sms.buld_nm_dc})</span></c:if></td>
							<td align="center" rowspan="2"><img
								src="${ctx}/images/btn_land2.gif" alt="토지대장"
								style="cursor: pointer;" onclick="jibunInfo('${sms.pnu}')" /></td>
						</tr>
						<tr>
							<td>${sms.sgg_nm} ${sms.rn} ${sms.buld_mnnm}
								<c:if test="${sms.buld_slno!=0}">- ${sms.buld_slno}</c:if>
							</td>
								<!--  여기 이동 기능 삽입해주세요 -->
							<%-- <td align="center"><img
								src="${ctx}/images/potal/move.gif" alt="이동"
								style="cursor: pointer;" onclick="return false;" /></td> --%>
						</tr>
						<%-- <tr>
							<td>${sms.sgg_nm} ${sms.addr } ${sms.lnbr_mnnm} -
								${sms.lnbr_slno}</td>
							<td align="center">
								<!-- 로드뷰 기능 삽입 예정 아직 구현 안됨 -->
								<img src='${ctx}/images/potal/daum.png' alt='로드뷰' style='cursor: pointer;' onclick='return false'/>&nbsp;&nbsp;
								<img src='${ctx}/images/potal/naver.png' alt='거르뷰' style='cursor: pointer;' onclick='return false;'/>
							</td>
						</tr> --%>
					</c:forEach>
				</c:if>
			</thead>
			<c:if test="${empty result_list}">
				<tr>
					<td colspan=5>검색된 결과가 없습니다.</td>
				</tr>
			</c:if>
		</table>
		<br>
		<c:if test="${total_dataCount != 0}">
			<div align="center">
				<span style="font-size: 12px;height:40px">${pageIndexList}</span>
			</div>
		</c:if>
	</div>
</body>
</html>


<%-- <%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link href="./css/common.css" rel="stylesheet" type="text/css" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body style="background:url(./images/common/bg.gif)">
<table border="0" cellpadding="0" cellspacing="0" style="height:100%">
  <tr>
    <td height="30" valign="top" ><img src="./images/search/list_title.gif" alt="" width="297" height="33" /></td>
  </tr>
  <tr>
    <td  valign="top" style="background-image:url(./images/search/contents_bg.gif)">
    <div class="bbsCont" style="margin:5px 0px 10px 10px; height:450px; width:282px; overflow-y:scroll">
      <table width="100%"  border="0" cellpadding="0" cellspacing="0" summary="목록" >
        <col class="w_40"/>
        <col />
        <col class="w_40"/>
        <thead>
          <tr>
            <th>No</th>
            <th>주소지</th>
            <th>이동</th>
            </tr>
          </thead>
         <c:if test="${not empty boardList}">
   		<c:forEach var="sms" items="${boardList}"  varStatus="status">
		<tr>
          <td align="center" style="font-size:12px; line-height: 1.0em;">${status.count}</td>
          <td style="font-size:12px; line-height: 1.0em;">${sms.sgg_nm} ${sms.rn} ${sms.buld_mnnm} - ${sms.buld_slno} ${sms.buld_nm}<br />
         <tr>
         	<td>${sms.sgg_nm} ${sms.addr } ${sms.lnbr_mnnm} - ${sms.lnbr_slno} ${sms.buld_nm}</td>
         </tr> 
          </td>
          <td style="font-size:12px; line-height: 1.0em;"><img src="./images/common/btn_move.gif" width="41" height="15"  style="cursor: pointer"></td>	
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${empty boardList}">
   		 <tr class=descBorder_c>
       	 <td colspan=5>검색된 게시물이 없습니다.</td>
         </tr>	
		</c:if>			
      </table>
    
      </div>

		<c:if test="${total_dataCount != 0}">
	     <tr align="center">
	        <td style="background-image:url(./images/search/contents_bg.gif)" align="center" height="30">${pageIndexList}</td>
	     </tr>
		</c:if> 
    </td>
  </tr>
	
  <tr>
    <td height="10"  valign="bottom"><img src="./images/search/contents_bottom.gif" width="297" height="10" /></td>
  </tr>
</table>
</body>
</html>
 --%>
 