		var basicInfo='<input type="radio" value="" id="bli_img_type1"name="bli_img_type" checked/>'
			+'라이브러리 선택<select id="tds_list" name="tds_list" onChange="sel3ds(this.value);"></select><br>'
			+'<input type="radio" value="" id="bli_img_type2" name="bli_img_type"/>라이브러리 직접선택'
				+'<input type="text" id="tds_path" name="tds_path" readOnly>';

		infoInit(basicInfo);//위에 정의한 메뉴 생성
		previewPage_load();
		//document.getElementById("libView").style.display ='block'; //미리보기
		//document.getElementById("3ds_list").style.display = 'block';
		makeButton('btn01','찾기',function(){ //input button 생성

			if ('tds_path'){	// shp 파일 찾기
				if (!bli_img_type2.checked) return;
				var fileName = TDS_VIEW.XDUIOpenFileDlg(true, '3ds');
				if (fileName != ""){
					if (TDS_VIEW.XDUIFileExist(fileName)){
						document.getElementById('tds_path').value = fileName;	
		
						var ln = TDS_VIEW.XDLayGetEditable();
						var objkey = "1";
						TDS_VIEW.XDObjDelete(ln, objkey);
		
						if (TDS_VIEW.XDUIFileExist(fileName)){
							tdsPath = fileName;
		
							TDS_VIEW.XDRefSetPos(250, 0, 250);
							TDS_VIEW.XDObjInsert3DS(objkey, fileName, 150);
							TDS_VIEW.XDSrcLocalObject(ln, objkey);
		
							TDS_VIEW.XDMapRender();
						} else {
							alert("3DS 모델링 로딩에 실패하였습니다.");
						}
					}
				}
			}
		},'btn02','건물 구축',function(){
			if ('run'){		// 실행
				top.setWorkMode('3ds_input');
				top.XDOCX.XDUISetWorkMode(20);
			}
		});
		
		//tds();
		var tds_path = 'tds_path';
		//var TDS_VIEW = XDOCX;
		//미리보기
		function preview(tp1, tp2, tds, img){
			if (tds == "") return;
			if (img == "") return;
			
			if (bli_img_type1.checked){
				var url = "C:\\xdcashe\\kopss\\lib\\";
				var path = "C:\\xdcashe\\kopss\\lib\\";
				var tds_url = url + tp1 + "/" + tp2 + "/" + tds + ".3DS";
				//var tds_path = path + tp1 + "\\" + tp2 + "\\" + tds + ".3DS";
				var tds_path = path + tds + ".3DS";
				var img_url = url + tp1 + "/" + tp2 + "/" + img + ".JPG";
				//var img_path = path + tp1 + "\\" + tp2 + "\\" + img + ".jpg";
				var img_path = path + img + ".JPG";
				
				if (!TDS_VIEW.XDUIFileExist(tds_path)){
					if (!TDS_VIEW.XDWebFileDownload(tds_url, tds_path)) {
						alert("3DS 모델링 로딩에 실패하였습니다");
						return;
					}
				}
				if (!TDS_VIEW.XDUIFileExist(img_path)){
					TDS_VIEW.XDWebFileDownload(img_url, img_path);
				}
		
				var ln = TDS_VIEW.XDLayGetEditable();
				var objkey = "1";
				TDS_VIEW.XDObjDelete(ln, objkey);
				// 다운 받으면 화면에 보이기
				if (TDS_VIEW.XDUIFileExist(tds_path)){
					tdsPath = tds_path;
					
					TDS_VIEW.XDRefSetPos(250, 0, 250);
					TDS_VIEW.XDObjInsert3DS(objkey, tdsPath, 150);
					TDS_VIEW.XDSrcLocalObject(ln, objkey);
								
					TDS_VIEW.XDMapRender();
				} else {
					alert("3DS 모델링 로딩에 실패하였습니다.");
				}
			}
		}
		
		var tdsPath = "";
		
		function previewPage_load(){
		
			var url = top.WEB_SERVER_URL + "/symbols/BASE";
			var path = top.m_workPath + "kopss/BASE";
			
			if (!TDS_VIEW.XDUIFileExist(path + ".xdw")){
				TDS_VIEW.XDWebFileDownload(url + ".xdw", path + ".xdw");
			}
			if (!TDS_VIEW.XDUIFileExist(path + ".xdi")){
				TDS_VIEW.XDWebFileDownload(url + ".xdi", path + ".xdi");
			}
			if (!TDS_VIEW.XDUIFileExist(path + ".xdl")){
				TDS_VIEW.XDWebFileDownload(url + ".xdl", path + ".xdl");
			}
			
			if (TDS_VIEW.XDUIFileExist(path + ".xdl")){
				TDS_VIEW.XDLayReadFile(path + ".xdl");
			}
			
			TDS_VIEW.XDCtrlSetView(0); // 맵 컨트롤 부분
			/*
			 *  0 : 맵 컨트롤 사용 안함
				1 : 인덱스 맵의 우하단 이동시 컨트롤 사용
				2 : 맵 컨트롤만 사용
				3 : 인덱스 맵만 사용
			 * */

			selType('A');
			
			TDS_VIEW.XDMapRender();
			
		}
		
		function sel3ds(value){
			if (value == "") return;
			var info = value.split("#");
			
			preview(info[0], info[1], info[2], info[3]);
		}

		function selType(value){
			tds_list.options.length = 0;
			
			if (value == "A"){	// 관공서
				tds_list.options[0] = new Option("- 선택 -","");
				tds_list.options[1] = new Option("개선문", "A#1#A01001#A01001");
				tds_list.options[2] = new Option("건물_교회", "A#1#A01002#A01002");
				tds_list.options[3] = new Option("건물_성당", "A#1#A01003#A01003");
				tds_list.options[4] = new Option("건물_시계탑", "A#1#A01004#A01004");
				tds_list.options[5] = new Option("건물_타워", "A#1#A01005#A01005");
			}
		}