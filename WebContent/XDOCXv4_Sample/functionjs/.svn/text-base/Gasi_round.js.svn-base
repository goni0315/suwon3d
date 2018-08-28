    	var basicInfo='가시권역분석 반경 값<br><input type="textbox" value="90" id="ViewArea" size="4" /> <br>'
    		+'가시권역분석 시야 높이<br><input type="textbox" value="1.8" id="ViewHeight2" size="4" /><br>'
    		+'가시권역분석 분석결과 전체범위<br><input type="textbox" value="" id="tArea2" size="8" /><br>'
    		+'가시권역분석 분석결과 가시범위<br><input type="textbox" value="" id="gZone2" size="8" /><br><br>';

    	infoInit(basicInfo);//위에 정의한 메뉴 생성

    	var Start_point0;
    	var Start_point1;
    	var Start_point2;
    	var End_point0;
    	var End_point1;
    	var End_point2;
    	var Pointcnt = 0;
    	var Center_point0;
    	var Center_point1;
    	var Center_point2;
    	var Pointcnt2 = 0;
    	
    	makeButton('btn01','가시권역 중심점',function(){ //input button 생성
    		top.XDOCX.XDSetMouseState(0);
    		top.setWorkMode('Gs_Center_point');
		},'btn02','가시권역 실행',function(){ //input button 생성
			
			if ((Center_point0!=null) && (Center_point1!=null) && (Center_point2!=null)) {
				
			}else{
				alert("가시권역_중심점이 없습니다. 분석시점을 다시 입력해주세요.")
			return;
			}
			
			var rt = "";
			top.XDOCX.XDRefSetColor(255, 0, 255, 0);			
			top.XDOCX.XDAnsViewShedSetColor(0);
			top.XDOCX.XDAnsViewShedSetColor(1);
			top.XDOCX.XDRefSetColor(255, 255, 0, 0);
			top.XDOCX.XDAnsViewShedSetColor(2);

		     //참조색 사용 후 기본색으로 복귀
		    top.XDOCX.XDRefSetColor(255, 255, 255, 255);
		     
			top.XDOCX.XDAnsSetViewElement(360, 1);
			
			rt = top.XDOCX.XDAnsCreateViewshed(parseFloat(Center_point0), parseFloat(Center_point1) +  parseFloat(ViewHeight2.value), parseFloat(Center_point2), parseFloat(Center_point0), parseFloat(Center_point1), parseFloat(Center_point2) +  parseFloat(ViewArea.value));
			
		    var info = rt.split(",");
		    tArea2.value = parseInt(info[0]*100)/100;
		    gZone2.value = parseInt(info[1]*100)/100;
		    
		}); 
