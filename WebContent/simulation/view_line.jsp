<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" type="text/css" href="../css/gislayout.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>3차원공간정보활용시스템</title>

<script type="text/javascript" src="../js/jquery/jquery.js"></script><!--callScript의 제이쿼리 함수를 위해 적용  -->
<script type="text/javascript" src="../js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../js/jquery/jquery-ui-1.8.custom.min.js"></script><!-- 조망, 네비 등의 속도 조절 슬라이드바 -->
<script type="text/javascript" src="../js/XDControl.js"></script>
<script type="text/javascript" src="../js/common.js"></script>

<script type="text/javascript">

	var jomang='jomang';
	var s_point = new Array();
	var e_point = new Array();

	function doSave(){ //input button 생성
		var result = '';
		var data = $('#listview tr');
		
		if(data.length == 0){
			alert('입력된 조망축이 없습니다.');
			return;
		}
		
		var file_path = top.XDOCX.XDUIOpenFileDlg(false, 'txt');
		if(file_path == '') return;
		
		$.each(data, function(j){
			if(j > 0) result += '#' ;
			
			var item = $($(this).find('td')[1]);
			var p = item.attr('p').split('_');
			
			result += item.text();
			result += ','+ new Number(p[0]);
			result += ','+ new Number(p[1]);
			result += ','+ new Number(p[2]);
			result += ','+ new Number(p[3]);
			result += ','+ new Number(p[4]);
			result += ','+ new Number(p[5]);
		});
		
		if(top.XDOCX.XDUISaveTxtFile(file_path, 'xd_jomang2\n'+result+"\n")){
			alert('조망축 저장이 완료 되었습니다.');
		}else{
			alert('조망축 저장에 실패 하였습니다.');
		}
	}
	
	function doOpen(){
		var file_path = top.XDOCX.XDUIOpenFileDlg(true, 'txt'); //파일 열기/저장 다이얼 로그를 호출
		if(file_path == '') return;

		var result = top.XDOCX.XDUIOpenTxtFile(file_path);

		if(result == '' || result.indexOf('\n') == -1){
			alert('저장된 정보가 없습니다.');
			return;
		}

		if(result.split('\n')[0] != 'xd_jomang2'){
			alert('지원하지 않는 형식의 파일입니다.');
			return;
		}

		var data = result.split('\n')[1].split('#');

		if(data.length == 0){
			alert('저장된 정보가 없습니다.');
			return;
		}

		doInit();

		$('#listview').empty();
		$.each(data, function(i){
			var item = this.split(',');

			var p = item[1]+'_'+item[2]+'_'+item[3]+'_'+item[4]+'_'+item[5]+'_'+item[6];

			$('#listview').append($(
					'<tr onclick="doSelectJomangPoint(this);">'+
					'    <td width="30" align="center">'+(i + 1)+'</td>'+
					'    <td width="280" align="center" p="'+p+'" >'+item[0]+'</td>'+
					'</tr>'
			));
		});
	}

	function doPlay(){
		var data = $('#listview tr');
		if(data.length == 0){
			alert('입력된 조망축이 없습니다.');
			return;
		}
		$('#listview tr').each(function(i){
			var item = this;
			
			if(i == 0) doSelectJomangPoint(item);
			else setTimeout(function(){
				doSelectJomangPoint(item);
			}, 3000*i);
		});
		
	}
	
	/*
	 * 분석모드 변경 : 직접입력, 조망점불러오기
	 */
	function changeAnalysisMode(){
		if($('#mode1')[0].checked){ // 직접입력
			document.getElementById("openBtn").style.display = "none";
			$('#btn_jomang_point').attr('disabled', true);
			$('#purpose').attr('disabled', true);
			$('#modeOne').attr('disabled', false);
			ClearAnalysis();
			top.XDOCX.XDMapClearTempLayer(); //임시 레이어 초기화
		
		}else{ // 조망점 불러오기
			document.getElementById("openBtn").style.display = "block";
			$('#btn_jomang_point').attr('disabled', false);
			$('#purpose').attr('disabled', false);
			$('#modeOne').attr('disabled', true);
			top.XDOCX.XDUISetWorkMode(1);
		}
	}
	
	/*
	 * 조망축설정
	 */
	function setInputPoint(){
		e_point = new Array();
		s_point = new Array();
		top.initFunction();
		top.addFunction(function(pos){
			if($('#modeOne')){ // 직접입력
				if (top.XDOCX.XDUIInputPointCount() == 1)
		        {
		            top.XDOCX.XDRefSetColor(255, 255, 0, 0);
		            top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
		            top.XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
		            
		            s_point.push(pos[0]);
		            s_point.push(pos[1]);
		            s_point.push(pos[2]);
		            
		            top.XDOCX.XDLaySetEditable("Temporary");
		            top.XDOCX.XDObjCreateText("조망축_시작점", "조망축_시작점", "");
		        }
		        else if (top.XDOCX.XDUIInputPointCount() == 2)
		        {
		        	top.initFunction();
		        	
		            top.XDOCX.XDRefSetColor(255, 255, 0, 0);
		            top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
		            top.XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);
		
		            e_point.push(pos[0]);
		            e_point.push(pos[1]);
		            e_point.push(pos[2]);
		            
		            top.XDOCX.XDLaySetEditable("Temporary");
		            top.XDOCX.XDObjCreateText("조망축_끝점", "조망축_끝점", "");
		            top.setWorkMode('');
		            top.XDOCX.XDUISetWorkMode(1);
		        }
			}
		});
		
//	 	ClearAnalysis();
		top.setWorkMode('조망축');
		top.XDOCX.XDUISetWorkMode(21);
//	 	top.XDOCX.XDClearTempLayer();
		top.XDOCX.XDObjDelete("Temporary","조망축_끝점");
		top.XDOCX.XDUIClearInputPoint();
	}
	
	function ClearAnalysis(){
//	    top.XDOCX.XDUIClearInputPoint(); //현재 입력점 초기화
//	    top.XDOCX.XDMapRenderLock(true);
	    top.XDOCX.XDLayClear("Temporary"); //대상 레이어를 초기화
	    top.XDOCX.XDLayClear("조망축"); //대상 레이어를 초기화
	    top.XDOCX.XDMapRenderLock(false);
	    top.XDOCX.XDMapResetRTT();
	    top.XDOCX.XDMapRender(); //현재 화면을 갱신 요청
	}

	/*
	 * 초기화
	 */
	function doInit(){
		top.XDOCX.XDLayRemove('조망축');
		$('#jomang_name').val('');
		$('#listview').empty();
		top.mapXDInit();
	}
	
	/*
	 * 등록
	 */
	function doAdd(){
		if(s_point.length == 0 || e_point.length == 0){
			alert('조망점을 입력해 주세요.');
			$('#jomang_name').val('');
			$('#view_height').val('');
			return;
		}
		
		var v_jomang_name = $.trim($('#jomang_name').val());
		var lvCount = $('#listview tr').length;
		
		if(!v_jomang_name){
			v_jomang_name = "조망축" + (lvCount + 1);
		}
		
		for(var i = 0; i < $('.name').length; i++){
	    	var name = $($('.name')[i]).text();
	    	
			if(name == v_jomang_name){
				alert('같은 이름의 조망점이 존재합니다.');
				$('#jomang_name')[0].focus();
				return;
			}
	    }
		
		var p = s_point[0]+'_'+s_point[1]+'_'+s_point[2]+'_'+e_point[0]+'_'+e_point[1]+'_'+e_point[2];
		
		var new_obj = $(
			'<tr onclick="doSelectJomangPoint(this);">'+
			'    <td width="30" align="center">'+(lvCount + 1)+'</td>'+
			'    <td width="280" align="center" p="'+p+'">'+v_jomang_name+'</td>'+
		    '</tr>'
		);
		
		$('#listview').append(new_obj);
		
		$('#jomang_name').val('');
		$('#view_height').val('');
		
		s_point = new Array();
		e_point = new Array();
		
		doSelectJomangPoint(new_obj);
	}

	/*
	 * 조망축 선택
	 */
	function doSelectJomangPoint(obj){
	    if($('#ck_auto_view')[0]){
	    	top.XDOCX.XDMapClearTempLayer();
	    	top.XDOCX.XDUIClearInputPoint();
	    	
	    	top.XDOCX.XDLayRemove('조망축');
	    	
	    	var data = $($(obj).find('td')[1]);
	        var joname = data.text();
	        var p = data.attr('p').split('_');
	        var px_point = new Number(p[0]);
	        var py_point = new Number(p[1]);
	        var pz_point = new Number(p[2]);
	        var dx_point = new Number(p[3]);
	        var dy_point = new Number(p[4]);
	        var dz_point = new Number(p[5]);


	        top.XDOCX.XDRefSetColor(255, 255, 0, 0);
	        top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
	        top.XDOCX.XDRefSetPos(px_point, py_point, pz_point);
	        top.XDOCX.XDLaySetEditable("Temporary");
	        top.XDOCX.XDObjCreateText("조망축_시작점" + joname, "조망축_시작점('" + joname + "')", "");

	        top.XDOCX.XDRefSetColor(255, 255, 0, 0);
	        top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
	        top.XDOCX.XDRefSetPos(dx_point, dy_point, dz_point);
	        top.XDOCX.XDLaySetEditable("Temporary");
	        top.XDOCX.XDObjCreateText("조망축_끝점" + joname, "조망축_끝점('" + joname + "')", "");

	        var layer = '조망축';
	        
	        if (top.XDOCX.XDLayGetHiddenValue(layer) == "") 
	        {
	            top.XDOCX.XDMapRenderLock(true);
	            top.XDOCX.XDLayCreate(5, layer);
	            top.XDOCX.XDMapRenderLock(false);
	            top.XDOCX.XDLaySetHiddenValue(layer, 1, 100000);
	            top.XDOCX.XDLaySetEditable(layer);
	        }
	        else 
	        {
		        top.XDOCX.XDLaySetEditable(layer);	
	        }
	        
	        top.XDOCX.XDLaySetSelectable(layer, true);

	        top.XDOCX.XDRefSetColor(255, 255, 0, 0);
	        top.XDOCX.XDUIInput3DPoint(px_point, py_point+1, pz_point);
	        top.XDOCX.XDUIInput3DPoint(dx_point, dy_point+1, dz_point);
	        top.XDOCX.XDMapRenderLock(true);
	        top.XDOCX.XDObjCreateLine(joname, 100, false);
	        top.XDOCX.XDUIClearInputPoint();
	        top.XDOCX.XDMapRenderLock(false);

	        var y_view_height;
	        var y_view_height_type = document.getElementById("view_height").value;
	        if(y_view_height_type == ""){
		        y_view_height = top.XDOCX.XDTerrainGetHeight(px_point, pz_point) + (y_view_height_type ? $y_view_height_type : 1.5);
	        }else{
	        	y_view_height = y_view_height_type;
	        }
	        top.XDOCX.XDCamLookAt(px_point, y_view_height, pz_point, dx_point, dy_point, dz_point);

	        top.XDOCX.XDMapResetRTT();
	        top.XDOCX.XDMapRender();
	    }
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
							<img src="../images/btn_view_point_off.gif" />
						</a>
					</li>
					<li style="float: right">
						<a href="view_line.jsp" target="left">
							<img src="../images/btn_view_line_on.gif" />
						</a>
					</li>
					<li style="padding-top: 10px; clear: both;">
						<img src="../images/category_SIDE.gif" />
					</li>
					<li class="f_whit_am">조망축 설정</li>
					<li>
						<a href="#" onclick="setInputPoint()">
							<img src="../images/btn_view_set.gif" />
						</a>
					
						<a href="#" onclick="doInit()">
							<img src="../images/btn_analysis_cancel.gif" width="96" height="24" />
						</a>
					</li>
                    </ul>
						<fieldset style="padding:5px;">
							<legend class="f_whit_am">관측시점</legend>
							<ul>
								<li>
									<label for="mode1"style="width: 235px;">
										<input type="radio" name="mode" value="" id="mode1" onClick="changeAnalysisMode();" checked="checked" /> 직접입력
									</label>
									<a href="#" onclick="doSave()">
										<img src="../images/btn_save.gif"/>
									</a>
									
								</li>
								<li style="clear: both;">
								<label for="mode2" style="width: 235px;">
								<input type="radio" name="mode" value="라디오" id="mode2" onclick="changeAnalysisMode();" />
										주요지점 리스트
								</label>
								</li>
								<li>
									<a href="#" id="openBtn" style="display: none">
										<img src="../images/btn_open_on.gif" id="btn_jomang_point" disabled="disabled" onclick="doOpen()">
									</a>
								</li>
							</ul>
						</fieldset>
                    <ul style=" margin-top:10px;">
					<li style="float: left; width: 220px;"><label for="jomang_name">지점명 :</label> 
						<input type="text" name="jomang_name" id="jomang_name" />
					</li>
					<li style="float: left;">
					<a href="#" onclick="doAdd()">
						<img src="../images/btn_input_ok.gif" width="62" height="24" />
					</a>
					</li>
					<li style="clear: both;">
						<img src="../images/category_SIDE.gif" />
					</li>
					<li class="f_whit_am" style="clear: both;">높이값 일괄 적용</li>
					<li><label for="view_height">관찰높이 :</label> 
						<input type="text" name="view_height" id="view_height" />
					</li>
					<li style="height: 170px;">
						<input name="input" type="hidden" value="" id="ck_auto_view">
						<div id="bbsCont" style="height: 160px; overflow-y: yes; width: 310px; background: #FFF; border: solid 1px #333333;">
							<table border="0" cellpadding="0" cellspacing="0" class="wps_100" summary="가시결과list">
								<col class="w_40" />
								<col />
								<tr>
									<th>No</th>
									<th align="center">지점명</th>
								</tr>
							</table>
							<input type="hidden"><table id="listview" border="0" cellpadding="0" cellspacing="0" style="width:100%"></table></input>
						</div>
					</li>
					<!-- <li style="float:right;">
							<img src="../images/btn_save.gif"/>
					</li> -->
				</ul>
			</div>
		</div>
	</div>
</body>
</html>
