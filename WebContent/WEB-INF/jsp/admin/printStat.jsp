<!-- 
	관리자 > 접속 통계 조회
 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>무제 문서</title>

<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css">
<link type="text/css" href="${ctx}/css/jquery-ui.css" rel="stylesheet" />

<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script> -->
<!-- <script type="text/javascript" src="${ctx}/js/jquery/jquery-1.11.0.min.js"></script>  -->

<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.18.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/highcharts.js"></script>
<script type="text/javascript" src="${ctx}/js/highcharts-3d.js"></script>

<script type="text/javascript" src="${ctx}/js/exporting.js"></script>

<script type="text/javascript">

//날짜에 0 붙여준당
function addZero(i){
	var rtn = i + 100;
	return rtn.toString().substring(1,3);
}

//s - 날짜 ('2013-12-25'), i는 몇일전 숫자
function getDt(s, i){
	
	//var dates = s.split('-');
	//var newDt = new Date(dates[0],dates[1],dates[2]);
	
	var newDt = new Date(s); //스트링으로 넣은건데 왜 안되는지 잘 모르곗다.. 그냥 테스트 페이지 만들면 된다. jquery영향 같기도한데..
	
	newDt.setDate( newDt.getDate() - i );
	
	return converDateString(newDt);
}

// 날짜와 달에 앞에 0붙이기
function converDateString(dt){
	return dt.getFullYear() + "-" + addZero(eval(dt.getMonth()+1)) + "-" + addZero(dt.getDate());
}

//슬라이드바 생성 20140121
$(function(){
		var todayDate = new Date();
		
		$("#datepicker1").val(todayDate.getFullYear()+"-"+addZero(eval(todayDate.getMonth()))+"-"+todayDate.getDate());
		$("#datepicker2").val(todayDate.getFullYear()+"-"+addZero(eval(todayDate.getMonth()+1))+"-"+todayDate.getDate());
		
		//달력 관련
		$.datepicker.setDefaults({
	        changeMonth: true,
	        changeYear: true,
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear:true,
		    dateFormat: 'yy-mm-dd',
		    buttonImageOnly: true,
		    buttonText: "달력",
		    buttonImage: ""
		});
		
		$("#datepicker1").datepicker({
		    defaultDate: todayDate,//(2013, 1-1, 27),
		    //showOn: "both", // focus, button, both
		    showAnim: "clip", // blind, clip, drop, explode, fold, puff, slide, scale, size, pulsate, bounce, highlight, shake, transfer (효과)
		    showOptions: {direction: 'horizontal'},
		    duration: 500
		}); 
		$("#datepicker2").datepicker({
		    defaultDate: todayDate,//(2013, 9-27, 27),
		    //showOn: "both", // focus, button, both
		    showAnim: "clip", // blind, clip, drop, explode, fold, puff, slide, scale, size, pulsate, bounce, highlight, shake, transfer (효과)
		    showOptions: {direction: 'horizontal'},
		    duration: 500
		}); 
	});
	
var parameters; //엑셀 다운로드를 위한 파라미터 셋팅

function fn_setParamList(param){
	this.parameters =  param;
}

function fn_getParamList(){
	
	return this.parameters;
}

/**
 * ajax로 부서 이름 설정
 */
function fn_getConnList(page,total){
	
		var strTimCnt = $('#datepicker1').val().replace(/-/gi, "");
		
		var endTimCnt = $('#datepicker2').val().replace(/-/gi, "");  
		
		/* var lmtTim = getDt($('#datepicker2').val(),31);  // 31일 LIMIT
		
		var lmtTimCnt = lmtTim.replace(/-/gi, ""); */
				
		if(strTimCnt > endTimCnt){
			alert("시작일은 종료일 보다 다음 일자일수 없습니다.");
			return;
		}
		
		/* if(strTimCnt < lmtTimCnt){
			alert("조회기간은 최대 31일 입니다. 한달 이상은 월간조회를 이용해주세요.");
			return false;
		} */ 
		var cSrc = $('#graphImg').attr('src');
		
		if(cSrc.indexOf("list") > -1){
			cSrc = cSrc.replace('list','graph');
			$('#graphImg').attr("src", cSrc);
			
			$('#graph').hide();
			$('#listdiv').slideDown();
		}
		
		var url =""; //요청 url
		
		var callBackFn = null; // 콜백 함수 설정
				
		var parameters = "mnuid="+$('#menuOp').val();
		
		parameters = parameters + "&startdate="+$('#datepicker1').val()+"&enddate="+$('#datepicker2').val();//날짜 파라미터 더하기 
		
		if(page == null){
			page = 1;
		}
		parameters = parameters + "&page="+page;
		
		
		if(total != null){
			parameters = parameters + "&totalPage=" + total;
		}
		parameters = parameters + "&vtype="+fn_getViewCheck(); //그래프의 일, 월 단위 선택
	
		fn_setParamList(parameters); //엑셀 다운로드를 위한 파라미터 셋팅
		
		url ="${ctx}/statConnList.do?" + parameters;
		
		callBackFn = function(result){
			fn_initUserList();
			
			fn_setPaging(result[0].pageIndexList);	//페이징 붙여주기
			
			fn_setTotal(result[0].totalNum);
			
			fn_setUserList(result[0].l_list);	 //콜백함수 지정
			
			fn_viewChart(result[0].vtype,result[0].g_list);
		}
		
		$.ajax({
			type:"get",
			//asyn:true,
			timeout : 10000,
			url: url,
			dataType: "json",
			//contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			error : function(request, status, error) {
			     alert("fn_getConnList // code : " + request.status + "\r\nmessage : " + request.reponseText);
			    },
			success : callBackFn
		});
		
}	
function fn_setVisibleType(ojbId){
	
	var cSrc = $('#'+ojbId).attr('src');
	
	if(cSrc.indexOf("graph") > -1){
					
		cSrc = cSrc.replace('graph','list');
		$('#'+ojbId).attr("src", cSrc);
		
		$('#listdiv').hide();
		$('#graph').slideDown();
		
	}else{
		cSrc = cSrc.replace('list','graph');
		$('#'+ojbId).attr("src", cSrc);
		
		$('#graph').hide();
		$('#listdiv').slideDown();
	}
	
}
//사용자 리스트 초기화 
fn_initUserList = function(){
	$('#userListTBody').empty();
	$('#pageSpan').empty();
	$('#exceldown').empty();
};
//사용라 리스트 붙여넣기 
fn_setUserList = function(result){
	
	
	
	var listStr = "";
	//alert(result);
	if(result == null || result==""){
		listStr += '<TR align="center">'
				+'<td colspan="5">검색 결과가 없습니다</td>';
	}else{
		
		var listObj = result;
		for(var i=0; i < result.length;i++){
			//표에 추가할 hmtl 정의
			listStr += '<TR align="center">'
						+'<TD>'+listObj[i].logseq+'</TD>'
						+'<TD>'+listObj[i].usrname+'</TD>'
						+'<TD>'+listObj[i].deptname+'</TD>'
						+'<TD>'+listObj[i].menuname+'</TD>'
						+'<TD>'+listObj[i].wdate+'</TD>';
		}
	}

	$('#userListTBody').append(listStr);
	
};
var totalPageNum = 0;

function fn_setTotal(tot){
	this.totalPageNum = tot; 	
}

function fn_getTotal(){
	return this.totalPageNum;
}

var curPage = 1;
//현제 패이지 설정
function fn_setPage(page){
	this.curPage = 	page;
}
//현제 패이지 설정
function fn_getPage(){
	return this.curPage;
}
//페이지 이동시 실행 
function fn_goPage(){
	
	fn_getConnList(fn_getPage(), fn_getTotal());
}
//페이징 붙여넣기 
function fn_setPaging(pageHtml){
	$('#pageSpan').html(pageHtml);
	$('#exceldown').html('<input type="button" value="엑셀다운로드" onclick="fn_downExcel()"/>');
}

/**
 * 차트 관련 시작
 */
function fn_viewChart(vtype,data){
	
	 
	
	var xLabel="월";
	var dataArr = new Array();
	var catArr = new Array();
	if(vtype=="day"){
		xLabel="일";
		
	}

	
/* 	var ddd = 	[['1월',9], ['2월',71.5], ['3월',71.5],['4월',71.5],['5월',71.5],['6월',71.5],['7월',71.5],['8월',71.5],['9월',71.5],['10월',71.5],
				       ['11월',71.5],['12월',71.5],['13월',71.5],['14월',71.5],['115월',71.5],['16월',71.5],['17월',71.5],['18월',71.5],['19월',71.5],['20월',71.5],
						['21월',71.5],['22월',71.5],['23월',71.5],['24월',71.5],['25월',71.5],['26월',71.5],['27월',71.5],['28월',71.5],['29월',71.5],['30월',71.5]
				       ]; */

     var ddd = 	[9, 78.5, 71.5];
				       
	for(var i = 0; i < data.length; i++ ){
		dataArr[i] = eval(data[i].usrid);
		catArr[i] = data[i].wdate+xLabel; 
	}

	 initChart(dataArr,catArr);
}
 
	
 
 function initChart(dataArr,catArr){
	 
	    // Set up the chart
	   var chart = new Highcharts.Chart({
	        chart: {
	            renderTo: 'container',
	            type: 'column',
	            margin: 75,
	            options3d: {
	                enabled: true,
	                alpha: 15,
	                beta: 15,
	                depth: 50,
	                viewDistance: 25
	            }
	        },
	        title: {
	            text: '수원시 3차원 공간정보 활용시스템 '
	        },
	        subtitle: {
	            text: '출력통계'
	        },
	        plotOptions: {
	            column: {
	                depth: 25
	            }
	        },
	        yAxis:{
	        	labels: {
	                formatter: function() {
	                    return this.value + ' 회';
	                }
	            },

	        	title: {
	        		text : ''
	        	}
	        },
	        xAxis:{
	        	
	        	categories:catArr ,
	        	//labels: {            formatter: function() {              return this.value+1 + xLabel;              } 
	            //},

        	title: {
        		text : ''
        	},
        	startOnTick :true,
        	min : 0,
        	tickInterval : 1
	        },
	        series: [{
		    		name : '횟수',
		    		yAxis : 0,
		    		data: dataArr
		    	 	}]
	    });
	    

	    // Activate the sliders
	    $('#R0').on('change', function(){
	        chart.options.chart.options3d.alpha = this.value;
	        showValues();
	        chart.redraw(false);
	    });
	    $('#R1').on('change', function(){
	        chart.options.chart.options3d.beta = this.value;
	        showValues();
	        chart.redraw(false);
	    });

	    function showValues() {
	        $('#R0-value').html(chart.options.chart.options3d.alpha);
	        $('#R1-value').html(chart.options.chart.options3d.beta);
	    }
	    showValues();
	  
	};


function fn_getViewCheck(){
	var radio = document.getElementsByName('rad1');

	 for(var i=0;i<radio.length;i++){
	  	if(radio[i].checked == true){
	  		return radio[i].value;		
	  	}
	 }
}
function fn_downExcel(){
	
	document.getElementById("tempFrm").src = "${ctx}/printStatExcelDown.do?"+fn_getParamList();;
}
</script>
</head>


<body>
	<table width="100%" height="100%" border="0" cellspacing="0"
		cellpadding="0"
		style="background-image: url(${ctx}/images/admin/title_bg.gif); height: 100%">
		<tr>
			<td width="14" height="35"><img
				src="${ctx}/images/admin/title_left.gif" alt="" width="14" height="35"></td>
			<td width="253" align="center"><img
				src="${ctx}/images/admin/title2.gif" alt="" width="92" height="35"></td>
			<td width="11"><img src="${ctx}/images/admin/title_side.gif" alt=""
				width="11" height="35"></td>
			<td>&nbsp;</td>
			<td width="14"><img src="${ctx}/images/admin/title_right.gif" alt=""
				width="14" height="35"></td>
		</tr>
		<tr>
			<td style="background-image: url(${ctx}/images/admin/left_bg.gif)"></td>
			<td align="center" valign="top" bgcolor="#FFFFFF"><table
					width="244" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="124">&nbsp;&nbsp;</td>
						<td >&nbsp;</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35" align="center" style="text-align:center">메 뉴</td>
						<td><LABEL> <SELECT name="menuOp" id="menuOp">
							<option value="103600">화면저장</option>
							<option value="103700">화면인쇄</option>
							
						</SELECT>
						</LABEL></td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="37px" align="center" style="text-align:center">기 간</td>
						<td>
							<input type="text" name="datepicker1" id="datepicker1" style="width: 100px;"> 부터
							<input type="text" name="datepicker2" id="datepicker2" style="width: 100px;"> 까지
						</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">&nbsp;</td>
						<td>
							<INPUT id="chkMonth" onClick="" value="month"  type="radio" name="rad1"> 월별
							<INPUT id="chkDay" onClick="" value="day" type="radio" name="rad1" CHECKED> 일별
						</td>
					</tr>
					<tr>
						<td colspan="2"><img src="${ctx}/images/admin/dot.gif" alt=""
							width="244" height="5"></td>
					</tr>
					<tr>
						<td height="35">&nbsp;</td>
						<td align="right">
							<img src="${ctx}/images/admin/btn_graph.gif" id="graphImg" onclick="fn_setVisibleType(this.id)" style="cursor:pointer;">
							<img src="${ctx}/images/admin/search.gif" alt="" style="margin-left: 5px;cursor:pointer;"  onclick="fn_getConnList();">
						</td>
					</tr>
				</table></td>
			<td style="background-image: url(${ctx}/images/admin/side_bg.gif)">&nbsp;</td>
			<td valign="top" bgcolor="#FFFFFF"><table width="200" border="0"
					cellspacing="0" cellpadding="0">
					<tr>
						<td>&nbsp;</td>
					</tr>
				</table>
				<div id="graph" style="display:none">
				<div class="bbsCont">
					<table align="center" class="wps_90" summary="목록">
						<thead>
							<tr>
								<th scope="col">접속이력통계 그래프</th>
							</tr>
						</thead>
						<tbody>
							<TR align="center">
								<TD><div id="container" style="height: 70%; width:70%;margin-top: 0px; margin-right: auto; margin-bottom: 0px; margin-left: auto; min-width: 310px;" data-highcharts-chart="0"></div></TD>
							</TR>
						</tbody>
					</table>
				</div>
				<div class="bbsCont"></div> 
				</div>
				<div id="listdiv">
					<div class="bbsCont">
						<table align="center" class="wps_90" summary="목록">
							<colgroup>
								<col class="w_50" />
								<col class="w_100" />
								<col class="w_400" />
								<col class="w_300" />
								<col class="w_250" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">NO</th>
									<th scope="col">사용자명</th>
									<th scope="col">부서</th>
									<th scope="col">사용메뉴</th>
									<th scope="col">접속시간</th>
								</tr>
							</thead>
							<tbody id="userListTBody">
							<tr>
								<td colspan="5" style="text-align:center; align:center">검색 해주세요.</td>
							</tr>
							</tbody>
						</table>
					</div>
					<br />
					<div align="center">
						<span style="font-size: 12px;height:40px" id="pageSpan"></span><span  style="float:right;padding-right:70px;" id="exceldown"></span>
					</div>
			 <!-- 컨텐츠 끝 -->
				</div>
			<!-- 컨텐츠 끝 --></td>	
			<td style="background-image: url(${ctx}/images/admin/right_bg.gif)">&nbsp;</td>
		</tr>
		<tr style="background-image: url(${ctx}/images/admin/end_bg.gif)">
			<td height="10"><img src="${ctx}/images/admin/end_left.gif" alt=""
				width="14" height="10"></td>
			<td align="center"></td>
			<td><img src="${ctx}/images/admin/end_side.gif" alt="" width="11"
				height="10"></td>
			<td></td>
			<td><img src="${ctx}/images/admin/end_right.gif" alt="" width="14"
				height="10"></td>
		</tr>
	</table>
	<iframe id="tempFrm" name="tempFrm" frameborder=0 width="0" height="0" />
</body>
</html>

