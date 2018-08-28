    	var basicInfo=''
            +'현재날짜 : <input type="text" value="" id="today" /><br>'   
    		+'시작시간 : <select name="s_flag" id="s_flag"style="width:52px;">'
    		+'<option value="오전" selected="selected">오전</option>'
    		+'<option value="오후">오후</option>'
    		+'</select>'
    		+'<select name="s_hour" id="s_hour" style="width:42px">'
    		+'</select>'
    		+' : <select name="s_minute" id="s_minute" style="width:42px">'
    		+'</select><br>'
    		+'종료시간 : <select name="e_flag" id="e_flag"style="width:52px;">'
    		+'<option value="오전">오전</option>'
    		+'<option value="오후"  selected="selected">오후</option>'
    		+'</select>'    		
    		+'<select name="e_hour" id="e_hour" style="width:42px">'
    		+'</select>'
    		+' : <select name="e_minute" id="e_minute" style="width:42px">'
    		+'</select></br><br>';

        
    	infoInit(basicInfo);//위에 정의한 메뉴 생성
    	var r = Array();
    	var g = Array();
    	var b = Array();
    	
    	r[5] = 0;
    	g[5] = 0;
    	b[5] = 0;
		r[0] = 255;
		g[0] = 0;
		b[0] = 0;
		r[1] = 219;
		g[1] = 0;
		b[1] = 0;
		r[2] = 165;
		g[2] = 0;
		b[2] = 0;
		r[3] = 111;
		g[3] = 0;
		b[3] = 0;
		r[4] = 75;
		g[4] = 0;
		b[4] = 0;  
		
		$('#resultset').append($(
				'<br><legend>침해량 범례	'
			    +'<table width="224" border="0" cellpadding="0">'
			      +'<tr>'
			        +'<td width="70">없음</td>'
			        +'<td><div class="setColor" id="setColor" style="background-color: #ff0000; width: 148px; height: 17px; border-width: 0px; border-style: none;"></div></td>'
			        +'</tr>'
			      +'<tr>'
			        +'<td>0~1시간</td>'
			        +'<td><div class="setColor" id="setColor1" style="background-color: #DB0000; width: 148px; height: 17px; border-width: 0px; border-style: none;"></div></td>'
			        +'</tr>'
			      +'<tr>'
			        +'<td>1~2시간</td>'
			        +'<td><div class="setColor" id="setColor2" style="background-color: #A50000; width: 148px; height: 17px; border-width: 0px; border-style: none;"></div></td>'
			        +'</tr>'
			      +'<tr>'
			        +'<td>2~3시간</td>'
			        +'<td><div class="setColor" id="setColor3" style="background-color: #6F0000; width: 148px; height: 17px; border-width: 0px; border-style: none;"></div></td>'
			        +'</tr>'
			      +'<tr>'
			        +'<td>3~4시간</td>'
			        +'<td><div class="setColor" id="setColor4" style="background-color: #4B0000; width: 148px; height: 17px; border-width: 0px; border-style: none;"></div></td>'
			        +'</tr>'
			      +'<tr>'
			        +'<td>5시간이상</td>'
			        +'<td><div class="setColor" id="setColor5" style="background-color: #000000; width: 148px; height: 17px; border-width: 0px; border-style: none;"></div></td>'
			        +'</tr>'
			      +'</table>'
		));
    	
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
        var month = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
        var chan_val = year + '-' + month + '-' + day;
        $('#today').val(chan_val);
        
    	makeButton('btn01','측정영역설정',function(){ //input button 생성
    		top.setWorkMode('');
    		top.XDOCX.XDUIClearInputPoint();
    		top.setXDMouseMode(24);
    	},'btn01','객체선택',function(){ //input button 생성
    		top.setXDMouseMode(6);
    		top.setWorkMode('객체선택');
    	},'btn01','실행',function(){ //input button 생성
    		
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
    		
    		// 분석 유효성 검사
    	    if (top.XDOCX.XDUIInputPointCount() < 3 ){
    	    	alert('침해량 분석할 영역을 설정해 주세요.');
    			return;
    	    }
    		
    	    if (top.XDOCX.XDSelGetCount() < 1 ){
    	    	alert('객체를 선택해 주세요.');
    	        return;
    	    }
    	    
    	    // 분석 결과물인 그리드 표현을 담을 대상 레이어 및 설정
    	    top.XDOCX.XDLayRemove("SunGrid");
    	    top.XDOCX.XDLayCreate(1, "SunGrid");
    	    top.XDOCX.XDLaySetEditable("SunGrid");
    	    top.XDOCX.XDLaySetHiddenValue("SunGrid", 1, 10000);

    	    // 범례 정보 설정
    	    top.XDOCX.XDAnsInundationClearColor();
    	    
    	    top.XDOCX.XDAnsInundationSetColor(255, r[0], g[0], b[0]);    //15 침해 없습
    	    
    	    top.XDOCX.XDAnsInundationSetColor(255, r[1], g[1], b[1]);    //14 20분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[1], g[1], b[1]);    //13 40분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[1], g[1], b[1]);    //12 1시간

    	    top.XDOCX.XDAnsInundationSetColor(255, r[2], g[2], b[2]);    //11 1시간 20분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[2], g[2], b[2]);   // 10 1시간 40분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[2], g[2], b[2]);    // 9  2시간

    	    top.XDOCX.XDAnsInundationSetColor(255, r[3], g[3], b[3]);  // 8  2시간 20분 
    	    top.XDOCX.XDAnsInundationSetColor(255, r[3], g[3], b[3]);  // 7  2시간 40분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[3], g[3], b[3]);  // 6  3시간

    	    top.XDOCX.XDAnsInundationSetColor(255, r[4], g[4], b[4]);    // 5  3시간 20분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[4], g[4], b[4]);    // 4  3시간 40분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[4], g[4], b[4]);    // 3  4시간

    	    top.XDOCX.XDAnsInundationSetColor(255, r[5], g[5], b[5]);  // 2  4시간 20분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[5], g[5], b[5]); // 1  4시간 40분
    	    top.XDOCX.XDAnsInundationSetColor(255, r[5], g[5], b[5]); // 0  5시간 이상


    	    var ideley = 2;

    	   top.XDOCX.XDAnsShadowDamageFromGrid(year, month, day, s_hour, s_minute, e_hour, e_minute, ideley);
    	   

    	   // 화면 반영을 위해 맵 갱신

    		top.XDOCX.XDMapResetRTT();
    		top.XDOCX.XDMapRender();
    		top.XDOCX.XDSelClear();
    		top.setXDMouseMode(1);
    		
    	});
    	

    	function doInit(){
    		top.XDOCX.XDLayRemove("SunGrid");
    	    top.mapXDInit();
    	}
   	
 