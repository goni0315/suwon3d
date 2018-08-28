	
		var basicInfo='<input type="button" value="북서" style="width:50px" onclick="doSetDirect(-45);">'
					 +'<input type="button" value="북" style="width:50px" onclick="doSetDirect(0);">'
					 +'<input type="button" value="북동" style="width:50px" onclick="doSetDirect(45);">'
					 +'<br>'
					 +'<input type="button" value="서" style="width:50px" onclick="doSetDirect(-90);">'
					 +'<input type="button" value="정지" style="width:50px" onclick="doPause();">'
					 +'<input type="button" value="동" style="width:50px" onclick="doSetDirect(90);">'
					 +'<br>'
					 +'<input type="button" value="남서" style="width:50px" onclick="doSetDirect(-135);">'
					 +'<input type="button" value="남" style="width:50px" onclick="doSetDirect(180);">'
					 +'<input type="button" value="남동" style="width:50px" onclick="doSetDirect(135);">'
					 +'<br>'
					 +'<input type="radio" name="set_mode" id="ch_car" value="" checked="checked"/> 자동차모드 '
					 +'<input type="radio" name="set_mode" id="ch_fly" value=""/> 비행기모드 '
					 +' 고도<input type="text" name="input_set_height" id="input_set_height" value="700" maxlength="4"style="width:60px"/> '
					 +' 각도<input type="text" name="input_set_angle" id="input_set_angle" value="45" maxlength="2" style="width:60px"/>'
					 +'<br>'
					 +' 주행속도 <input type="text" id="set_speed" value="5" maxlength="2" style="width: 60px;"/>'
					 +'</br>'
					 +'<div id="simulation_drive" style="width:100%; border:1;"></div></br>';
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성

		var m_naviPlay = false; // 주행실행 중인지 여부
		var m_naviPause = false; // 중지상태 여부
		
		document.getElementById("simulation_drive").style.display='block'; 

		$('#simulation_drive').append($('<fieldset><legend>경로목록</legend><div><table width="232" border="0" cellpadding="0" cellspacing="0">'
				+'<tr><th width="30">No</th><th width="60">X</th><th width="60">Y</th><th>Z</th></tr></table>'
				+'<div style="width:230px; height:100px; border:1px solid #828790; overflow-y:scroll; background:#FFF;">'
				+'<table id="listview" border="0" cellpadding="0" cellspacing="0" style="width:100%"></table></div></p></div></fieldset>'
		));

		
		makeButton('btn01','저장',function doSave(){ //input button 생성
			top.XDOCX.XDUIClearInputPoint();
			
			$('#listview tr').each(function(){
				var point = $(this).find('td');
				
				top.XDOCX.XDUIInput3DPoint($(point[1]).text(), $(point[2]).text(), $(point[3]).text());
			});

		    if (top.XDOCX.XDUIInputPointCount() < 2)
		    {
		        alert('경로를 입력하세요.');
		        return;
		    }
			
			var file_path = top.XDOCX.XDUIOpenFileDlg(false, 'txt');
		    if(file_path == '') return;
		    
		    top.XDOCX.XDNaviRouteSave(file_path);
		    
		},'btn02','불러오기',function doOpen(){
			var file_path = top.XDOCX.XDUIOpenFileDlg(true, 'txt');
		    if(file_path == '') return;
		    
			var result = top.XDOCX.XDUIOpenTxtFile(file_path);
			
			if(result == ''){
				alert('저장된 정보가 없습니다.');
				return;
			}
			top.XDOCX.XDUIClearInputPoint();
			doInitPointData();
			var arr = result.split('\n');

			for(var i = 1; i <= parseInt(arr[0]); i++){
				var point = arr[i].split('\t');
				doAddPointData([point[0], point[1], point[2]])
				
				top.XDOCX.XDUIInput3DPoint(point[0], point[1], point[2]);
			}
			
		},'btn03','모의주행지점 설정',function doInputPoint(){
			if($('#listview tr').length > 0){ // 입력된 포인트가 있을 경우
				if(confirm('이미 입력된 포인트가 있습니다.\n입력된 포인트를 삭제하시고 계속 하시겠습니까?')){
					top.XDOCX.XDUIClearInputPoint();
					doInitPointData();	
				}else{
					return;
				}
			}
			
			top.setWorkMode('모의주행');
			top.XDOCX.XDUISetWorkMode(21);
			
		 	top.initFunction();
			
			top.addFunction(function(data){
				var button = data['button'];
				var pos = data['pos'];
				
				if(button == 1){
					doAddPointData(pos);
				}else{
					top.initFunction();
					top.setWorkMode('');
					top.XDOCX.XDUISetWorkMode(1);
				}
			});
		},'btn04','실행',function doExecute(){

			if($('#listview tr').length < 2){
				alert('2개 이상의 포인트를 입력하십시오.');
				return;
			}

			if($('#set_speed').val() < 1 || $('#set_speed').val() >10){
				alert('주행 속도 범위는 1~10 사이입니다.\n다시 입력하십시오.');
				return;
			}

			if($('#ch_fly')[0].checked){
				if($('#input_set_height').val() < 10 || $('#input_set_height').val() > 1000){
					alert('고도 범위는 10~1000 사이입니다.\n다시 입력하십시오.');
					return;
				}
				if($('#input_set_angle').val() < 0 || $('#input_set_angle').val() > 90){
					alert('각도 범위는 0~90 사이입니다.\n다시 입력하십시오.');
					return;
				}
			}

			m_naviPause = false;

			top.initFunction();
			top.addFunction(function(){
				if(m_naviPause == false){
					m_naviPlay = false;
				}
			});

			if(m_naviPlay == false){
				top.setWorkMode('');
				top.XDOCX.XDUISetWorkMode(1);
				top.XDOCX.XDNaviInit();	

				if($('#ch_fly')[0].checked){//비행모드
					top.XDOCX.XDCamSetAngle($('#input_set_height').val());
					top.XDOCX.XDCamSetDistance($('#input_set_angle').val());
				}else{//자동차모드
					top.XDOCX.XDCamSetAngle(-10);
					top.XDOCX.XDCamSetDistance(20);
				}
				top.XDOCX.XDNaviPlay($('#set_speed').val());
				m_naviPlay = true;
			}else{
				top.XDOCX.XDNaviPlay($('#set_speed').val());
			}
				
		},'btn05','일시정지',function doPause(){
			if (m_naviPlay == true){
				m_naviPause = true;
				top.XDOCX.XDNaviPause();
			}
		},'btn06','정지',function doStop(){
			m_naviPause = false;
			if (m_naviPlay == true)
			{
				top.XDOCX.XDNaviStop();
				m_naviPlay = false;
			}
		},'btn07','새로고침',function doInit(){
			m_naviPause = false;
			top.initFunction();
			input_set_height.value = 700;
			input_set_angle.value = 45;
			set_speed.value = 5;
			top.setWorkMode('');
			top.XDOCX.XDUISetWorkMode(1);
			top.XDOCX.XDUIClearInputPoint();
			doInitPointData();
			doStop();
		});
		
		/*
		 *모의주행 시점 각도 
		 */
		function doSetDirect(val){
			if (m_naviPlay == true){
			 	top.XDOCX.XDNaviSetDirect(val);
			}
		}
		
		/*
		 * 좌표 데이터 추가
		 */
		function doAddPointData(pos){
			$('#listview').append($(
				'<tr>'+
				'	<td width="30">'+($('#listview tr').length+1)+'</td>'+
				'	<td width="60">'+Math.round((new Number(pos[0])))+'</td>'+
				'	<td width="60">'+Math.round((new Number(pos[1])))+'</td>'+
				'	<td>'+Math.round((new Number(pos[2])))+'</td>'+
				'</tr>'
			));
		}

		/*
		 * 좌표 데이터 초기화
		 */
		function doInitPointData(){
			$('#listview').empty();
		}