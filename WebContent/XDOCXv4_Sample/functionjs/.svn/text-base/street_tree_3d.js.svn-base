		var basicInfo='<input name="rd_img_type" type="hidden" id="rd_img_type1">'
					 +'가로수 종류선택<select onChange="sel3ds(this.value);">'
					 	+'<option value="0">선택</option>'
                 		+'<option value="tree#tree">가로수1</option>'
                 		+'<option value="tree1#matsuba">가로수2</option>'
                 		+'<option value="tree2#tree1">가로수3</option>'
                 		+'<option value="tree3#meta">가로수4</option>'
                 		+'</select><br>'
					 +'가로수 배치간격<input id="tree_gab" value="8" text-align: right;" maxlength="10" size="3"/> m <br>'
					 +'가로수 높이<input id="tree_hei" value="6.0" text-align: right;" maxlength="10"  size="3"/> m '
					 +'<br><br>';
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성
		previewPage_load();
		var tds_path ='tds_path';
		var tdsPath = '';
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
				//해당 포인트 지점에 3D 객체 생성
				top.XDOCX.XDObjCreate3DSymbol(objkey, tree_gab.value, tree_hei.value, 0, tdsPath);	
				
		        top.XDOCX.XDUIClearInputPoint();
		        top.XDOCX.XDUISetWorkMode(1);
			}
		});
		
		function preview(tds, png){
			if (tds == "") return;
			if (png == "") return;
			
			if (rd_img_type1){
				var url = top.WEB_SERVER_URL + "/symbols/tree3d/";
				var path = top.m_workPath + "kopss/tree3d/";
				
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
				TDS_VIEW.XDObjDelete(ln, objkey);//미니 맵에 있는 객체 삭제
				// 다운 받으면 화면에 보이기
				if (TDS_VIEW.XDUIFileExist(path + tds + ".3DS")){
					tdsPath = path + tds + ".3DS";
					
					TDS_VIEW.XDRefSetPos(250, 0, 250); //미리보기 맵에서의 위치
					TDS_VIEW.XDObjInsert3DS(objkey, tdsPath, 150);//3D 이미지 불러오기
					TDS_VIEW.XDSrcLocalObject(ln, objkey);//객체위치로 카메라 이동
								
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
			
			TDS_VIEW.XDCtrlSetView(0);
			
			TDS_VIEW.XDMapRender();
		}