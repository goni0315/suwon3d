	
		var basicInfo='<input name="mode" id="mode1" type="radio" value="" onClick="changeAnalysisMode();" checked="checked"/>조망축 직접입력'
					 +'<input type="button" id="modeOne" value="조망축입력" onClick="setInputPoint();" ><br>'
					 +'<input name="mode" id="mode2" type="radio" value="" onClick="changeAnalysisMode();"/>주요지점리스트'
					 +'<input type="button" id="btn_jomang_point" value="조망점불러오기" disabled="disabled" onClick="doload();"/>'
					 +'<input type="button" id="purpose" value="목표점 지정" onClick="setInputPoint1();" disabled/><br>' 
					 +'<br>'
					 +'조망축설정  지점명<input type="text" name="jomang_name" id="jomang_name" maxlength="20"/>'
					 +'관찰높이값 지정 <input type="text" id="view_height" maxlength="3">'
					 +'<input type="button" value="등록" onClick="doAdd();"/>'
					 +'<div id="jomang_axis" style="width:100%; border:1;"></div>'
					 +'</br>';
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성
		
		var jomang='jomang';
		var s_point = new Array();
		var e_point = new Array();
		
		document.getElementById("jomang_axis").style.display='block'; 
		
		$('#jomang_axis').append($('<table width="232" border="0" cellpadding="0" cellspacing="0"><tr><td>'
			 	+'<div style="width:130px; height:100px; border:1px solid #828790; overflow-y:scroll; background:#FFF;">'
			 	+'<table id="listview1" border="0" cellpadding="0" cellspacing="0" style="width:100%"></table></div></td><td><table>'
                +'<tr><td>X :</td><td><input type="text" id="txt_x" style="width: 85px; text-align: right;"/> </td></tr><tr><td>Y :</td>'
                +'<td><input type="text" id="txt_y" style="width: 85px; text-align: right;"/> </td></tr><tr><td>Z :</td>'
                +'<td><input type="text" id="txt_z" style="width: 85px; text-align: right;"/> </td></tr></table></td></tr></table>'
                +'<br>'
                +'<br>'
                +'<input name="input" type="checkbox" value="" id="ck_auto_view" checked="checked">리스트선택시 조망축 보기'
                +'<table width="232" border="0" cellpadding="0" cellspacing="0"><tr><th width="30">No</th>'
                +'<th>지점명</th></tr></table>'
                +'<div style="width:230px; height:100px; border:1px solid #828790; overflow-y:scroll; background:#FFF;" >'
                +'<table id="listview" border="0" cellpadding="0" cellspacing="0" style="width:100%"></table></div>'
		));

		makeButton('btn01','저장',function doSave(){ //input button 생성
			var result = '';
			var data = $('#listview tr');;
			
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
		},'btn02','불러오기',function doOpen(){
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
			txt_x.value = '';
			txt_y.value = '';
			txt_z.value = '';
			$.each(data, function(i){
				var item = this.split(',');

				var p = item[1]+'_'+item[2]+'_'+item[3]+'_'+item[4]+'_'+item[5]+'_'+item[6];

				$('#listview').append($(
						'<tr onclick="doSelectJomangPoint(this);">'+
						'    <td width="30" align="center">'+(i + 1)+'</td>'+
						'    <td p="'+p+'" >'+item[0]+'</td>'+
						'</tr>'
				));
			});
		},'btn03','실행',function doPlay(){
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
			
		},'btn04','손이동',function(){
			top.XDOCX.XDUISetWorkMode(1);
		});
		
		/*
		 * 분석모드 변경 : 직접입력, 조망점불러오기
		 */
		function changeAnalysisMode(){
			if($('#mode1')[0].checked){ // 직접입력
				$('#btn_jomang_point').attr('disabled', true);
				$('#purpose').attr('disabled', true);
				$('#modeOne').attr('disabled', false);
				ClearAnalysis();
				top.XDOCX.XDMapClearTempLayer(); //임시 레이어 초기화
			
			}else{ // 조망점 불러오기
				$('#btn_jomang_point').attr('disabled', false);
				$('#purpose').attr('disabled', false);
				$('#modeOne').attr('disabled', true);
				top.XDOCX.XDUISetWorkMode(1);
			}
		}
		/*
		 * 조망지점 불러오기
		 */
		function doload(){// 조망지점 파일열기
			var file_path = top.XDOCX.XDUIOpenFileDlg(true, 'txt');
			if(file_path == '') return;
			
			var result = top.XDOCX.XDUIOpenTxtFile(file_path);
			
			if(result == '' || result.indexOf('\n') == -1){
				alert('저장된 정보가 없습니다.');
				return;
			}
			
			if(result.split('\n')[0] != 'xd_jomang1'){
				alert('지원하지 않는 형식의 파일입니다.');
				return;
			}
			
			var data = result.split('\n')[1].split('#');
			
			if(data.length < 2){
				alert('저장된 정보가 없습니다.');
				return;
			}
			
//			 	doInit();
			top.XDOCX.XDLayClear("Temporary");
		    $('#listview1').empty();
		    
		    for(var i = 1; i < data.length; i++){
		    	var item = data[i].split(',');
		    	
		    	$('#listview1').append($(
		           		'<tr onclick="doSelectJomangPoint1(this);">'+
		    	       	'	<td align="center">'+
		    	       	'<input type="hidden" value="'+item[1]+'" id="x_point" name="x_point"/>'+
		    	       	'<input type="hidden" value="'+item[2]+'" id="y_point" name="y_point"/>'+
		    	       	'<input type="hidden" value="'+item[3]+'" id="z_point" name="z_point"/>'+item[0]+'</td>'+
		           		'</tr>'
				));

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
			
//		 	ClearAnalysis();
			top.setWorkMode('조망축');
			top.XDOCX.XDUISetWorkMode(21);
//		 	top.XDOCX.XDClearTempLayer();
			top.XDOCX.XDObjDelete("Temporary","조망축_끝점");
			top.XDOCX.XDUIClearInputPoint();
		}
		
		/*
		 * 조망지점으로 조망축 입력
		 */
		function setInputPoint1(){
			e_point = new Array();
			top.initFunction();
			top.addFunction(function(pos){
				if($('#mode2')[0].checked){
					top.XDOCX.XDUISetWorkMode(21);
					
					top.XDOCX.XDUIInputPoint(s_point[0], s_point[2]);//x, z 
					if(top.XDOCX.XDUIInputPointCount() == 2){
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
			
			top.setWorkMode('조망축');
			top.XDOCX.XDUISetWorkMode(21);
			top.XDOCX.XDObjDelete("Temporary","조망축_끝점");
			top.XDOCX.XDUIClearInputPoint();
		}

		function ClearAnalysis(){
//		    top.XDOCX.XDUIClearInputPoint(); //현재 입력점 초기화
//		    top.XDOCX.XDMapRenderLock(true);
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
			$('#listview1').empty();
			top.mapXDInit();
			txt_x.value = '';
			txt_y.value = '';
			txt_z.value = '';
		}
		
		/*
		 * 조망축 선택
		 */
		function doSelectJomangPoint(obj){
		    if($('#ck_auto_view')[0].checked){
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

		        var v_view_height = top.XDOCX.XDTerrainGetHeight(px_point, pz_point) + ($('#view_height').val() ? $('#view_height').val() : 1.5);
		        
		        top.XDOCX.XDCamLookAt(px_point, v_view_height, pz_point, dx_point, dy_point, dz_point);

		        top.XDOCX.XDMapResetRTT();
		        top.XDOCX.XDMapRender();
		    }
		}
		
		/*
		 * 조망지점 선택
		 */
		function doSelectJomangPoint1(obj){
			top.XDOCX.XDLayRemove('조망축');
			ClearAnalysis();
			top.XDOCX.XDMapClearTempLayer();
//		 	top.XDOCX.XDClearTempLayer();
			
			s_point = new Array();
			txt_x.value = $(obj).find('[name=x_point]').val();
			txt_y.value = $(obj).find('[name=y_point]').val();
			txt_z.value = $(obj).find('[name=z_point]').val();
			
			$(obj).find('td').each(function(i){
				if(i == 0){
					jName = $(this).text();
					s_point.push($(this).find('[name=x_point]').val()); 
					s_point.push($(this).find('[name=y_point]').val());
					s_point.push($(this).find('[name=z_point]').val());
				}
			});
			
		    top.XDOCX.XDLaySetEditable("Temporary");
		    top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
		    top.XDOCX.XDRefSetColor(0, 255, 0, 0);
		    top.XDOCX.XDRefSetPos(s_point[0], s_point[1], s_point[2]);
		    
		    top.XDOCX.XDObjCreateText("Temporary", jName, "");
		    top.XDOCX.XDCarmeraMoveOval(s_point[0], s_point[1], s_point[2], 5);
		    top.XDOCX.XDUISetWorkMode(1);
			top.XDOCX.XDMapRender();
		}

		/*
		 * 등록
		 */
		function doAdd(){
			if(s_point.length == 0 || e_point.length == 0){
				alert('조망점을 입력해 주세요.');
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
				'    <td p="'+p+'">'+v_jomang_name+'</td>'+
			    '</tr>'
			);
			
			$('#listview').append(new_obj);
			
			$('#jomang_name').val('');
			
			s_point = new Array();
			e_point = new Array();
			
			doSelectJomangPoint(new_obj);
		}

