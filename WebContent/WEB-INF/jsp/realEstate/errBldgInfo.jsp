<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<title>����������ȸ</title>
<link href="css/realEstateCss/realEstateCommon.css" type="text/css" rel="stylesheet" />
</head>

<body>
<div id="wrap">
	<div id="header">
    	<ul class="menu_tab">
        	<li><a href="#">��������</a></li>
            <li><a href="#">��������</a></li>
        </ul>
    </div>
    <div id="container">
    	<ul class="sub_tab">
        	<li><a href="#">��������</a></li>
            <li><a href="#">�����̿��ȹ</a></li>
            <li><a href="#">��������</a></li>
            <li><a href="#">��������</a></li>
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