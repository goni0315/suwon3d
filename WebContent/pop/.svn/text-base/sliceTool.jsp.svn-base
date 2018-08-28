<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>단면분석</title>
<link href="../css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<script type="text/javascript">
window.onload = function(){
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
};
//var Start_point0; 
//var Start_point1;
//var Start_point2;
//var End_point0;
//var End_point1;
//var End_point2;

//단면도 분석 레이어 리스트
function laylist() {
	var oList = $('#Layer');
	oList.empty();

	$.getJSON("../js/sidelayer.json",function(data, status) {
		$.each(data,function(i, n) {
		//oList.append($('<option value="'+n.LARY_ENM+'">'+n.LARY_NM+'</option>'));
		oList.append($("<tr>"
					+ "<td width='40' align='center'><input type='checkbox' name='layer' id='checkbox' value='"+ n.LARY_ENM + "' checked='checked'>"
					+ ($('#Layer tr').length + 1)
					+ "</td>"
					+ "<td align='center'>"
					+ n.LARY_NM
					+ "</td>"
					+ "</tr>"));
		});
	});
	
}

//단면분석 시작점
function sliceStart(){
	top.XDOCX.XDLayClear("Temporary");
	top.XDOCX.XDUIClearInputPoint();
	top.XDOCX.XDUISetWorkMode(0);
	top.setWorkMode('WideStart');
}

//단면분석 목표점
function sliceEnd(){ 
	 
	top.XDOCX.XDUISetWorkMode(0);
	top.setWorkMode('WideEnd');
	
}

//단면분석 실행
function sliceExe(){
	
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
	       if ((parent.Start_point0!=null) && (parent.Start_point1!=null) && (parent.Start_point2!=null)) {
	    	   
			}else{
				alert("분석시점이 없습니다. 분석시점을 다시 입력해주세요.");
			return;
			}
			if ((parent.End_point0!=null) && (parent.End_point1!=null) && (parent.End_point2!=null)) {
				
			}else{
				alert("목표점이 없습니다. 분석시점을 다시 입력해주세요.");
			return;
			}
	      
	       top.XDOCX.XDUIInput3DPoint(parseFloat(parent.Start_point0), parseFloat(parent.Start_point1), parseFloat(parent.Start_point2));
	       top.XDOCX.XDUIInput3DPoint(parseFloat(parent.End_point0), parseFloat(parent.End_point1), parseFloat(parent.End_point2));
	       
	       var sPath = "c:\\wslice.txt";
	       top.XDOCX.XDLaySetEditable("Temporary");
	       
	       if (top.XDOCX.XDAnsWideSlice(30, 10, sPath))
	       {
	       	var w = 700;
	    	var h = 500;
	    	var l = screen.width - w;
	    	var t = screen.height - h;
	    	

	        var url = "pop_section.html";

	    	win_dan = window.showModelessDialog(url, top, "dialogWidth:" + w + "px; dialogHeight:" + h + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px; border:thin; status:no; resizable:no; center:no; help:no; scroll:no;");
	    	
	       }
	       else
	       {
	          alert("분석에 실패하였습니다.");
	       }
	       
	       top.XDOCX.XDUIClearInputPoint();
		
	};
	
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
</script>
</head>
<body>
		<div style="background: #2c3445; margin: 2px;">
			<p style="float: right;">
				
			</p>
			<p class="f_whit_am">단면분석</p>
		</div>
		<ul style="margin: 5px;">
			<li style="float: left; margin-right: 3px;">
				<a href="#" onclick="sliceStart()">
					<img src="${ctx}/images/btn_slice_point.gif" />
				</a>
			</li>
			<li style="float: left; margin-right: 3px;">
				<a href="#" onclick="sliceEnd()">
					<img src="${ctx}/images/btn_slice_ta.gif" />
				</a>
			</li>
			<li style="margin-right: 3px; float: left;">
				<a href="#" onclick="sliceExe()">
					<img src="${ctx}/images/btn_slice_s.gif" />
				</a>
			</li>
		</ul>
		<div id="resultset" style="margin-left: 10px">
		</div>
</body>
</html>