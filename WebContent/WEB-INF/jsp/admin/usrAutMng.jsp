<!-- 
	수원시 3차원 시스템 운영페이지 >> 권한관리 
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>권한관리</title>

<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
var totalPageNum = 0;
function fn_setTotal(tot){
	this.totalPageNum = tot; 	
}
function fn_getTotal(){
	return this.totalPageNum;
}
/**
 * ajax로 부서 이름 설정
 */
function fn_getMainDept(comId){
		
		var url =""; //요청 url
		var callBackFn = null; // 콜백 함수 설정
		
		if(comId == 'main'){ //상위부서 목록 요청
			url ="${ctx}/mainDeptList.do";
			callBackFn = fn_setMainDeptList;
		}else{ //하위부서 목록 요청
			var pDeptName = $('#mainDept').val();
		
			if(pDeptName == 'init'){ //부서 선택이 안됐을때
				fn_setSubDeptList(pDeptName);
				return false;
			}else{
				
				url ="${ctx}/subDeptList.do?deptname="+encodeURIComponent(pDeptName);
				callBackFn = fn_setSubDeptList;	
			}
		}
		$.ajax({
			type:"get",
			//asyn:true,
			timeout : 10000,
			url: url,
			dataType: "json",
			//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     alert("fn_getMainDept // code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : callBackFn
		});
		
}
/**
 * ajax로 하위부서 목록으로 사용자 리스트 조회
 */
function fn_getSubDept(){
		
		var url =""; //요청 url
		var callBackFn = null; // 콜백 함수 설정
		var pGrpId = $('#subDept').val();
	
		if(pGrpId == 'init'){ //부서 선택이 안됐을때
			return false;
		}else{
			url ="${ctx}/subDeptUsrList.do?grpid="+encodeURIComponent(pGrpId);
			
			callBackFn = function(result){
				var userList = result[0].u_list; //메인 부서에 해당하는 사용자 리스트
				
				fn_setUserList(userList);				//유저 리스트 넘겨줌
				fn_setPaging(result[0].pageIndexList);	//페이징 붙여주기
				
			};	
		}
	
		$.ajax({
			type:"get",
			//asyn:true,
			timeout : 10000,
			url: url,
			dataType: "json",
			//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     alert("fn_getSubDept //  code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : callBackFn
		});
		
}
//상위부서 설정
fn_setMainDeptList = function(result){
	
	var mainDeptOp=document.getElementById("mainDept");
	
	
	$('#mainDept').empty().data('options');
	
	/* for(var i=0;i<mainDeptOp.options.length;i++){
		mainDeptOp.options[i] = null;
	} */
	
	mainDeptOp.options[0]=new Option("::::::: 부서선택 :::::::","init");
	
	for(var i=1;i<result.length;i++)
	{
		mainDeptOp.options[i]=new Option(result[i].dept_name,result[i].dept_name);
	}
	
};

//하위부서 설정
fn_setSubDeptList = function(result){

	var subDeptOp=document.getElementById("subDept");

	if(result == 'init'){
		
		
		$('#subDept').empty().data('options');
		
		/* for(var i=0 ; i < subDeptOp.options.length+1 ; i++){ //자바스크립트로 초기화 하는게 이유모를 에러 발생해서 jqeury 초기화문으로 대체
			subDeptOp.options[i] = null;
			cnt++;
		} */
		
		
		
		subDeptOp.options[0]=new Option("::::::::: 부 서 선 택 :::::::::","init");
		
		fn_initUserList();
		
	}else{
		
		var subDeptList = result[0].n_list; //서브 부서 리스트
		var userList = result[0].u_list; //메인 부서에 해당하는 사용자 리스트
		
		fn_setUserList(userList);				//유저 리스트 넘겨줌
		fn_setPaging(result[0].pageIndexList);	//페이징 붙여주기
		fn_setTotal(result[0].totalNum);
		
		for(var i=0;i<subDeptOp.options.length;i++){ //옵션 초기화
			subDeptOp.options[i] = null;
		}
		
		subDeptOp.options[0]=new Option("::::::::: 부 서 선 택 :::::::::","init"); //첫번째 옵션에 부서선택 넣어주기
		var namePaser = "";
		for(var i=1;i<subDeptList.length;i++) //부서 옵션 셋팅
		{
			namePaser = subDeptList[i].dept_name;
			
			if(namePaser.length > 13){
				namePaser = namePaser.substring(0,13) + "..";
			} 
			subDeptOp.options[i]=new Option(namePaser,subDeptList[i].dept_grpid);
		}
	}
	
};
//사용자 리스트 초기화 
fn_initUserList = function(){
	$('#userListTBody').empty();
	$('#pageSpan').empty();
};
//사용라 리스트 붙여넣기 
fn_setUserList = function(result){
	
	fn_initUserList();
	
	var autOptionList = fn_getVarUstList(); //권한 리스트 가져오기
	
	
	
	var listStr = "";
	var deptNamePaser = null;
	var mDeptName = "";
	var sDeptName = "";
	var aut_des = "";
	for(var i=0; i < result.length;i++){
		//부서명 파싱
		mDeptName = result[i].maindept;
		
		deptNamePaser = mDeptName.indexOf('.');
		
		sDeptName = mDeptName.substring(deptNamePaser+1,mDeptName.length);
		
		aut_des = result[i].aut_des;
		
		//메인 부서명
		if( deptNamePaser >- 1){
			mDeptName = mDeptName.substring(0,deptNamePaser);	
		}
		
		
		//하위부서명
		if(sDeptName != null || sDeptName != ""){
			deptNamePaser = sDeptName.indexOf('.');
			
			if( deptNamePaser >- 1){
				sDeptName = sDeptName.replace('.',' > ');	
			}
		}else{
			sDeptName = mDeptName;
		}
		
		//표에 추가할 hmtl 정의
		listStr += '<TR align="center">'
				+'<TD>'+result[i].usrname+'</TD>'
				+'<TD>'+mDeptName+'</TD>'
				+'<TD>'+sDeptName+'</TD>'
				+'<TD><select id="'+result[i].usrid+'">';
				
				for(var j = 0; j < autOptionList.length ; j++){
					
					if(aut_des==autOptionList[j].aut_des){
						listStr += '<option value="'+autOptionList[j].aut_cde+'" selected>'+autOptionList[j].aut_des+'</option>';
					}else{
						listStr += '<option value="'+autOptionList[j].aut_cde+'">'+autOptionList[j].aut_des+'</option>';	
					}
					
				}
				
		listStr +='</select></TD><TD><a href="javascript:fn_modifyAut(\''+result[i].usrid+'\')"><img src="${ctx}/images/admin/btn_mod.gif" width="48" height="20" style="cursor:pointer"></a>'
					+'</TD>'
					+'</TR>';
	}
	
	$('#userListTBody').append(listStr);
	
};
//페이징 붙여넣기 
function fn_setPaging(pageHtml){
	$('#pageSpan').html(pageHtml);
}
/**
 * 페이지 클릭했을때 실행되는 함수 
 */
function fn_goPage(grpIds){
	
	var url =""; //요청 url
	
	var callBackFn = null; // 콜백 함수 설정
	
	url ="${ctx}/mainUsrAutList.do?grpid="+grpIds+"&page="+fn_getPage()+"&totalpage="+fn_getTotal();
	
	callBackFn = function(result){
		var userList = result[0].u_list; //메인 부서에 해당하는 사용자 리스트
		fn_setTotal(result[0].totalNum); //총수 셋틍
		fn_setUserList(userList);				//유저 리스트 넘겨줌
		fn_setPaging(result[0].pageIndexList);	//페이징 붙여주기
	};	
	
	$.ajax({
		type:"get",
		//asyn:true,
		timeout : 10000,
		url: url,
		dataType: "json",
		//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("fn_goPage code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : callBackFn
	});
	
}

var curPage = 1;
//현제 패이지 설정
function fn_setPage(page){
	this.curPage = 	page;
}
//현제 패이지 설정
function fn_getPage(page){
	return this.curPage;
}
//이름으로 검색 하는 함수
function fn_nameSearch(){
	var url =""; //요청 url
	
	var callBackFn = null; // 콜백 함수 설정
	
	url ="${ctx}/mainUsrAutList.do?usrname="+encodeURIComponent($('#searchUsrName').val())+"&totalpage=0";
	
	callBackFn = function(result){
		var userList = result[0].u_list; //메인 부서에 해당하는 사용자 리스트
		fn_setUserList(userList);				//유저 리스트 넘겨줌
	};	
	
	$.ajax({
		type:"get",
		//asyn:true,
		timeout : 10000,
		url: url,
		dataType: "json",
		//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("fn_nameSearch // code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : callBackFn
	});
	
}
//엔터 쳐서 검색
function keypress() { // 엔터로 검색 할 수 있게 이벤트 
	var kcode; 
	
	kcode = window.event.keyCode; 
	
	if(kcode==13){ //엔터 
		fn_nameSearch(); 
	} 
}

//권한 목록 리스트
var autList = null;

function fn_setVarUstList(auts){
	this.autList = auts;
};

function fn_getVarUstList(){
	return this.autList;
};
//권한 목록 리스트 조회
function fn_getAutList(){
	var url =""; //요청 url
	
	var callBackFn = null; // 콜백 함수 설정
	
	url ="${ctx}/getAutLIst.do";
	
	callBackFn = function(result){ //콜백 함수 설정
		fn_setVarUstList(result); 
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
//권한 수정 하는 함수 
function fn_modifyAut(id){
	var url =""; //요청 url
	
	var callBackFn = null; // 콜백 함수 설정
	var pAutCde = $('#'+id).val();
	//alert(pAutCde + " // " + id);
	
	url ="${ctx}/modifyUsrAut.do?usrid="+id+"&autcde="+pAutCde;
		
	callBackFn = function(result){
		if(result.resultCode ="S"){
			alert("수정되었습니다.");
		}else{
			alert("수정에 실패하였습니다.");
		}
	};	
	
	$.ajax({
		type:"get",
		//asyn:true,
		timeout : 10000,
		url: url,
		dataType: "json",
		//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("fn_modifyAut code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : callBackFn
	});
}


function showAutUsr(){
	
	var aut = $("#aut").val();
	
	if(aut=="SYS001" || aut=="SYS002" || aut=="SYS003"){
		
		var url =""; //요청 url
		
		var callBackFn = null; // 콜백 함수 설정
		url=  "${ctx}/showAutUser.do?aut="+aut;
		alert(url);
		
		callBackFn = function(result){
			var userList = result[0].u_list; //메인 부서에 해당하는 사용자 리스트
			fn_setUserList(userList);				//유저 리스트 넘겨줌
			alert(userList);
		};	
		
		$.ajax({
			type:"get",
			//asyn:true,
			timeout : 10000,
			url: url,
			dataType: "json",
			//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     alert("fn_nameSearch // code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : callBackFn
		});
		
		
		
		
		
		
		
		
		
	}
	

	
	
	
}
</script>
</head>

<body onload="fn_getMainDept('main');fn_getAutList();">
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
						<td width="74">&nbsp;</td>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="3"><img src="${ctx}/images/admin/tap_01_on.gif" width="118" height="33">&nbsp;
									<a href="${ctx}/menuAutMng.do"><img src="${ctx}/images/admin/tap_02.gif" alt="메뉴관리" width="118" height="33"></a></td>
					</tr>
					<tr>
						<td colspan="3"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">상위부서선택</td>
						<td colspan="2"><SELECT id="mainDept" name="mainDept" onchange="fn_getMainDept('sub')" style="align:center;text-align:center">
								<option>::::::: 부서선택 :::::::</option>
						</SELECT></td>
					</tr>
					<tr>
						<td height="35">하위부서선택</td>
						<td colspan="2"><SELECT id="subDept" name="subDept" onchange='fn_getSubDept()'>
								<option>::::::: 부서선택 :::::::</option>
						</SELECT></td>
					</tr>
					<tr>
						<td colspan="3"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="36" colspan="3" class="f_orange">부서를 선택하면 해당 부서에
							속한&#13;<br> 사용자들이 우측 화면에 나타납니다.&#13;
						</td>
					</tr>
					<tr>
						<td colspan="3"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">사용자명</td>
						<td width="90"><label for="textfield"></label> <input
							type="text" name="searchUsrName" id="searchUsrName" style="width: 80px;" onkeypress="keypress()"></td>
						<td width="80"><img src="${ctx}/images/admin/search.gif" alt="" onclick="fn_nameSearch()" width="48" height="20" style="cursor:pointer"></td>
					</tr>
					<tr>
						<td colspan="3"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">권한별 보기</td>
						<td colspan="2">
						<SELECT id="aut" onchange='showAutUsr()'>
								<option>::::::: 권한선택 :::::::</option>
								<option value="SYS003">일반사용자</option>
								<option value="SYS002">상하수도사용자</option>
								<option value="SYS001">관리자</option>
								</SELECT>		
						
						
						</td>
					</tr>
				</table></td>
			<td style="background-image: url(${ctx}/images/admin/side_bg.gif)">&nbsp;</td>
			<td valign="top" bgcolor="#FFFFFF"><table width="200" border="0"
					cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div class="bbsCont">
					<table align="center" class="wps_90" summary="목록">
						<colgroup>
							<col class="w_100" />
							<col class="w_200" />
							<col class="w_200" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">사용자명</th>
								<th scope="col">상위부서</th>
								<th scope="col">하위부서</th>
								<th scope="col">권한</th>
								<th scope="col">수정</th>
							</tr>
						</thead>
						<tbody id="userListTBody">
						<tr>
							<td colspan="5" style="text-align:center; align:center">부서를 선택 하세요</td>
						</tr>
						</tbody>
					</table>
				</div>
				<br />
				<div align="center">
					<span style="font-size: 12px;height:40px" id="pageSpan"></span>
				</div>
			 <!-- 컨텐츠 끝 --></td>
			<td style="background-image: url(${ctx}/images/admin/right_bg.gif)">&nbsp;</td>
		</tr>
		<tr style="background-image: url(${ctx}/images/admin/end_bg.gif)">
			<td height="10"><img src="${ctx}/images/admin/end_left.gif" alt=""
				width="14" height="10"></td>
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

