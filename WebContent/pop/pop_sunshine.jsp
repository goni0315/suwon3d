<%
// '분석' > '일조권분석' > '태양궤적도보기' 기능을 실행시키면  나타나는 화면페이지.
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>	
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>태양궤적도</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/XDControl.js"></script>
<style type="text/css">
input.txt {border:1px solid #c0d2f2;padding:3px 2px 0px;width:315px;height:17px;}
input.txt2 {border:1px solid #c0d2f2;padding:3px 2px 0px;width:70px;height:17px;}
input.txt3 {border:1px solid #c0d2f2;padding:3px 2px 0px;width:30px;height:17px;}
td.searchsub {font-size:12px;font-family: Arial, Helvetica, sans-serif;padding:3px 3px 3px 3px;}
</style>

<script type="text/jscript" language="javascript" >
    function page_load() {
        var cntrPos = window.dialogArguments;
		var result = "";		
	    if(cntrPos != "") {
			cntrPos = cntrPos.split(",");
			result = document.TDOCX.XTDSunOrbitOnly("", cntrPos[0], cntrPos[1], cntrPos[2], cntrPos[3], cntrPos[4], cntrPos[5], 17);
            result = cntrPos[0] + "," + cntrPos[1] + "," + cntrPos[2] + "," + result;	
        }	
        
        var Temp = result.split(",");
		
        form1.input3.value = Temp[0];
        form1.input4.value = Temp[1];
        form1.input5.value = Temp[2];
        form1.input6.value = Temp[3];
        form1.input7.value = Temp[4];
        form1.input8.value = Temp[5];
        form1.input9.value = Temp[6];
        form1.input10.value = Temp[7];
        form1.input11.value = Temp[8];        
        form1.input12.value = Temp[1];        
    }
    
    function page_close() {
		window.close();
	}
</script> 

</head>

<body onLoad="javascript:page_load();">
<form name="form1" method="post" action="">
<div id="grade" style="width: 650px; height: 320px;">
  <div style="background: #2c3445; margin: 2px;">
    <p style="float: right;"></p>
    <p class="f_whit_am">태양궤적도보기</p>
  </div>
  <table width="650" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td colspan="3"></td>
    </tr>
    <tr>
      <td colspan="3"><table width="100%" border="0" cellpadding="0" cellspacing="0" style="background-image:url(${ctx}/images/pop/pop_menu_bg.gif)">
        <tr>
          <td width="104"><img src="${ctx}/images/pop/pop_menu4On.gif" alt="" width="104" height="33"></td>
          <td width="104">&nbsp;</td>
          <td>&nbsp;</td>
          <td width="10" align="right"><img src="${ctx}/images/pop/pop_menu_end.gif" alt="" width="10" height="33"></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td width="10" style="background-image:url(${ctx}/images/pop/left_bg.gif)"></td>
      <td bgcolor="#f8f8f8"><table width="599" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="50" class="searchsub"><strong> 좌표계 </strong></td>
          <td width="549"><span class="searchsub">
            <input type="text" onFocus="" onBlur="" class="txt" name="input2" id="input2" value="KoreaTM(Middle)"/>
          </span></td>
        </tr>
        <tr>
          <td colspan="4" align="left"><table width="407" border="0" cellspacing="0" cellpadding="1">
            <tr>
              <td width="43" height="22" align="center">X</td>
              <td width="85"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt2" name="input3" id="input3" style="width:90px"/>
              </span></td>
              <td width="38" align="center">Y</td>
              <td width="87"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt2" name="input4" id="input4" style="width:90px" />
              </span></td>
              <td width="32" align="center">Z</td>
              <td width="110"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt2" name="input5" id="input5" style="width:90px" />
              </span></td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td colspan="4" align="left"><table width="599" border="0" cellspacing="0" cellpadding="1">
            <tr>
              <td width="40" height="22" align="center"><strong>경도</strong></td>
              <td width="30"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt3" name="input6" id="input6"/>
              </span></td>
              <td width="11" align="left">도</td>
              <td width="33" align="right"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt3" name="input7" id="input7"/>
              </span></td>
              <td width="11">분</td>
              <td width="31"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt3" name="input8" id="input8"/>
              </span></td>
              <td width="23"><span class="searchsub">초</span></td>
              <td width="29" align="center"><strong>위도</strong></td>
              <td width="31"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt3" name="input9" id="input9"/>
              </span></td>
              <td width="17">도</td>
              <td width="35"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt3" name="input10" id="input10"/>
              </span></td>
              <td width="16">분</td>
              <td width="31"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt3" name="input11" id="input11"/>
              </span></td>
              <td width="22">초</td>
              <td width="33"><strong>높이</strong></td>
              <td width="90"><span class="searchsub">
                <input type="text" onFocus="" onBlur="" class="txt3" name="input12" id="input12" style="width:90px" />
              </span></td>
              <td width="82">M</td>
            </tr>
          </table></td>
        </tr>
      </table></td>
      <td width="10" style="background-image:url(${ctx}/images/pop/right_bg.gif)"></td>
    </tr>
    <tr>
      <td height="15" style="background-image:url(${ctx}/images/pop/left_bott.gif)"></td>
      <td style="background-image:url(${ctx}/images/pop/bott_bg.gif)"></td>
      <td style="background-image:url(${ctx}/images/pop/right_bott.gif)"></td>
    </tr>
  </table>
  <table width="650" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td height="2" colspan="3"></td>
    </tr>
    <tr>
      <td colspan="3"><table width="100%" border="0" cellpadding="0" cellspacing="0" style="background-image:url(${ctx}/images/pop/pop_menu_bg.gif)">
        <tr>
          <td width="104"><img src="${ctx}/images/pop/pop_menu5On.gif" alt="" width="104" height="33"></td>
          <td width="104">&nbsp;</td>
          <td>&nbsp;</td>
          <td width="10" align="right"><img src="${ctx}/images/pop/pop_menu_end.gif" alt="" width="10" height="33"></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td width="10" style="background-image:url(${ctx}/images/pop/left_bg.gif)"></td>
      <td align="top" bgcolor="#f8f8f8"><div id="img_show" style="position:relative; left:8px;width:625px;height:304px;">
        <table width="98%" height="98%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="100%" height="100%"><script type="text/javascript">tdk();</script></td>
          </tr>
        </table>
      </div></td>
      <td width="10" style="background-image:url(${ctx}/images/pop/right_bg.gif)"></td>
    </tr>
    <tr>
      <td height="15" style="background-image:url(${ctx}/images/pop/left_bott.gif)"></td>
      <td style="background-image:url(${ctx}/images/pop/bott_bg.gif)"></td>
      <td style="background-image:url(${ctx}/images/pop/right_bott.gif)"></td>
    </tr>
  </table>
</div>

</form>
</body>
</html>
