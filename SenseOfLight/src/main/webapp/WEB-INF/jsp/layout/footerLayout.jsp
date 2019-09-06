<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%--  CSS/JS 파일 캐싱 방지 --%>
<%
	String styleCss = application.getRealPath("/css/style.css");
	File style = new File(styleCss);
	Date lastModifiedStyle = new Date(style.lastModified()); 

	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/css/layout/layout_footer.css?ver=<%=fmt.format(lastModifiedStyle)%>"/>" rel="stylesheet" />
<title>Insert title here</title>
</head>
<body>
<div id="footer_main">
	<ul>
		<li><div id="footer_logo"><label>Sense of Light</label></div></li>
		<li><div id="footer_account">
			<ul>
				<li><pre>COMPANY YS조명     OWNER 한윤서     BUSINESS LICENSE607-07-95156     ONLINE-LICENSE 제 2006-울산남구-53707호</pre></li>
				<li><pre>TEL 999-9999     FAX 0909-990-9999     E-MAIL ginfizz1124188@gmail.com</pre></li>
			</ul>
			</div>
		</li>
	</ul>
</div>
</body>
</html>