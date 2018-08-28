<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Error Page</title>
<script type="text/javascript">
function fn_go_back(){
	history.go(-1);
}

function fn_go_open_platform(){
	var f = document.searchForm;
	f.action= '${ctx}/main.jsp';
    f.submit();
}

//]]>
</script>
<style type="text/css">
.errer_wrap {text-align:center; background:url(${ctx}/images/error/bg_errer.gif) no-repeat 50% 0; width:625px; padding-top:120px; margin-top:95px;}
.errer_wrap p {padding:30px 0 40px; color:#999; line-height:1.5em;}
.errer_wrap p a {color:#b19716; text-decoration:underline;}
.errer_wrap .btn {border-top:1px solid #ebebeb; padding-top:40px;}

a.btn01{display:inline-block;height:30px;padding:0;background:url('${ctx}/images/error/btn01.gif') left 0;overflow:hidden;cursor:pointer;}
a.btn01 span{display:inline-block;height:30px;padding:8px 3px 0 0;background:url('${ctx}/images/error/btn01.gif') right 0;font-weight:bold;text-align:center;color:#fff;letter-spacing:-1px;cursor:pointer;}

#cont{width:760px;min-height:400px;_height:400px;margin:0 auto;}
#cont{width:760px;min-height:400px;_height:400px;margin:0 auto;}
#cont h2{margin-bottom:10px;}

span.w153{width:153px;}

</style>

</head>
<body>
<div id="wrap">
	<div id="cont">
		<form name="searchForm" action ="${ctx}/main.jsp">
		<div class="errer_wrap">
			<h2><img src="${ctx}/images/error/txt_errer02.gif" alt="" /></h2>
			<p>에러가 발생했습니다. <br />
			같은 증상이 계속해서 발생하면 관리자에게 문의하세요.
				
			</p>
			<div class="btn">
<!--				<a href="javascript:fn_go_back();" class="btn01"><span class="w153">이전 페이지로 가기</span></a>-->
				<!-- <a href="javascript:fn_go_open_platform();" class="btn01"><span class="w153">홈으로 가기</span></a> -->
			</div>
		</div>
		</form>
	</div>
</div>

<%

if(session.getAttribute("usrid")==null){
	
	
	session.invalidate();
	out.println("<script>");
	out.println("alert('세션이 만료되었습니다. 다시 접속해주세요')");
	out.println("</script>");	
	
}

%>

</body>
</html>



