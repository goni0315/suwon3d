<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>내비게이션</title>

<link href="css/gislayout.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/jquery/jquery.js"></script>
<!--callScript의 제이쿼리 함수를 위해 적용  -->
<script type="text/javascript" src="js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript"
	src="js/jquery/jquery-ui-1.8.custom.min.js"></script>
<!-- 조망, 네비 등의 속도 조절 슬라이드바 -->
<script type="text/javascript">

   //메뉴선택시 이미지 초기화
	function clearMenu() {
	   //좌표초기화
		doInit();
		document.getElementById("flyView").src = "${ctx}/images/navi05_off.gif";
		document.getElementById("carView").src = "${ctx}/images/navi06_off.gif";

		document.getElementById("play").src = "${ctx}/images/navi11_off.gif";
		document.getElementById("pause").src = "${ctx}/images/navi12_off.gif";
		document.getElementById("stop").src = "${ctx}/images/navi13_off.gif";

		document.getElementById("front").src = "${ctx}/images/navi07_off.gif";
		document.getElementById("back").src = "${ctx}/images/navi08_off.gif";
		document.getElementById("left").src = "${ctx}/images/navi09_off.gif";
		document.getElementById("right").src = "${ctx}/images/navi10_off.gif";

		document.getElementById("na_tool1").src = "${ctx}/images/na_tool01_off.gif";
		document.getElementById("na_tool2").src = "${ctx}/images/na_tool02_off.gif";
		document.getElementById("na_tool3").src = "${ctx}/images/na_tool03_off.gif";
		document.getElementById("na_tool4").src = "${ctx}/images/na_tool04_off.gif";
		document.getElementById("na_tool5").src = "${ctx}/images/na_tool05_off.gif";
		document.getElementById("na_tool6").src = "${ctx}/images/na_tool06_off.gif";

	}
	var m_naviPlay = false; // 주행실행 중인지 여부
	var m_naviPause = false; // 중지상태 여부
	function startLoad() {

		document.getElementById("simulation_drive").style.display = 'none';

		$('#simulation_drive').append($('<fieldset><legend>경로목록</legend><div><table width="232" border="0" cellpadding="0" cellspacing="0">'
								+ '<tr><th width="30">No</th><th width="60">X</th><th width="60">Y</th><th>Z</th></tr></table>'
								+ '<div style="width:230px; height:100px; border:1px solid #828790; overflow-y:scroll; background:#FFF;">'
								+ '<table id="listview" border="0" cellpadding="0" cellspacing="0" style="width:100%"></table></div></p></div></fieldset>'));
	}

	//저장
	function doSave() {
		top.XDOCX.XDUIClearInputPoint();

		$('#listview tr').each(
				function() {
					var point = $(this).find('td');

					top.XDOCX.XDUIInput3DPoint($(point[1]).text(), $(point[2])
							.text(), $(point[3]).text());
				});

		if (top.XDOCX.XDUIInputPointCount() < 2) {
			alert('경로를 입력하세요.');
			return;
		}

		var file_path = top.XDOCX.XDUIOpenFileDlg(false, 'txt');
		if (file_path == '')
			return;

		top.XDOCX.XDNaviRouteSave(file_path);

	}
	//불러오기
	function doOpen() {
		var file_path = top.XDOCX.XDUIOpenFileDlg(true, 'txt');
		if (file_path == '')
			return;

		var result = top.XDOCX.XDUIOpenTxtFile(file_path);

		if (result == '') {
			alert('저장된 정보가 없습니다.');
			return;
		}
		top.XDOCX.XDUIClearInputPoint();
		doInitPointData();
		var arr = result.split('\n');

		for (var i = 1; i <= parseInt(arr[0]); i++) {
			var point = arr[i].split('\t');
			doAddPointData([ point[0], point[1], point[2] ]);

			top.XDOCX.XDUIInput3DPoint(point[0], point[1], point[2]);
		}
	}

	//모의주행 지점 설정
	function doInputPoint() {
		if ($('#listview tr').length > 0) { // 입력된 포인트가 있을 경우
			if (confirm('이미 입력된 포인트가 있습니다.\n입력된 포인트를 삭제하시고 계속 하시겠습니까?')) {
				top.XDOCX.XDUIClearInputPoint();
				doInitPointData();
			} else {
				return;
			}
		}
		top.setWorkMode('모의주행');
		top.XDOCX.XDUISetWorkMode(21);

		top.initFunction();

		top.addFunction(function(data) {
			var button = data['button'];
			var pos = data['pos'];

			if (button == 1) {
				doAddPointData(pos);
			} else {
				top.initFunction();
				top.setWorkMode('');
				top.XDOCX.XDUISetWorkMode(1);
			}
		});

	}

	//모의주행 실행 -- 자동차
	function doExecute() {
		top.XDOCX.XDNaviPause();
		if (top.XDOCX.XDUIInputPointCount() < 2) {
			alert('경로를 입력하세요.');
			return;
		}
		if ($('#set_speed').val() < 1 || $('#set_speed').val() > 10) {
			alert('주행 속도 범위는 1~10 사이입니다.\n다시 입력하십시오.');
			return;
		}

		m_naviPause = false;

		top.initFunction();
		top.addFunction(function() {
			if (m_naviPause == false) {
				m_naviPlay = false;
			}
		});

		if (m_naviPlay == false) {
			top.setWorkMode('');
			top.XDOCX.XDUISetWorkMode(1);
			top.XDOCX.XDNaviInit();

			//자동차모드
			top.XDOCX.XDCamSetAngle(-10);
			top.XDOCX.XDCamSetDistance(20);

			top.XDOCX.XDNaviPlay($('#set_speed').val());
			m_naviPlay = true;
		} else {
			top.XDOCX.XDNaviPlay($('#set_speed').val());
		}
	}

	//모의주행 실행 -- 비행기
	function doExecuteFly() {
		top.XDOCX.XDNaviPause();
		if (top.XDOCX.XDUIInputPointCount() < 2) {
			alert('경로를 입력하세요.');
			return;
		}
		if ($('#set_speed').val() < 1 || $('#set_speed').val() > 10) {
			alert('주행 속도 범위는 1~10 사이입니다.\n다시 입력하십시오.');
			return;
		}
		if ($('#input_set_height').val() < 10
				|| $('#input_set_height').val() > 1000) {
			alert('고도 범위는 10~1000 사이입니다.\n다시 입력하십시오.');
			return;
		}
		if ($('#input_set_angle').val() < 0 || $('#input_set_angle').val() > 90) {
			alert('각도 범위는 0~90 사이입니다.\n다시 입력하십시오.');
			return;
		}

		m_naviPause = false;

		top.initFunction();
		top.addFunction(function() {
			if (m_naviPause == false) {
				m_naviPlay = false;
			}
		});
		if (m_naviPlay == false) {
			top.setWorkMode('');
			top.XDOCX.XDUISetWorkMode(1);
			top.XDOCX.XDNaviInit();

			top.XDOCX.XDCamSetAngle("45");
			top.XDOCX.XDCamSetDistance($('#input_set_height').val());
			top.XDOCX.XDNaviPlay($('#set_speed').val());
			m_naviPlay = true;
		} else {
			top.XDOCX.XDNaviPlay($('#set_speed').val());
		}
	}

	//일시정지
	function doPause() {
		if (m_naviPlay == true) {
			m_naviPause = true;
			top.XDOCX.XDNaviPause();
		}
	}

	//정지
	function doStop() {
		m_naviPause = false;
		if (m_naviPlay == true) {
			top.XDOCX.XDNaviStop();
			m_naviPlay = false;
		}
	}

	//새로고침
	function doInit() {
		m_naviPause = false;
		top.initFunction();
		input_set_height.value = "300";
		set_speed.value = 5;
		top.setWorkMode('');
		top.XDOCX.XDUISetWorkMode(1);
		top.XDOCX.XDUIClearInputPoint();
		doInitPointData();
		doStop();
	}

	//모의주행 시점 각도 
	function doSetDirect(val) {
		if (m_naviPlay == true) {
			top.XDOCX.XDNaviSetDirect(val);
		}
	}

	//좌표 데이터 추가
	function doAddPointData(pos) {
		$("#listview").append(
				$('<tr>' + '	<td width="30">' + ($('#listview tr').length + 1)
						+ '</td>' + '	<td width="60">'
						+ Math.round((new Number(pos[0]))) + '</td>'
						+ '	<td width="60">' + Math.round((new Number(pos[1])))
						+ '</td>' + '	<td>' + Math.round((new Number(pos[2])))
						+ '</td>' + '</tr>'));
	}

	//좌표 데이터 초기화
	function doInitPointData() {
		$("#listview").empty();
	}

// 	function naviSpeed(val) {
// 		var set_speed = document.getElementById('set_speed').value;
// 		if (set_speed > 10 || set_speed < 1) {
// 			alert('내비게이션 속도는 1 ~ 10 사이로 입력해주세요.');
// 			document.getElementById('set_speed').value = 5;
// 			return;
// 		}
// 		if (val == 'up') {
// 			document.getElementById('set_speed').value = parseInt(set_speed) + 1;
// 		} else {
// 			document.getElementById('set_speed').value = set_speed - 1;

// 		}
// 	}

	function toggleBtn(objNm, toggleNm) {
		if (objNm != '' || toggleNm != '') {
			switch (toggleNm) {
			//경로 뷰잉모드
			case 'naviView':
				if (objNm == 'fly') {
					doStop();
					doExecuteFly();
					document.getElementById("flyView").src = "${ctx}/images/navi05_on.gif";
					document.getElementById("carView").src = "${ctx}/images/navi06_off.gif";
				} else {
					doStop();
					doExecute();
					document.getElementById("flyView").src = "${ctx}/images/navi05_off.gif";
					document.getElementById("carView").src = "${ctx}/images/navi06_on.gif";
				}
				//재생버튼 토글
				document.getElementById("play").src = "${ctx}/images/navi11_on.gif";
				document.getElementById("pause").src = "${ctx}/images/navi12_off.gif";
				document.getElementById("stop").src = "${ctx}/images/navi13_off.gif";

				//전방 버튼으로 토글
				document.getElementById("front").src = "${ctx}/images/navi07_on.gif";
				document.getElementById("back").src = "${ctx}/images/navi08_off.gif";
				document.getElementById("left").src = "${ctx}/images/navi09_off.gif";
				document.getElementById("right").src = "${ctx}/images/navi10_off.gif";

				//tool
				document.getElementById("na_tool1").src = "${ctx}/images/na_tool01_off.gif";
				document.getElementById("na_tool2").src = "${ctx}/images/na_tool02_off.gif";
				document.getElementById("na_tool3").src = "${ctx}/images/na_tool03_off.gif";
				document.getElementById("na_tool4").src = "${ctx}/images/na_tool04_off.gif";
				document.getElementById("na_tool5").src = "${ctx}/images/na_tool05_off.gif";
				document.getElementById("na_tool6").src = "${ctx}/images/na_tool06_off.gif";
				break;
			//전,후,좌,우
			case 'viewMode':
				if (objNm == 'F') {
					document.getElementById("front").src = "${ctx}/images/navi07_on.gif";
					document.getElementById("back").src = "${ctx}/images/navi08_off.gif";
					document.getElementById("left").src = "${ctx}/images/navi09_off.gif";
					document.getElementById("right").src = "${ctx}/images/navi10_off.gif";
				} else if (objNm == 'B') {
					document.getElementById("front").src = "${ctx}/images/navi07_off.gif";
					document.getElementById("back").src = "${ctx}/images/navi08_on.gif";
					document.getElementById("left").src = "${ctx}/images/navi09_off.gif";
					document.getElementById("right").src = "${ctx}/images/navi10_off.gif";
				} else if (objNm == 'L') {
					document.getElementById("front").src = "${ctx}/images/navi07_off.gif";
					document.getElementById("back").src = "${ctx}/images/navi08_off.gif";
					document.getElementById("left").src = "${ctx}/images/navi09_on.gif";
					document.getElementById("right").src = "${ctx}/images/navi10_off.gif";
				} else {
					document.getElementById("front").src = "${ctx}/images/navi07_off.gif";
					document.getElementById("back").src = "${ctx}/images/navi08_off.gif";
					document.getElementById("left").src = "${ctx}/images/navi09_off.gif";
					document.getElementById("right").src = "${ctx}/images/navi10_on.gif";
				}
				break;
			//재생,일시정지,정지
			case 'playMode':
				if (objNm == 'play') {
					if (document.getElementById("flyView").src
							.indexOf('on.gif') == -1) {
						doExecute();
						document.getElementById("play").src = "${ctx}/images/navi11_on.gif";
						document.getElementById("pause").src = "${ctx}/images/navi12_off.gif";
						document.getElementById("stop").src = "${ctx}/images/navi13_off.gif";
						document.getElementById("flyView").src = "${ctx}/images/navi05_off.gif";
						document.getElementById("carView").src = "${ctx}/images/navi06_on.gif";
					} else {
						doExecuteFly();
						document.getElementById("play").src = "${ctx}/images/navi11_on.gif";
						document.getElementById("pause").src = "${ctx}/images/navi12_off.gif";
						document.getElementById("stop").src = "${ctx}/images/navi13_off.gif";
						document.getElementById("flyView").src = "${ctx}/images/navi05_on.gif";
						document.getElementById("carView").src = "${ctx}/images/navi06_off.gif";
					}
				} else if (objNm == 'pause') {
					if (document.getElementById("flyView").src
							.indexOf('on.gif') == -1) {
						document.getElementById("play").src = "${ctx}/images/navi11_off.gif";
						document.getElementById("pause").src = "${ctx}/images/navi12_on.gif";
						document.getElementById("stop").src = "${ctx}/images/navi13_off.gif";
						document.getElementById("flyView").src = "${ctx}/images/navi05_off.gif";
						document.getElementById("carView").src = "${ctx}/images/navi06_on.gif";
					} else {
						document.getElementById("play").src = "${ctx}/images/navi11_off.gif";
						document.getElementById("pause").src = "${ctx}/images/navi12_on.gif";
						document.getElementById("stop").src = "${ctx}/images/navi13_off.gif";
						document.getElementById("flyView").src = "${ctx}/images/navi05_on.gif";
						document.getElementById("carView").src = "${ctx}/images/navi06_off.gif";
					}
				} else {
					document.getElementById("play").src = "${ctx}/images/navi11_off.gif";
					document.getElementById("pause").src = "${ctx}/images/navi12_off.gif";
					document.getElementById("stop").src = "${ctx}/images/navi13_on.gif";
				}
				break;

			//툴바
			case 'toolMenu':
				if (objNm == 'na_tool1') {
					top.MapControl('clickInformation');
					document.getElementById("na_tool1").src = "${ctx}/images/na_tool01_on.gif";
					document.getElementById("na_tool2").src = "${ctx}/images/na_tool02_off.gif";
					document.getElementById("na_tool3").src = "${ctx}/images/na_tool03_off.gif";
					document.getElementById("na_tool4").src = "${ctx}/images/na_tool04_off.gif";
					document.getElementById("na_tool5").src = "${ctx}/images/na_tool05_off.gif";
					document.getElementById("na_tool6").src = "${ctx}/images/na_tool06_off.gif";
				} else if (objNm == 'na_tool2') {
					top.MapControl('img_save');
					document.getElementById("na_tool1").src = "${ctx}/images/na_tool01_off.gif";
					document.getElementById("na_tool2").src = "${ctx}/images/na_tool02_on.gif";
					document.getElementById("na_tool3").src = "${ctx}/images/na_tool03_off.gif";
					document.getElementById("na_tool4").src = "${ctx}/images/na_tool04_off.gif";
					document.getElementById("na_tool5").src = "${ctx}/images/na_tool05_off.gif";
					document.getElementById("na_tool6").src = "${ctx}/images/na_tool06_off.gif";
				} else if (objNm == 'na_tool3') {
					top.MapControl('img_print');
					document.getElementById("na_tool1").src = "${ctx}/images/na_tool01_off.gif";
					document.getElementById("na_tool2").src = "${ctx}/images/na_tool02_off.gif";
					document.getElementById("na_tool3").src = "${ctx}/images/na_tool03_on.gif";
					document.getElementById("na_tool4").src = "${ctx}/images/na_tool04_off.gif";
					document.getElementById("na_tool5").src = "${ctx}/images/na_tool05_off.gif";
					document.getElementById("na_tool6").src = "${ctx}/images/na_tool06_off.gif";
				} else if (objNm == 'na_tool4') {
					top.MapControl('move_hand');
					document.getElementById("na_tool1").src = "${ctx}/images/na_tool01_off.gif";
					document.getElementById("na_tool2").src = "${ctx}/images/na_tool02_off.gif";
					document.getElementById("na_tool3").src = "${ctx}/images/na_tool03_off.gif";
					document.getElementById("na_tool4").src = "${ctx}/images/na_tool04_on.gif";
					document.getElementById("na_tool5").src = "${ctx}/images/na_tool05_off.gif";
					document.getElementById("na_tool6").src = "${ctx}/images/na_tool06_off.gif";
				} else if (objNm == 'na_tool5') {
					top.MapControl('cam_total');
					document.getElementById("na_tool1").src = "${ctx}/images/na_tool01_off.gif";
					document.getElementById("na_tool2").src = "${ctx}/images/na_tool02_off.gif";
					document.getElementById("na_tool3").src = "${ctx}/images/na_tool03_off.gif";
					document.getElementById("na_tool4").src = "${ctx}/images/na_tool04_off.gif";
					document.getElementById("na_tool5").src = "${ctx}/images/na_tool05_on.gif";
					document.getElementById("na_tool6").src = "${ctx}/images/na_tool06_off.gif";
				} else {
					top.MapControl('map_clear');
					document.getElementById("na_tool1").src = "${ctx}/images/na_tool01_off.gif";
					document.getElementById("na_tool2").src = "${ctx}/images/na_tool02_off.gif";
					document.getElementById("na_tool3").src = "${ctx}/images/na_tool03_off.gif";
					document.getElementById("na_tool4").src = "${ctx}/images/na_tool04_off.gif";
					document.getElementById("na_tool5").src = "${ctx}/images/na_tool05_off.gif";
					document.getElementById("na_tool6").src = "${ctx}/images/na_tool06_on.gif";
				}
				break;
			}
		}
	}

	//주행속도 조절버튼
	function naviSpeed(val) {
		var set_speed = document.getElementById('set_speed').value;
		if (set_speed > 9 || set_speed < 2) {
			alert('내비게이션 속도는 1 ~ 10 사이로 입력해주세요.');
			document.getElementById('set_speed').value = 5;
			return;
		}
		if (val == 'up') {
			document.getElementById('set_speed').value = parseInt(set_speed) + 1;
		} else {
			document.getElementById('set_speed').value = set_speed - 1;

		}
	}

	//동영상 녹화시작
	function videoRecording() {
		var ri = document.getElementById("recIcon");
		var src = ri.src;
		if (src.indexOf('navi_rec.gif') != -1) {
			$(ri).attr('src', '${ctx}/images/cont_stop.gif');
			doRecordStart();
		} else {
			$(ri).attr('src', '${ctx}/images/navi_rec.gif');
			doRecordStop();
		}
	}

	/**
	 * 녹화
	 */
	var file_path;
	function doRecordStart() {
		location.replace(top.WEB_SERVER_URL_SB + "/VideoRecorder&Menual.zip");
	}

	/**
	 * 정지
	 */
	function doRecordStop() {
		if (top.XDOCX.XDCapAVIIsRecording() == false) {
			alert("녹화가 진행 중이지 않습니다.");
			return;
		}
		top.XDOCX.XDCapAVIRecordEnd();
	}
</script>
</head>

<body onload="startLoad()">
	<div style="width: 436px;">
		<div style="float: left">
			<table border="0" cellpadding="0" cellspacing="0"
				style="float: left;">
				<tr>
					<td><a href="#" class="roll" onclick="doInputPoint()"> <img
							src="${ctx}/images/navi01_off.gif" alt="경로설정"> <img
							src="${ctx}/images/navi01_on.gif" class="over" alt="경로설정">
					</a></td>
				</tr>
				<tr>
					<td><a href="#" class="roll" onclick="doSave()"> <img
							src="${ctx}/images/navi02_off.gif" alt="경로저장"> <img
							src="${ctx}/images/navi02_on.gif" class="over" alt="경로저장">
					</a></td>
				</tr>
				<tr>
					<td><a href="#" class="roll" onclick="doOpen()"> <img
							src="${ctx}/images/navi03_off.gif" alt="불러오기"> <img
							src="${ctx}/images/navi03_on.gif" class="over" alt="불러오기">
					</a></td>
				</tr>
				<tr>
					<td><a href="#" class="roll" onclick="doInit()"> <img
							src="${ctx}/images/navi04_off.gif" alt="경로삭제"> <img
							src="${ctx}/images/navi04_on.gif" class="over" alt="경로삭제">
					</a></td>
				</tr>
			</table>
		</div>
		<div style="float: left">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td><a href="#" name="naviView"
						onclick="toggleBtn('fly','naviView');"> <img
							id="flyView" src="${ctx}/images/navi05_on.gif" alt="">
					</a></td>
				</tr>
				<tr>
					<td><a href="#" name="naviView"
						onclick="toggleBtn('car','naviView');"> <img
							id="carView" src="${ctx}/images/navi06_off.gif" alt="">
					</a></td>
				</tr>
			</table>
		</div>
		<div style="float: left">
			<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="91"
						style="background: url(${ctx}/images/navi_bg01.gif) no-repeat;">
						<ul style="margin-left: 5px; margin-top: 5px;">
							<li style="float: left;"><a href="#"
								onclick="naviSpeed('down')"><img
									src="${ctx}/images/set26_2.gif"></a></li>
							<li style="float: left; width: 32px; margin-top: 3px;"><input
								type="text" name="set_speed" id="set_speed" value="5"
								style="text-align: center; border: solid 1px; width: 30px;"
								readonly></li>
							<li><a href="#" onclick="naviSpeed('up')"><img
									src="${ctx}/images/set26_1.gif"></a></li>
						</ul>
					</td>
					<td width="91"
						style="background: url(${ctx}/images/navi_bg03.gif) no-repeat;"
						align="center">
						<ul>
							<li><a href="#" onclick="doRecordStart()"> <img
									id="recIcon" src="${ctx}/images/navi_bg03.gif">
							</a></li>
						</ul>
					</td>
					<td>
						<!-- 재생 --> <a href="#" name="playMode"
						onclick="toggleBtn('play','playMode');"> <img id="play"
							src="${ctx}/images/navi11_off.gif" alt="">
					</a>
					</td>
					<td>
						<!-- 일시정지 --> <a href="#" name="playMode"
						onclick="toggleBtn('pause','playMode');doPause()"> <img
							id="pause" src="${ctx}/images/navi12_off.gif" alt="">
					</a>
					</td>
					<td>
						<!-- 정지 --> <a href="#" name="playMode"
						onclick="toggleBtn('stop','playMode');doStop()"> <img
							id="stop" src="${ctx}/images/navi13_off.gif" alt="">
					</a>
					</td>
				</tr>
			</table>
		</div>
		<div style="float: left">
			<table border="0" cellpadding="0" cellspacing="0" style="float: left">
				<tr>
					<!-- 전 -->
					<td><a href="#" name="viewMode"
						onclick="toggleBtn('F','viewMode');doSetDirect(0)"> <img
							id="front" src="${ctx}/images/navi07_on.gif" alt="">
					</a></td>
					<!-- 후 -->
					<td><a href="#" name="viewMode"
						onclick="toggleBtn('B','viewMode');doSetDirect(180)"> <img
							id="back" src="${ctx}/images/navi08_off.gif" alt="">
					</a></td>
				</tr>
				<tr>
					<!-- 좌 -->
					<td><a href="#" name="viewMode"
						onclick="toggleBtn('L','viewMode');doSetDirect(-90)"> <img
							id="left" src="${ctx}/images/navi09_off.gif" alt="">
					</a></td>
					<!-- 우 -->
					<td><a href="#" name="viewMode"
						onclick="toggleBtn('R','viewMode');doSetDirect(90)"> <img
							id="right" src="${ctx}/images/navi10_off.gif" alt="">
					</a></td>
				</tr>
			</table>
		</div>
		<div style="float: left">
			<table width="207" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td height="31" colspan="8"
						style="background: url(${ctx}/images/navi_bg02.gif)"><input
						type="text" name="input_set_height" id="input_set_height"
						align="absmiddle" value="300"
						style="width: 50px; margin: 2px 0 0 50px"></td>
				</tr>
				<tr>
					<!-- 정보 -->
					<%-- 
					<td>
						<img src="${ctx}/images/na_tool00.gif">
					</td>
					 --%>
					<td><a href="#" name="toolMenu"
						onclick="toggleBtn('na_tool1','toolMenu');" title="정보보기"> <img
							id="na_tool1" src="${ctx}/images/na_tool01_off.gif">
					</a></td>
					<!-- 캡처 -->
					<td><a href="#" name="toolMenu"
						onclick="toggleBtn('na_tool2','toolMenu');" title="화면저장"> <img
							id="na_tool2" src="${ctx}/images/na_tool02_off.gif" alt="">
					</a></td>
					<!-- 인쇄 -->
					<td><a href="#" name="toolMenu"
						onclick="toggleBtn('na_tool3','toolMenu');" title="화면출력"> <img
							id="na_tool3" src="${ctx}/images/na_tool03_off.gif" alt="">
					</a></td>
					<!-- 이동 -->
					<td><a href="#" name="toolMenu"
						onclick="toggleBtn('na_tool4','toolMenu');" title="손이동"> <img
							id="na_tool4" src="${ctx}/images/na_tool04_off.gif" alt="">
					</a></td>
					<!-- 전체화면 -->
					<td><a href="#" name="toolMenu"
						onclick="toggleBtn('na_tool5','toolMenu');" title="전체화면"> <img
							id="na_tool5" src="${ctx}/images/na_tool05_off.gif" alt="">
					</a></td>
					<!-- 새로고침 -->
					<td><a href="#" name="toolMenu"
						onclick="toggleBtn('na_tool6','toolMenu');" title="초기화"> <img
							id="na_tool6" src="${ctx}/images/na_tool06_off.gif" alt="">
					</a></td>
					<td><a href="#"
						onclick="window.parent.showHistoryToggle(); doInit();"> <img
							src="${ctx}/images/na_tool08.gif"
							style="width: 29px; height: 100%;">
					</a></td>
					<td><img src="${ctx}/images/na_tool07.gif"
						style="width: 95%; height: 100%;"></td>
				</tr>
			</table>
			<div id="simulation_drive"></div>
		</div>
	</div>
</body>
</html>