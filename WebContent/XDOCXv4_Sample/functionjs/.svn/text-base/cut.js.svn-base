	
		var basicInfo='바닥면 평균높이<input type="text" value="" id="hei_average" name="hei_average" size="6" readOnly/>m<br>'
			+' 바닥면 최저<input type="text" value="" id="hei_min" name="hei_min" size="6" readOnly/><br>'
			+' 바닥면 최고<input type="text" value="" id="hei_max" name="hei_max" maxlength="10" size="6" readOnly/><br>'
			+' 바닥면 변경높이<input type="text" value="" id="hei_change" name="hei_change" size="6" readOnly/>m<br>'
			+' 바닥면 이미지<input type="text" value="" id="img_base" name="img_base" size="6" readOnly/></br>'
			+' 경사면 이미지<input type="text" value="" id="img_slope" /><br>'	
			+' 경사면 각도<input type="radio" value="" id="rd_slope_type1" name="rd_slope_type" checked/><input id="slope_angle" value="45" size="6" />도<br>'
			+' 경사면 구배<input type="radio" value="" id="rd_slope_type2" name="rd_slope_type"/><input id="slope_tan1" value="1" size="6"/>:<input id="slope_tan2" value="1" size="6"/><br>'
			+' 토공량산출 토공량<input type="text" value="" id="rs_total" name="rs_total" size="6" readOnly/>㎥<br><br>'
			/*+' 덤프트럭환산 트럭종류<select name="rs_truck" id="rs_truck" onChange="chg_truck"><option value="5.3">8톤</option><option value="10.0">15톤</option><option value="16.0">24톤</option><option value="17.0">25.5톤</option><option value="18.0">27톤</option></select><br>'
			+' 덤프트럭환산 대당부피<input value="10.0" id="rs_vol" onChange="chg_vol"/>㎡<input type="text" id="rs_cnt" name="rs_cnt" readOnly/>대</br>'*/;
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성
		//document.getElementById("cut").style.display = 'block';
		
		var chg_truck = 'chg_truck';
		var chg_vol = 'chg_vol';	
		var baseUrl = '../images/test01.gif';
		var slopeUrl = '../images/test02.gif';

/*		$('#cut').append($('<br>'
					+'바닥면 이미지 미리보기<img src="${contextPath}/images/test01.gif" id="img_base_preview" style="width:66px;height:27px;border:solid #ffffff 1px;"/>'
					+'<br>'
					+'경사면 이미지 미리보기<img src="${contextPath}/images/test02.gif" id="img_slope_preview" style="width:66px;height:27px;border:solid #ffffff 1px;"/>'

		));*/
		makeButton('btn01','지형성절토 영역설정',function(){ //input button 생성
			var hei_min;
			var hei_max;
			var hei_average;
			var hei_change;
			top.setWorkMode('set_rect');
			top.XDOCX.XDUISetWorkMode(24);
		},
		'btn02','지형성절토 영역취소',function(){ //input button 생성
			top.XDOCX.XDUIClearInputPoint();
			hei_change.value = '';
			hei_average.value = '';
			hei_min.value = '';
			hei_max.value = '';
			top.XDOCX.XDUISetWorkMode(1);
		},'btn03','바닥면 이미지 찾기',function(){ //input button 생성
			var fileName = top.XDOCX.XDUIOpenFileDlg(true, 'jpg,bmp');
			if (fileName != ""){
				if (top.XDOCX.XDUIFileExist(fileName)){
					document.getElementById('img_base').value = fileName;	
					img_preview('img_base', fileName);
				}
			}
		},'btn04','경사면 이미지 불러오기',function(){ //input button 생성
			var fileName = top.XDOCX.XDUIOpenFileDlg(true, 'jpg,bmp');
			if (fileName != ""){
				if (top.XDOCX.XDUIFileExist(fileName)){
					document.getElementById('img_slope').value = fileName;	
					img_preview('img_slope', fileName);
				}
			}
		},
		
		'btn05','지형성절토 실행',function(){ //input button 생성

			if ('run'){		// 실행
				if (top.XDOCX.XDUIInputPointCount() < 3) { //3개미만의 지점 찍고 실행시 얼럿창
					alert("성/절토를 실행할 영역을 지정하세요");
					return;	
				}
				var imgBasePath = img_base.value;
				var imgSlopePath = img_slope.value;
				if (imgBasePath == "") {
					imgBasePath = top.m_workPath + "kopss\\" + "base.jpg"; //성절토 기본이미지 경로
				}
				if (imgSlopePath == "") {
					imgSlopePath = top.m_workPath + "kopss\\" + "slop.jpg";
				}
		
				var angle = 0;
				if (rd_slope_type2.checked){
					var thi = parseFloat(slope_tan1.value) / parseFloat(slope_tan2.value); 
					angle = Math.Atan(thi) * 0.1 * 3.14159265358979 * 180.0;
				}else{
					angle = slope_angle.value;
				}
				var result = top.XDOCX.XDTerrCutEdit(parseInt(hei_change.value), angle, imgBasePath, imgSlopePath);
				rs_total.value = Math.round(result * 100) / 100;
				
				rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
				
				top.XDOCX.XDUIClearInputPoint();
				top.XDOCX.XDUISetWorkMode(1);
				}
			if (chg_truck){		// 트럭선택
				rs_vol.value = rs_truck.value;
				if (rs_total.value != ""){
					rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
				}
			}
			if (chg_vol){		// 트럭의 적재부피
				if (rs_total.value != ""){
					rs_cnt.value = Math.ceil(rs_total.value / rs_vol.value);
				}		
			}
		});

/*		function img_preview(mode, src){

			if (mode == "img_slope") {
				document.getElementById('img_slope_preview').style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "',sizingMethod=scale)";
				img_slope_src = src;
			} else if (mode == "img_base") {
				document.getElementById('img_base_preview').style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "',sizingMethod=scale)";
				img_base_src = src;
			}
		}
		*/