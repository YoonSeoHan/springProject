<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.io.*, java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<html>
<head>
<%--  CSS/JS 파일 캐싱 방지 --%>
<%
	String styleCss = application.getRealPath("/css/style.css");
	File style = new File(styleCss);
	Date lastModifiedStyle = new Date(style.lastModified());

	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link href="<c:url value="/css/view/list.css"/>" rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script src="jquery/jquery-ui.js"></script>
<script type="text/javascript">
function Link(num) {
	var f = frm;
	f.method="get"
	f.action="product_Detail.do"
	f.productNum.value = num;
	f.submit();
}

</script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<!-- 만들때 content내부에서 잘 동작하도록 사이즈 잘보고 만들것 -->
	<!-- 1350px 에 상품 5개 + 각상품의 padding체크 -->
	<%-- <c:forEach items="${productList.productlist }" var="data" varStatus="i">
	<c:out value="${data.productImg }"></c:out> <br>
	<c:out value="${data.productName }"></c:out> <br>
	<c:out value="${data.productAccount }"></c:out> <br>
	<c:out value="${data.productPirce }"></c:out> <br>
</c:forEach> --%>
	<c:set var="chk" value="${fn:length(fileList.filelist) }"></c:set>


	<div id="product_wrap">
		<div id="product_title">
			<div id="product_label">
				<label>PRODUCT - <c:out value="${product }"/></label>
			</div>
			<div id="product_sub">
				<ul>					
					<li><div><a href="product_List.do?product=001">LED 20평형</a></div></li>
					<li><div><a href="#">LED 30평형</a></div></li>
					<li><div><a href="product_List.do?product=002">디자인 조명</a></div></li>
					<li><div><a href="#">샹들리에/엔틱</a></div></li>
				</ul>
			</div>
		</div>
		<c:forEach items="${fileList.filelist }" varStatus="i">
			<c:set var="chk" value="${i.index+1 }" />
			<c:set var="lastChild" value="" />
			<c:if test="${chk%5 eq 0}">
				<c:set var="lastChild" value="margin-right: 0;" />
			</c:if>
			<div class="product_list" style="${lastChild}">
				<ul>
					<li>
						<div class="img_list">
							<c:set var="list" value="${fileList.filelist[i.index].imgList }.gif" />
							<c:set var="productNum" value="${fileList.filelist[i.index].productNum }"/>
							<a href="#" onclick="Link(${productNum})">
							<img src="<c:url value='/images/list/${list }'/>">
							</a>
							<%-- <c:set var = "haha" value="${imageList.imagelist[i.index].imgList }.gif"/> 
							<c:out value="${haha }"/> --%>
						</div>
					</li>
					<li>
						<div class="product_name">
						<c:out value ="${fileList.filelist[i.index].productName }"/>
						</div>
					</li>
					<li>
						<div class="product_account">
						<c:out value ="${fileList.filelist[i.index].productAccount }"/>
						</div>
					</li>
					<li>
						<div class="product_price">
						<c:out value ="${fileList.filelist[i.index].productPrice }원"/>
						</div>
					</li>
				</ul>
			</div>
		</c:forEach>
	</div>
<form name="frm">
	<input type="hidden" name="productNum"  style="padding:0; margin:0;">
</form>
</body>
</html>