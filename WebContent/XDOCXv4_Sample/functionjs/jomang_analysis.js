	
		var basicInfo='<input type="checkbox" name="checkbox2" id="checkbox2">조망 높이값 설정'
					 +'<input type="text" name="txtHeight" id="txtHeight" maxlength="10" style="width: 80px; text-align: right;"> m'
					 +'<br>'
					 +'시뮬레이션 속도 <input name="slider1input"  id="slider1input" size="4" value="30" style="width: 30px; text-align: right;" readonly/>'
					 +'<div id="slider" style="margin-top:10px;"></div>'
					 +'</br>'
					 +'<div id="jomang_analysis" style="width:100%; border:1;"></div>';
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성
		
		var count = 1;
		var addCount;
		var viewList = '';
		
		document.getElementById("jomang_analysis").style.display='block'; 

		$('#jomang_analysis').append($('<fieldset><legend>방향점리스트</legend><table width="260" border="0" cellpadding="0" cellspacing="0">'
				+'<tr><th width="45">No</th><th width="75">X</th><th width="75">Y</th><th>Z</th></tr></table>'
                +'<div style="width:270px; height:180px; border:1px solid #828790; overflow-y:scroll; background:#FFF;" >'
                +'<table id="tableTest" border="0" cellpadding="0" cellspacing="0" style="width:100%" ></table></div></fieldset>'
		));
		
		$(function(){
			$("#slider").slider({min: 0, max: 50, value: 30, change: function(event, ui){
				$('#slider1input').val(ui.value);
			}});
		});
		
		makeButton('btn01','저장',function fileSave(){ //input button 생성
			var filepath = top.XDOCX.XDUIOpenFileDlg(false, "txt");

			if (filepath == "") { 
				return; }
			var rows = tableTest.rows.length;
			var pos = viewList.split(",");
			var sText = '';
			if(pos[1] == 'POSX'){
				for(var i = 5; i < pos.length; i++)
				{
					if(i%4 == 0 && i%5 == 0){
						if(i%4 == 0){
							sText= sText+pos[i]+"\n";
						}
					}else{
						if(i%5 == 0){
							sText = sText + pos[i]+",";
						}else if(i%4 == 0){
							sText= sText+pos[i]+"\n";
						}else{
							sText = sText+pos[i]+",";
						}
					}
				}
			}else{
				for(var i = 1; i < pos.length; i++)
				{
					if(i%4 == 0 && i%5 == 0){
						if(i%4 == 0){
							sText= sText+pos[i]+"\n";
						}
					}else{
						if(i%5 == 0){
							sText = sText + pos[i]+",";
						}else if(i%4 == 0){
							sText= sText+pos[i]+"\n";
						}else{
							sText = sText+pos[i]+",";
						}
					}
				}
			}

			var r_sText = 'xd_jomang3\n'+sText;

			var a = top.XDOCX.XDUISaveTxtFile(filepath, r_sText); 

			if(a == true){
				alert("txt파일이 저장이 완료됬습니다.");
			}

		},'btn02','불러오기',function fileLoad(){
			if(jomangStr == ''){
				alert("기준점을  선택해주세요");
				return false;
			}
			var rows = tableTest.rows.length;
			var filepath = top.XDOCX.XDUIOpenFileDlg(true, "txt");
			if (filepath == "") { 
				return; 
			}
			if(rows != 1){
				clearAll();
			}
			var i = top.XDOCX.XDUIOpenTxtFile(filepath);
			var strList = i.split('\n');
			var list = '';

			if(strList.length >= 2 && strList[0] == 'xd_jomang3'){
				for(var i = 1; i < strList.length-1; i++)
				{
					list = list +","+ strList[i];
				}
				var pos = list.split(",");
				var cnt = pos.length-1;
				//alert(cnt);
				viewList = '';
				var ant = 1;
				for (var i=1; i < cnt;)
				{
					makeTbl(ant, pos[i], pos[i+1], pos[i+2], pos[i+3]);
					i = i+4;
					ant++;
				}
				mgrdata('s2');
			}else{
				alert('지원하지 않는 형식의 파일입니다.');
			}
			
		},'btn03','새로고침',function clearAll(){
			 var rows = tableTest.rows.length;
			 //alert(rows);
			 for(var i = 0; i < rows; i++)
			 { 	
					tableTest.deleteRow('0');	
			 }
			 viewList = '';

			top.XDOCX.XDLaySetEditable("Temporary");
			top.XDOCX.XDLayClear("Temporary");
			top.XDOCX.XDAnsJomangListClear();
			top.XDOCX.XDLaySetEditable("Temporary2");
			top.XDOCX.XDLayRemove("Temporary2");
			//top.setOperationMode(1);
			top.XDOCX.XDUISetWorkMode(1);
			top.XDOCX.XDMapRender();
			
		},'btn04','조망지점 설정',function selectJomang(state){
			   	top.setObj('1');

				if (top.XDOCX.XDAnsJomangListCount() < 1){
					alert("기준점을 선택해주세요");	
				}else{
				   	var count = top.XDOCX.XDAnsJomangListCount();
				   	alert("방향점 "+count+"를 입력해주세요 .");		
				}
				top.XDOCX.XDAnaJomangElement(top.getObj());
			   
				top.XDOCX.XDUISetWorkMode(94);
				top.setSimulMode(103);
				top.XDOCX.XDLayCreate(9, "Temporary2");
				top.XDOCX.XDLaySetEditable("Temporary2");
				
		},'btn05','실행',function jomangRun_Click(){
			var iJomangSpeed = 0;
			iJomangSpeed = (50 - slider1input.value) * 10;
			if (iJomangSpeed > 0){
				top.setJomangSpeed(iJomangSpeed);
			}
			var m_bolSmoothMove = false;
			if (top.XDOCX.XDAnsJomangListCount() > 2)
			{
				top.XDOCX.XDCamSetSmooth(false);
				top.XDOCX.XDLaySetVisible("Temporary2", false);

				top.XDOCX.XDAnsViewProspectHigh(top.XDOCX.XDAnsJomangListCount(), top.getJomangSpeed(), top.getJomangBasePt());
				top.XDOCX.XDLaySetVisible("Temporary2", true);
				top.XDOCX.XDUISetWorkMode(1);
				top.XDOCX.XDMapRender();
			}
			else
			{
				alert("조망권보기를 시작하기 위해서는 기준점과 2개 이상의 지점을 입력하여야 됩니다.");
			}
		});
		
		/*
		 *높이값 설정
		 * */
		function mgrdata(value){
			
			var rows = tableTest.rows.length;
			var pos = jomangStr.split(",");
			
			top.XDOCX.XDLaySetEditable("Temporary");
			top.XDOCX.XDLayClear("Temporary");
			top.XDOCX.XDLaySetEditable("Temporary2");
			top.XDOCX.XDLayRemove("Temporary2");
			
			top.XDOCX.XDAnsJomangListClear();
			top.XDOCX.XDMapRenderLock(true);
			top.XDOCX.XDUIClearInputPoint();
			top.XDOCX.XDSelClear();
			top.XDOCX.XDMapClearTempLayer();
			top.XDOCX.XDAnsClear();
			top.XDOCX.XDAnsClearSlice();
			top.XDOCX.XDUIDistanceClear();
			top.XDOCX.XDMapRenderLock(false);
			top.XDOCX.XDMapRender();
			
			top.XDOCX.XDLaySetEditable("Temporary");
			top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 255, 255, 255);
			top.XDOCX.XDRefSetColor(0, 0, 0, 0);
			top.XDOCX.XDRefSetPos(pos[0],pos[1],pos[2]);
			top.XDOCX.XDObjCreateText("기준점", "기준점", top.getWorkPath() + "\\texture\\BlueP.png");
			top.XDOCX.XDLaySetEditable("Temporary2");
			top.XDOCX.XDAnsJomangListInsert(pos[0],pos[1],pos[2]);
			top.XDOCX.XDMapRender();
		        
			for(var i =1; i < rows + 1; i++){
				
				var count = document.getElementById('tno'+i).value;
				var pos_x = document.getElementById('tx'+i).value;
				var pos_z = document.getElementById('tz'+i).value;
			    
				if (checkbox2.checked == true){
					var pos_y = txtHeight.value;
				}else{
			 		var pos_y = document.getElementById('ty'+i).value;				 
				}
				
				document.getElementById('ty'+i).value = pos_y;
				top.XDOCX.XDLaySetEditable("Temporary");
				top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 255, 255, 255);
				top.XDOCX.XDRefSetColor(0, 0, 0, 0);
				top.XDOCX.XDRefSetPos(pos_x, pos_y, pos_z);
				//top.XDOCX.XDObjCreateText("방향점" + Convert.ToString(top.XDOCX.XDAnsJomangListCount()), "방향점" + Convert.ToString(top.XDOCX.XDAnsJomangListCount()), Application.StartupPath + "\\images\\GreenP.png");
				top.XDOCX.XDObjCreateText("방향점" + count, "방향점" + count, top.getWorkPath() + "\\texture\\GreenP.png");            
				top.XDOCX.XDLaySetEditable("Temporary2");
				top.XDOCX.XDAnsJomangListInsert(pos_x, pos_y, pos_z);
				top.XDOCX.XDMapRender();
			}
		}
		/*
		 *  조망 분석
		 */
		function setJomangIn(posX, posY, posZ)
		{
			jomangStr = posX+","+posY+","+posZ;
		}
		
		function makeTbl(countNo, pos_X, pos_Y, pos_Z, str){
			viewList = viewList+","+pos_X+","+pos_Y+","+pos_Z+","+str;
			if(countNo != 'NO'){
				pos_X = parseFloat(pos_X).toFixed(2);
				pos_Y = parseFloat(pos_Y).toFixed(2);
				pos_Z = parseFloat(pos_Z).toFixed(2);
			}
			addCount = countNo;

				$('#tableTest').append($(
						'<tr>'+
						'<td align="center"><input type="text" id="tno'+addCount+'" value="'+countNo+'" name="tno'+addCount+'" size="2" style="border:0;" readonly /></td>'+
						'<td align="center"><input type="text" id="tx'+addCount+'" value="'+pos_X+'" name="tx'+addCount+'" size="7" style="border:0;" readonly /></td>'+
						'<td align="center"><input type="text" id="ty'+addCount+'" value="'+pos_Y+'"name="ty'+addCount+'" size="4" style="border:0;" readonly /></td>'+
						'<td align="center"><input type="text"  id="tz'+addCount+'" value="'+pos_Z+'" name="tz'+addCount+'" size="7" style="border:0;" readonly /></td>'+
						'</tr>'
			    ));
			count++;
		}