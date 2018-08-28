<!-- 
	운영 시스템 메인
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원 공간정보 활용시스템 운영자 페이지</title>
<link href="{ctx}/css/admin_common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>

<script type="text/javascript">
	
<!--
	function MM_preloadImages() { //v3.0
		var d = document;
		if (d.images) {
			if (!d.MM_p)
				d.MM_p = new Array();
			var i, j = d.MM_p.length, a = MM_preloadImages.arguments;
			for (i = 0; i < a.length; i++)
				if (a[i].indexOf("#") != 0) {
					d.MM_p[j] = new Image;
					d.MM_p[j++].src = a[i];
				}
		}
	}
	function MM_findObj(n, d) { //v4.01
		var p, i, x;
		if (!d)
			d = document;
		if ((p = n.indexOf("?")) > 0 && parent.frames.length) {
			d = parent.frames[n.substring(p + 1)].document;
			n = n.substring(0, p);
		}
		if (!(x = d[n]) && d.all)
			x = d.all[n];
		for (i = 0; !x && i < d.forms.length; i++)
			x = d.forms[i][n];
		for (i = 0; !x && d.layers && i < d.layers.length; i++)
			x = MM_findObj(n, d.layers[i].document);
		if (!x && d.getElementById)
			x = d.getElementById(n);
		return x;
	}

	function MM_nbGroup(event, grpName) { //v6.0
		var i, img, nbArr, args = MM_nbGroup.arguments;
		if (event == "init" && args.length > 2) {
			if ((img = MM_findObj(args[2])) != null && !img.MM_init) {
				img.MM_init = true;
				img.MM_up = args[3];
				img.MM_dn = img.src;
				if ((nbArr = document[grpName]) == null)
					nbArr = document[grpName] = new Array();
				nbArr[nbArr.length] = img;
				for (i = 4; i < args.length - 1; i += 2)
					if ((img = MM_findObj(args[i])) != null) {
						if (!img.MM_up)
							img.MM_up = img.src;
						img.src = img.MM_dn = args[i + 1];
						nbArr[nbArr.length] = img;
					}
			}
		} else if (event == "over") {
			document.MM_nbOver = nbArr = new Array();
			for (i = 1; i < args.length - 1; i += 3)
				if ((img = MM_findObj(args[i])) != null) {
					if (!img.MM_up)
						img.MM_up = img.src;
					img.src = (img.MM_dn && args[i + 2]) ? args[i + 2]
							: ((args[i + 1]) ? args[i + 1] : img.MM_up);
					nbArr[nbArr.length] = img;
				}
		} else if (event == "out") {
			for (i = 0; i < document.MM_nbOver.length; i++) {
				img = document.MM_nbOver[i];
				img.src = (img.MM_dn) ? img.MM_dn : img.MM_up;
			}
		} else if (event == "down") {
			nbArr = document[grpName];
			if (nbArr)
				for (i = 0; i < nbArr.length; i++) {
					img = nbArr[i];
					img.src = img.MM_up;
					img.MM_dn = 0;
				}
			document[grpName] = nbArr = new Array();
			for (i = 2; i < args.length - 1; i += 2)
				if ((img = MM_findObj(args[i])) != null) {
					if (!img.MM_up)
						img.MM_up = img.src;
					img.src = img.MM_dn = (args[i + 1]) ? args[i + 1]
							: img.MM_up;
					nbArr[nbArr.length] = img;
				}
		}
	}
//-->


</script>
</head>

<body
	onLoad="doLogin('${usrid}','admin');MM_preloadImages('${ctx}/images/admin/menuOn_01.gif','${ctx}/images/admin/menuOn_02.gif','${ctx}/images/admin/menuOn_03.gif','${ctx}/images/admin/menuOff_00.gif','${ctx}/images/admin/menuOn_00.gif')">

	<table width="200" border="0" cellspacing="0" cellpadding="0"
		style="width: 100%; height: 100%">
		<tr>
			<td height="69"><table width="100%" border="0" cellpadding="0"
					cellspacing="0"
					style="background-image:url(${ctx}/images/admin/top_bg.gif)">
					<tr>
						<td width="14" rowspan="2"><img src="${ctx}/images/admin/top_left.gif" alt="" width="14" height="69"></td>
						<td width="235" rowspan="2"><img src="${ctx}/images/admin/ci.gif" alt="" width="269" height="69" onclick="location.replace('http://105.1.2.121/Suwon3d/main.jsp?usrid=${usrid}')" style="cursor: pointer;"></td>
						<td height="31" align="right" valign="bottom"><table
								border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td><span style="color:#1f21d8; font-weight:bold;" id="topUsrname"></span>님이 로그인되었습니다.</td>
									<td></td>
								</tr>
							</table></td>
						<td width="14" rowspan="2" align="right"><img src="${ctx}/images/admin/top_right.gif" alt="" width="14" height="69"></td>
					</tr>
					<tr>
						<td align="center"><table border="0" cellpadding="0"
								cellspacing="0">
								<tr>
									<td><a href="${ctx}/noticeList.do" target="sub"
										onClick="MM_nbGroup('down','group1','menuOff00','${ctx}/images/admin/menuOn_00.gif',1)" 
										onMouseOver="MM_nbGroup('over','menuOff00','${ctx}/images/admin/menuOn_00.gif','',1)"
										onMouseOut="MM_nbGroup('out')"><img src="${ctx}/images/admin/menuOn_00.gif" alt="" name="menuOff00" border="0" onload="MM_nbGroup('init','group1','menuOff00','${ctx}/images/admin/menuOff_00.gif',1)"></a></td>
									<td><a href="${ctx}/usrAutList.do" target="sub"
										onClick="MM_nbGroup('down','group1','menuOff01','${ctx}/images/admin/menuOn_01.gif',1)"
										onMouseOver="MM_nbGroup('over','menuOff01','${ctx}/images/admin/menuOn_01.gif','',1)"
										onMouseOut="MM_nbGroup('out')"><img src="${ctx}/images/admin/menuOff_01.gif" alt="" name="menuOff01" border="0" onload=""></a></td> 
									<td><a href="${ctx}/admin/layerList.do" target="sub"
										onClick="MM_nbGroup('down','group1','menuOff02','${ctx}/images/admin/menuOn_02.gif',1)"
										onMouseOver="MM_nbGroup('over','menuOff02','${ctx}/images/admin/menuOn_02.gif','',1)"
										onMouseOut="MM_nbGroup('out')"><img src="${ctx}/images/admin/menuOff_02.gif" alt="" name="menuOff02" border="0" onload=""></a></td>
									<td><a href="${ctx}/connStat.do" target="sub"
										onClick="MM_nbGroup('down','group1','menuOff03','${ctx}/images/admin/menuOn_03.gif',1)"
										onMouseOver="MM_nbGroup('over','menuOff03','${ctx}/images/admin/menuOn_03.gif','',1)"
										onMouseOut="MM_nbGroup('out')"><img src="${ctx}/images/admin/menuOff_03.gif" alt="" name="menuOff03" border="0" onload=""></a></td>
											
									<td><a href="${ctx}/printStat.do" target="sub"
										onClick="MM_nbGroup('down','group1','menuOff04','${ctx}/images/admin/menuOn_04.gif',1)"
										onMouseOver="MM_nbGroup('over','menuOff04','${ctx}/images/admin/menuOn_04.gif','',1)"
										onMouseOut="MM_nbGroup('out')"><img src="${ctx}/images/admin/menuOff_04.gif" alt="" name="menuOff04" border="0" onload=""></a></td>
																						
									<td><a href="${ctx}/adminLogList.do" target="sub"
										onClick="MM_nbGroup('down','group1','menuOff05','${ctx}/images/admin/menuOn_05.gif',1)"
										onMouseOver="MM_nbGroup('over','menuOff05','${ctx}/images/admin/menuOn_05.gif','',1)"
										onMouseOut="MM_nbGroup('out')"><img src="${ctx}/images/admin/menuOff_05.gif" alt="" name="menuOff05" border="0"	onload=""></a></td>
								</tr>
							</table></td>
					</tr>
				</table></td>
		</tr>
	<%-- <input type="hidden" id="usrid" value="${usrid}" name="${usrid}"/> --%>
		<tr>
			<td valign="top"><iframe name="sub" frameborder="0"
					height="100%" width="100%" scrolling="yes" src="${ctx}/noticeList.do?usrid=${usrid}"></iframe></td>
		</tr>
	</table>
	
	
</body>
</html>
