<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${ctx}/css/gislayout.css" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript">
var  m_Ax;
var  m_Ay;
var  m_Az;
var  m_Bx;
var  m_By;
var  m_Bz;
//분시시점 입력
function Sasun_Set(mode){
	top.XDOCX.XDUIClearInputPoint();
	
	top.XDOCX.XDUISetWorkMode(21);
	
	top.setWorkMode(mode);
}
//실행
function Start(){
	if (top.bExistObjectInLayer("Temporary", "시작점") == false)
    {
        alert("사선분석 라인을 입력하세요.");
        return;
    }
	
	if ((m_Ax==null) && (m_Ay==null) && (m_Az==null)){
		alert("사선분석 라인을 입력하세요.");
        return;
	}
	
    var alpha = Math.ceil(255/100*Opacity.value);

    var sideAngle = FlaringAngle.value;
    var range = FlarinLength.value;


    var tmpSideLength, sideLength, slopeAngle, seeHeight;

   
   slopeAngle = (Math.atan(Viewrate.value) * 180) / Math.PI;

   if (checkbox2.checked == true)
   {
       seeHeight = ViewHeight.value;
   }
   else
   {
       seeHeight = 0;
   }
   if (Road_size.value == "")
   {
       var lenX = m_Ax - m_Bx;
       
       var lenY = m_Ay - m_By;
       var lenZ = m_Az - m_Bz;

       var powX = Math.pow(lenX, 2);
       var powY = Math.pow(lenY, 2);
       var powZ = Math.pow(lenZ, 2);

       var lenT = Math.sqrt((powX + powY + powZ) / 2);
       range = lenT * 10;
   }
    
   top.XDOCX.XDLaySetEditable("Temporary");

	var color1 = "0,0,255";
	color1 = color1.split(',');
   top.XDOCX.XDAnsCreateSlopePlane(m_Ax, parseFloat(m_Ay) + parseFloat(seeHeight), m_Az, m_Bx, m_By, m_Bz,slopeAngle, sideAngle, range, color1[0], color1[1], color1[2], alpha);
    
   top.XDOCX.XDMapResetRTT();
   top.XDOCX.XDMapRender();
   top.XDOCX.XDUISetWorkMode(1);
}

//초기화
function Clear(){
	 top.XDOCX.XDLayClear("Temporary");
	 
	 top.XDOCX.XDMapRenderLock(true);
	 top.XDOCX.XDUIClearInputPoint();
	 top.XDOCX.XDSelClear();
     top.XDOCX.XDAnsClear();
     top.XDOCX.XDAnsClearSlice();
     top.XDOCX.XDUIDistanceClear();
     top.XDOCX.XDMapRenderLock(false);
     top.XDOCX.XDMapRender();
	
	 m_Ax=null;
	 m_Ay=null;
	 m_Az=null;
	 Road_size.value = "";
	 ViewHeight.value=1.6;
	 Viewrate.value = 1.5;
	 FlaringAngle.value = 60;
	 FlarinLength.value = 200;
	 Opacity.value = 50;
	 $('#result').empty();
	}
	
</script>
</head>
<body>
	<div id="panel">
		<div id="title">
			<div id="category" style="margin-top: 35px;">
				<ul style="width: 320px;">
					<li style="float: left;">
						<a href="gasi.jsp" target="left">
							<img src="${ctx}/images/btn_gasi_off.gif" alt="가시권" />
						</a>
					</li>
					<li style="float:left;margin-left: 4px;">
						<a href="gasi_zone.jsp"target="left">
							<img src="${ctx}/images/btn_gasiZone_off.gif" alt="가시권역" />
						</a>
					</li>
					<li style="float: right">
						<a href="sasun.jsp"target="left">
							<img src="${ctx}/images/btn_sasun_on.gif" alt="사선분석" />
						</a>
					</li>
					<li style="padding-top: 15px; clear: both;"><img src="${ctx}/images/category_SIDE.gif" /></li>

					<li class="f_whit_am">분석시점설정</li>
					<li>
						<a href="#" onclick="Sasun_Set('Road_size')"><img src="${ctx}/images/btn_center_set.gif"/></a>
					
						<a href="#" onclick="Clear()"><img src="${ctx}/images/btn_analysis_cancel.gif" width="96" height="24" /></a>
					</li>
                    <li></li>
                    </ul>
	              <fieldset style="padding:5px">
	              <legend>도로폭</legend>
						도로폭 :<input id="Road_size" name="Road_size" type="text" disabled style="width:80px"  readonly="readonly" value="0"> m
	              </fieldset>
					<fieldset style="padding:5px">
						<legend class="f_whit_am" style="margin-top: 14px;">분석설정옵션</legend>
						<ul>
							<li style="float: left;">
								<label style="width:120px;">
									<input type="checkbox" name="checkbox2" id="checkbox2">
									시야높이적용
								</label> 
								<input type="text" name="ViewHeight" id="ViewHeight" value="1.7" maxlength="4" /> m
							</li>
							<li style="clear: both;">
								<label style=" padding-left:48px;">비율</label> 
								<input type="text" name="Viewrate" id="Viewrate" value="1.5" maxlength="4" /> 배
							</li>
						</ul>
					</fieldset>
					<fieldset style="padding:5px">
						<legend class="f_whit_am" style="margin-top: 14px;">사용자정의옵션</legend>
						<ul>
							<li style="float: left;">
								<label for="FlaringAngle">퍼짐각</label> 
								<input type="text" name="FlaringAngle" id="FlaringAngle" value="60" /> 도
							</li>
							<li style="float: left;">
								<label for="FlarinLength">분사길이</label> 
								<input type="text" name="FlarinLength" id="FlarinLength" value="200" />m
							</li>
						    <li style="clear: both;">
								<label for="Opacity">불투명도</label> 
							  <input type="text" name="Opacity" id="Opacity" value="50" />%
							</li>
						</ul>
					</fieldset>
						<a href="#" onclick="Start()">
							<img src="${ctx}/images/btn_ok.gif" style="margin:10px 0 10px 0; float:right;"/>
						</a>
			</div>
		</div>
	</div>
</body>
</html>
