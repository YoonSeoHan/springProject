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
<link href="<c:url value="/css/view/modifyForm.css"/>" rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#modify_memBemail2').change(function() {
			var os = $('#modify_memBemail2 option:selected').val();
			if (os == '직접입력') {
				$('#modify_memBemail1').val('');
			} else {
				$('#modify_memBemail1').val(os);
			}
		});

	})
</script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<div id="modify_wrap">
		<div id="modify_tabbox">
			<div>
				<div>
					<a href="myPage.do">마이페이지</a>
				</div>
				<div>
					<a href="#">장바구니</a>
				</div>
				<div>
					<a href="order_Status.do">주문/배송 조회</a>
				</div>
				<div style="background-color: #c28562;">
					<a href="member_Modify.do" style="color: white;">회원정보 수정</a>
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
		<div id="modify_message">
			<div>
				<img src="<c:url value='/images/common/img_member_default.gif'/>" />
			</div>
			<div>저희 쇼핑몰을 이용해 주셔서 감사합니다. 한윤서 님은 [일반회원] 회원이십니다.</div>
		</div>
		<div style="width: 1350px; height: 25px; display: inline-block;"></div>
		<div id="modify_form">
			<div id="modify_title">
				<h3>기본정보</h3>
				<p>
					<img src="<c:url value='/images/common/ico_required.gif'/>">필수입력사항
				</p>
			</div>
			<div id="modify_table">
				<div>
					<div>
						아이디&nbsp;<img src="<c:url value='/images/common/ico_required.gif'/>">
					</div>
					<div>
						<input type="text">(영문소문자/숫자, 4~16자)
					</div>
				</div>
				<div>
					<div>
						비밀번호&nbsp;<img src="<c:url value='/images/common/ico_required.gif'/>">
					</div>
					<div>
						<input type="password" readonly="readonly">(영문 대소문자/숫자 4자~16자)
					</div>
				</div>
				<div>
					<div>
						비밀번호 확인&nbsp;<img src="<c:url value='/images/common/ico_required.gif'/>">
					</div>
					<div>
						<input type="password" readonly="readonly">
					</div>
				</div>
				<div>
					<div>
						이름&nbsp;<img src="<c:url value='/images/common/ico_required.gif'/>">
					</div>
					<div>
						<input type="text">
					</div>
				</div>
				<div>
					<div>
						<p>
							주소&nbsp;<img style="width: 5px; height: 5px;" src="<c:url value='/images/common/ico_required.gif'/>">
						</p>
					</div>
					<div>
						<input type="text"><input type="button" value="우편번호" id="postbtn" onclick="execPostCode(1);"><br> <input type="text">&nbsp;기본주소<br> <input type="text">&nbsp;나머지주소
					</div>
				</div>
				<div>
					<div>일반전화</div>
					<div>
						<select id="order_memLandline1">
							<option value="02">02</option>
							<option value="031">031</option>
							<option value="032">032</option>
							<option value="033">033</option>
							<option value="041">041</option>
							<option value="042">042</option>
							<option value="043">043</option>
							<option value="044">044</option>
							<option value="051">051</option>
							<option value="052">052</option>
							<option value="053">053</option>
							<option value="054">054</option>
							<option value="055">055</option>
							<option value="061">061</option>
							<option value="062">062</option>
							<option value="063">063</option>
							<option value="064">064</option>
							<option value="0502">0502</option>
							<option value="0503">0503</option>
							<option value="0504">0504</option>
							<option value="0505">0505</option>
							<option value="0506">0506</option>
							<option value="0507">0507</option>
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select> <label>-</label> <input type="text" id="order_memLandline2"> <label>-</label> <input type="text" id="order_memLandline3">
					</div>
				</div>
				<div>
					<div>
						휴대전화&nbsp;<img src="<c:url value='/images/common/ico_required.gif'/>">
					</div>
					<div>
						<select id="order_memPhone1">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select> <label>-</label> <input type="text" id="order_memPhone2"> <label>-</label> <input type="text" id="order_memPhone3">
					</div>
				</div>
				<div>
					<div>
						이메일&nbsp;<img src="<c:url value='/images/common/ico_required.gif'/>">
					</div>
					<div>
						<input type="text" id="modify_memFemail"> <label>@</label><input type="text" id="modify_memBemail1"> <select id="modify_memBemail2">
							<option value="직접입력">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="nate.com">nate.com</option>
							<option value="hotmail.com">hotmail.com</option>
							<option value="yahoo.com">yahoo.com</option>
							<option value="empas.com">empas.com</option>
							<option value="korea.com">korea.com</option>
							<option value="dreamwiz.com">dreamwiz.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div>
			<a href="#">회원정보 수정</a>
			<a href="#">취소</a>
			<a href="#">회원 탈퇴</a>
		</div>	
	</div>
</body>
</html>