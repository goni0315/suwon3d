<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../css/gislayout.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>
<script type="text/javascript" src="../js/jquery/jquery.js"></script>
<script type="text/javascript" src="../js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="../js/XDControl.js"></script>
<script type="text/javascript" src="../js/common.js"></script>
<script type="text/javascript">
var turn_left = 'turn_left';
var turn_right = 'turn_right';
var high_angle = 'high_angle';
var low_angle = 'low_angle';
var timer = null;

function pointClick(){ //input button 생성
	if(top.XDOCX.XDObjGetBox("Temporary", "대상지") != ''){
		if(confirm('이미 대상지가 설정된 상태입니다. 대상지를 다시 설정하시겠습니까?')){
			top.XDOCX.XDLaySetEditable("Temporary");
			top.XDOCX.XDMapRenderLock(true);
			top.XDOCX.XDObjDelete("Temporary", "대상지");
			
			top.XDOCX.XDMapRenderLock(false);
			top.XDOCX.XDMapRender();
			
			top.XDOCX.XDUISetWorkMode(0);
			top.setWorkMode('조망점입력_대상지');
		}
	}else{
		top.XDOCX.XDUISetWorkMode(0);
		top.setWorkMode('조망점입력_대상지');
	}
	
	top.initFunction();
	top.addFunction(function(pos){
		top.XDOCX.XDUISetWorkMode(20);

        top.XDOCX.XDLaySetEditable("Temporary");
        top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 0, 0, 0);
        top.XDOCX.XDRefSetColor(0, 255, 0, 0);
        top.XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
        
        if($('#ch_display_text')[0].checked)
        	top.XDOCX.XDObjCreateText("대상지", "대상지", "");
        else
            top.XDOCX.XDObjCreateText("대상지", "", "");

        top.XDOCX.XDMapRender();
        top.setWorkMode('');
        top.XDOCX.XDUISetWorkMode(1);
	});
}

function pointName(){ //input button 생성
	if(top.XDOCX.XDObjGetBox("Temporary", "대상지") == ''){
		alert('대상지를 먼저 선택해 주세요.');
		return;
	}
	
	top.initFunction();
	top.addFunction(function(pos){
		var lvCount = $('#listview tr').length;
		
		if(lvCount > 5){
			alert('조망지점은 5개까지만 입력해주세요');
			return;
		}
		var v_jomang_name = $.trim($('#jomang_name').val());
        
		if(v_jomang_name == ''){
			alert('조망지점명을 입력해주세요.');
			return;
		}
		//조망점 이름 입력 없을 시
       /*  if(v_jomang_name == ''){
        	if($('#ch_display_text')[0].checked){
        		v_jomang_name = "조망점" + (lvCount + 1);
            }else{
            	v_jomang_name = "";
            }
        } */
        
        for(var i = 0; i < $('.name').length; i++){
        	var name = $($('.name')[i]).text();
        	
			if(name == v_jomang_name){
				alert('같은 이름의 조망점이 존재합니다.');
				$('#jomang_name')[0].focus();
				return;
			}
        }
		
// 		pos[0] = Math.round(new Number(pos[0])); 
// 		pos[1] = Math.round(new Number(pos[1]));
// 		pos[2] = Math.round(new Number(pos[2]));
		
        top.XDOCX.XDUISetWorkMode(20);
        top.XDOCX.XDLaySetEditable("Temporary");
        top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 0, 0, 0);
        top.XDOCX.XDRefSetColor(0, 255, 0, 0);
        top.XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);

        top.XDOCX.XDObjCreateText("조망점" + (lvCount + 1), v_jomang_name, "");
        
        $('#listview').append($(
           		'<tr onclick="doSelectJomangPoint(this);" class="grid_row">'+
    	       	'	<td align="center" class="name">'+
    	       	'<input type="hidden" value="'+pos[0]+'" id="x_point" name="x_point"/>'+
    	       	'<input type="hidden" value="'+pos[1]+'" id="y_point" name="y_point"/>'+
    	       	'<input type="hidden" value="'+pos[2]+'" id="z_point" name="z_point"/>'+v_jomang_name+'</td>'+
           		'</tr>'
		));
        
        jomang_name.value = '';
        
        top.setWorkMode('');
        top.XDOCX.XDUISetWorkMode(1);
        top.XDOCX.XDMapRender();
	});
	top.setWorkMode('조망점입력_조망점');
    top.XDOCX.XDUISetWorkMode(0);
}

function pointExe(){
	if(top.XDOCX.XDObjGetBox("Temporary", "대상지") == ''){
		alert('대상지가 설정되지 않았습니다.');
		return;
	}
	
	$('#listview tr').each(function(i){
		var item = this;
		
		if(i == 0) doSelectJomangPoint(item);
		else setTimeout(function(){
			doSelectJomangPoint(item);
		}, 2000*i);
	});
}

function doSelectJomangPoint(obj){
	if(!$('#ch_auto_view')[0].checked) return;
	
	if(top.XDOCX.XDObjGetBox("Temporary", "대상지") == ''){
		alert('대상지를 먼저 선택해 주세요.');
		return;
	}
	
	var jName = null;
	var x = null;
	var y = null;
	var z = null;
	txt_x.value = $(obj).find('[name=x_point]').val();
	txt_y.value = $(obj).find('[name=y_point]').val();
	txt_z.value = $(obj).find('[name=z_point]').val();
	
	$(obj).find('td').each(function(i){
		if(i == 0){
			jName = $(this).text();
			x = $(this).find('[name=x_point]').val(); 
			y = $(this).find('[name=y_point]').val();
			z = $(this).find('[name=z_point]').val();
		}
	});
	
	top.XDOCX.XDLaySetEditable("Temporary");
    top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 0, 0, 0);
    top.XDOCX.XDRefSetColor(0, 255, 0, 0);
    top.XDOCX.XDRefSetPos(x, y, z);
    top.XDOCX.XDObjCreateText(jName, jName, "");
	
	var target_pos = top.XDOCX.XDObjGetPosition("Temporary", "대상지").split(',');
    
	if($('#ch_set_height')[0].checked && $('#input_set_height').val() != ''){
		var hy = $('#input_set_height').val();
		top.XDOCX.XDCamLookAt(x, hy, z, target_pos[0], target_pos[1], target_pos[2]);
	}else{
		$('#ch_person_height')[0].checked = true;
		top.XDOCX.XDCamLookAt(x, (new Number(y) + 1.8), z, target_pos[0], target_pos[1], target_pos[2]);
	}
	
	//top.XDOCX.XDCamSetMode(0);
	top.XDOCX.XDMapRender();
}

//초기화
function doInit(){
	top.XDOCX.XDCamSetMode(0);
	$('#jomang_name').val('');
	$('#listview').empty();
	txt_x.value = '';
	txt_y.value = '';
	txt_z.value = '';
	top.XDOCX.XDMapRenderLock(true);
	top.XDOCX.XDLayClear("대상지");
	top.XDOCX.XDLayClear("조망점");
	top.XDOCX.XDMapRenderLock(false);
	top.mapXDInit();
	top.XDOCX.XDUISetWorkMode(1);
}

</script>
</head>
<body style="background: url(../images/category_bg1.gif)">
	<div id="panel">
		<div id="title">
			<div id="category1" style="margin-top: 35px;">
				<ul style="width: 320px;">
					<li style="float: left;">
						<a href="view.jsp" target="left">
							<img src="../images/btn_view_A_off.gif" />
						</a>
					</li>
					<li style="float: left; margin-left: 4px;">
						<a href="view_point.jsp" target="left">
							<img src="../images/btn_view_point_on.gif" />
						</a>
					</li>
					<li style="float: right">
						<a href="view_line.jsp" target="left">
							<img src="../images/btn_view_line_off.gif" />
						</a>
					</li>
					<li style="padding-top: 15px; clear: both;"><img src="../images/category_SIDE.gif" /></li>
					<li class="f_whit_am">대상지</li>
					<li style="float: left;">
						<a href="#" onclick="pointClick()">
							<img src="../images/btn_gasi_point.gif" width="96" height="24" />
						</a>
					</li>
					<li style="float: left; margin:0 0 0 3px;">
						<a href="#" onclick="doInit()">
							<img src="../images/btn_analysis_cancel.gif" width="96" height="24" />
						</a>
					</li>
					<li style="clear:both;"><img src="../images/category_SIDE1.gif" /></li>
					<li class="f_whit_am" style="margin-top: 10px;">조망점</li>
					<li style="float: left;">
						<label for="jomang_name">지점명 :</label>
						<input type="text" name="jomang_name" id="jomang_name" />
					</li>
					<li style="margin: 0 0 0 3px;"></li>
					<li style="float: left;">
						<a href="#" onclick="pointName()">
							<img src="../images/btn_gasi_name.gif" width="96" height="24" />
						</a>
					</li>
					<li style="padding-top: 5px; clear: both;">
						<img src="../images/category_SIDE.gif" />
					</li>
				</ul>
					<fieldset style="padding:5px;">
						<legend class="f_whit_am">조망점 리스트</legend>
						<ul style="height: 60px;">
							<li style="float: left;">
								<label for="ch_auto_view" style="width: 250px;">
								<input id="ch_auto_view" name="input" type="checkbox" value="" checked="checked"/> 리스트 선택 시 조망보기</label>
							</li>
							<li style="clear: both; float: left;">
								<label for="ch_display_text" style="width: 250px;">
								<input id="ch_display_text" name="input" type="checkbox" value="" checked="checked"/> 텍스트 표시 여부</label>
							</li>
						</ul>
						<div style="width: 120px; height: 80px; border: solid 1px #333333; background: #FFF; clear: both; float: left;">
							<table id="listview" border="0" cellpadding="0" cellspacing="0" style="width: 100%;">
								
							</table>
						</div>

						<ul style="float: left; margin-left: 10px;">
							<li><label for="txt_x" style="width: 30px;">X :</label>
								<input type="text" name="txt_x" id="txt_x" style="width: 80px;" />
							</li>
							<li><label for="txt_y" style="width: 30px;">Y :</label>
								<input type="text" name="txt_y" id="txt_y" style="width: 80px;" />
							</li>
							<li><label for="txt_z" style="width: 30px;">Z :</label>
								<input type="text" name="txt_z" id="txt_z" style="width: 80px;" />
							</li>
						</ul>

						<div style="float: right; width: 100px;"></div>

					</fieldset>
					</br>
					<fieldset style="padding:5px;">
						<legend class="f_whit_am">관측시점</legend>
						<ul style="height: 60px;">
							<li style="float: left;">
								<label for="textfield" style="width: 250px;"> 
									<input type="radio" name="set_height" value="라디오" id="ch_person_height" checked="checked" /> 사람
								</label>
							</li>
							<li style="clear: both;">
								<label for="textfield">
									<input type="radio" name="set_height" value="라디오" id="ch_set_height" /> 직접입력
								</label>
							<input id="input_set_height" type="text" style="width: 50px; float: left;" />m
							</li>
						</ul>
					</fieldset>
						<a href="#" onclick="pointExe()">
							<img src="../images/btn_ok.gif" alt="" style="margin-top: 10px;float:right;"/>
						</a>
			</div>
		</div>
	</div>
</body>
</html>
