<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript">
var imgPath = "";

var tree_edit = 'tree_edit';
var obj_sel = 'obj_sel';
var lay_sel = 'lay_sel';
var img_path = 'img_path';
//구간선택
function treeStart(){
	top.XDOCX.XDUISetWorkMode(21);
	
}
//구간선택 취소
function treeCancle(){
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(1);
	
}
//실행취소
function treeCancle(){
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(1);
	//top.MapControl('map_clear');
	$("#tree_hei").val("6");
	$("#tree_gap").val("8");
	$("#tree_width").val("4.5");
	$("#img_path").val("");
	document.getElementById("img_prv").style.backgroundImage="";
	
}
//실행
function treeExe(){
	if ('run'){		// 실행
		if (tree_type1){		// 경로입력식재

			if (top.XDOCX.XDUIInputPointCount() < 2) {
				alert('2개 이상의 지점을 입력하세요');
				return;
			}
			if (imgPath == "" || imgPath == '0') {
				alert('텍스쳐 이미지를 선택하세요');
				return;
			}
							
			var objkey = getCurrDate();
			top.XDOCX.XDObjCreateLineBillboard(objkey, tree_gab.value, tree_width.value, tree_hei.value, imgPath);	
			
	        top.XDOCX.XDUIClearInputPoint();    
	        top.XDOCX.XDUISetWorkMode(1);
		} 
	}
}
//이미지 찾기
function imgSearch(){
	if ('img_path'){	// shp 파일 찾기
		if (!st_img_type2) return;
		var fileName = top.XDOCX.XDUIOpenFileDlg(true, 'png,bmp,jpg,jpeg');
		if (fileName != ""){
			if (top.XDOCX.XDUIFileExist(fileName)){
				document.getElementById('img_path').value = fileName;	
				img_preview(fileName);
			}
		}
	}
}
//미리보기
function img_preview(src){
	if (!top.XDOCX.XDUIFileExist(src)) {
		alert("파일이 존재하지 않습니다.");
		return;
	}
	imgPath = src;
	//document.getElementById('img_prv').style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(preview_src='" + preview_src + "',sizingMethod=scale)";
	
	var filepath = src.replace(/\\/gi,'/');
	filepath = filepath.replace(':\\',':/');
	preview_src = "file:///"+filepath;
	document.getElementById("img_prv").style.backgroundImage="url(" + preview_src + ")";
}
</script>
</head>

<body>
	<div id="panel">
		<div id="title">
			<div id="category">
				<ul style="width: 320px;">
					<li style="float: left;">
						<a href="tree.jsp" target="left">
							<img src="${ctx}/images/btn_lib_tree_off.gif" />
						</a>
					</li>
					<li style="float: right">
						<a href="tree_add.jsp" target="left">
							<img src="${ctx}/images/btn_lib_add_on.gif" />
						</a>
					</li>
					
					<li style="padding-top: 10px; clear: both;">
						<img src="${ctx}/images/category_SIDE.gif" /> 
					</li>
					<li class="f_whit_am">가로수 구간설정</li>
					<li style="float: left;">
						<a href="#" onclick="treeStart()"><img src="${ctx}/images/btn_section.gif" width="96" height="24" /></a>
					</li>
					<li style="float: left;margin: 0px 0 0 3px;">
						<a href="#" onclick="treeCancle()"><img src="${ctx}/images/btn_move.gif" width="62" height="24" /></a>
					</li>
					<li style="padding-top: 10px; clear: both;">
						<img src="${ctx}/images/category_SIDE.gif" />
						<input type="hidden" name="tree_type" id="tree_type1"/>
						<input name="st_img_type" type="hidden" id="st_img_type2"/>
					</li>
					<li class="f_whit_am">사용자 라이브러리 추가</li>
					<li>
						<input type="text" id="img_path" name="img_path" style="width:250px" readOnly/>
						<input type="button" value="찾기" style="width:40px; height:22px; cursor:hand;" onClick="imgSearch()"/>
					</li>
					<li>
						<img src="${ctx}/images/category_SIDE1.gif" />
					</li>
				</ul>
				<fieldset style="padding:5px">
					<legend class="f_whit_am">가로수 옵션</legend>
					<ul>
						<li style="float: left;">가로수높이 
						  <input type="text" name="tree_hei" id="tree_hei" value="6.0"/> m
						</li>
						<li style="clear: both;">가로수간격 
						  <input type="text" name="tree_gab" id="tree_gab" value="8" /> m
						</li>
						<li style="clear: both; float: left;">가로수너비 
						  <input type="text" name="tree_width" id="tree_width" value="4.5" /> m
						</li>
					</ul>
				</fieldset>
				<ul>
					<li style="float: left;margin: 10px 0 10px 3px;">
						<a href="#" onclick="treeExe()"><img src="${ctx}/images/btn_add.gif" width="96" height="24" /></a>
					</li>
					<li style="float: left;margin: 10px 0 10px 3px;">
						<a href="#" onclick="treeCancle();">
							<img src="${ctx}/images/btn_analysis_cancel.gif" width="96" height="24" />
						</a>
					</li>
				</ul>
			</div>
		</div>
		<div align="center">
			<h4>
				<img src="${ctx}/images/result_title1.gif" alt="결과" width="340" height="34" />
			</h4>
			<div id="img_prv" style="height: 200px; width: 256px; background-color: #FFF; border: solid 1px #2c3444; margin: 10px; clear: both;background-repeat:no-repeat; background-position: center;"></div>
		</div>
	</div>
</body>
</html>