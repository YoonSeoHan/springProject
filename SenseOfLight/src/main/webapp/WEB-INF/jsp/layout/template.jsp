<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
<link href="<c:url value="/css/layout/layout_template.css"/>" rel="stylesheet" />

<script src="jquery/jquery.cookie.js"></script>
<meta charset=UTF-8>

<title>Insert title here</title>
</head>
<body>
  <div id="template">
    <div id="header"><tiles:insertAttribute name="header" ignore="true"/></div>
    <div id="content"><tiles:insertAttribute name="content" ignore="true"/></div>    
    <div id="footer"><tiles:insertAttribute name="footer" ignore="true"/></div>
   </div>
</body>
</html>