<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설물 리스트</title>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery-ui-1.8.custom.min.js"></script>
<link href="${ctx}/css/admin_common.css" rel="stylesheet" type="text/css">
</head>
<body style="padding: 10px;">

<script type="text/javascript">
//자식창에서 부모창 함수 호출 ex
function openerControl(pnu){
	window.opener.doBldgView(pnu);	
}
</script>
<div style="text-align: right; padding-bottom: 5px;">
전체 ${totalCount}, 페이지 ${pageNum} / ${totalPage}
</div>
				<div class="bbsCont">
					<table class="wps_100">
						<colgroup>
							<col class="w_20" />
							<col class="w_20"/>
							<col class="w_80" />
							<col class="w_60" />
							<col class="w_60" />
						</colgroup>
							<tr>
								<th scope="col">준공년도</th>
								<th scope="col">구 분</th>
								<th scope="col">명 칭</th>
								<th scope="col">도로명주소</th>
								<th scope="col">지번주소</th>
							</tr>
											
								<c:forEach items="${bldgList}" var="list"> 
															
								<tr>
									<td align="center" >${list.bldg_year}</td>
									
									<td align="center">${list.utl3d_type}</td>
																		
									<c:choose>
									<c:when test="${not empty list.utl3d_bn}">
									<td align="center">${list.utl3d_bn}</td>	
									</c:when>
									<c:otherwise>
									<td align="center">-</td>	
									</c:otherwise>									
									</c:choose>																
								
									<td align="center"><a href="javascript:openerControl('${list.pnu}')">
									${list.utl_3d_rna}</a></td>
									
									<td align="center"><a href="javascript:openerControl('${list.pnu}')">
									${list.utl3d_bad}</a></td>
								</tr>
								
								
						 	</c:forEach> 
						 	
					</table>
				</div>
				<div style="text-align: center; font-size: 12px; vertical-align: middle; padding-top:20px; position: fixed; left: 280px;" >
				<c:if test="${prev}">
				<a href="${ctx}/buildingManagement.do?pageNum=${startPage-1}" style="text-decoration: none;"><img  src="${ctx}/images/bbs/page_first.gif" style="vertical-align: middle;"></a>				
				</c:if>
				<c:forEach begin="${startPage}" end="${endPage}" var="idx">
				<c:choose>
				<c:when test="${pageNum eq idx}">
				
				<a href="${ctx}/buildingManagement.do?pageNum=${idx}" style="text-decoration: none;">[<span style="color: red; font-size: 13px">${idx}</span>]</a>				
				</c:when>
				<c:otherwise>
					<a href="${ctx}/buildingManagement.do?pageNum=${idx}" style="text-decoration: none;">[${idx}]</a>				
				</c:otherwise>
				</c:choose>
				
				</c:forEach>
				<c:if test="${next}">
				<a href="${ctx}/buildingManagement.do?pageNum=${endPage+1}" style="text-decoration: none;"><img  src="${ctx}/images/bbs/page_last.gif" style="vertical-align: middle;"></a>				
				</c:if>
				</div>
	
	
			
</body>
</html>