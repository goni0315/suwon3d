//var basicInfo='1'
/*var basicInfo='객체 아이디 : <input type="text" id="objId" name="objId" value="0"/>'*/
var basicInfo='';

	infoInit(basicInfo);//위에 정의한 메뉴 생성

makeButton('btn01','거리측정',function(){ //input button 생성
	top.XDOCX.XDUISetWorkMode(81);
},
'btn02','높이측정',function(){ //input button 생성
	top.setWorkMode('cal_hei');
	top.XDOCX.XDUISetWorkMode(20);		//입력 지점 설정
	top.XDOCX.XDUIClearInputPoint();	//입력점 초기화
},
'btn03','면적측정',function(){ //input button 생성
	top.XDOCX.XDUISetWorkMode(80);
},
'btn04','부피측정',function(){ //input button 생성
	top.setWorkMode('cal_volume');
	top.XDOCX.XDUISetWorkMode(6);		
	top.XDOCX.XDSelClear();
},
'btn05','지도확대',function(){ //input button 생성
	top.XDOCX.XDUISetWorkMode(2);
},
'btn06','지도축소',function(){ //input button 생성
	top.XDOCX.XDUISetWorkMode(4);
}
); 

