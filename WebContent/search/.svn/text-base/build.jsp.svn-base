<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ko" xml:lang="ko">
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script type="text/javascript">
function jibunSearch(){
	frm.action = '${ctx}/buildSearch.do';
	frm.target = 'searchList';
	frm.submit();
}
function fnc_input_number(){
	   var e = event.keyCode;
	   window.status = e;
	   if (e>=48 && e<=57) return;
	   if (e>=96 && e<=105) return;
	   if (e>=37 && e<=40) return;
	   if (e==8 || e==9 || e==13 || e==46 || e==229) return;//229는 한글
	   event.returnValue = true;
}
</script>
</head>

<body>
	<form id="frm" action="" method="post">
		<div id="panel" class="panel_main">
			<div id="title">
				<div id="category">
					<ul>
						<li><label style="margin-top:5px;" >건물검색</label>
							<input type="text" name="build_name"
								id="build_name"  onkeydown="fnc_input_number()" style="padding-left:5px; width:110px; height:20px; ime-mode:active;" />
							&nbsp;
								 <input
								type="image" src="../images/btn_search.gif" align="absmiddle"
								onclick="jibunSearch()" /></li>
					</ul>
				</div>
			</div>
			<div>
				<h4>
					<img src="../images/result_title.gif" alt="결과" width="340"
						height="34" />
				</h4>
					<iframe id="searchList" name="searchList" src="${ctx}/blinkBuList.do" frameborder="0" width="320px" style="height:100%; min-height: 500px; max-height: 700px;" scrolling="no" />
			</div>
		</div>

	</form>


</body>
</html>
