<!-- 
	수원시 3차원 활용시스템 메인 >> 검색기능 >> 도로명검색 결과 페이지
 -->
<%@page import="util.StirngUtil"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%@page import="java.net.URLDecoder"%>

<%      
	StirngUtil util = new StirngUtil(); 
	request.setCharacterEncoding("UTF-8");
	String searchText= URLDecoder.decode(util.nullStringCheck((String)request.getParameter("build_name")), "UTF-8");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>검색결과</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/css/common.css" />

<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/Properties.js"></script>
<script type="text/javascript" src="${ctx}/js/xml2json.js"></script>
<script type="text/javascript" src="${ctx}/js/GeoTrans.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.xdomainajax.js"></script>
<script type="text/javascript" src="${ctx}/js/common.js"></script>
<script type="text/javascript" src="${ctx}/js/roadView.js"></script>

<script>
/*KLIS 한국토지 정보 시스템연계 링크걸기(부동산 정보 열람) */
function jibunInfo(pnu){
	//alert(pnu);
	var w=window.open("http://klis.gg.go.kr/sis/main.do","_blank","width=100px,height=100px");
	var url="http://klis.gg.go.kr/sis/info/baseInfo/baseInfo.do?";
	url+="service=baseInfo&landcode="+pnu+"&gblDivName=baseInfo&scale=0&gyujae=0";
	var win="";
	try{
		win=window.open(url,"addrInfoWin","");
		w.close();
	}catch(e){
		if(w!='null'){
			w.close();
		}
	}	
}

var totalP;
var startP; //기본 시작은 1 페이지부터
var displayNum=5; //기본 5개씩 보여주게 셋팅 

function setTotal(total){ // 토탈저장
	
	this.totalP=total;
} 
function getTotal(){ //토탈 
	return totalP;
}
function setStart(spg){ //시작페이지 설정
	this.startP=spg;
}
function getStart(){ //시작 검색 번호 설정
	return startP;
}
function setDisplayNum(dnum){ //리스트에 한번에 뿌릴양
	this.displayNum=dnum;
}
function getDisplayNum(){
	return displayNum;
}
function jumpPage(gopage){ //페이징 이동 
	
	// top.btnCamClear(); //기존에 생성된 포인트 없애기
	var startvalue=1;
	if(gopage>1){
		startvalue = (gopage-1)*getDisplayNum()+1;
	}
	getApiRss(startvalue);
}
/**
 *  페이징 함수
 */
function paging(){
	
	
	var total = getTotal();
	var blockNum = getDisplayNum();
	var blockPage=5; // 한 화면에 보여줄 페이지 수
	var start = getStart();
	var currentPage = Math.floor(start/blockNum)+1; // 현재페이지 - start > 10  = start /10 math.floor 내림
	
	var startPage =Math.floor((currentPage - 1) / blockPage) * blockPage + 1;
	var endPage=startPage + blockPage - 1;
	
	/* if(currentPage >10){
		currentPage = ((currentPage-1) / 10)+1;
	} */
	var totalPage = Math.ceil(total/blockNum); // 전체 페이지 수 - math.ceil(total/10) math.ceil 올림
	
	if(endPage > totalPage){
		endPage=totalPage;
	}
	//var blockPage; // 한 화면에 보여줄 페이지 수
	var pageString="";
	
	if(totalPage>5){
		pageString += "<li><img src='${ctx}/images/bbs/page_first.gif' alt='맨앞' class='vmiddle' onclick='jumpPage(1)'style='cursor: hand;'/>&nbsp;</li>";
		
		if(currentPage > blockPage){
			var prepage = Math.floor((currentPage-1)/5)*5;
			pageString += "<li><img src='${ctx}/images/bbs/page_prev.gif' alt='이전'	class='vmiddle mar_r5' onclick='jumpPage("+prepage+")' style='cursor: hand;' />&nbsp;</li>";
		}else{
			pageString += "<li><img src='${ctx}/images/bbs/page_prev.gif' alt='이전'	class='vmiddle mar_r5' />&nbsp;</li>";
		}
		
		for(var i=startPage;i<=endPage;i++){
			if(currentPage==i){
				pageString += "<li>[<font color='Fuchsia'>"+i+"</font>]</li>&nbsp;";
			}else{
				pageString +="<a href='javascript:jumpPage("+i+")' style='cursor: hand;'>["+i+"]</a>&nbsp;";
			}
		}
		
		if(totalPage - startPage >= blockPage){
			var nextpage = endPage+1;
			pageString +=
				"<li><img src='${ctx}/images/bbs/page_next.gif'onclick=jumpPage("+nextpage+") alt='다음' class='vmiddle mar_l5' style='cursor: hand;'/>&nbsp;</li>";
		}else{
			pageString += "<li><img src='${ctx}/images/bbs/page_next.gif' alt='다음' class='vmiddle mar_l5'/>&nbsp;</li>";
		}
		pageString +="<li><img src='${ctx}/images/bbs/page_last.gif' alt='맨뒤' onclick='jumpPage("+totalPage+")' class='vmiddle' style='cursor: hand;'/></li>";
		
	}else{
		for(var i=1;i<=totalPage;i++){
			if(currentPage==i){
				pageString +="<li>[<font color='Fuchsia'>"+i+"</font>]</li>&nbsp;";
			}else{
				pageString +="<a href='javascript:jumpPage("+i+")' style='cursor: hand;'>["+i+"]</a>&nbsp;";	
			}
		}
	}
	$('#bbsPaging').html(pageString);
}
/**
 * ajax로 api요청 결과를 받는 함수
 */
 
function getApiRss(spg){
	 //ajaxCallBack();
		setStart(spg); //시작 페이지 셋팅 
		
		var display=getDisplayNum(); //한번에 보여줄 개수
		
		divChagne('loading');
		
		var queryParam = encodeURIComponent("수원시<%=searchText%>"); //검색어 인코딩 
		
		
		/* var rquery = "&query="+queryParam; 				//검색어
		
		var rkey = "key="+NaverLocalAPI.KEY; 			//api 등록키
		var rtarget ="&target=local"; 						//api 분류(local 필수)
		var rstart = "&start="+spg;							//시작페이지
		var rdisplay = "&display="+display;					//한번에 보여줄 페이지수
		
		var url = NaverLocalAPI.URL+rkey+rtarget+rstart+rdisplay+rquery; //요청 url */
		//alert(url);		
		$.ajax({
			type:"post",
			//asyn:true,
			timeout : 10000,
			url: "${ctx}/textSearch/potalSearch.do",
			data:{searchText : queryParam},
			dataType: "text",
			//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     alert("code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : ajaxCallBack
			});
		
}

/**
 * 검색 결과를 파싱 밑 분기 하는 함수
 */
function ajaxCallBack(rss,req,st){
	try{
		var myXML = rss.substring(1,rss.length-1);
		myXML = myXML.replace(/\\/gi,"");
		var JSONConvertedXML = $.xml2json(myXML);
		jQuery("#resultTotal").empty();
		
		
		var totalCount = JSONConvertedXML.channel.total;
	
		if(totalCount>1000){ //api의 검색 시작값의 최대는 1000;
			totalCount=1000;
		}
		jQuery("#resultTotal").append(totalCount);
		
		setTotal(totalCount); //총페이지 설정
		
		//좌표변환 관련[S]
		var geo = new GeoTrans();
	    geo.init("katec", "geo");
	    
	  	//좌표변환 관련[E]
		
	  	//테이블 초기화 관련[S]
	  	var rows = resultList.rows.length;
	  	var thisResult=null;
	  	
	  	//상세정보 보기로 넘길 파라미터들 선언
	  	var ptitle="";
	  	var pdescription="";
	  	var paddress="";
	  	var ptelephone="";
	  	var plink="";
	  	var mapx="";
	  	var mapy="";
	  	
	  	
	  	//top.removeSearchPoint();
	  	//이전 검색 결과 삭제
		for(var i = 0; i < rows; i++)
		   {  
			resultList.deleteRow('i'); 
		   }
	  	//검색 결과 리스트 th 삽입
		jQuery("#resultList").append(
		'<tr>'
		+'<th>No</th>'
		+'<th>네이버 지역검색 결과</th>'
		+'<th>정보</th>'
		+'</tr>');
		
		if(totalCount==0){ //검색 결과가 없을때
			//alert('검색 결과가 없습니다');
			jQuery("#resultList").append(
				'<tr>'
				+'<td colspan=5>검색된 결과가 없습니다.</td>'
				+'</tr>');
			
		}else if(totalCount==null){
			alert('검색에 실패했습니다. \n다시 시도해주세요 ');
			
		}else{
			//alert(getStart()+" // " +getTotal());	
			//테이블 초기화 관련[E]
			if(getStart()==getTotal()){
				
				thisResult=JSONConvertedXML.channel.item;
				
				//var pt = new Point(thisResult.mapx, thisResult.mapy); //좌표변환
			    
				//var out_pt = geo.conv(pt); //좌표변환
				
				ptitle = charReplace(thisResult.title);
			    pdescription = charReplace(thisResult.description);
			    paddress=charReplace(thisResult.address);
			    proadaddress=charReplace(thisResult.roadAddress);
			  	//alert(thisResult.mapx + "  // "  + thisResult.mapy );
			    mapx =charReplace(thisResult.mapx);
			  	mapy =charReplace(thisResult.mapy);
			  	
			    ptelephone=charReplace(thisResult.telephone);
			  	plink=charReplace(thisResult.link);
			    
			  	
			    //var detailAppend = '"'+ptitle+'","'+pdescription+'","'+paddress+'","'+ptelephone+'","'+plink+'"'; //상세정보에 보여줄 파라미터 셋팅
			    var detailAppend = '"'+ptitle+'","'+pdescription+'","'+paddress+'","'+ proadaddress+'","'+ptelephone+'","'+plink+'"'; //상세정보에 보여줄 파라미터 셋팅
			  	
			    //alert(detailAppend);
			    //alert(detailParm);
			    //top.fn_searchPoint(ptitle,out_pt,0,detailParam);  // 배포시 주석처리
			    
			    addRow_same(ptitle,paddress,proadaddress,1,mapx,mapy,detailAppend); //개발 배포시 주석처리
			    //addRow_same(ptitle,paddress,proadaddress,1,detailAppend); //개발 배포시 주석처리 
			    
			    //addRow_same(ptitle,out_pt,detailAppend,1); //배포
			    
			    //top.moveLonLatAlt(out_pt.x,out_pt.y,1500); //검색위치로 이동 
			    
				
			    //top.detailInfo(thisresult.title, thisresult.description, thisresult.address, thisresult.telephone, thisresult.link);
			}else{	
				
				for(var i=0;i<JSONConvertedXML.channel.item.length;i++){
					
					thisResult=JSONConvertedXML.channel.item[i];
					var pt = new Point(thisResult.mapx, thisResult.mapy); //좌표변환
				    var out_pt = geo.conv(pt); //좌표변환
				    
				    ptitle = charReplace(thisResult.title); // html태그 걸러내기
				    pdescription = charReplace(thisResult.description); //설명
				    
				    paddress=charReplace(thisResult.address); //주소
				    proadaddress=charReplace(thisResult.roadAddress); //도로명 주소
				    
				    mapx =charReplace(thisResult.mapx); //x좌표
				  	mapy =charReplace(thisResult.mapy); //y좌표
				  	
				  	ptelephone=charReplace(thisResult.telephone); //전화번호
				  	plink=charReplace(thisResult.link);//홈페이지 
				  	
				    var detailAppend = '"'+ptitle+'","'+pdescription+'","'+paddress+'","'+ proadaddress+'","'+ptelephone+'","'+plink+'"'; //상세정보에 보여줄 파라미터 셋팅
				  	//alert(detailParam);
				    //alert(detailParm);
				    //top.fn_searchPoint(ptitle,out_pt,i,detailParam); // 배포시 주석처리
				    addRow_same(ptitle,paddress,proadaddress,i+1,mapx,mapy,detailAppend); //개발 배포시 주석처리
				    //addRow_number(ptitle,out_pt,detailAppend,i+1);	//개발 배포시 주석처리
				    // addRow_same(ptitle,out_pt,detailAppend,i+1); //배포
				    
				    
				    //p_pointArr=new top.pointArr(out_pt.x,out_pt.y); //검색취
				    
				    //top.pointArray.push(p_pointArr);
				    //top.detailInfo(thisresult.title, thisresult.description, thisresult.address, thisresult.telephone, thisresult.link);
				}
				//top.fn_MoveSearchArea(top.pointArray);
			}
			paging();
			
		}
		divChagne('end');
	}catch(e){
		alert(e);
	}
}

/**
 * 결과를 동적 테이블로 생성해주는 함수 - 같은 아이콘으로 표시되는 리스트
 */ 
function addRow_same(title,addr,roaddr,num,x,y,info) {
	jQuery('#resultList').append(
			"<tr>"
			+"<td rowspan='3' align='center' class='f_dblue_b' text-align='center'>"+num+"</td>"
			+"<td >"
			+'<a href="#" onclick="CoordTrans(\'KTM\',\'WTM\','+x+','+y+');return false;" style="cursor:pointer;" class="f_orange_b">'
			+title+"</a></td>"
			+"<td align='center'>"
			+"</td></tr>"
			+"<tr>"
				+"<td>"+roaddr+"</td>"
				+"<td align='center'>"
				+"<a href='#' onclick='setDetailInfo("+info+")' style='cursor:hand'>"  
				+"<img src='${ctx}/images/potal/info.gif' alt='상세정보' style='cursor: pointer;' onclick='openPop(\"${ctx}/pop/potalDetailPop.jsp\");return false;'/>"
				+'</a>'
			+"</td></tr>"
			+"<tr>"
				+"<td>"+addr+"</td>"
				+"<td align='center'>"
				
				+"<img src='${ctx}/images/potal/daum.png' alt='로드뷰' style='cursor: pointer;' onclick='RoadViewCoord(\"KTM\",\"WGS84\","+x+","+y+");'/>&nbsp;&nbsp;"
				+"<img src='${ctx}/images/potal/naver.png' alt='거리뷰' style='cursor: pointer;' onclick='ShowStreetView("+x+","+y+");return false;'/>"
			+"</td></tr>"
	    );
	
	/* jQuery("#resultList").append(
			'<tr>'
			+'<td rowspan="3" align="center" class="f_dblue_b">'+num+'</td>'
			+'<td class="f_orange_b">'
			+"<a href='#' onclick='CoordTrans(\"KTM\",\"WTM\","+x+","+y+");return false;' style='cursor:pointer'>"
			+title+'</td></a>'
			+'<td rowspan="3" align="center">'
			+'<img src="${ctx}/images/potal/daum.png" alt="로드뷰" style="cursor: pointer;" onclick="RoadViewCoord(\'KTM\',\'WGS84\','+x+','+y+');"/>&nbsp;'
			+'<img src="${ctx}/images/potal/naver.png" alt="거르뷰" style="cursor: pointer;" onclick="ShowStreetView('+x+','+y+');return false;"/></td>'
			+'</tr>'
			+'<tr>'
				+'<td>'+roaddr+'</td>'
				+'</tr>'
			+'<tr>'
				+'<td>'+addr+'</td>'
			+'</tr>'
	    );
 */		
	
}

/**
 * 결과를 동적 테이블로 생성해주는 함수 - 번호로 표시되는 리스트 
 */ 
function addRow_number(title,location,param,num) {
	var pointId = "ic_"+title;
	jQuery("#resultList").append(
			"<tr id='"+top.emptyReplace(pointId)+"' >"
				+"<td align='center'><img src='../../images/searchpoint/poisearch"+num+".png' alt=''></td>"
				+"<td class='list_subject' align='left'>"+title+"</td>"
				+"<td align='center'>"
				+"<a href='#' onclick='top.setDetailInfo("+param+")' style='cursor:hand'  >"  
				+"<img src='../../images/common/info.gif' alt='상세정보' onclick=\"top.openPopLayer('../gis/popup/searchDetailPop.html',true,'searchInfo',1);return false;\">"
				+"</a>"
				+"</td>"
				+"<td align='center'>"
				+"<a href='#' onclick='top.setDetailInfo("+param+")' style='cursor:hand' >"
				+"<img src='../../images/common/move.gif' alt='' onclick=\"top.moveLonLat("+location.x+","+location.y+");top.openPopLayer('../gis/popup/searchDetailPop.html',true,'searchInfo',2);return false;\" style='cursor:hand'  onmouseover='top.highlight(\""+pointId+"\")' onmouseout='top.releaseHighlight(\""+pointId+"\")'>"
				+"</a>"
				+"</td>"
			+"<tr>"
	    );
}
//로딩 효과 주기
function divChagne(flag){
	if(flag=='loading'){
		document.getElementById("bbsCont").style.display="none";
		document.getElementById("loadingDiv").style.display="block";
		//$('#resultDiv').hide();
		//$('#loadingDiv').show();
	}else{
		document.getElementById("bbsCont").style.display="block";
		document.getElementById("loadingDiv").style.display="none";
		//$('#resultDiv').show();
		//$('#loadingDiv').hide();
	}
}

</script>
</head>
<!--  건물검색어 입력 항목과 검색결과가 나타나는 페이지 -->
<body onload="getApiRss(1,5)">
	<div id="loadingDiv" style="z-index:10;display:block">
	<center>
		<img src="${ctx}/images/potal/loadinfo2.gif"><br/>
		<span class="f_olive">포털로 검색 요청중 입니다</span>
	</center>
	</div>
	<div id="bbsCont"
		style="height: 100%; overflow-y: scroll; width: 320px;">
		<table border="0" cellpadding="0" cellspacing="0" class="wps_100"
			title="list" summary="list" id="resultList">
			<col class="w_40" />
			<col />
			<col class="w_60" />
			<thead>
			</thead>
		</table>
		<br>
		<div id="bbsBottom" style="display: none;">
			<ul id='bbsPaging'>
			</ul>
		</div>
	</div>
</body>
</html>
