/**
 * 로드뷰 관련 함수 모음 
 * 2014 04 03
 */
var win_roadview = null;

/**
 * 좌표변환 함수
 * @fromCoord 원본 좌표
 * @toCoord 목표좌표
 * @x,y 좌표값
 */ 
RoadViewCoord = function(fromCoord,toCoord,x,y){
	
	var url = "http://apis.daum.net/local/geo/transcoord?apikey="+DaumApiKey.geoTrans+"&x="+x+"&y="+y+"&fromCoord="+fromCoord+"&toCoord="+toCoord+"&output=xml";
	//alert(url);
	var ConPos = $.ajax({
		type:"get",
		//asyn:true,
		timeout : 10000,
		url: url,
		dataType: "xml",
		//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
		    },
		success : roadViewCoordCallBack //콜백함수 
		});
	//alert(ConPos);
	}

/**
* 콜백함수 
* json을 바로 가져다 쓸수 없어서 xml2json오픈소스 사용
*/
roadViewCoordCallBack = function(rss,req,st){
		
	var myXML = rss.responseText;
	var JSONConvertedXML = $.xml2json(myXML);
	var paramX =parseFloat(JSONConvertedXML.x);
	var paramY =parseFloat(JSONConvertedXML.y);
	
	ShowRoadView(paramX,paramY); //이동
}

//로드뷰 띄우는 함수
ShowRoadView= function(lng,lat){
	if(win_roadview!=null){win_roadview.close(); win_roadview= null;}
	var w = 595;
	var h = 475;
	var l = 555;
	var t = 30;
	/* if (getIEVersion() >= 7) {
		w = 250;
		h = 300;
	} */
	var requestUrl = "/Suwon3d/pop/roadViewPage.jsp?lng="+encodeURI(encodeURIComponent(lng))+"&lat="+encodeURI(encodeURIComponent(lat))+"&apiKey="+encodeURI(encodeURIComponent(DaumApiKey.roadView));
	var cntr = "no";
	//win_roadview = window.showModelessDialog(requestUrl, "", "dialogWidth:" + w + "px; dialogHeight:" + h + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px; border:thin; status:no; resizable:no; center:" + cntr + "; help:no; scroll:no;");
	//win_roadview = window.open(, "popup", "width:" + w + "px; height:" + h + "px; border:thin; status:no; resizable:no; center:yes; help:no; edge:no; scroll:no;");
	win_roadview = window.open(requestUrl, "roadView","width="+w+",height="+h+",toolbar=no,scrollbars=0,location=0,status=0,menubar=0,resizable=0,directories=0,top="+t+",left="+l);
	return false;
}

//네이버 스트리트뷰 띄우는 함수 
ShowStreetView=function(x,y){
	if(win_roadview!=null){win_roadview.close(); win_roadview= null;}
	var w = 1024;
	var h = 768;
	var l = 250;
	var t = 30;
	/* if (getIEVersion() >= 7) {
		w = 250;
		h = 300;
	} */
	var requestUrl = "http://map.naver.com/?dlevel=14&x="+encodeURI(encodeURIComponent(x))+"&y="+encodeURI(encodeURIComponent(y))+"&mapMode=0&tab=0&street=on&enc=b64";
	
	win_roadview = window.open(requestUrl, "streetView","width="+w+",height="+h+",toolbar=no,scrollbars=0,location=0,status=0,menubar=0,resizable=1,directories=0,top="+t+",left="+l);
	
	return false;
	
}

/**
 * 좌표변환 함수 
 * @param fromCoord 원본 좌표체계, toCoord 변환할 좌표쳬계, x x값, y y값
 * grs80 tm이 없어서 가장 비슷한 wtm으로 변경후 보정치 추가 
 */
CoordTrans = function(fromCoord,toCoord,x,y,flag){
	var url = "http://apis.daum.net/local/geo/transcoord?apikey="+DaumApiKey.geoTrans+"&x="+x+"&y="+y+"&fromCoord="+fromCoord+"&toCoord="+toCoord+"&output=xml";
	console.log(url);
	var ConPos = $.ajax({
		type:"get",
		//asyn:true,
		timeout : 10000,
		url: url,
		dataType: "xml",
		//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
		error : function(request, status, error) {
		     alert("code : " + request.status + "\r\nmessage : " + request.reponseText + "\r\nerror : " + error);
		    },
		success :  function(rss,req,st){
			
			var myXML = rss.responseText;
			var JSONConvertedXML = $.xml2json(myXML);
			var paramX =parseFloat(JSONConvertedXML.x);
			var paramY =parseFloat(JSONConvertedXML.y) + 100000; //200,000 600,000만 보정을 위해
			console.log(x+" , "+y);
			console.log(paramX + " , " +paramY);
			
			CameraMove(paramX,paramY);
		}
		});
	//alert(ConPos);
	};
	
	/**
	* 카메라 이동 및 포인트
	*/
CameraMove = function(x,y){
    
	top.XDOCX.XDLayClear("Temporary");
	top.XDOCX.XDCamSetAngle(51);
	top.XDOCX.XDCamMove(x, 100, y, 10);
	top.XDOCX.XDCamSet(x, y, 300, 51); // 300은 가시거리 설정 값 51은 틸트값
	top.XDOCX.XDLaySetEditable("Temporary");
	top.XDOCX.XDRefSetFontStyle("굴림", 12, false, true, 1, 0, 0, 0);
	top.XDOCX.XDRefSetColor(0, 255, 0, 0);
	
	// 포인트 생성
	var hei = top.XDOCX.XDTerrGetHeight(x, y);
	 
	top.XDOCX.XDRefSetPos(x, hei, y);
	
	top.XDOCX.XDObjCreateText("SearchPoint", "", top.getWorkPath() + "pointer.png"); 
	top.XDOCX.XDCarmeraSetYAngle(90);	//건물검색 정북방향으로 
     /* top.XDOCX.XDCamSetMode(0); */
	setTimeout(function(){
		top.XDOCX.XDRenderData();
		top.XDOCX.XDMapRender();
		top.XDOCX.XDMapLoad();
	  }, 500);

}

var detailInfo;        

/**
 * 전달 방식에 따라 정보를 배열로 전달 하는 방식과 
 * 개별 프로퍼트로 받아서 배열 생성후 전달 하는 방식으로 양분
 */
setDetailInfo = function (tle,desc,addr,raddr,tele,lin){
	var detailInfoArr=new Array(tle,desc,addr,raddr,tele,lin);
	this.detailInfo=detailInfoArr;
};

/**
 * 상세조회 값을 담은 배열을 리턴
 * @returns {detailInfo}
 */

function getDetailInfo(){
	return this.detailInfo;
}

/**
 * 팝업창 띄우기 
 * @param targetUrl
 * @returns {Boolean}
 */
function openPop(targetUrl) {
	var url = targetUrl;
	window.open(url,
			"inofomation",
			"width=150,height=225,toolbar=no,scrollbars=0,location=0,status=0,menubar=0,resizable=0,directories=0,top=260,left=245");
	return false;
}