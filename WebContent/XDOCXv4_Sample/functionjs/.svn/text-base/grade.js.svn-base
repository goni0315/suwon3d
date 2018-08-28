    	var basicInfo='평균경사향 : <input type="textbox" value="" id="avgDirectionResult" size="12"/><br>'
        +'평균경사도 : <input name="LowHeight0" type="text" id="avgAngleResult" style="width:100px">도<br><br>'
        +'<legend>경사향별 색상표'
        +'</legend>'
        +'<table width="230" border="0" cellpadding="0">'
        +'<tr>'
        +'<td width="60" bgcolor="#ff6400">&nbsp;</td>'
        +'<td>북</td>'
        +'<td width="60" bgcolor="#ffaf00">&nbsp;</td>'
        +'<td>북동</td>'
        +'</tr>'
        +'<tr>'
        +'<td bgcolor="#ffff00">&nbsp;</td>'
        +'<td>동</td>'
        +'<td bgcolor="#32ff96">&nbsp;</td>'
        +'<td>남동</td>'
        +'</tr>'
        +'<tr>'
        +'<td bgcolor="#0064ff">&nbsp;</td>'
        +'<td>남</td>'
        +'<td bgcolor="#f3264c">&nbsp;</td>'
        +'<td>남서</td>'
        +'</tr>'
        +'<tr>'
        +'<td bgcolor="#963296">&nbsp;</td>'
        +'<td>서</td>'
        +'<td bgcolor="#c80064">&nbsp;</td>'
        +'<td>북서</td>'
        +'</tr>'
        +'</table><br><br>'
        ;
    	
    	
    	infoInit(basicInfo);//위에 정의한 메뉴 생성
		

    	makeButton('btn01','영역선택',function(){ //input button 생성
    		
    		top.setWorkMode('');
    		top.XDOCX.XDUIClearInputPoint();
    		top.XDOCX.XDLayRemove("slant");
    		top.XDOCX.XDUISetWorkMode(24);
    		
    	},'btn01','영역취소',function(){ //input button 생성

    		top.XDOCX.XDUIClearInputPoint();
    		
    	},'btn01','경사향분석',function(){ //input button 생성
    		
    		if (top.XDOCX.XDUIInputPointCount() > 2)
    		{
    		    top.XDOCX.XDLayRemove("slantDirection");
    		    top.XDOCX.XDLayCreateEX(1, "slantDirection", 1, 30000);
    		    top.XDOCX.XDLaySetEditable("slantDirection");

    		    result = top.XDOCX.XDAnsTerrainAvgDirect();

    		    top.XDOCX.XDMapResetRTT();
    		    top.XDOCX.XDMapRender();
    		    top.XDOCX.XDUISetWorkMode(1);

    			var avgDirection = ''; // 평균경사향
    			var avgAngle = ''; // 평균경사도

    			avgAngle = parseInt(result*100)/100; // 평균경사도
    			
    		    if (result <= 12.25 && result > -12.25){
    				avgDirection = '북향';
    		    }else if (result <= 33.75 && result > -12.25){
    				avgDirection = "북북동향";
    		    }else if (result <= -12.5 && result > -33.75){
    				avgDirection =  "북북서향";
    		    }else if (result <= 56.25 && result > 33.75){
    				avgDirection =  "북동향";
    		    }else if (result <= -33.75 && result > -56.25){
    				avgDirection =  "북서향";
    		    }else if (result <= 78.75 && result > 56.25){
    				avgDirection = "북동동향";
    		    }else if (result <= -56.25 && result > -78.75){
    				avgDirection =  "북서서향";
    		    }else if (result <= 101.25 && result > 78.75){
    				avgDirection = "동향";
    		    }else if (result <= -78.75 && result > -101.25){
    				avgDirection = "서향";
    		    }else if (result <= 123.75 && result > 101.25){
    				avgDirection = "남동동향";
    		    }else if (result <= -101.25 && result > -123.75){
    				avgDirection =  "남서서향";
    		    }else if (result <= 146.25 && result > 123.75){
    				avgDirection = "남동향";
    		    }else if (result <= -123.75 && result > -146.25){
    				avgDirection = "남서향";
    		    }else if (result <= 168.75 && result > 146.25){
    				avgDirection = "남남동향";
    		    }else if (result <= -146.25 && result > -168.75){
    				avgDirection =  "남남서향";
    		    }else if (result <= 180 && result > 168.75){
    				avgDirection = "남향";
    		    }else if (result <= -168.75 && result >= -180){
    				avgDirection =  "남향";
    		    }else{
    				alert("오류가 발생하였습니다.");
    		    }
    			
    		    avgDirectionResult.value = avgDirection;
    		    avgAngleResult.value = avgAngle;
    		    
    		    top.setIndicator('경사향', {
    	     		'평균경사향': avgDirection, 
    	     		'평균경사도': avgAngle
    	     	});

    		}else{
    			alert("3개 이상의 점을 입력해야 합니다.");
    		}
		    
    	}); 
