		var basicInfo='<a id="tree_hide1"><input type="hidden" name="tree_type" id="tree_type1"/></a>'
					 +'가로수 종류<input name="st_img_type" type="hidden" id="st_img_type1"/>'
					 +'<select onChange="javascript:selImage(this.value);">'
	                     +'<option value="0">선택</option>'
	                     +'<option value="1">느티나무</option>'
	                     +'<option value="2">단풍나무</option>'
	                     +'<option value="3">대왕참나무</option>'
	                     +'<option value="4">메타쉐콰이어</option>'
	                     +'<option value="5">벚꽃나무</option>'
	                     +'<option value="6">벚나무</option>'
	                     +'<option value="7">산벚나무</option>'
	                     +'<option value="8">살구나무</option>'
	                     +'<option value="9">소나무</option>'
	                     +'<option value="10">수양버들</option>'
	                     +'<option value="11">왕벚나무</option>'
	                     +'<option value="12">은행나무</option>'
	                     +'<option value="13">이팝나무</option>'
	                     +'<option value="14">중국단풍나무</option>'
	                     +'<option value="15">플라타나스</option>'
	                     +'<option value="16">회화나무</option>'
                     +'</select><br>'
                     +'<a id="tree_hide2">가로수 배치 간격<input id="tree_gab" value="8" text-align: right;" maxlength="2" size="3"/> m </a><br>'
                     +'가로수 높이 조절<input id="tree_hei" value="6.0" text-align: right;" maxlength="10" size="3" /> m <br>'
                     +'가로수 너비 조절<input id="tree_width" value="4.5" text-align: right;" maxlength="10" size="3" /> m <br><br>';

		
		infoInit(basicInfo);//위에 정의한 메뉴 생성
		
		var imgPath = "";

		var tree_edit = 'tree_edit';
		var obj_sel = 'obj_sel';
		var lay_sel = 'lay_sel';
		var img_path = 'img_path';
		
		makeButton('btn01','구간 선택',function(){
			top.XDOCX.XDUISetWorkMode(21);
			
		},'btn02','구간 취소',function(){
			top.XDOCX.XDUIClearInputPoint();
			top.XDOCX.XDUISetWorkMode(1);
			
		},'btn03','실행',function(){
			if ('run'){		// 실행
				if (tree_type1){		// 경로입력식재

					if (top.XDOCX.XDUIInputPointCount() < 2) {
						alert('2개 이상의 지점을 입력하세요');
						return;
					}
					if (imgPath == "" || imgPath == '0') {
						alert('텍스쳐 이미지를 선택하세요');
						return;
					}
									
					var objkey = getCurrDate();
					top.XDOCX.XDObjCreateLineBillboard(objkey, tree_gab.value, tree_width.value, tree_hei.value, imgPath);	
					
			        top.XDOCX.XDUIClearInputPoint();    
			        top.XDOCX.XDUISetWorkMode(1);
				} 
			}
		});
		
		function selImage(value){
			if (value == "") return;
			
			if (st_img_type1){
				var url = top.WEB_SERVER_URL + "/symbol/tree/tree" + value + ".png";
				var path = top.m_workPath + "kopss/tree/tree" + value + ".png";
				
				if (!top.XDOCX.XDUIFileExist(path)){
					if (!top.XDOCX.XDWebFileDownload(url, path)) {
						alert("텍스쳐 파일 로딩에 실패하였습니다");
						return;
					}
				}
				
				// 다운 받으면 화면에 보이기
				if (top.XDOCX.XDUIFileExist(path)){
					img_preview(path);
				} else {
					alert("텍스쳐 파일 로딩에 실패하였습니다.");
				}
			}
		}
		
		function img_preview(src){
			imgPath = src;
		}

		function setType(type){
			if (type == 1){
				document.getElementById('tree_hide1').style.display = "";
				document.getElementById('tree_hide2').style.display = "";
			}else if (type == 2){
				document.getElementById('tree_hide1').style.display = "none";
				document.getElementById('tree_hide2').style.display = "none";
			}
		}
