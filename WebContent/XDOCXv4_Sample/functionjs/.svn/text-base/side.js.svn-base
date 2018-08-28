    	var basicInfo='시야각 : <input id="ViewAngle" value="30" style="width:80px; text-align: right;" class="number disImeMode" maxlength="3" />도<br>'
            +'간격(m) : <input id="ViewSpace" value="10" style="width:80px; text-align: right;" class="number disImeMode" maxlength="3" />m</br><br>'; 

    	infoInit(basicInfo);//위에 정의한 메뉴 생성
    	
		$('#resultset').append($(
                '<table width="232" border="0" cellpadding="0" cellspacing="0" class="typeH">'
				+'<tr>'
				+'<th width="60"><input type="checkbox" name="chk_layAll" id="chk_layAll" onClick="Lay_check(this.checked)">No</th>'
				+'<th>레이어명</th>'
				+'</tr>'
				+'</table>'
				+'<div style="width:270px; height:160px; border:1px solid #828790;overflow-y:scroll; background:#FFF;" >'
				+'<table border="0" cellpadding="0" cellspacing="0" id="Layer" style="width:100%">'
				+'</table>'
				+'</div>'
				
		));
		laylist();
    	
		var Start_point0;
		var Start_point1;
		var Start_point2;
		var End_point0;
		var End_point1;
		var End_point2;
		
    	makeButton('btn01','단면시작점',function(){ //input button 생성
    		top.XDOCX.XDLayClear("Temporary");
    		top.XDOCX.XDUIClearInputPoint();
    		top.XDOCX.XDUISetWorkMode(0);
    		top.setWorkMode('WideStart');
    		
    	},'btn01','단면목표점',function(){ //input button 생성
 
    		top.XDOCX.XDUISetWorkMode(0);
    		top.setWorkMode('WideEnd');
    		
    	},'btn01','단면실행',function(){ //input button 생성
    		
    	   top.XDOCX.XDAnsTargetLayerClear();
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
    	   	 	//setTabControl(1, '.div_button', '.div_cls');
    	   	    return;
    	   	}

    	   	var layinfo = new Array();
    	   	
    	   	layinfo = layerNames.split(",");
    	       for ( i = 0; i < layinfo.length; i++)
    	       {
    	                   top.XDOCX.XDLaySetEditable(layinfo[i]);
    	                   //레이어 편집 활성화.
    	                   top.XDOCX.XDAnsTargetLayerAdd(layinfo[i]);
    	       }

    	       top.XDOCX.XDAnsTargetObjectClear();

    	       var selCnt = 0;
    	       var selCnt = top.XDOCX.XDSelGetCount();
    	       var selCode;
    	       var pa = new Array();

    	       for (i = 0; i <= selCnt - 1; i++)
    	       {
    	           selCode = top.XDOCX.XDSelGetCode(i);
    	           pa = selCode.split('#');
    	           top.XDOCX.XDAnsTargetObjectAdd(pa[0], pa[1]);
    	       }

    	       top.XDOCX.XDUIClearInputPoint();
    	       if ((Start_point0!=null) && (Start_point1!=null) && (Start_point2!=null)) {
    	   		
    			}else{
    				alert("분석시점이 없습니다. 분석시점을 다시 입력해주세요.");
    			return;
    			}
    			if ((End_point0!=null) && (End_point1!=null) && (End_point2!=null)) {
    				
    			}else{
    				alert("목표점이 없습니다. 분석시점을 다시 입력해주세요.");
    			return;
    			}
    	      
    	       top.XDOCX.XDUIInput3DPoint(parseFloat(Start_point0), parseFloat(Start_point1), parseFloat(Start_point2));
    	       top.XDOCX.XDUIInput3DPoint(parseFloat(End_point0), parseFloat(End_point1), parseFloat(End_point2));
    	       
    	       var sPath = "c:\\wslice.txt";
    	       top.XDOCX.XDLaySetEditable("Temporary");
    	       
    	       if (top.XDOCX.XDAnsWideSlice(parseFloat(ViewAngle.value), parseFloat(ViewSpace.value), sPath))
    	       {
    	       	var w = 700;
    	    	var h = 500;
    	    	var l = screen.width - w;
    	    	var t = screen.height - h;
    	    	

    	        var url = "./popview/pop_section.html";

    	    	win_dan = window.showModelessDialog(url, top, "dialogWidth:" + w + "px; dialogHeight:" + h + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px; border:thin; status:no; resizable:no; center:no; help:no; scroll:no;");
    	    	
    	       }
    	       else
    	       {
    	          alert("분석에 실패하였습니다.");
    	       }
    	       
    	       top.XDOCX.XDUIClearInputPoint();
    		
    	}); 
    	

    	
    	//레이어 리스트
    	function laylist(){
    		var oList = $('#Layer');
    		oList.empty();
    		
    			$.getJSON("json/sidelayer.json", function(data,status) {

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
