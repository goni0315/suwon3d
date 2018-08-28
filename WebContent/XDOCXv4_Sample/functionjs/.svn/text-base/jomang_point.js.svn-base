	
		var basicInfo='지점명 <input type="text" id="jomang_name" maxlength="20">'
					 +'<br>'
					 +'<input name="set_height" type="radio" id="ch_person_height" value="radio2" checked> 사람 '
					 +'<br>'
					 +'<input type="radio" name="set_height" id="ch_set_height" value="radio3">'
					 +'직접입력<input type="text" name="input_set_height" id="input_set_height" style="width:40px" maxlength="3" /> m '
					 +'<br>'
					 +'<input type="button" value="좌회전" onMouseDown="doCamMove(turn_left);" onMouseUp="doStopCamMove();" onMouseOut="doStopCamMove();"/>'
					 +'<input type="button" value="우회전" onMouseDown="doCamMove(turn_right);" onMouseUp="doStopCamMove();" onMouseOut="doStopCamMove();"/>'
					 +'<input type="button" value="고각" onMouseDown="doCamMove(high_angle);" onMouseUp="doStopCamMove();" onMouseOut="doStopCamMove();"/>'
					 +'<input type="button" value="저각" onMouseDown="doCamMove(low_angle);" onMouseUp="doStopCamMove();" onMouseOut="doStopCamMove();"/>'
					 +'<input type="button" value="1인칭시점" onclick="setNaviMode(1)" />'
					 +'<input type="button" value="3인칭시점" onclick="setNaviMode(0)" />'
					 +'<div id="jomang_point" style="width:100%; border:1;"></div>'
					 +'</br>';
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성
		
		
		document.getElementById("jomang_point").style.display='block'; 
		
		$('#jomang_point').append($('<input id="ch_auto_view" name="input" type="checkbox" value="" checked/>리스트선택시 조망보기'
				+'<input id="ch_display_text" name="input" type="checkbox" value="" checked/>텍스트표시여부'
				+'<tr><td><div style="width:130px; height:100px; border:1px solid #828790; overflow-y:scroll; background:#FFF;">'
                  +'<table id="listview" border="0" cellpadding="0" cellspacing="0" class="type1" style="width:100%">'
                  +'</table></div></td><tr><td><table><tr><td>X </td><td>'
                  	+'<input type="text" id="txt_x" style="width: 85px; text-align: right;"/></td></tr><tr><td>Y </td>'
                  	+'<td><input type="text" id="txt_y" style="width: 85px; text-align: right;"/></td></tr><tr><td>Z :</td>'
                  	+'<td><input type="text" id="txt_z" style="width: 85px; text-align: right;"/> </td></tr></table></td></tr>'
		));
		
		var turn_left = 'turn_left';
		var turn_right = 'turn_right';
		var high_angle = 'high_angle';
		var low_angle = 'low_angle';
		var timer = null;
		
		makeButton('btn01','저장',function(){ //input button 생성
			var result = '';
			
			var target_pos = top.XDOCX.XDObjGetPosition("Temporary", "대상지").split(',');
			var data = $('#listview tr');
			
			if(top.XDOCX.XDObjGetBox("Temporary", "대상지") == ''){
				alert('대상지가 설정되지 않았습니다.');
				return;
			}
			
			if(data.length == 0){
				alert('입력된 조망점이 없습니다.');
				return;
			}
			
		    var file_path = top.XDOCX.XDUIOpenFileDlg(false, 'txt');
		    if(file_path == '') return;
			
			result = target_pos[0]+','+target_pos[1]+','+target_pos[2];
			
			$.each(data, function(){
				result += '#';
				
				result += $(this).find('td').text()+',';
				result += $(this).find('[name=x_point]').val()+',';
				result += $(this).find('[name=y_point]').val()+',';
				result += $(this).find('[name=z_point]').val();

			});
			
			if(top.XDOCX.XDUISaveTxtFile(file_path, 'xd_jomang1\n'+result+"\n")){
				alert('조망점 저장이 완료 되었습니다.');
			}else{
				alert('조망점 저장에 실패 하였습니다.');
			}
		},'btn02','불러오기',function(){ //input button 생성
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
			
			doInit();
			
			var target_pos = data[0].split(',');
			
			top.XDOCX.XDLaySetEditable("Temporary");
		    top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 0, 0, 0);
		    top.XDOCX.XDRefSetColor(0, 255, 0, 0);
		    top.XDOCX.XDRefSetPos(target_pos[0], target_pos[1], target_pos[2]);
		    
		    top.XDOCX.XDObjCreateText("대상지", "대상지", "");
			
		    $('#listview').empty();
		    txt_x.value = '';
			txt_y.value = '';
			txt_z.value = '';
		    for(var i = 1; i < data.length; i++){
		    	var item = data[i].split(',');
		    	
		    	$('#listview').append($(
		           		'<tr onclick="doSelectJomangPoint(this);" class="grid_row">'+
		    	       	'	<td align="center" class="name">'+
		    	       	'<input type="hidden" value="'+item[1]+'" id="x_point" name="x_point"/>'+
		    	       	'<input type="hidden" value="'+item[2]+'" id="y_point" name="y_point"/>'+
		    	       	'<input type="hidden" value="'+item[3]+'" id="z_point" name="z_point"/>'+item[0]+'</td>'+
		           		'</tr>'
				));
		    }
		},'btn03','조망점 대상지 설정',function(){ //input button 생성
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
		},'btn04','조망점 지점명 설정',function(){ //input button 생성
			if(top.XDOCX.XDObjGetBox("Temporary", "대상지") == ''){
				alert('대상지를 먼저 선택해 주세요.');
				return;
			}
			
			top.initFunction();
			top.addFunction(function(pos){
				var lvCount = $('#listview tr').length;
				var v_jomang_name = $.trim($('#jomang_name').val());
		        
		        if(v_jomang_name == ''){
		        	if($('#ch_display_text')[0].checked){
		        		v_jomang_name = "조망점" + (lvCount + 1);
		            }else{
		            	v_jomang_name = "";
		            }
		        }
		        
		        for(var i = 0; i < $('.name').length; i++){
		        	var name = $($('.name')[i]).text();
		        	
					if(name == v_jomang_name){
						alert('같은 이름의 조망점이 존재합니다.');
						$('#jomang_name')[0].focus();
						return;
					}
		        }
				
//		 		pos[0] = Math.round(new Number(pos[0])); 
//		 		pos[1] = Math.round(new Number(pos[1]));
//		 		pos[2] = Math.round(new Number(pos[2]));
				
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
		},'btn05','실행',function(){
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
		});
		
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
				top.XDOCX.XDCamLookAt(x, $('#input_set_height').val(), z, target_pos[0], target_pos[1], target_pos[2]);
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
		


		/*
		 * 카메라 이동
		 */
		function doCamMove(m_mouseMoveMode){
			try
		    {
		        switch (m_mouseMoveMode)
		        {
		            case "high_angle":
						if (top.XDOCX.XDCamGetMode() == 1)
		                {
							top.XDOCX.XDCamMoveStep(5);
		                }
		                else
		                {
		                	top.XDOCX.XDCamMoveStep(4);
		                }
		                break;
		            case "low_angle":
						if (top.XDOCX.XDCamGetMode() == 1)
		                {
		                	  top.XDOCX.XDCamMoveStep(4);
		                }
		                else
		                {
		                	  top.XDOCX.XDCamMoveStep(5);
		                }
		                break;
		            case "turn_left":
		                if (top.XDOCX.XDCamGetMode() == 1)
		                {
		                	 top.XDOCX.XDCamMoveStep(9);
		                      }
		                else
		                {
		                	top.XDOCX.XDCamMoveStep(8);
		                 }
		                break;
		            case "turn_right":
		                if (top.XDOCX.XDCamGetMode() == 1)
		                {
		                	top.XDOCX.XDCamMoveStep(8);
		                }
		                else
		                {
		                	top.XDOCX.XDCamMoveStep(9);
		                }
		                break;
		        }
		    }catch(e){

		    }
		    
		    timer = setTimeout('doCamMove("'+m_mouseMoveMode+'")', 50);
		}

		/*
		 * 카메라 이동 중지
		 */
		function doStopCamMove(){
			if(timer) clearTimeout(timer);
		}

		
		/*
		 * 1,3인칭 보기
		 * */
		setNaviMode = function(viewFlag) {
		    if (viewFlag == 0) {
	            XDOCX.XDCamSetMode(NaviMode.NAVI_FLY);
	         //   viewFlag = 1;
		    } else {
	        	XDOCX.XDCamSetMode(NaviMode.NAVI_WALK);
	        //	viewFlag = 0;
		    }
		};
		