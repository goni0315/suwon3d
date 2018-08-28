    	var basicInfo=''
            +'현재날짜 : <input type="text" value="" id="today" /></br>';   
        
    	infoInit(basicInfo);//위에 정의한 메뉴 생성
    	//doSelectJomangPoint();
		$('#resultset').append($(
                '<table width="232" border="0" cellpadding="0" cellspacing="0" class="typeH">'
				+'<tr>'
				+'<th width="40"><input type="checkbox" name="chk_layAll" id="chk_layAll" onClick="Lay_check(this.checked)">No</th>'
				+'<th>레이어명</th>'
				+'</tr>'
				+'</table>'
				+'<div style="width:230px; height:160px; border:1px solid #828790;overflow-y:scroll; background:#FFF;" >'
				+'<table border="0" cellpadding="0" cellspacing="0" id="Layer" style="width:100%">'
				+'</table>'
				+'</div>'
		));
		laylist();
		
    	var shadowTime = false;
    	var input_pos = null; // 측정지점입력
    	
    	var now = new Date();
        var year= now.getFullYear();
        var month = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
        var chan_val = year + '-' + month + '-' + day;
        $('#today').val(chan_val);
        
    	makeButton('btn01','분석기준건물선택',function(){ //input button 생성
    		top.setXDMouseMode(6);
    		top.setWorkMode('객체선택');	
    	},'btn01','분석실행',function(){ //input button 생성
  		
    		var info = "";
    		
    		if(top.XDOCX.XDSelGetCount() == 0){
    			alert("분석 기준건물 1개를 선택하세요.");
    			return;
    		}else{
    			info = top.XDOCX.XDSelGetCode(0);
    		}
    		
 		
    		var selinfo = info.split('#');
    		var layerNames = '';
    		var checkCount = 0;
    		var list_layer = $('[name=layer]');
    		
    		$.each(list_layer, function(){
    			if(this.checked){
    				checkCount += 1;
    				
    				if(layerNames.length > 0){
    					layerNames += ",";
    				}
    				
    				layerNames += this.value;
    			}
    		});
    		
    		if (checkCount == 0)
    		{
    		    alert("선택된 레이어가 없습니다.");
    		    return;
    		}
    		alert();
    		var tmpPath = "C:\\xdcashe\\iljoInfringe.txt";
//    	 	var result = top.XDOCX.XDAnsILJODamageAtBuildByObjects(tmpPath, selinfo[0], selinfo[1], layerNames, checkCount, yy, mm, dd, 17, false);
    		var result = top.XDOCX.XDAnsILJODamageAtBuildByObjects(tmpPath, selinfo[0], selinfo[1], layerNames, checkCount, year, month, day, 17, false);
    		
    		if (result != ""){
    			if (result == "") return;
    			top.setStrTemp(tmpPath);
    			
    			var winOpen;
    			var w = 655;
    			var h = 553;
    			var l = screen.width - w;
    			var t = screen.height - h;
    			
    			if (/MSIE/.test(navigator.userAgent)) { 
    				if(navigator.appVersion.indexOf("MSIE 7.0")>=0) {
    					w = 650;
    					h = 523;
    				} else if(navigator.appVersion.indexOf("MSIE 8.0")>=0) {
    					w = 650;
    					h = 523;
    				}
    				l = screen.width - (w + 10);
    				t = screen.height - (h + 30);                     
    			}
    			
    			var cntr = "no";
//    	 		var url = "../left/pop_sunshine1.jsp";
    			var url = "Sunshine_List.html";
    			
    			if (winOpen != null) { winOpen.close(); winOpen = null; }
//    	 		winOpen = window.showModelessDialog(url, top, "dialogWidth:" + w + "px; dialogHeight:" + h + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px; border:thin; status:no; resizable:no; center:" + cntr + "; help:no; scroll:no;");
    			winOpen = window.showModelessDialog(url, top, "dialogWidth:628" + "px; dialogHeight:500" + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px; border:thin; status:no; resizable:no; center:" + cntr + "; help:no; scroll:no;");
    		}
    		
    		top.setXDMouseMode(1);

    	});
    	
    	//레이어 리스트
    	function laylist(){
    		var oList = $('#Layer');
    		oList.empty();
    		
    			$.getJSON("layer.json", function(data,status) {

    				$.each(data, function(i, n) { 
        				//oList.append($('<option value="'+n.LARY_ENM+'">'+n.LARY_NM+'</option>'));
        				
        				oList.append($(
        					"<tr>"+
        						"<td width='40' align='center'><input type='checkbox' name='layer' id='checkbox' value='"+ n.LARY_ENM + "'>"+($('#Layer tr').length+1)+"</td>"+
        						"<td align='center'>"+n.LARY_NM+"</td>"+
        					"</tr>"
        				));    				
    				});
    			});    			
    	}
    	
    	//전체 선택 해제
    	function Lay_check(checked){

    			var list_layer = $('[name=layer]');
    			
    			$.each(list_layer, function(){
    				if(checked==true){
    					this.checked =true;
    				}else{
    					this.checked =false;	
    				}
    			});
    		
    	}    
    	
 