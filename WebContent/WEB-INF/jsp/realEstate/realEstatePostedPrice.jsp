<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>����������ȸ</title>
<link href="css/realEstateCss/realEstateCommon.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<style type="text/css">
table{
table-layout: fixed;
}

th{
width:100px;
}
td{
width: 150px;
}

</style>
</head>
<script type="text/javascript">
var rLandList = "";
var splitLandList = "${landPostedPrice}".split("&");
var yearList = splitLandList[0];
var priceList = splitLandList[1];

//������ �߰�
function yearListView() {
	var rYearList = yearList.split(",");
	for(var i=0;i <= rYearList.length-2;i++){
		$('#year').append($('<td align="center">' + rYearList[i] + '</td>'));
	}
}

//���ݺ� �߰�
function priceListView() {
	var rPriceList = priceList.split(",");
	for(var i=0;i <= rPriceList.length-2;i++){
		var val = addComma(rPriceList[i]);
		$('#price').append($('<td align="center">\\' + val + '��</td>'));
	}
}

function onLoadLandList() {
	yearListView();
	priceListView();
}
//$('#year').append($('<td align="center"></td>'));
//$('#price').append($('<td align="center"></td>'));
</script>
<body onload="onLoadLandList()">
<div id="wrap">
	<div id="header">
    	<ul class="menu_tab">
        	<li><a href="${ctx}/realEstateCadastre.do?pnu=${pnu}" class="on">��������</a></li>
            <li><a href="${ctx}/realEstateGeneralHeader.do?pnu=${pnu}">��������</a></li>
        </ul>
    </div>
    <div id="container">
    	<ul class="sub_tab">
            <li><a href="${ctx}/realEstateCadastre.do?pnu=${pnu}">��������</a></li>
            <li><a href="${ctx}/realEstateLandUsePlan.do?pnu=${pnu}">�����̿��ȹ</a></li>
            <li><a href="${ctx}/realEstatePostedPrice.do?pnu=${pnu}" class="on">��������</a></li>
            <li><a href="${ctx}/realEstateIndividualHouse.do?pnu=${pnu}">��������</a></li>
        </ul>
        <div class="content">
          <div style="overFlow-x : scroll;width: 100%">
          <table cellpadding="0" cellspacing="0" class="t_style04">
          	<tr id="year">
            	<th>����(��/��)</th>
            </tr>
            <tr id="price">
            	<th>����</th>
            </tr>
          </table>
          </div>
          <p class="explain">*�ڷᰡ ���ų�, ��ȸ���� �� ���� ������ ���Ͻø� ���� �μ��� �����Ͻñ� �ٶ��ϴ�.</p>
      </div>
    </div>
</div>
</body>
</html>