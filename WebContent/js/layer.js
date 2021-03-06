﻿/*
 * 레이어 visible 상태 설정
 */
function setLayerVisible(obj, layer_name){
	
	obj = $(obj);
	var src = obj.attr('src');
	
	if(src.indexOf('_on') != -1){
		XDOCX.XDLaySetVisible(layer_name, false);
		$(obj).attr('src', './images/layer/icon_light_off.gif');
	}else{
		XDOCX.XDLaySetVisible(layer_name, true);
		$(obj).attr('src', './images/layer/icon_light_on.gif');
	}
	
	top.XDOCX.XDMapResetRTT();
	top.XDOCX.XDMapRender();
}

// 현제 고도값 산출
function selectLayer(layer_name){
	$('.layer').removeClass('selected');
	$('[layer='+layer_name+']').addClass('selected');
	
	var hValue = XDOCX.XDLayGetHiddenValue(layer_name).split(',');
	
	if(hValue.length == 2){
		$('#vis_min').val(Math.round(hValue[0]));
		$('#vis_max').val(Math.round(hValue[1]));
	}
}

function setLayerHiddenValue(){
	var layer = $('.selected').attr('layer');
	
	if ($('.selected').length == 0 || layer == "") {
		alert("적용할 레이어를 선택하세요");
		return;
	}
	if ($('#vis_min').val() == '') {
		alert("최소고도를 입력하세요");
		return;
	}
	if ($('#vis_max').val() == '') {
		alert("최대고도를 입력하세요");
		return;
	}
	
	XDOCX.XDLaySetHiddenValue(layer, $('#vis_min').val(), $('#vis_max').val());
}

function layImport() {	//레이어 들여오기
	divOpen();
 	var tmpFile = XDOCX.XDUIOpenFileDlg(true, "xdl");
 	if (tmpFile == "") return;
 	if (top.XDOCX.XDLayReadFile(tmpFile) == true) {
 		var idx = top.XDOCX.XDLayGetCount() - 1;
 		var tmpLayer = top.XDOCX.XDLayGetName(idx);
 		
 		var isVisible = top.XDOCX.XDLayGetVisible(tmpLayer);
		var isEditable = top.XDOCX.XDLayGetEditable() == tmpLayer;
		appendExtLayerInfo(tmpLayer);

 		
		//트리구조
 		$('#기타').append($(
			'<li class="layer" layer="'+tmpLayer+'" ><span style="width:100px; cursor:pointer;" onclick="selectLayer(\''+tmpLayer+'\')">'+tmpLayer
			+'</span><span><img src="./images/icon_light_'+(isVisible ? 'on' : 'off')+'.gif" width="16" height="16"' 
			+'onclick="setLayerVisible(this, \''+tmpLayer+'\');"/></li>'		
		));
		
 		//top.gotoLayPage(document.location.href);
 	}
}

function layRemove() {	//레이어 제거
	divOpen();
	var layer = $('.selected').attr('layer');
	
	if ($('.selected').length == 0 || layer == "") {
		alert("삭제할 레이어를 선택하세요");
		return;
	}
	
	if(layer == 'Temporary'){
		alert("임시 레이어는 삭제할 수 없습니다.");
		return;
	}
	
	if(confirm("해당 레이어를 삭제하시겠습니까?")){
		top.XDOCX.XDLaySetVisible(layer, false);
		top.XDOCX.XDLayRemove(layer);
		top.XDOCX.XDMapRender();
		$('.selected').remove();
		top.deleteExtLayerInfo(layer);
		
		//top.gotoLayPage(document.location.href);
	}
}

var _ext_layer_info = []; // 추가된 레이어 정보

/*
 * extend 레이어 추가
 * 
 * @param lyr_name
 */
function appendExtLayerInfo(lyr_name){
	var isExist = false;
	
	$.each(_ext_layer_info, function(){
		if(this == lyr_name){
			isExist = true;
		}
	});
	
	if(!isExist){
		_ext_layer_info.push(lyr_name);
		return true;
	}else{
		return false;
	}
}

/*
 * extend 레이어 삭제
 * 
 * @param lyr_name
 */
function deleteExtLayerInfo(lyr_name){
	var temp_arr = [];
	
	$.each(_ext_layer_info, function(){
		if(this != lyr_name){
			temp_arr.push(this);
		}
	});
	
	_ext_layer_info = temp_arr;
	
	return _ext_layer_info;
}

/*
 * extend 레이어 목록 반환
 */
function getExtLayerInfo(){
	return _ext_layer_info;
}

function divOpen(){
	$('#inc_create_layer').hide();
	$('#inc_set_layer').show();
}

function layCreate(){
	var display = $('#inc_create_layer').css('display').toUpperCase();
	if(display == 'NONE'){
		$('#inc_create_layer').show();
		$('#inc_set_layer').hide();
	}else{
		$('#inc_create_layer').hide();
		$('#inc_set_layer').show();
	}
}

function doLayCreate(){
	divOpen();
	var frm = document.layerForm;
	
	var type = frm.type.value;
	var tmpLayer = frm.name.value;
	
	if(tmpLayer == ''){
		alert('생성할 레이어명을 입력하십시오.');
		frm.name.focus();
		return;
	}
	
	if(top.XDOCX.XDLayCreate(type, tmpLayer)){
 		$('#기타').append($(
			'<li class="layer" layer="'+tmpLayer+'" ><span style="width:100px; cursor:pointer;" onclick="selectLayer(\''+tmpLayer+'\')">'+tmpLayer
			+'</span><span><img src="./images/layer/icon_light_on.gif" width="16" height="16"' 
			+'onclick="setLayerVisible(this, \''+tmpLayer+'\');"/></li>'		
		));
		
		frm.type.value = '0';
		frm.name.value = '';
		
		$('#inc_create_layer').hide();
		top.appendExtLayerInfo(name);
		
		
	}else{
		alert('레이어 생성에 실패하였습니다.');
	}
}

function layExport() {	//레이어 내보내기
	divOpen();
	var layer = $('.selected').attr('layer');
	
	if ($('.selected').length == 0 || layer == "") {
		alert("저장할 레이어를 선택하세요");
		return;
	}
	
	var tmpFile = XDOCX.XDUIOpenFileDlg(false, "xdl");
	
	if (tmpFile == "") return; 
	
	if (XDOCX.XDLaySaveFile(layer, tmpFile)){
		alert(" 레이어 저장에 성공하였습니다. ");
	}else{
		alert(" 레이어 저장에 실패하였습니다. ");
	}
	
}
//지하컨트롤 여부 설정, 지형을 투명하게 하고, 지하시설물 레이어 visivle 설정한다.
//분석기능  > 매설시뮬레이션 에서 사용.	
//상/하수도 에서 사용 
layVis = function(vis) {
	var len = XDOCX.XDLayGetCount();
	for (var i = 1; i < len; i++) {
		var tmpLayer = XDOCX.XDLayGetName(i);
		var tmpInfo = getLayInfo(tmpLayer, true);	
		if (tmpInfo != "") {
			if(tmpInfo.m_f_gr == "FGR001") {		//지형 투명하게
				if (vis == true) {
					TmpRefColor(100, 255, 255, 255);
					XDOCX.XDLaySetVisible(tmpLayer, true);
				} else {	
					TmpRefColor(255, 255, 255, 255);
				}
				XDOCX.XDLaySetColor(tmpLayer);
				GetRefColor();
			} else if(tmpInfo.m_f_gr == "FGR005") {		//지하시설물 보이게
				XDOCX.XDLaySetVisible(tmpLayer, vis);
			}
			XDOCX.XDMapSetUnderGround(vis);
		} 
	}
	top.XDOCX.XDMapLoad();
	top.XDOCX.XDMapRender();
};

//레이어 지번,도로명,건물번호 등 선택방지
function layViewVal() {
	top.XDOCX.XDLaySetHiddenValue('KO3D_AL_EMD',1,10000);
	top.XDOCX.XDLaySetHiddenValue('KO3D_AL_EMD_T',1,10000);
	top.XDOCX.XDLaySetHiddenValue('AL_EMD',1,10000);
	top.XDOCX.XDLaySetHiddenValue('KO3D_PL_BBND_T',1,800);
	top.XDOCX.XDLaySetHiddenValue('KO3D_PL_BBND',1,800);
	top.XDOCX.XDLaySetHiddenValue('ETC_CCTV',1,5000);
	top.XDOCX.XDLaySetHiddenValue('Shelter_3D',1,5000);
	top.XDOCX.XDLaySetHiddenValue('Suwon_Security_Changan',1,3000);
	top.XDOCX.XDLaySetHiddenValue('Suwon_Security_Gwonseon',1,3000);
	top.XDOCX.XDLaySetHiddenValue('Suwon_Security_Paldal',1,3000);
	top.XDOCX.XDLaySetHiddenValue('Suwon_Security_Yeongtong',1,3000);

	top.XDOCX.XDLaySetVisible('LT_C_UQ141_UQQ900',false);

	top.XDOCX.XDLaySetVisible('FL_CHIMSL',false);
	top.XDOCX.XDLaySetVisible('FL_CHIMSL_T',false);
	top.XDOCX.XDLaySetVisible('FL_CHIMWL',false);
	top.XDOCX.XDLaySetVisible('FL_CHIMWL_T',false);

	top.XDOCX.XDLaySetVisible('SW_BUILD',false);
}
