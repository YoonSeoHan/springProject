<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.io.*, java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="light.common.service.Token" %>
<%
	String styleCss = application.getRealPath("/css/style.css");
	File style = new File(styleCss);
	Date lastModifiedStyle = new Date(style.lastModified());
	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<html>
<head>
<link href="<c:url value="/css/layout/layout_header.css"/>" rel="stylesheet" />
<link href="<c:url value="/css/layout/layout_popup_login.css"/>" rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script type="text/javascript">
	
	
	$(document).ready(function() {
						var remember = false;
						$(document).on('click', '#login', function (){
											/* 아이디가 존재하면 */
											/* 아이디 저장여부 */
											/* undefined or null */
											var cookie = $.cookie("memInputId");
											/* 아이디 저장을 눌렀을 경우에만 쿠키 생성 */
											/* ->로그인한 기록이 있을경우 */
											if (cookie != undefined
													|| cookie != "null") {
												$('#memId').val(cookie);
												$('#remember').prop("checked",
														true);
											}
											/* ->로그인한 기록이 없거나 아이디저장 체크를 안했을 경우 */
											if (cookie == undefined
													|| cookie == "null") {
												$('#memId').val("");
												$('#remember').prop("checked",
														false);
											}

											$('#popup_layer, #overlay_t')
													.show();
											$('#popup_layer').css(
													"top",
													Math.max(0, $(window)
															.scrollTop() + 120)
															+ "px");
											// $('#popup_layer').css("top", Math.max(0, (($(window).height() - $(this).outerHeight()) / 2) + $(window).scrollTop()) + "px");		
										}
						); 
						$('#overlay_t, .close').click(function(e) {
							e.preventDefault();
							$('#popup_layer, #overlay_t').hide();
						});
						
						$("#inb_container li").hover(function() {
							$(this).children("ul").first().slideToggle(1);
						});

						/* 로그인 버튼 클릭 */
						$("#loginAction")
								.on(
										"click",
										function(e) {
											e.preventDefault();

											if ($("#memId").val() == "") {
												alert("아이디를 입력하세요");
												$("#memId").focus();
												return false;
											}
											if ($("#memPw").val() == "") {
												alert("비밀번호를 입력하세요");
												$("#memId").focus();
												return false;
											}
											/* 로그인 버튼 클릭시 remember 체크 */

											var params = $("#loginfrm")
													.serialize()
													+ "&remember=" + remember;
											/* alert(JSON.stringify(params)); */
											$.ajax({
												type : "post",
												url : "<c:url value='/loginAction.do' />",
												data : params,
												/* 되돌려받는 type을 json으로 하면 에러처리 text로 하면 success */
												dataType : "text", //post방식 제거시 get방식
												/* ContentType : 'application/json;charset=UTF-8', //post방식  */
												async : true, // 비동기
												success : function(data) {
												alert("success");
												/* 쿠키 생성 및 삭제 */
												remember = $("#remember").is(":checked") == true || false;
															if (remember == true) {
																var memId = $('#memId').val();
																$.cookie("memInputId",memId,{expires : 1,path : '/'});
															} else {
																$.cookie("memInputId",null);
															}
														},
														error : function(
																request,
																status, error) {
															alert("code:"
																	+ request.status
																	+ "\n"
																	+ "message:"
																	+ request.responseText
																	+ "\n"
																	+ "error:"
																	+ error);
														}
													});

										});
					});

	
	/* e는 크롬에서만 가능 -> IE용을 별도로 지정 */
	/* var AddEvent = window.attachEvent || window.addEventListener; 
	var AddBeforeUnload = window.attachEvent ? 'onbeforeunload' : 'beforeunload'; 
	AddEvent(AddBeforeUnload, function(e) {
		var confirmationMessage = '아직 해당 내용을 저장하지 않았습니다. 저장하지 않은 채로 다른 페이지로 이동하시겠어요?';
		(e || window.event).returnValue = confirmationMessage;
		var CRUD = "test";
		var params = ['test', '5'];
		var jsonList = { "CRUD" : CRUD, "params" : params};
		$.ajax({
			type : "post",
			url : "<c:url value='/CartService.ajax'/>",
			data: JSON.stringify(jsonList),
			dataType: "text",
			async: true,
			contentType: "application/json; charset=utf-8",
			success : function(data) {
			}, error: function (request, status, error) {
				alert("code:"+ request.status+ "\n"
						+ "message:"+ request.responseText+ "\n"
						+ "error:"+ error);
			}
		})
		
		return confirmationMessage;

	})  */

</script>

<title>Insert title here</title>
</head>
<body>
<%--<script type="text/javascript">
 <%
if(request.getAttribute("TOKEN_KEY")==null){
	Token.set(request);
	%>
		alert('핳하');
	<%
}
%>
		</script>
		<form id="frm" action="Token.ajax" method="post">
		<input type="hidden" name="TOKEN_KEY" id="TOKEN_KEY" value="<%=request.getAttribute("TOKEN_KEY")%>"/>
		</form> --%>
	<!-- header-start -->
	<header id="header_main">
		<hgroup id="header_title">
			<h1>
				<a href="solhome.do">Sense of Light</a>
			</h1>
		</hgroup>
		<nav id="header_gnb">
			<ul>
				<li><a href="javascript:" class="gnb_menu" id="login">LOGIN</a></li>
				<li><a href="member_Join.do" class="gnb_menu">JOIN</a></li>
				<li><a href="product_Cart.do" class="gnb_menu">CART</a></li>
				<li><a href="myPage.do" class="gnb_menu">MYPAGE</a></li>
			</ul>
		</nav>
		<nav id="header_inb">
			<ul id="inb_container">
				<li><a href="product_List.do?product=001,002" class="inb_menu">거실 · 로비</a>
					<ul class="inb_tab">
						<li>
							<div>
								<div class="tab_sub">
									<ul>
										<li><a href="product_List.do?product=001">LED 20평형</a></li>
										<li><a href="#">LED 30평형</a></li>
										<li><a href="product_List.do?product=002">디자인 조명</a></li>
										<li><a href="#">샹들리에/엔틱</a></li>
									</ul>
								</div>
								<div class="tab_image">
									<img src="<c:url value="/images/tab/tab_lobby.jpg"/>">
								</div>
							</div>
						</li>
					</ul></li>
				<li><a href="#" class="inb_menu">LED조명</a>
					<ul class="inb_tab">
						<li>
							<div>
								<div class="tab_sub">
									<ul>
										<li><a href="#">LED 실속세트</a></li>
										<li><a href="#">LED 거실조명</a></li>
										<li><a href="#">LED 식탁/포인트</a></li>
										<li><a href="#">LED 주방/욕실</a></li>
									</ul>
								</div>
								<div class="tab_image">
									<img src="<c:url value="/images/tab/tab_led.jpg"/>">
								</div>
							</div>
						</li>
					</ul></li>
				<li><a href="product_List.do?product=003,004" class="inb_menu">방조명</a>
					<ul class="inb_tab">
						<li>
							<div>
								<div class="tab_sub">
									<ul>
										<li><a href="#">LED 큰방</a></li>
										<li><a href="#">LED 작은방</a></li>
										<li><a href="product_List?product=003">샹들리에/엔틱</a></li>
										<li><a href="product_List?product=004">패브릭 조명</a></li>
									</ul>
								</div>
								<div class="tab_image">
									<img src="<c:url value="/images/tab/tab_room.jpg"/>">
								</div>
							</div>
						</li>
					</ul></li>
				<li><a href="#" class="inb_menu">식탁 · 포인트</a>
					<ul class="inb_tab">
						<li>
							<div>
								<div class="tab_sub">
									<ul>
										<li><a href="#">LED 식탁조명</a></li>
										<li><a href="#">북유럽</a></li>
										<li><a href="#">빈티지</a></li>
										<li><a href="#">샹들리에/엔틱</a></li>
									</ul>
								</div>
								<div class="tab_image">
									<img src="<c:url value="/images/tab/tab_table.jpg"/>">
								</div>
							</div>
						</li>
					</ul></li>
				<li><a href="#" class="inb_menu">주방 · 레일</a>
					<ul class="inb_tab">
						<li>
							<div>
								<div class="tab_sub">
									<ul>
										<li><a href="#">LED 주방조명</a></li>
										<li><a href="#">디자인 조명</a></li>
										<li><a href="#">레일형 조명</a></li>
										<li><a href="#">스포트 조명</a></li>
									</ul>
								</div>
								<div class="tab_image">
									<img src="<c:url value="/images/tab/tab_kitchen.jpg"/>">
								</div>
							</div>
						</li>
					</ul></li>
				<li><a href="#" class="inb_menu">벽조명</a>
					<ul class="inb_tab">
						<li>
							<div>
								<div class="tab_sub">
									<ul>
										<li><a href="#">ED 벽조명</a></li>
										<li><a href="#">북유럽</a></li>
										<li><a href="#">빈티지</a></li>
										<li><a href="#">샹들리에/엔틱</a></li>
									</ul>
								</div>
								<div class="tab_image">
									<img src="<c:url value="/images/tab/tab_wall.jpg"/>">
								</div>
							</div>
						</li>
					</ul></li>
			</ul>
		</nav>
	</header>
	<!-- header-end -->

	<!-- login_popupLayer -->
	<div id="overlay_t"></div>
	<div id="popup_layer">
		<!-- login_popupLayer_inner -->
		<form id="loginfrm">
			<div id="popup_layer_inner">
				<div id="layer_title">MEMBER LOGIN</div>
				<div id="layer_tab">
					<ul>
						<li><a href="#" class="member_tab">회원로그인</a></li>
						<li><a href="#" class="member_tab">비회원주문조회</a></li>
					</ul>
				</div>
				<div id="layer_login">
					<input type="text" placeholder="아이디" class="input_id" name="memId" id="memId"><br> <input type="password" placeholder="비밀번호" class="input_password" name="memPw" id="memPw">
				</div>
				<div id="layer_login_btn">
					<a href="javascript:" class="member_login" id="loginAction">LOGIN</a>
				</div>
				<div id="layer_login_save">
					&nbsp;<input type="checkbox" id="remember">&nbsp;<font>아이디 저장</font>
				</div>
				<div id="layer_login_option">
					<ul>
						<li><a href="#" class="member_menu">회원가입</a></li>
						<li><a href="#" class="member_menu">아이디찾기</a></li>
						<li><a href="#" class="member_menu">비밀번호찾기</a></li>
					</ul>
				</div>
			</div>
			<input type="hidden" value="<%=request.getServletPath()%>" id="url" name="url" />
		</form>
		<!-- login_popupLayer_inner_end -->
	</div>
</body>
</html>