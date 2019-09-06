<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.io.*, java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<html>
<head>
<%
String styleCss = application.getRealPath("/css/style.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link href="<c:url value="/css/layout/layout_test.css"/>" rel="stylesheet" />
<link href="<c:url value="/css/view/detailForm.css"/>" rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script src="jquery/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(function(){ 

	
	
});
function test() {
	var test = [1, 2, 3, 4];
	
	test.slice(
}

</script>
<meta charset=UTF-8>
<title>Insert title here</title>
<style>
/* prev_user_upload_img */

</style>
</head>
<body>
<a href="javascript:" onclick="test();">haha</a>




</body>
</html>