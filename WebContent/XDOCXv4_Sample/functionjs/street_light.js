		var basicInfo='<input name="sl_img_type" type="hidden" id="sl_img_type1">'
					 +'가로등 종류<select onChange="javascript:sel3ds(this.value);">'
					 	+'<option value="0">선택</option>'
                    	+'<option value="type1#SL1">가로등1</option>'
                    	+'<option value="type2#SL2">가로등2</option>'
                    	+'<option value="type3#SL3">가로등3</option>'
                    	+'<option value="type4#SL4">가로등4</option>'
                    	+'</select><br>'
                     +'가로등 간격<input id="tree_gab" value="8" text-align: right;" maxlength="10" size="3"/> m <br>'
                     +'가로등 높이<input id="tree_hei" value="6.0" text-align: right;" maxlength="10" size="3"/> m <br>'
                     +'가로등 방향<input id="tree_angle" value="0" text-align: right;" maxlength="3" size="3"/> 도'
					 +'<br><br>';
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성

		var tdsPath = "";

		makeButton('btn01','구간 선택',function(){
			top.XDOCX.XDUISetWorkMode(21);
			
		},'btn02','구간 취소',function(){
			top.XDOCX.XDUIClearInputPoint();
			top.XDOCX.XDUISetWorkMode(1);
			
		},'btn03','실행',function(){
			if ('run'){		// 실행
				if (top.XDOCX.XDUIInputPointCount() < 2) {
					alert('2개 이상의 지점을 입력하세요');
					return;
				}
			
				if (tdsPath == "") {
					alert('3DS 모델링 파일을 선택하세요');
					return;
				}
				
				var objkey = getCurrDate();
				top.XDOCX.XDObjCreate3DSymbol(objkey, tree_gab.value, tree_hei.value, tree_angle.value, tdsPath);	
				
		        top.XDOCX.XDUIClearInputPoint(); 
		        top.XDOCX.XDUISetWorkMode(1);
			}
		});
		

		function preview(tds, png){
			if (tds == "") return;
			if (png == "") return;
			
			if (sl_img_type1){
				var url = top.WEB_SERVER_URL + "/symbols/light/";
				var path = top.m_workPath + "kopss/light/";
				
				if (!TDS_VIEW.XDUIFileExist(path + tds + ".3DS")){
					if (!TDS_VIEW.XDWebFileDownload(url + tds + ".3DS", path + tds + ".3DS")) {
						alert("3DS 모델링 로딩에 실패하였습니다");
						return;
					}
				}
				if (!TDS_VIEW.XDUIFileExist(path + png + ".png")){
					TDS_VIEW.XDWebFileDownload(url + png + ".png", path + png + ".png");
				}

				var ln = TDS_VIEW.XDLayGetEditable();
				var objkey = "1";
				TDS_VIEW.XDObjDelete(ln, objkey);
				// 다운 받으면 화면에 보이기
				if (TDS_VIEW.XDUIFileExist(path + tds + ".3DS")){
					tdsPath = path + tds + ".3DS";
					
					TDS_VIEW.XDRefSetPos(250, 0, 250);
					TDS_VIEW.XDObjInsert3DS(objkey, tdsPath, 150);
					TDS_VIEW.XDSrcLocalObject(ln, objkey);
								
					TDS_VIEW.XDMapRender();
				} else {
					alert("3DS 모델링 로딩에 실패하였습니다.");
				}
			}
		}

		function sel3ds(value){
			if (value == "") return;
			var info = value.split("#");
			
			preview(info[0], info[1]);
		}

		function page_load(){
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
			
//		 	if (TDS_VIEW.XDUIFileExist(path + ".xdw")){
//		 		TDS_VIEW.XDReadXDWFile(path + ".xdw");
//		 	}
			if (TDS_VIEW.XDUIFileExist(path + ".xdl")){
				TDS_VIEW.XDLayReadFile(path + ".xdl");
			}
			
			TDS_VIEW.XDCtrlSetView(0);
			
			TDS_VIEW.XDMapRender();
		}