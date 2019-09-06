<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link href="<c:url value="/css/view/mypageForm.css"/>" rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script type="text/javascript">
	
</script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<div id="mypage_wrap">
		<div id="mypage_tabbox">
			<div>
				<div style="background-color: #c28562;">
					<a href="myPage.do" style="color: white;">마이페이지</a>
				</div>
				<div>
					<a href="#">장바구니</a>
				</div>
				<div>
					<a href="order_Status.do">주문/배송 조회</a>
				</div>
				<div>
					<a href="member_Modify.do">회원정보 수정</a>
				</div>
				<div>
					<a href="#">관심상품</a>
				</div>
			</div>
			<div>
				<div>
					<a href="#">적립금내역</a>
				</div>
				<div>
					<a href="#">쿠폰내역</a>
				</div>
				<div>
					<a href="#">내 게시물 관리</a>
				</div>
				<div>
					<a href="#">내 배송지 관리</a>
				</div>
				<div>
					<a href="#">오늘 본 상품</a>
				</div>
			</div>
		</div>
		<div style="width: 1350px; height: 50px; display: inline-block;"></div>
		<div id="mypage_message">
			<div>
				<img src="<c:url value='/images/common/img_member_default.gif'/>" />
			</div>
			<div>저희 쇼핑몰을 이용해 주셔서 감사합니다. 한윤서 님은 [일반회원] 회원이십니다.</div>
		</div>
		<div style="width: 1350px; height: 25px; display: inline-block;"></div>
		<div id="mileage_box">
			<ul>
				<li><strong> <img src="<c:url value='/images/common/arrow.jpg'/>"> 가용 적립금
				</strong> <input type="button" value="조회"> <strong> 3,000원 </strong></li>
				<li><strong> <img src="<c:url value='/images/common/arrow.jpg'/>"> 총적립금
				</strong> <strong> 3,000원 </strong></li>
				<li><strong> <img src="<c:url value='/images/common/arrow.jpg'/>"> 사용 적립금
				</strong> <strong> 3,000원 </strong></li>
				<li><strong> <img src="<c:url value='/images/common/arrow.jpg'/>"> 총주문
				</strong> <strong> 3,000원 </strong></li>
				<li><strong> <img src="<c:url value='/images/common/arrow.jpg'/>"> 쿠폰
				</strong> <input type="button" value="조회"> <strong> 3,000원 </strong></li>
			</ul>
		</div>
		<div style="width: 1350px; height: 25px; display: inline-block;"></div>
		<div id="order_status">
			<div>
				<h3>나의 주문처리 현황</h3>
				<span>(최근 3개월 기준)</span>
			</div>
			<div>
				<ul>
					<li>
						<strong>입금전</strong>
						<strong>0</strong>
					</li>
					<li>
						<strong>배송준비중</strong>
						<strong>0</strong>
					</li>
					<li>
						<strong>배송중</strong>
						<strong>0</strong>
					</li>
					<li>
						<strong>배송완료</strong>
						<strong>0</strong>
					</li>
				</ul>
				<ul>
					<li> · 취소&nbsp;&nbsp;:&nbsp;&nbsp;0</li>
					<li> · 교환&nbsp;&nbsp;:&nbsp;&nbsp;0</li>
					<li> · 반품&nbsp;&nbsp;:&nbsp;&nbsp;0</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>