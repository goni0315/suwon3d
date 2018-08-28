	
		var basicInfo='레이어<select name="sel_layer" id="sel_layer" onchange="doLoadObjectOfLayer(this.value);">'
						+'<option>객체선택모드</option></select>' 
					 +'<br>'
					 +'이동거리<input id="textfield2" value="5" name="textfield2" text-align: right;" onChange="dist=this.value;" maxlength="10"/>m<br>'
					 +'<input type="button" value="◀" onclick="objMove(left)"/>'
					 +'<input type="button" value="▲" onclick="objMove(north)"/>'
					 +'<input type="button" value="▼" onclick="objMove(south)"/>'
					 +'<input type="button" value="▶" onclick="objMove(right)"/>'
					 +'<input type="button" value="상" onclick="objMove(up)"/>'
					 +'<input type="button" value="하" onclick="objMove(down)"/>'
					 +'<br>'
					 +'회전각(시계)<input id="textfield3" value="5" name="textfield3" style="width:80px; text-align: right;" onChange="angle=this.value;" maxlength="3" class="number disImeMode"/>&nbsp;도'
					 +'<input type="button" value="회전실행" onclick="objRotate(0)"/><br><br>'
					 +'<input type="button" value="시계15º" onclick="objRotate(15)"/>'
					 +'<input type="button" value="시계45º" onclick="objRotate(45)"/>'
					 +'<input type="button" value="시계90º" onclick="objRotate(90)"/><br><br>'
					 +'<input type="button" value="반시계15º" onclick="objRotate(-15)"/>'
					 +'<input type="button" value="반시계45º" onclick="objRotate(-45)"/>'
					 +'<input type="button" value="반시계90º" onclick="objRotate(-90)"/><br>'
					 +'<br>';
		 
		infoInit(basicInfo);//위에 정의한 메뉴 생성
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
		
		makeButton('btn01','손이동',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(1);
		},'btn02','객체선택',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(6);
		},'btn03','원선택',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(10);
		},'btn04','면선택',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(7);
		},'btn05','다각선택',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(11);
		},'btn06','사각선택',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(8);
		},'btn07','선택취소',function(){ //input button 생성
			top.XDOCX.XDSelClear();
			top.XDOCX.XDUISetWorkMode(1);
		},'btn08','수평이동',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(41);
		},'btn09','수직이동',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(42);
		},'btn10','회전',function(){ //input button 생성
			if (top.XDOCX.XDSelGetCount() < 1) {
				alert('객체를 선택하세요');
				return;
			}		
			top.XDOCX.XDUISetWorkMode(43);
			
		},'btn11','붙여넣기',function(){ //input button 생성
			if (top.getObjCopy() != ""){
				top.setWorkMode('obj_paste');
				top.XDOCX.XDUISetWorkMode(20);
			}else{
				alert('붙여넣기할 객체가 없습니다.');
			}
		},'btn12','잘라내기',function(){ //input button 생성
			if (top.XDOCX.XDSelGetCount() == 1){
				var objCode = top.XDOCX.XDSelGetCode(0);
				objCode = objCode.split("#");
				if (top.XDOCX.XDObjExportXDO(objCode[0], objCode[1], top.getXDWorkPath() + "objCopy.xdo")){
					top.setObjCopy(objCode[1]);	
					top.XDOCX.XDSelDelete();
				}
			}else if (top.XDOCX.XDSelGetCount() > 1){
				alert('단일객체에 대하여 실행가능합니다.');
			}else{
				alert('객체를 선택하세요');
			}
		},'btn13','복사하기',function(){ //input button 생성
			if (top.XDOCX.XDSelGetCount() == 1){
				var objCode = top.XDOCX.XDSelGetCode(0);
				objCode = objCode.split("#");
				if (top.XDOCX.XDObjExportXDO(objCode[0], objCode[1], top.getXDWorkPath() + "objCopy.xdo")){
					top.setObjCopy(objCode[1]);	
					top.XDOCX.XDSelClear();
				}
				
			}else if (top.XDOCX.XDSelGetCount() > 1){
				alert('단일객체에 대하여 실행가능합니다.');
			}else{
				alert('객체를 선택하세요');
			}
		},'btn14','복사취소',function(){ //input button 생성
			top.setObjCopy('');
			top.XDOCX.XDUISetWorkMode(1);
		},'btn15','삭제',function(){ //input button 생성
			if (top.XDOCX.XDSelGetCount() > 0){
				if(confirm('선택한 객체를 삭제합니다.')){
					top.XDOCX.XDSelDelete();
				}
			}else{
				alert('삭제할 객체를 선택하세요');
			}
		});
		
		
		function doLoadLayerInfo(){
			var oList = $('#sel_layer');
			oList.empty();
			
			var arr_layer = top.getExtLayerInfo();
			
			oList.append($('<option value="">객체선택모드</option>'));
			
			$.each(arr_layer, function(){
				var lyr_type = top.XDOCX.XDLayGetType(this); //레이어 타입 반환
				
				if(lyr_type == 0 || lyr_type == 6 || lyr_type == 9)
					oList.append($('<option value="'+this+'">'+this+'</option>'));
			});
		}
		
		function doLoadObjectOfLayer(layer_name){
			if(layer_name == '') return;
			
			top.XDOCX.XDSelClear();
			var layer_count = top.XDOCX.XDLayGetObjectCount(layer_name);
			
			if(layer_count > 0){
				if(confirm("선택하신 레이어는 [" + layer_count + "] 개의 객체를 가지고 있습니다\n계속진행하시겠습니까?")){
					
					for(var i = 0; i < layer_count; i++){
						var objId = top.XDOCX.XDLayGetObjectKey(layer_name, i);
						top.XDOCX.XDSelSetCode(layer_name, objId);
					}
				}
			}else{
				alert('선택하신 레이어에 객체가 존재하지 않습니다.');
			}
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
		
		//회전방향설정
		function objRotate(value){
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
						top.XDOCX.XDObjSetRotate(info[0], info[1], 1, angle);
					}
				}		
			}else{
				var ln = sel_layer.value;
				
				if (top.XDOCX.XDLayGetObjectCount(ln) > 0 ){
					for (var i = 0; i < top.XDOCX.XDLayGetObjectCount(ln); i++){
						var key = top.XDOCX.XDLayGetObjectKey(ln, i);
						
						if (value != 0){
							top.XDOCX.XDObjSetRotate(ln, key, 1, value);
						}else{
							top.XDOCX.XDObjSetRotate(ln, key, 1, angle);
						}			
					}
				}else {
					alert("레이어 내에 객체가 없습니다.");
					return;
				}
			}
			
			top.XDOCX.XDMapRender();
		}