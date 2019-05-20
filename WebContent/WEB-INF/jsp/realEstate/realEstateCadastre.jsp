<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>����������ȸ</title>
<link href="css/realEstateCss/realEstateCommon.css" type="text/css" rel="stylesheet" />
</head>
<script type="text/javascript">

var rLandList = "";
splitLandList = "${landCadastre}".split("&");
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
        	<li><a class="on" href="${ctx}/realEstateCadastre.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">��������</a></li>
            <li><a href="${ctx}/realEstateGeneralHeader.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">��������</a></li>
               <c:if test="${not empty buildList}">
        <c:forEach items="${buildList}" var="buld">        
        <li><h3 style="color: white; padding: 10px 10px 10px 100px; margin-left: 100px;">${buld.sgg_nm} ${buld.rn} ${buld.buld_mnnm}<c:if test="${buld.buld_slno!=0}">- ${buld.buld_slno}</c:if> (����) ${buld.emd_nm} ${buld.jibun}</h3></li>
        </c:forEach>
        </c:if>
        </ul>
    </div>
    <div id="container">
    	<ul class="sub_tab">
        	<li><a href="${ctx}/realEstateCadastre.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>"class="on">��������</a></li>
            <li><a href="${ctx}/realEstateLandUsePlan.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">�����̿��ȹ</a></li>
            <li><a href="${ctx}/realEstatePostedPrice.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">��������</a></li>
            <li><a href="${ctx}/realEstateIndividualHouse.do?pnu=${pnu}<c:if test="${not empty bul_man_no}">&bul_man_no=${bul_man_no}</c:if>">��������</a></li>
        </ul>
        <div class="content">
          <p class="tit"><input id="landInfoMSG" type="text" value="" style="background-color: #FFF; border:0;" size="100" readonly></p>
          <table cellpadding="0" cellspacing="0" class="t_style">
          	<colgroup>
            	<col width="18%" />
                <col width="15%" />
                <col width="18%" />
                <col width="15%" />
                <col width="18%" />
                <col width="15%" />
            </colgroup>
          	<tr>
            	<th>����</th>
                <td><input id="landInfo0" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>�����ڵ�</th>
                <td><input id="landInfo1" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>�����</th>
                <td><input id="landInfo2" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr>
            <tr>
            	<th>����</th>
                <td><input id="landInfo3" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>���������̵�����</th>
                <td><textarea id="landInfo4" style="white-space:normal;background-color: #FFF; border:0;" readonly></textarea></td>
                <th>���������̵�����</th>
                <td><input id="landInfo5" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr>
            <tr>
            	<th>���� �̵���������</th>
                <td><input id="landInfo6" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>�������Ű���</th>
                <td><input id="landInfo7" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>�ּҼ����Ǻ�������</th>
                <td><input id="landInfo8" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr> 
            <tr>
            	<th>�������и�</th>
                <td><input id="landInfo9" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>�����μ�</th>
                <td><input id="landInfo10" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>�����ڸ�</th>
                <td><input id="landInfo11" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr>
            <tr>
            	<th>�������ּ�</th>
                <td><input id="landInfo12" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>���������Ǻ�������</th>
                <td><input id="landInfo13" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>���������̵���������</th>
                <td><input id="landInfo14" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr>
            <tr>
            	<th>���������Ǻ�����������</th>
                <td><input id="landInfo15" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>�������հǹ�</th>
                <td><input id="landInfo16" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>�������</th>
                <td><input id="landInfo17" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr>
            <tr>
            	<th>������޺�������</th>
                <td><input id="landInfo18" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
                <th>Ư�̻���</th>
                <td colspan="3"><input id="landInfo19" type="text" value="" style="background-color: #FFF; border:0;" readonly></td>
            </tr>
          </table>
          <p class="explain">*�ڷᰡ ���ų�, ��ȸ���� �� ���� ������ ���Ͻø� ���� �μ��� �����Ͻñ� �ٶ��ϴ�.<br>
*������ ���� ������ ����������ȣ�� �� 18���� ���� ������ �����ϰ� �ֽ��ϴ�.</p>
        <!-- <div class="save">
        	<a href="#"><img src="realEstateImages/btn_save.gif"></a>
        </div> -->
      </div>
    </div>
</div>
</body>
</html>