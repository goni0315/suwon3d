		var basicInfo='도로 선택<input name="rd_img_type" type="hidden" id="rd_img_type1" checked>'
					 +'<select id="img_list" onChange="javascript:selImage(this.value);">'
					 	+'<option value="road">소방도로</option>'
					 	+'<option value="road_2">2차선도로</option>'
					 	+'<option value="road2">2차선도로+인도</option>'
					 	+'<option value="road_4">4차선도로</option>'
					 	+'<option value="road4">4차선도로+인도</option>'
					 	+'<option value="road_6">6차선도로</option>'
					 	+'<option value="road6">6차선도로+인도</option>'
					 	+'<option value="road_8">8차선도로</option>'
					 	+'<option value="road8">8차선도로+인도</option>'
					 	+'<option value="road_10">10차선도로</option>'
					 	+'<option value="road10">10차선도로+인도</option>'
					 	+'<option value="road_12">12차선도로</option>'
					 	+'<option value="road12">12차선도로+인도</option>'
					 +'</select><br>'
					 +'<input name="rd_img_type" type="hidden" id="rd_img_type2">'
					 +'<input type="hidden" id="img_path" name="img_path" readOnly>'
					 +'도로 폭<input id="road_width" value="6" maxlength="10" size="3"/> m (직접입력가능) <br>'
					 +'*1차선 도로폭 기준은 \'3m ~ 3.5m\'.<br>'
					 +'*보행자 도로폭 기준은 \'1m ~ 1.5m\'.<br><br>';
		
		infoInit(basicInfo);//위에 정의한 메뉴 생성
 
		var img_path = 'img_path';
		var cooiseImage = '';
		
		makeButton('btn01','구간 선택',function(){
			top.XDOCX.XDUISetWorkMode(21);//포인터 입력
		},'btn02','구간 취소',function(){
			top.XDOCX.XDUIClearInputPoint();//입력점 초기화
			top.XDOCX.XDUISetWorkMode(1);//이동 손모양
		},'btn03','실행',function(){
			if ('run'){		// 실행
				//imgPath = document.getElementById('img_path').value;
				var imgName = document.getElementById('img_list').value;//여기서 다시 받아와야 함
				if (top.XDOCX.XDUIInputPointCount() < 2) {
					alert('2개 이상의 지점을 입력하세요');
					return;
				}
				if (imgPath == "") {
					alert('텍스쳐 이미지를 선택하세요');
					return;
				}
				
				var objkey = getCurrDate();//연월일시분초
				var trans = 100 * 2.55;//불투명도
				var width = road_width.value;//도로폭조절
				
				top.XDOCX.XDObjCreateLineRoad(objkey, width, trans, 255, 255, 255, imgPath);
		        top.XDOCX.XDUIClearInputPoint();//입력점 초기화
		        top.XDOCX.XDMapLoad();//맵 로딩
		        top.XDOCX.XDUISetWorkMode(1);//마우스 상태를 기본 이동상태로
			}
		});
		
		function selImage(value){
			if (value == "") return;
			cooiseImage = value;
			
			var check = value.substring(4);
			
			if(check.substring(0,1) == '_'){
				var hipenOut = check.substring(1);
				//그냥 도로 일 경우 차선 * 3m(한 차선의 폭)
				document.getElementById('road_width').value = hipenOut * 3;
			}else if(check.substring(0,1) == ''){
				document.getElementById('road_width').value = 6;
			}else{
				//인도가 포함된 도로 일 경우 차선 * 3m(한 차선의 폭) + 2(인도 양쪽의 폭)
				document.getElementById('road_width').value = check * 3 + 2;
			}
			
			if (rd_img_type1){
				//WEB_SERVER_URL 경로가 하드 코딩 되어있음(XDControl.js 59번라인)
				var url = top.WEB_SERVER_URL + "/symbols/road/" + value + ".jpg";
				//m_workPath = c:\\xdcashe\\ C드라이브 루트에 이미지 있는 것 확인
				var path = top.m_workPath + "kopss\\road\\" + value + ".jpg";
				
				if (!top.XDOCX.XDUIFileExist(path)){
					if (!top.XDOCX.XDWebFileDownload(url, path)) {
						alert("텍스쳐 파일 로딩에 실패하였습니다");
						return;
					}
				}
				
				// 다운 받으면 화면에 보이기
				if (top.XDOCX.XDUIFileExist(path)){
					imgPath = path;
				} else {
					alert("텍스쳐 파일 로딩에 실패하였습니다.");
				}
			}
		}