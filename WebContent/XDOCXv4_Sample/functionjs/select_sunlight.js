    	var basicInfo=''
            +'<select id="speed_mode" style="height:22">'
            +'<option value="0">빠름</option>'
            +'<option value="1" selected="selected">보통</option>'
            +'<option value="2">느림</option>'
            +'</select>'
            +'현재날짜 : <input type="text" value="" id="today" />'   
    		+'시작시간 : <select name="s_flag" id="s_flag"style="width:52px;">'
    		+'<option value="오전" selected="selected">오전</option>'
    		+'<option value="오후">오후</option>'
    		+'</select>'
    		+'<select name="s_hour" id="s_hour" style="width:42px">'
    		+'</select>'
    		+' : <select name="s_minute" id="s_minute" style="width:42px">'
    		+'</select>'
    		+'종료시간 : <select name="e_flag" id="e_flag"style="width:52px;">'
    		+'<option value="오전">오전</option>'
    		+'<option value="오후"  selected="selected">오후</option>'
    		+'</select>'    		
    		+'<select name="e_hour" id="e_hour" style="width:42px">'
    		+'</select>'
    		+' : <select name="e_minute" id="e_minute" style="width:42px">'
    		+'</select></br>'
    		+'일조량 : <input type="text" value="" id="result_time" />'
    		+'x : <input type="text" value="" id="result_x" />'
    		+'y : <input type="text" value="" id="result_y" />'
    		+'z : <input type="text" value="" id="result_z" /></br>';

    		

    		

        
    	infoInit(basicInfo);//위에 정의한 메뉴 생성
    	//doSelectJomangPoint();
           	
    	for(var i = 1; i <= 12; i++){
    		$("#s_hour").append("<option value="+i+">"+i+"</option>");
    		$("#e_hour").append("<option value="+i+">"+i+"</option>");
    	}
    	for(var i = 1; i <= 60; i++){
    		$("#s_minute").append("<option value="+i+">"+i+"</option>");
    		$("#e_minute").append("<option value="+i+">"+i+"</option>");
    	}
    	
    	$("#s_hour").val("10").attr("selected", "selected");
    	$("#e_hour").val("4").attr("selected", "selected");
    	
    	var shadowTime = false;
    	var input_pos = null; // 측정지점입력
    	
    	var now = new Date();
        var year= now.getFullYear();
        var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
        var chan_val = year + '-' + mon + '-' + day;
        $('#today').val(chan_val);
        
    	var txt_x = 230133.390625
    	var txt_y = 79.696625
    	var txt_z = 312159.812500
    	exeFunction();
    	makeButton('btn01','일조분석 대상설정',function(){ //input button 생성
    		top.setXDMouseMode(6);
    		top.setWorkMode('객체선택');	
    	},'btn01','측정지점입력',function(){ //input button 생성
    		
    		top.addFunction(function(pos){
    			top.XDOCX.XDObjDelete("Temporary", "측정지점");
    			
    			top.XDOCX.XDRefSetColor(255, 255, 0, 0);
    			top.XDOCX.XDRefSetFontStyle("굴림", 12, true, true, 1, 0, 0, 0);
    			top.XDOCX.XDRefSetPos(pos[0], pos[1], pos[2]);	
    	        		
    			top.XDOCX.XDLaySetEditable("Temporary");
    			top.XDOCX.XDObjCreateText('측정지점', '측정지점', '');
    			top.setWorkMode('');
    	        top.setXDMouseMode(1);
    	        top.XDOCX.XDMapRender();
    		});
    		
    		top.setXDMouseMode(0);
    		top.setWorkMode('측정지점입력');
    		
    		top.addFunction(function(pos){
    			input_pos = pos;
    		});
    		
    		//setTabControl(1, '.div_button', '.div_cls');
    	},'btn01','측정실행',function(){ //input button 생성
    		
    		doAnalysis(); 		    
    		
    		//setTabControl(1, '.div_button', '.div_cls');
    	},'btn01','일조분석수치확인',function(){ //input button 생성
    		exeFunction();
    	},'btn01','일시정지',function(){ //input button 생성
    		top.XDOCX.XDAnsShadowSimulation(0);
    		top.setWorkMode('객체선택');	
    	},'btn01','정지',function(){ //input button 생성
    		top.XDOCX.XDAnsShadowSimulStop();
    		top.XDOCX.XDUIShadowTimeInfo(false);
    		top.XDOCX.XDAnsShadowClear();
    		top.XDOCX.XDMapRender();

    	    shadowTime = false;
    	},'btn01','초기화',function(){ //input button 생성
    		$('#result_time').text('');
    		$('#result_x').text('');
    		$('#result_y').text('');
    		$('#result_z').text('');
    		
    		top.XDOCX.XDAnsShadowSimulStop();
    		top.XDOCX.XDUIShadowTimeInfo(false);
    		top.XDOCX.XDAnsShadowClear();
    		top.XDOCX.XDMapRender();

    	    shadowTime = false;
    	    top.mapXDInit();
    	});
    	
    	function doAnalysis(){

    		if(input_pos == null || input_pos.length != 3){
    			alert('측정지점을 입력하십시오.');
    			return;
    		}
    		
    		var s_flag = $('#s_flag').val();
    		var s_hour = parseInt($('#s_hour').val());
    		var s_minute = $('#s_minute').val();
    		
    		var e_flag = $('#e_flag').val();
    		var e_hour = parseInt($('#e_hour').val());
    		var e_minute = $('#e_minute').val();
    		
    		if(s_flag == '오후'){
    			if(s_hour != 12) s_hour = s_hour + 12;
    			else s_hour = 0;
    		}
    		
    		if(e_flag == '오후'){
    			if(e_hour != 12) e_hour = e_hour + 12;
    			else e_hour = 0;
    		}		

    		top.initFunction();
    		top.addFunction(function(){
    			shadowTime = false;
    		    var sTmp = top.XDOCX.XDAnsShadowGetSunLightMinute();

    		    top.XDOCX.XDUIShadowTimeInfo(false);
    		    top.XDOCX.XDAnsShadowClear();
    		    top.XDOCX.XDUIClearInputPoint();
    		    top.XDOCX.XDSelClear();
    		    top.XDOCX.XDMapRender();

    		    top.setXDMouseMode(1);
    		    
    		    if(sTmp){
    		    	var result_time = sTmp.split(',');

    				$('#result_time').val(result_time[0]+'시간 '+result_time[1]+'분');
    		    	$('#result_x').val(input_pos[0]);
    		    	$('#result_y').val(input_pos[1]);
    		    	$('#result_z').val(input_pos[2]);
    		    	
    		    	top.setIndicator('선택지점',
    		    		{
    		    			'일조량': result_time[0]+'시간 '+result_time[1]+'분',
    		    			'TX': input_pos[0],
    		    			'TY': input_pos[1],
    		    			'TZ': input_pos[2]
    		    		}
    		    	);
    		    	

    		    }
    		});
    		
    		if (shadowTime == true) // 일시정지 시 다시 재생
    	    {
    	        top.XDOCX.XDAnsShadowSimulation(1);
    	        return;
    	    }
    		
    		var Cnt = top.XDOCX.XDSelGetCount();

    	    if (Cnt > 0)
    	    {
    	        var startDate, endDate = null;
    	        top.XDOCX.XDUIShadowTimeInfo(true);
    	        
    	        var ideley = 2;
    	        var iterm = 2;
    	      
    	        if($('#speed_mode').val() == '0'){ // 빠름
    	        	ideley = 5;
    	            iterm = 1;
    	        }else if($('#speed_mode').val() == '1'){ // 보통
    	        	ideley = 2;
    	            iterm = 5;
    	        }else if($('#speed_mode').val() == '2'){ // 느림
    	        	ideley = 1;
    	            iterm = 10;
    	        }

    	        top.XDOCX.XDAnsShadowSetPos(input_pos[0], input_pos[1], input_pos[2], true);
    	        top.XDOCX.XDAnsShadowSimulTime(year, mon, day, s_hour, s_minute, 0, e_hour, e_minute, 0);
    	        top.XDOCX.XDShadowSimulTerm(ideley, iterm);

    	        top.XDOCX.XDShadowSimulation(1);
    	        shadowTime = true;
    	    }
    	    
    	    else
    	    {
    	    	alert('일조권 보기 대상객체를 선택해야 합니다.');
    	    }
    	}



