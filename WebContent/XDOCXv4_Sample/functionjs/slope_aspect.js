    	var basicInfo='평균경사 : <input type="textbox" value="" id="txt01" /><br>'
        +'최대경사 : <input name="LowHeight0" type="text" id="txt02" style="width:100px" ><br>'
    	+'최소경사 : <input name="HiHeight0" type="text" id="txt03" style="width:100px" ></br>';
    	
    	
    	infoInit(basicInfo);//위에 정의한 메뉴 생성
		$('#resultset').append($(
                '<br><legend>경사도별 색상정보</legend>'
                +'<table width="280" height="100%" border="0" cellpadding="0">'
                +'<tr>'
                +'<td width="32" bgcolor="#e11900">&nbsp;</td>'
                +'<td width="15">&nbsp;</td>'
                +'<td width="162">45도 이상 50도미만</td>'
                +'</tr>'
                +'<tr>'
                +'<td bgcolor="#c83200">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>40도 이상 45도미만</td>'
                +'</tr>'
                +'<tr>'
                +'<td bgcolor="#af4b00">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>35도 이상 40도미만</td>'
                +'</tr>'
                +'<tr>'
                +'<td bgcolor="#966400">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>30도 이상 35도미만</td>'
                +'</tr>'
                +'<tr>'
                +'<td bgcolor="#7d7d00">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>25도 이상 30도미만</td>'
                +'</tr>'
                +'<tr>'
                +'<td bgcolor="#649600">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>20도 이상 25도미만</td>'
                +'</tr>'
                +'<tr>'
                +'<td bgcolor="#4baf00">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>15도 이상 20도미만</td>'
                +'</tr>'
                +'<tr>'
                +'<td bgcolor="#32c800">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>10도 이상 15도미만</td>'
                +'</tr>'
                +'<tr>'
              +'<td bgcolor="#19e100">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>5도 이상 10도미만</td>'
                +'</tr>'
                +'<tr>'
              +'<td bgcolor="#00ff00">&nbsp;</td>'
                +'<td>&nbsp;</td>'
                +'<td>0도 이상 5도미만</td>'
                +'</tr>'
                +'</table>'
                
		));
		



    	makeButton('btn01','영역선택',function(){ //input button 생성
    		
    		top.setWorkMode('');
    		top.XDOCX.XDUIClearInputPoint();
    		top.XDOCX.XDLayRemove("slant");
    		top.XDOCX.XDUISetWorkMode(24);
    		
    	},'btn01','영역취소',function(){ //input button 생성

    		top.XDOCX.XDUIClearInputPoint();
    		
    	},'btn01','경사도분석',function(){ //input button 생성
    		if (top.XDOCX.XDUIInputPointCount() > 2){
    			top.XDOCX.XDLayRemove("slant");
    			top.XDOCX.XDLayCreateEX(1, "slant", 1, 30000);
    			top.XDOCX.XDLaySetEditable("slant");
    			result = top.XDOCX.XDAnsTerrainAvgSlove();
    			
    			top.XDOCX.XDMapResetRTT();
    			top.XDOCX.XDMapRender();
    			top.XDOCX.XDUISetWorkMode(1);
    		
    			var txtsp = result.split(",");
    			
    			txt01.value = new String( Math.round((new Number(txtsp[0])*100) / 100) );
    			txt02.value = new String( Math.round((new Number(txtsp[2])*100) / 100) );
    			txt03.value = new String( Math.round((new Number(txtsp[1])*100) / 100) );
    			
    			top.setIndicator('경사도', {
    	     	   '평균경사': txt01.value, 
    	     	   '최대경사': txt02.value, 
    	     	   '최소경사': txt03.value
    	     	});
    	        

    		}else{
    			alert("3개 이상의 점을 입력해야 합니다.");
    		}
		    
    	}); 
