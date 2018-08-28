    	var basicInfo='가시권 분석 시야 각<br><input type="textbox" value="90" id="ViewAngle" size="4"/> 도</br>'
    		+'가시권 분석 시야 높이<br><input type="textbox" value="1.7" id="ViewHeight" size="4"/></br>'
    		+'가시권 분석결과 전체범위<br><input type="textbox" value="" id="tArea" size="8"/></br>'
    		+'가시권 분석결과 가시범위<br><input type="textbox" value="" id="gZone" size="8"/></br><br>';

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
    	
    	makeButton('btn01','분석 시작점',function(){ //input button 생성
    		top.XDOCX.XDSetMouseState(0);
    		top.setWorkMode('Gs_Start_point');
    		
    	},'btn02','분석 목표점',function(){ //input button 생성
    		top.XDOCX.XDSetMouseState(0);
    		top.setWorkMode('Gs_End_point');
		},'btn03','분석 실행',function(){ //input button 생성
			if ((Start_point0!=null) && (Start_point1!=null) && (Start_point2!=null)) {
				
			}else{
				alert("분석시점이 없습니다. 분석시점을 다시 입력해주세요.");
			return;
			}
			if ((Start_point0!=null) && (Start_point1!=null) && (Start_point2!=null)) {
				
			}else{
				alert("분석시점이 없습니다. 분석시점을 다시 입력해주세요.");
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
		     
			top.XDOCX.XDAnsSetViewElement(ViewAngle.value, 1);
			
			rt = top.XDOCX.XDAnsCreateViewshed(parseFloat(Start_point0), parseFloat(Start_point1 +  Number(ViewHeight.value)), parseFloat(Start_point2), parseFloat(End_point0), parseFloat(End_point1), parseFloat(End_point2));
			
		    var info = rt.split(",");
		    tArea.value = parseInt(info[0]*100)/100;
		    gZone.value = parseInt(info[1]*100)/100;
		    var x = parseFloat(gZone);
		    var y = parseFloat(tArea);
		}); 
