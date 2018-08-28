<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>

<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript">
var left="left";
var north="north";
var south="south";
var right="right";
var up="up";
var down="down";
var angle = 5;
var dist = 5;		
var m_ox, m_oy, m_oz = 0.0;
var obj_move_horizon='obj_move_horizon';
var obj_move_vertical='obj_move_vertical';
var obj_rotate='obj_rotate';
//객체 선택
function choose(){ 
	top.XDOCX.XDUISetWorkMode(6);
}
//다각선택
function selfChoose(){ 
	top.XDOCX.XDUISetWorkMode(11);
}
//선택취소
function chooseCancel(){ 
	top.XDOCX.XDSelClear();
	top.XDOCX.XDUISetWorkMode(1);
}
//수평이동
function widthMove(){ 
	top.XDOCX.XDUISetWorkMode(41);
}
//수직이동
function highMove(){ 
	top.XDOCX.XDUISetWorkMode(42);
}
//회전
function turnMove(){ 
	if (top.XDOCX.XDSelGetCount() < 1) {
		alert('객체를 선택하세요');
		return;
	}		
	top.XDOCX.XDUISetWorkMode(43);
	
}
//이동
function objMove(mode){
	if (sel_layer.value == ""){	
		if(top.XDOCX.XDSelGetCount() < 1) {
			alert("선택된 객체가 없습니다.");    
			return ;
		}
		for(var i = 0; i < top.XDOCX.XDSelGetCount(); i++) {
			var info = top.XDOCX.XDSelGetCode(i);
			info = info.split("#");

			if (!getObjectCenterPoint(info[0], info[1], false, 0)) return;

			var value = parseInt(dist);
			if (mode == "left"){		// 위치이동_수평
				top.XDOCX.XDObjMove(info[0], info[1], m_ox-value, m_oy, m_oz, true);
			}else if (mode == "north"){		// 회전		
				top.XDOCX.XDObjMove(info[0], info[1], m_ox, m_oy, m_oz+value, true);
			}else if (mode == "south"){		// 선택		
				top.XDOCX.XDObjMove(info[0], info[1], m_ox, m_oy, m_oz-value, true);
			}else if (mode == "right"){		// 위치이동_수직
				top.XDOCX.XDObjMove(info[0], info[1], m_ox+value, m_oy, m_oz, true);
			}else if (mode == "up"){		// 초기화		
				top.XDOCX.XDObjMove(info[0], info[1], m_ox, m_oy+value, m_oz, true);
			}else if (mode == "down"){		// 초기화			
				top.XDOCX.XDObjMove(info[0], info[1], m_ox, m_oy-value, m_oz, true);
			}
		}

	}else{
		var ln = sel_layer.value;
		
		if (top.XDOCX.XDLayGetObjectCount(ln) > 0 ){
			for (var i = 0; i < top.XDOCX.XDLayGetObjectCount(ln); i++){
				var key = top.XDOCX.XDLayGetObjectKey(ln, i);
				
				if (!getObjectCenterPoint(ln, key, false, 0)) return;
			
				var value = parseInt(dist);
				if (mode == "left"){		// 위치이동_수평
					top.XDOCX.XDObjMove(ln, key, m_ox-value, m_oy, m_oz, true);
				}else if (mode == "north"){		// 회전		
					top.XDOCX.XDObjMove(ln, key, m_ox, m_oy, m_oz+value, true);
				}else if (mode == "south"){		// 선택		
					top.XDOCX.XDObjMove(ln, key, m_ox, m_oy, m_oz-value, true);
				}else if (mode == "right"){		// 위치이동_수직
					top.XDOCX.XDObjMove(ln, key, m_ox+value, m_oy, m_oz, true);
				}else if (mode == "up"){		// 초기화		
					top.XDOCX.XDObjMove(ln, key, m_ox, m_oy+value, m_oz, true);
				}else if (mode == "down"){		// 초기화			
					top.XDOCX.XDObjMove(ln, key, m_ox, m_oy-value, m_oz, true);
				}		
			}			
		}else{
			alert("레이어 내에 객체가 없습니다.");    
			return ;
		}
	}
	top.XDOCX.XDMapRender();
}
//회전방향설정
function objRotate(value,course){
	if (sel_layer.value == ""){
		
		if(top.XDOCX.XDSelGetCount() < 1) {
			alert("선택된 객체가 없습니다.");    
			return ;
		}
		for(var i = 0; i < top.XDOCX.XDSelGetCount(); i++) {
			var info = top.XDOCX.XDSelGetCode(i);
			info = info.split("#");
			
			if(value != 0){
				top.XDOCX.XDObjSetRotate(info[0], info[1], 1, value);
			}else{
				if(course == 'right'){
					//오른쪽
					var angle1 = angle - (angle * 2);
					top.XDOCX.XDObjSetRotate(info[0], info[1], 1, angle1);
				}else if(course == 'left'){
					//왼쪽
					top.XDOCX.XDObjSetRotate(info[0], info[1], 1, angle);
				}
			}
		}		
	}	
	top.XDOCX.XDMapRender();
}

function getObjectCenterPoint(lName, key, by, h) {
	var temp, pa;
	temp = top.XDOCX.XDObjGetBox(lName, key);
	if(temp=="") {
		alert(false);
		return false;
	}
	
	pa = temp.split(",");
	m_ox = eval(pa[0]) + (eval(pa[3]) - eval(pa[0]))/2;
	if (by == true) {
		m_oy = h;
	} else {
		m_oy = eval(pa[1]);
	}
	m_oz = eval(pa[2]) + (eval(pa[5])-eval(pa[2]))/2;
	
	return true;
}
</script>
</head>

<body style="background: url(${ctx}/images/category_bg1.gif)">
	<div id="panel">
		<div id="title">
			<div id="category1">
				<ul style="width: 320px;">
					<li style="float: left;">
						<a href="edit_move.jsp" target="left">
							<img src="${ctx}/images/btn_edit_move_on.gif" />
						</a>
					</li>
					<li style="float: right">
						<a href="edit.jsp" target="left">
							<img src="${ctx}/images/btn_edit_off.gif" />
						</a>
					</li>
					<li style="padding-top: 10px; clear: both;"><img src="${ctx}/images/category_SIDE.gif" /></li>
					<li class="f_whit_am">대상설정</li>
					<li style="float: left; margin-top: 0px;">
						<input type="hidden" name="sel_layer" id="sel_layer" onchange="doLoadObjectOfLayer(this.value);">
						<a href="#" onclick="choose()">
							<img src="${ctx}/images/btn_obj.gif" alt="대상선택"/>
						</a>
					</li>
					<li style="float: left; margin: 0px 0 0 3px;">
						<a href="#" onclick="chooseCancel()">
							<img src="${ctx}/images/btn_cancel.gif" />
						</a>
					</li>
					<li style="padding-top: 5px; clear: both;">
						<img src="${ctx}/images/category_SIDE1.gif" />
					</li>
				</ul>
				<fieldset style="padding:5px;">
					<legend class="f_whit_am">마우스</legend>
					<ul>
						<li style="float: left;">
							<label> 
								<input name="RadioGroup1" type="radio" id="RadioGroup1_0" value="라디오" onclick="widthMove()"/> 수평이동
							</label>
						</li>
						<li style="float: left;">
							<label>
								<input type="radio" name="RadioGroup1" value="라디오" id="RadioGroup1_1" onclick="highMove()"/> 수직이동
							</label>
						</li>
						<li style="float: left;">
							<label>
								<input type="radio" name="RadioGroup1" value="라디오" id="RadioGroup1_2" onclick="turnMove()"/> 회전
							</label>
						</li>
					</ul>
				</fieldset>
				</br>
				<hr />
				<fieldset  style="padding:5px;">
					<legend class="f_whit_am">대상 이동</legend>
					<ul>
						<li style="float: left;"><label for="textfield2">이동거리</label>
							<input type="text" name="textfield2" id="textfield2" onChange="dist=this.value;" maxlength="10"/> m</li>
						<li style=" clear:both;height: 100px;">
							<table border="0" cellpadding="0" cellspacing="0" summary="편집 콘트롤 버튼">
								<tr>
									<td rowspan="2">
										<a href="#" onclick="objMove(left)">
											<img src="${ctx}/images/btn_control_01.gif" alt="왼쪽" />
										</a>
									</td>
									<td>
										<a href="#" onclick="objMove(north)"><img src="${ctx}/images/btn_control_02.gif" alt="전방" /></a>
									</td>
									<td rowspan="2">
										<a href="#" onclick="objMove(right)">
											<img src="${ctx}/images/btn_control_03.gif" alt="오른쪽" />
										</a>
									</td>
									<td>
									  <a href="#" onclick="objMove(up)">
									    <img src="${ctx}/images/btn_control_05.gif" alt="상승"  />
								      </a>								    </td>
								</tr>
								<tr>
									<td>
										<a href="#" onclick="objMove(south)"><img src="${ctx}/images/btn_control_06.gif" alt="후방" /></a>
									</td>
									<td>
									  <a href="#" onclick="objMove(down)">
									    <img src="${ctx}/images/btn_control_07.gif" alt="하강" />
								      </a>								    </td>
								</tr>
								
							</table>

						</li>
					</ul>
				</fieldset>
				<hr />
				</br>
				<fieldset  style="padding:5px;">
					<legend class="f_whit_am">시설물 회전</legend>
					<ul>
						<li style="float: left;">
						<label for="textfield3">회전각도<br /></label> 
							<input type="text" name="textfield3" id="textfield3" onChange="angle=this.value;" maxlength="3" value="15"/> 도
						</li>
						<li style=" clear:both;margin: 10px 0 10px 3px;">
							<a href="#" onclick="objRotate(0,left)">
								<img src="${ctx}/images/btn_rot_01.gif">
							</a>
							<a href="#" onclick="objRotate(0,right)">
								<img src="${ctx}/images/btn_rot_02.gif">
							</a>
						</li>
					</ul>
				</fieldset>
				<hr />
			</div>
		</div>
	</div>
</body>
</html>