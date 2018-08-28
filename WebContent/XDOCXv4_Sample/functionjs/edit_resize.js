	
		var basicInfo='레이어 <select name="sel_layer" id="sel_layer" onChange="doLoadObjectOfLayer(this.value);">'
            			+'<option>객체선택모드</option></select>'
            		 +'<br>'
            		 +'<input name="type" type="radio" id="type1"> 배율변경 : '
            		 +' 동서<input id="resize_x" value="100" text-align: right;" maxlength=""/> % '
            		 +' 남북<input id="resize_z" value="100" text-align: right;" maxlength=""/> % '
            		 +' 높이<input id="resize_y" value="100" text-align: right;" maxlength=""/> % '
            		 +'<br>'
            		 +'<input type="radio" name="type" id="type2" checked> 직접변경 : '
            		 +'<input type="radio" name="hei_type" id="hei_type1">'
            		 +' 건물높이<input id="resize_hei" value="9" text-align: right;" maxlength="10"/> m '
            		 +'<input type="radio" name="hei_type" id="hei_type2" checked>'
            		 +' 건물층수<input id="resize_floor" value="3" text-align: right;" maxlength="3"/> 층 '
            		 +'<br>';
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성

		//var rd_resize_mouse1 ='rd_resize_mouse1';
		
		makeButton('btn01','객체선택',function(){ //input button 생성
			top.XDOCX.XDUISetWorkMode(6);
			
		},'btn02','선택취소',function(){ //input button 생성
			top.XDOCX.XDSelClear();
			top.XDOCX.XDUISetWorkMode(1);
		},'btn03','높이조절',function(){ //input button 생성
			if ('height'){		// 위치이동_수평
				if (top.XDOCX.XDSelGetCount() < 1) {
					alert('객체를 선택하세요');
					return;
				}
				top.XDOCX.XDUISetWorkMode(45);
			}
			
		},'btn04','수평너비조절',function(){ //input button 생성
			if ('width'){
				if (top.XDOCX.XDSelGetCount() < 1) {
					alert('객체를 선택하세요');
					return;
				}
				top.XDOCX.XDUISetWorkMode(46);
			}
		},'btn05','실행',function(){ //input button 생성

				if (sel_layer.value == ""){	
					if(top.XDOCX.XDSelGetCount() < 1) {
						alert("선택된 객체가 없습니다.");    
						return ;
					}
					
					if (type1.checked){		
						for(var i = 0; i < top.XDOCX.XDSelGetCount(); i++) {
							temp = top.XDOCX.XDSelGetCode(i);
							pa = temp.split("#");
							var m_selObj_lName = pa[0];
							var m_selObj_Id = pa[1];

							var box = top.XDOCX.XDObjGetBox(m_selObj_lName, m_selObj_Id);
							
							if (box != "") {
								var xy = box.split(",");
								var before_height = xy[4]-xy[1];	// 객체높이
											
								if(top.XDOCX.XDObjSetScale(m_selObj_lName, m_selObj_Id, resize_x.value / 100, resize_y.value / 100, resize_z.value / 100)==true){
									box = top.XDOCX.XDObjGetBox(m_selObj_lName, m_selObj_Id);
									xy = box.split(",");
									var after_height = xy[4]-xy[1];	// 객체높이
									
								   //건물의 중심을 기준으로 크기변경, 고로 땅에 붙이자
									var value = (after_height - before_height) / 2;
									if(getObjectCenterPoint(m_selObj_lName, m_selObj_Id, false, 0)==true){
										top.XDOCX.XDObjMove(m_selObj_lName, m_selObj_Id, m_ox, (parseFloat(m_oy)+value), m_oz, true);
									}
								}
							}
						}
					}else{
						var hei = 0;
						if (hei_type1.checked){
							height = resize_hei.value;
						}else{
							height = 3 * resize_floor.value;
						}
						
						for(var i = 0; i < top.XDOCX.XDSelGetCount(); i++) {
							temp = top.XDOCX.XDSelGetCode(i);
							pa = temp.split("#");
							var m_selObj_lName = pa[0];
							var m_selObj_Id = pa[1];

							var box = top.XDOCX.XDObjGetBox(m_selObj_lName, m_selObj_Id);
							
							if (box != "") {
								var xy = box.split(",");
								var current_height = xy[4]-xy[1];	// 객체높이
								
								// 배율계산
								var times = height/current_height;
							
								if(top.XDOCX.XDObjSetScale(m_selObj_lName, m_selObj_Id, 1, times, 1)==true){
								   //건물의 중심을 기준으로 크기변경, 고로 땅에 붙이자
									var value = (height - current_height) / 2;
									if(getObjectCenterPoint(m_selObj_lName, m_selObj_Id, false, 0)==true){
										top.XDOCX.XDObjMove(m_selObj_lName, m_selObj_Id, m_ox, (parseFloat(m_oy)+value), m_oz, true);
									}
								}
							}
						}
					}
				}else{
					var ln = sel_layer.value;
					
					if (top.XDOCX.XDLayGetObjectCount(ln) > 0){			
						if (type1.checked){		
							for (var i = 0; i < top.XDOCX.XDLayGetObjectCount(ln); i++){
								var key = top.XDOCX.XDLayGetObjectKey(ln, i);

								var box = top.XDOCX.XDObjGetBox(ln, key);
								
								if (box != "") {
									var xy = box.split(",");
									var before_height = xy[4]-xy[1];	// 객체높이
												
									if(top.XDOCX.XDObjSetScale(ln, key, resize_x.value / 100, resize_y.value / 100, resize_z.value / 100)==true){
										box = top.XDOCX.XDObjGetBox(ln, key);
										xy = box.split(",");
										var after_height = xy[4]-xy[1];	// 객체높이
										
									   //건물의 중심을 기준으로 크기변경, 고로 땅에 붙이자
										var value = (after_height - before_height) / 2;
										if(getObjectCenterPoint(ln, key, false, 0)==true){
											top.XDOCX.XDObjMove(ln, key, m_ox, (parseFloat(m_oy)+value), m_oz, true);
										}
									}
								}
							}
						}else{
							var hei = 0;
							if (hei_type1.checked){
								height = resize_hei.value;
							}else{
								height = 3 * resize_floor.value;
							}

							for (var i = 0; i < top.XDOCX.XDLayGetObjectCount(ln); i++){
								var key = top.XDOCX.XDLayGetObjectKey(ln, i);

								var box = top.XDOCX.XDObjGetBox(ln, key);
								
								if (box != "") {
									var xy = box.split(",");
									var current_height = xy[4]-xy[1];	// 객체높이
									
									// 배율계산
									var times = height/current_height;
								
									if(top.XDOCX.XDObjSetScale(ln, key, 1, times, 1)==true){
									   //건물의 중심을 기준으로 크기변경, 고로 땅에 붙이자
										var value = (height - current_height) / 2;
										if(getObjectCenterPoint(ln, key, false, 0)==true){
											top.XDOCX.XDObjMove(ln, key, m_ox, (parseFloat(m_oy)+value), m_oz, true);
										}
									}
								}
							}
						}
					}else{
						alert("레이어 내에 객체가 없습니다.");    
						return ;
					}
				}
				top.XDOCX.XDMapRender();
		});
		
		/**
		 * 해당 레이어의 전체 객체 로드
		 */
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
		
		var m_ox, m_oy, m_oz = 0.0;

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
