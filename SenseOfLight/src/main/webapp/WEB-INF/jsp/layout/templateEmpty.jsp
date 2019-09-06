<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<html>
<head>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body style="width: 100%; height: 700px; background-color: red;">
<div id="templateEmpty">
    <div id="content"><tiles:insertAttribute name="content" ignore="true"/></div>
   </div>

</body>
</html>