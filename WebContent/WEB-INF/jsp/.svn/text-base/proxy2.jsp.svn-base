<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ page import="java.net.*,java.io.*"%>
<%@ page import="net.sf.json.xml.XMLSerializer"%> 
<%@ page import="net.sf.json.*"%>

<%
	try {
		String reqUrl = request.getParameter("url");	//OR:   request.getQueryString();
		System.out.println("요청 url : " + reqUrl);
		URL url = new URL(reqUrl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setDoOutput(true);
		con.setRequestMethod(request.getMethod());
		int clength = request.getContentLength();
		if (clength > 0) {
			con.setDoInput(true);
			byte[] idata = new byte[clength];
			request.getInputStream().read(idata, 0, clength);
			con.getOutputStream().write(idata, 0, clength);
		}
		
		
		
		BufferedReader rd = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
		String line;
		String str = "";
		while ((line = rd.readLine()) != null) {
			if (line != ""){
				str += line;
			}
		}
		JSONObject jsonObj = (JSONObject)new XMLSerializer().read(str);
        System.out.println("결과1 : " + jsonObj);
        
		System.out.println("결과2 : " + str);
		response.setContentType(con.getContentType());
		//response.setContentType("text/xml; charset=utf-8");
		out.println(jsonObj);
		
		rd.close();
	} catch (Exception e) {
		response.setStatus(500);
	}
%>