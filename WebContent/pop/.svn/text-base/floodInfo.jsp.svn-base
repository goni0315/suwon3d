<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<title>침수 팝업창</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<style type="text/css">

</style>
<script type="text/javascript">
function closeWin()
{
   self.close();     
} 
</script>
</head>
<body>
	<div style="width: 400px; height:250px; border: solid 1px #2c3445;">
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				<a href='#' onclick='closeWin()'><img src="${ctx}/images/pop_close.gif" /></a>
			</p>
		  <p class="f_whit_am">침수지역 정보 조회</p>
		</div>
		<div class="bbsCont">
			<table border="1" class="wps_100">
			<c:if test="${not empty floodInfoPopUpList}">
            <c:forEach var="sms" items="${floodInfoPopUpList}">
				<tr>
					<th width="85">침수지구</th>
					<th width="89">&nbsp;</th>
					<th width="62">${sms.flo_loc}</th>
					<th width="96">&nbsp;</th>
				</tr>            
<%-- 				<tr>
					<th class="bbsFrom">침수지구 </th>
					<td colspan="3">${sms.flo_loc}</td>
				</tr> --%>
				<tr>
					<th class="bbsFrom">침수년도</th>
					<td>${sms.flo_year}</td>
					<th class="bbsFrom" >피해면적</th>
					<td >${sms.dmg_are}</td>
				</tr>
				<tr>
					<th class="bbsFrom">침수시작일</th>
					<td>${sms.str_year}</td>
					<th class="bbsFrom">침수종료</th>
					<td>${sms.end_year}</td>
				</tr>
				<tr>
					<th class="bbsFrom">침수시간</th>
					<td>${sms.flo_hour}</td>
					<th class="bbsFrom">침수형태</th>					
					<td>${sms.flo_sot}</td>
			  </tr>
				<tr>
					<th class="bbsFrom">재해명</th>
					<td colspan="3">${sms.dmg_nm}</td>
					
			  </tr>
				<tr>

					<th class="bbsFrom" >침수원인상세</th>
					<td colspan="3">${sms.flo_cau}</td>						
			  </tr>
			  </c:forEach>
			  </c:if>			  
			</table>
		</div>
	</div>
	<!--침수상세-->
<!--  	<div style="width: 500px; height: 250px; border: solid 1px #2c3445;">
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				<img src="../images/pop_close.gif" />
			</p>
			<p class="f_whit_am">침수 상세정보</p>
		</div>
		<div class="bbsCont">
			<table width="400" border="1" class="wps_100">
				<tr>
					<th width="115">침수지구</th>
					<th width="219">고색1지구</th>
				</tr>
				<tr>
					<th class="bbsFrom">침수년도</th>
					<td>2012년</td>
					<th class="bbsFrom">피해면적</th>
					<td>143,461</td>					
				</tr>
				<tr>
					<th class="bbsFrom">침수시작월일</th>
					<td>20120705</td>
					<th class="bbsFrom">침수종료일</th>
					<td>20120706</td>
				</tr>
				<tr>
					<th class="bbsFrom">침수시간</th>
					<td>8시간</td>
				</tr>
				<tr>
					<th class="bbsFrom">재해명</th>
					<td>2012년 국지성 집중호우</td>
				</tr>
				<tr>
					<th class="bbsFrom">침수원인상세</th>
					<td>집중호우에 의한 하천 범람</td>
				</tr>												
				<tr>
					<th class="bbsFrom">침수형태</th>
					<td>집중호우</td>
				</tr>
			</table>
		</div>
	</div> -->

</body>
</html>