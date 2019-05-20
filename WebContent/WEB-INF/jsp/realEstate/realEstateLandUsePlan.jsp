<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>대장정보조회</title>
<link href="css/realEstateCss/realEstateCommon.css" type="text/css" rel="stylesheet" />
</head>
<script type="text/javascript">
var rLandList = "";
var splitLandList = "${landUsePlan}".split("&");

function landInfoView() {
	if(splitLandList.length <= 1){
		document.getElementById("landInfoMSG").value = splitLandList;
	}else{
		for(var i=0;i <= splitLandList.length-1;i++){
			document.getElementById("landInfo" + i).value = splitLandList[i];
		}
	}
}
</script>
<body onload="landInfoView()">
<div id="wrap">
	<div id="header">
    	<ul class="menu_tab">
        	<li><a href="${ctx}/realEstateCadastre.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>" class="on">토지정보</a></li>
            <li><a href="${ctx}/realEstateGeneralHeader.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">건축정보</a></li>
              <c:if test="${not empty buildList}">
        <c:forEach items="${buildList}" var="buld">        
        <li><h3 style="color: white; padding: 10px 10px 10px 100px; margin-left: 100px;">${buld.sgg_nm} ${buld.rn} ${buld.buld_mnnm}<c:if test="${buld.buld_slno!=0}">- ${buld.buld_slno}</c:if> (지번) ${buld.emd_nm} ${buld.jibun}</h3></li>
        </c:forEach>
        </c:if>
        </ul>
    </div>
    <div id="container">
    	<ul class="sub_tab">
        	<li><a href="${ctx}/realEstateCadastre.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">토지대장</a></li>
            <li><a href="${ctx}/realEstateLandUsePlan.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>" class="on">토지이용계획</a></li>
            <li><a href="${ctx}/realEstatePostedPrice.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">공시지가</a></li>
            <li><a href="${ctx}/realEstateIndividualHouse.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">개별주택</a></li>
        </ul>
        <div class="content">
        <p class="tit"><input id="landInfoMSG" type="text" value="" style="background-color: #FFF; border:0;" size="100" readonly></p>
          <table cellpadding="0" cellspacing="0" class="t_style02">
          	<colgroup>
            	<col width="40%" />
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
            </colgroup>
     	    <tr>
            	<th>소재지</th>
                <th>지번</th>
                <th>지목</th>
                <th>면적</th>
            </tr>
            <tr>
            	<td><input id="landInfo0" type="text" value="" style="background-color: #FFF; border:0;" readonly size="70"></td>
                <td><input id="landInfo1" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <td><input id="landInfo2" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <td><input id="landInfo3" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr>
          </table>
          <table cellpadding="0" cellspacing="0" class="t_style03">
          	<colgroup>
            	<col width="20%" />
                <col width="25%" />
                <col width="55%" />
            </colgroup>
          	<tr>
            	<th rowspan="2">지역·지구등 지정여부</th>
                <th>국토의 계획 및 이용에 관한 법률에 따른 지역·지구등</th>
                <td><textarea id="landInfo4" cols="75" style="white-space:normal;background-color: #FFF; border:0;" readonly></textarea></td>
            </tr>
            <tr>
                <th>다른 법령 등에 따른 지역·지구등</th>
                <td><textarea id="landInfo5" cols="75" style="white-space:normal;background-color: #FFF; border:0;" readonly></textarea></td>
            </tr>
            <tr>
            	<th colspan="2">토지이용규제 기본법 시행령 제9조제4항 각호에 해당되는 사항</th>
                <td><textarea id="landInfo6" cols="75" style="white-space:normal;background-color: #FFF; border:0;" readonly></textarea></td>
            </tr>
          </table>
          <p class="explain">*자료가 없거나, 조회내용 외 상세한 정보를 원하시면 관련 부서에 문의하시기 바랍니다.</p>
        <!-- <div class="save">
        	<a href="#"><img src="images/btn_save.gif"></a>
        </div> -->
      </div>
    </div>
</div>
</body>
</html>