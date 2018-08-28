<!-- 
	수원시 3차원 활용시스템 메인 >> 검색기능 >> 도로명검색 결과 페이지 >> 상세정보 팝업
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>상세정보</title>
<style type="text/css">
<!--
#apDiv1 {
	position: absolute;
	width: 200px;
	height: 115px;
	z-index: 1;
}
-->
</style>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript">
	function adjustSize(){
		self.resizeTo(270,$('#mainTable').height()+65);
	}
	function initInfo() {
		//(tle,desc,addr,raddr,tele,lin)
		var info = opener.getDetailInfo();
		if (info != null) {
			//$('span').empty();
			$('#title').text(info[0]); //이름
			
			if(info[1]==""||info[1]==null){ //설명
				$('#description').text('설명없음');
			}else{
				$('#description').text(info[1]);
			}
			
			
			if(info[2]==""||info[2]==null){ //지번주소
				$('#addr').text('정보미존재');
			}else{
				$('#addr').text(info[2]);	
			}
			
			if(info[3]==""||info[3]==null){ //도로명주소
				$('#raddr').text('정보미존재');
			}else{
				$('#raddr').text(info[3]);	
			}
			
			if(info[4]==""||info[4]==null){ //전화번호
				$('#phone').text('정보미존재');
			}else{
				$('#phone').text(info[4]);	
			}
			
			if(info[5]==""||info[5]==null){ //홈페이지
				//$('#hometext').text('홈페이지없음');
				$('#thirdtd').css("height","0");
				
				$('#linkDiv').attr("style","display:none");
				
				
				//$('#homeank').attr("style","cursor:default");
				//$('#homeank').attr("target","_self");
			}else{
				$('#thirdtd').css("height","1");
				$('#linkDiv').attr("style","display:block");
				//$('#hometext').text('홈페이지바로가기');
				$('#homeank').attr("style","cursor:hand");
				$('#homeank').attr("target","_blank");
				$('#homeank').attr("href",info[5]);	
			}
		}
		adjustSize();
	}
	
</script>
</head>

<body onload="initInfo()" style="margin:0 0 0 0;">
	<table width="250" border="0" cellpadding="0" cellspacing="0" id="mainTable">
		<tr>
			<td height="28" style="background: url(${ctx}/images/common/pop_top.gif)">
				<table width="250" height="23" border="0">
					<tr>
						<td width="235" class="f_whit_am">
						<div id="title" style='margin-left:15px;margin-bottom:2px;text-align:left;text-overflow:ellipsis;width:195px;overflow:hidden;white-space:nowrap;'>조회중..</div>
						</td>
						<td width="15" align="left"><img
							src="${ctx}/images/common/pop_close.gif" width="22" height="22" onclick="javascript:self.close();" style="cursor:hand" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr  valign="top">
			<td height="190" align="left"
				style="background: url(${ctx}/images/common/pop_bg.gif)">
				<table width="238" border="1" cellspacing="0" cellpadding="0" style="position:relative;left:3px">
					<tr>
						<td><span id="description" style="position:relative;float:left">조회중..</span></td>
					</tr>
					<tr bgcolor="#CACACA">
						<td height="1"></td>
					</tr>
					<tr>
						<td height="4"></td>
					</tr>
					<tr>
						<td class="f_bluish"><b><span style="position:relative;float:left;">도로명 주소</span></b></td>
					</tr>
					<tr>
						<td><span class="f_gray" id="raddr" style="position:relative;float:left">조회중..</span></td>
					</tr>
					<tr bgcolor="#CACACA">
						<td height="1"></td>
					</tr>
					<tr>
						<td height="4"></td>
					</tr>
					<tr>
						<td class="f_bluish"><b><span style="position:relative;float:left;">지번 주소</span></b></td>
					</tr>
					<tr>
						<td><span class="f_gray" id="addr" style="position:relative;float:left">조회중..</span></td>
					</tr>
					<tr bgcolor=#CACACA>
						<td height="1"></td>
					</tr>
					<tr>
						<td height="4"></td>
					</tr>
					<tr>
						<td class="f_orange_b"><b><span style="position:relative;float:left">전화번호</span></b></td>
					</tr>
					<tr>
						<td>
							<span class=f_gray id="phone" style="position:relative;float:left">조회중..</span><br />
						</td>
					</tr>
					<tr bgcolor="#CACACA">
						<td height="1" id="thirdtd"></td>
					</tr>
					<tr>
						<td height="4"></td>
					</tr>
					<!-- <tr>
						<td>
							<div id="linkDiv" style="display:none">
							<a href="#" target="_self" id="homeank" style="cursor:default">
								<b><span style="position:relative;float:left" id="hometext">홈페이지</span></b>
							</a>
							</div>
						</td>
					</tr> -->
					<tr>
						<td>
						<div id="linkDiv" style="display:block" >
						홈페이지							
							<a href="#" target="_self" id="homeank" >
								<img src="${ctx}/images/common/btn_go.gif" width="23" height="13" alt="홈페이지바로가기"/>
							</a>
						</div>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height='5px;'><img src="${ctx}/images/common/pop_bottom.gif" width="250" height="5" />
			</td>
		</tr>
	</table>
</body>
</html>
