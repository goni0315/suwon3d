    	var basicInfo='총높이 : <input type="textbox" value="90" id="AvgFloor" size="6"/>m<br>'
        +'최저높이 : <input name="LowHeight0" type="text" id="LowHeight0" size="4">m '
        +'<input name="LowHeight1" type="text" id="LowHeight1" size="4">층<br>'
    	+'최고높이 : <input name="HiHeight0" type="text" id="HiHeight0" size="4">m '
        +'<input name="HiHeight1" type="text" id="HiHeight1" size="4">층<br>'
    	+'평균높이 : <input name="AvgHeight0" type="text" id="AvgHeight0" size="4">m '
        +'<input name="AvgHeight1" type="text" id="AvgHeight1" size="4">층</br>';
    	
    	
    	infoInit(basicInfo);//위에 정의한 메뉴 생성

    	
    	makeButton('btn01','객체선택',function(){ //input button 생성
    		top.XDOCX.XDUISetWorkMode(6); 
    		
    	},'btn01','원형선택',function(){ //input button 생성
    		top.XDOCX.XDUISetWorkMode(10);
    		
    	},'btn02','다각선택',function(){ //input button 생성
    		top.XDOCX.XDUISetWorkMode(11);
    		
    	},'btn01','평균높이분석',function(){ //input button 생성
    		var count = top.XDOCX.XDSelGetCount();
    	    if (count == 0)
    	    {
    	        alert("객체을 선택해 주세요.");
    	        return;
    	    }
    	    
    	    var keyCode;
    	    var layerName;
    		var aveHeight = 0;
    		for (var i = 0; i <= count - 1; i++)
    	    {
    	        pos = i;
    	       var retStr = top.XDOCX.XDSelGetCode(i);
    	       var retParts = retStr.split("#");
    	        if ((retParts[0] != null))
    	            layerName = retParts[0];
    	        if ((retParts[1] != null))
    	            keyCode = retParts[1];
    	            
    	        retStr = top.XDOCX.XDObjectGetBox(layerName, keyCode);
    	        retParts = retStr.split(",");
    	        if ((retParts[1] != null))
    	            bottomHeight = retParts[1];
    	        if ((retParts[4] != null))
    	            topHeight = retParts[4];
    	      
    	        objHeight = topHeight - bottomHeight;
    	       
    	        if (i == 0)
    	        {
    	            minHeight = objHeight;
    	            maxHeight = objHeight;
    	        }
    	        else
    	        {
    	            if (objHeight < minHeight)
    	            {
    	                minHeight = objHeight;
    	            }
    	            if (objHeight > maxHeight)
    	            {
    	                maxHeight = objHeight;
    	            }
    	        }
    	        aveHeight = aveHeight + objHeight;

    	        var cnt =i+1;
    	        
    	        top.XDOCX.XDLaySetEditable("Temporary");
    	        top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
    	        top.XDOCX.XDRefSetColor(0, 0, 255, 0);
    	       
    	        
    	        var x =(parseFloat(retParts[0]) + parseFloat(retParts[3]))/2;
    	        var y =(parseFloat(retParts[1]) + parseFloat(retParts[4]))/2;
    	        var z =(parseFloat(retParts[2]) + parseFloat(retParts[5]))/2;
    	        top.XDOCX.XDRefSetPos(parseFloat(x), parseFloat(y), parseFloat(z));
    	        top.XDOCX.XDObjCreateText(i, parseInt(objHeight*100)/100 +"m", "");
    	       
    	        //pv.XDOCX.XDSetMouseState((short)MouseState.MOVE_GRAB);

    	        top.XDOCX.XDRenderData();
    	    }
    		
    		aveHeight = aveHeight / count;

    		document.getElementById('LowHeight0').value = (parseInt(minHeight*100)/100).toFixed(2);
    		document.getElementById('HiHeight0').value = (parseInt(maxHeight*100)/100).toFixed(2);
    		document.getElementById('AvgHeight0').value = (parseInt(aveHeight*100)/100).toFixed(2);

    		document.getElementById('LowHeight1').value = ((parseInt(minHeight) /parseInt(AvgFloor.value)*10)/10).toFixed(2);
    		document.getElementById('HiHeight1').value = ((parseInt(maxHeight) /parseInt(AvgFloor.value)*10)/10).toFixed(2);
    		document.getElementById('AvgHeight1').value = ((parseInt(aveHeight)/parseInt(AvgFloor.value)*10)/10).toFixed(2);
    	    top.XDOCX.XDSelClear();
    	    //clsMapControl.setMouseState(MouseState.MOVE_GRAB);
    	   top.XDOCX.XDUISetWorkMode(1);
    		
    	}
		    
		); 
