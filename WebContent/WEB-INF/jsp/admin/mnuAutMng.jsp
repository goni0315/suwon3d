<!-- 
	관리자 > 메뉴권한관리
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript">
//권한 목록 리스트
var autList = null;

function fn_setAUstList(auts){
	var autOp = document.getElementById("Op_autList");
	
	$('#Op_autList').empty().data('options');
	
	autOp.options[0]=new Option("::::::::::::  권한  ::::::::::::","init");
	
	for(var i=0;i<auts.length;i++)
	{
		autOp.options[i+1]=new Option(auts[i].aut_des,auts[i].aut_cde);
	}
	
};

//권한 목록 리스트 조회
function fn_getAutList(){
	var url =""; //요청 url
	
	var callBackFn = null; // 콜백 함수 설정
	
	url ="${ctx}/getAutLIst.do";
	
	callBackFn = function(result){ //콜백 함수 설정
		fn_setAUstList(result); 
		//alert(autList[0].aut_cde);
	};	
	
	$.ajax({
		type:"get",
		//asyn:true,
		timeout : 10000,
		url: url,
		dataType: "json",
		//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("fn_getAutList // code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : callBackFn
	});
}
//db에서 메뉴 리스트 조회
function fn_getMenuList(autcde){
	var url =""; //요청 url
	
	var callBackFn = null; // 콜백 함수 설정
	
	url ="${ctx}/getMenuList.do?autcde="+autcde;
	
	callBackFn = function(result){ //콜백 함수 설정
		fn_setMenuList(result); 
		//alert(autList[0].aut_cde);
	};	
	
	$.ajax({
		type:"get",
		//asyn:true,
		timeout : 10000,
		url: url,
		dataType: "json",
		//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("fn_getMenuList // code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : callBackFn
	});
}

//현재 권한이 가지고 있는 메뉴 리스트 
var var_MyMneuList = null;

function fn_setvarMyMneuList(list){
	this.var_MyMneuList = list;
	
}
function fn_getvarMyMneuList(){
	return this.var_MyMneuList;
}
//전체 메뉴 리스트 셋팅
fn_setMenuList = function(result){
	
	var allMenuOp = document.getElementById("allMenu");
	var myMenuOp = document.getElementById("myMenu");
	
	$('#allMenu').empty().data('options');
	$('#myMenu').empty().data('options');
	
	
	
	var varAllMenuList = result[0].allm_list;
	
	fn_setvarMyMneuList(result[0].mym_list);
	
	var varMyMneuList = fn_getvarMyMneuList();
	
	
	
	var aCnt = 0;

	var menuFlag = true;	
	//전체 메뉴 리스트중 이미 권한을 가지고 있는 메뉴는 제외
	for(var i=0; i < varAllMenuList.length ; i++)
	{
		menuFlag = true;
		
		for(var j=0; j < varMyMneuList.length ; j++){
			if(varAllMenuList[i].mnu_id == varMyMneuList[j].mnu_id){
				menuFlag = false;
			}
		}
		
		if(menuFlag){
			allMenuOp.options[aCnt]=new Option(varAllMenuList[i].mnu_nam,varAllMenuList[i].mnu_id);
			aCnt++;
		}
		
	}
	//권한을 가지고 있는 목록만 표시
	for(var j=0; j < varMyMneuList.length ; j++){
		myMenuOp.options[j]=new Option(varMyMneuList[j].mnu_nam,varMyMneuList[j].mnu_id);
	}
}

//left to right
function addCom(){
	var left_list	= document.getElementById("allMenu");
	var right_list	= document.getElementById("myMenu");
	 
    var str  		= new Array();
    var str2 		= new Array();
    var str3 		= new Array();
    var idx 		= 0;
    
  	for( var i=0; i<right_list.options.length; i++ ){
  		if( right_list.options[i].selected==true ){
  			str[idx]  = right_list.options[i].value; //값
  			str2[idx] = right_list.options[i].innerText; //텍스트 
  			str3[idx] = right_list.options[i].index; //삭제를 위한 인덱스 
  			idx++;
  		}
  	}  	
  	
  	for( var i=0;i< str3.length;i++ ){
  		right_list.remove(str3[i]-i);
  	}
  			
  	if( left_list.length==0 ) {
	  	for( i=0; i<str.length; i++ ) {
	  		left_list.options[i] = new Option(str2[i],str[i]);
	  	}
  	}else if( left_list.length>0 ) {
  		for( i=0; i<str.length;i++ ) {
  			left_list.options[left_list.length] = new Option(str2[i],str[i]);
	  	}
  	}
}

//left to right
function delCom(){
	var left_list	= document.getElementById("allMenu");
	var right_list	= document.getElementById("myMenu");
	 
    var str  		= new Array();
    var str2 		= new Array();
    var str3 		= new Array();
    var idx 		= 0;
    
  	for( var i=0; i<left_list.options.length; i++ ){
  		if( left_list.options[i].selected==true ){
  			str[idx]  = left_list.options[i].value;
  			str2[idx] = left_list.options[i].innerText;
  			str3[idx] = left_list.options[i].index;
  			idx++;
  		}
  	}  	
  	
  	for( var i=0;i< str3.length;i++ ){
  		left_list.remove(str3[i]-i);
  	}
  			
  	if( right_list.length==0 ) {
	  	for( i=0; i<str.length; i++ ) {
	  		right_list.options[i] = new Option(str2[i],str[i]);
	  	}
  	}else if( right_list.length>0 ) {
  		for( i=0; i<str.length;i++ ) {
	  		right_list.options[right_list.length] = new Option(str2[i],str[i]);
	  	}
  	}
}
function fn_makeMenuParam(){
	var right_list	= document.getElementById("myMenu");
	var varMyMneuList = fn_getvarMyMneuList();
	
	var addM = "";
	
	for( var i=0; i<right_list.options.length; i++ ){ 
		addM  += right_list.options[i].value+",";
  	}
	
	//권한을 가지고 있는 목록만 표시
	var jMenuId ="";
	var myMenuStr="";
	
	for(var j=0; j < varMyMneuList.length ; j++){
		
		jMenuId = varMyMneuList[j].mnu_id;
		myMenuStr += jMenuId+",";
		if(addM.indexOf(jMenuId) > -1){
			addM = addM.replace(jMenuId+",","");
		}
	}
	
	for(var i=0; i < right_list.options.length; i++){
		jMenuId = right_list.options[i].value;
		if(myMenuStr.indexOf(jMenuId) > -1){
			myMenuStr = myMenuStr.replace(jMenuId+",","");
		}
	} 
	
	addM = addM.substring(0,addM.length-1);
	
	myMenuStr = myMenuStr.substring(0,myMenuStr.length-1);
	
	var retrunArr = new Array(addM,myMenuStr);
	
	return retrunArr;
}
//메뉴 권한 수정
function fn_updateMenuAut(){
	var url =""; //요청 url
	
	var callBackFn = null; // 콜백 함수 설정
	
	var autcde =$('#Op_autList').val(); 
	if(autcde == 'SYS001'){
		alert("관리자 권한은 변경할 수 없습니다.");
		return false;
		
	}
	var params = fn_makeMenuParam();
	
	if(params[0].length==0 && params[1].length==0 ){
		alert("수정사항이 없습니다.");
		return false;
	};
	
	
	url ="${ctx}/setMenuAut.do?autcde="+autcde+"&addlist="+params[0]+"&removelist="+params[1];
	
	callBackFn = function(result){ //콜백 함수 설정
		if(result.resultCode ="S"){
			alert("수정되었습니다.");
		}else{
			alert("수정에 실패하였습니다.");
		}
		//alert(autList[0].aut_cde);
	};	
	
	$.ajax({
		type:"get",
		//asyn:true,
		timeout : 10000,
		url: url,
		dataType: "json",
		//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("fn_getAutList // code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : callBackFn
	});
}
</script>
</head>

<body onload="fn_getAutList()">
	<table width="100%" height="100%" border="0" cellspacing="0"
		cellpadding="0"
		style="background-image: url(${ctx}/images/admin/title_bg.gif); height: 100%">
		<tr>
			<td width="14" height="35"><img
				src="${ctx}/images/admin/title_left.gif" alt="" width="14" height="35"></td>
			<td width="253" align="center"><img
				src="${ctx}/images/admin/title3.gif" alt="" width="82" height="35"></td>
			<td width="11"><img src="${ctx}/images/admin/title_side.gif" alt=""
				width="11" height="35"></td>
			<td>&nbsp;</td>
			<td width="14"><img src="${ctx}/images/admin/title_right.gif" alt=""
				width="14" height="35"></td>
		</tr>
		<tr>
			<td style="background-image: url(${ctx}/images/admin/left_bg.gif)"></td>
			<td align="center" valign="top" bgcolor="#FFFFFF"><table
					width="244" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="63">&nbsp;</td>
						<td width="181">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2"><a href="${ctx}/usrAutList.do?chk=1">
											<img src="${ctx}/images/admin/tap_01.gif" width="118" height="33">
										</a>&nbsp;<img src="${ctx}/images/admin/tap_02_on.gif"alt="" width="118" height="33">
						</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35"> 권한선택 </td>
						<td><SELECT id="Op_autList" name="Op_autList" onchange="fn_getMenuList(this.value)">
								<option>::::::::::::  권한  ::::::::::::</option>
						</SELECT></td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td colspan="2"><p class="f_orange">.&#13;</p></td>
					</tr>
					<tr>
						<td height="35">&nbsp;</td>
						<td align="right">&nbsp;</td>
					</tr>
				</table></td>
			<td style="background-image: url(${ctx}/images/admin/side_bg.gif)">&nbsp;</td>
			<td valign="top" bgcolor="#FFFFFF"><table width="200" border="0"
					cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div>
					<table border="0" align="center" cellpadding="0" cellspacing="0">
						<tr>
							<td width="203" class="f_blue_b">전체메뉴</td>
							<td width="31">&nbsp;</td>
							<td width="199" class="f_blue_b">추가메뉴</td>
						</tr>
						<tr>
							<td class="f_blue_b">&nbsp;</td>
							<td>&nbsp;</td>
							<td class="f_orange">선택한 권한이 소유하고 있는 메뉴입니다.</td>
						</tr>
						<tr>
							<td rowspan="4"><label> <select name="allMenu" size="15" multiple id="allMenu" style="width: 250px;height:245px">
									<option>권한을 선택하세요</option>
								</select>
							</label></td>
							<td><img src="${ctx}/images/admin/side1.gif" width="31" height="88"></td>
							<td rowspan="4"><select name="myMenu" size="15" multiple id="myMenu" style="width: 250px;height:245px">
							</select></td>
						</tr>
						<tr>
							<td><img src="${ctx}/images/admin/side_b2.gif" alt="" width="31"
								height="33" onclick="delCom()" style="cursor:pointer"></td>
						</tr>
						<tr>
							<td><img src="${ctx}/images/admin/side_b1.gif" alt="" width="31"
								height="33" onclick="addCom()" style="cursor:pointer"></td>
						</tr>
						<tr>
							<td height="95"><img src="${ctx}/images/admin/side2.gif" alt=""
								width="31" height="95"></td>
						</tr>
					</table>
				</div>
				<div class="bbsCont"></div>
				<div id="bbsBottom">
					<ul id="bbsPaging">
						<li></li>
						<img src="${ctx}/images/admin/btn_ok.gif" width="48" height="20" onclick="fn_updateMenuAut()" sytle="cursor:pointer">&nbsp;
					</ul>
				</div> <!-- 컨텐츠 끝 --></td>
			<td style="background-image: url(${ctx}/images/admin/right_bg.gif)">&nbsp;</td>
		</tr>
		<tr style="background-image: url(${ctx}/images/admin/end_bg.gif)">
			<td height="10"><img src="${ctx}/images/admin/end_left.gif" alt=""
				width="14" height="10" ></td>
			<td align="center"></td>
			<td><img src="${ctx}/images/admin/end_side.gif" alt="" width="11"
				height="10"></td>
			<td></td>
			<td><img src="${ctx}/images/admin/end_right.gif" alt="" width="14"
				height="10"></td>
		</tr>
	</table>
</body>
</html>


