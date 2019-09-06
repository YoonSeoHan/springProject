<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	/* 주소 선택 */
 	 $('#choice_mail').change(function () {
 		 var os = $('#choice_mail option:selected').val();
 		 if(os == '직접입력'){
 			$('#memBemail').val('');
 		 } else{
 			$('#memBemail').val(os);
 		 }
 	 });
	
	$('#frm').on("submit", function (e) {
		/* e.preventDefault(); */
		/* id 정규식 */
		
		var regExpId = new RegExp("^[a-zA-Z][a-zA-Z0-9]{6,16}$","g");
		var regExpPw = new RegExp("^[0-9a-z]+$");
        var matchId = regExpId.exec($('#join_memId').val());
        var matchPw = regExpPw.exec($('#join_memPw').val());
		if($('#join_memId').val() == ""){
			alert("아이디를 입력하세요");
			$('#join_memId').focus();
			return false;
		}
		 if (matchId == null || $('#join_memId').val() <  6 || $('#join_memId').val() > 16) { 
			 alert("아이디 6~16글자, 첫 글자는 영어, 대,소문자와 숫자만 사용해 주세요.");
             $('#join_memId').focus();
             return false; 
 		}
		if($('#join_memPw').val() == ""){
			alert("비밀번호를 입력하세요");
			$('#join_memPw').focus();
			return false;
		}
		if($('#memPwchk').val() == ""){
			alert("비밀번호를 입력하세요");
			$('#memPwchk').focus();
			return false;
		}
		if($('#join_memPw').val() != $('#memPwchk').val()){
			alert("비밀번호가 일치하지 않습니다.");
			$('#memPwchk').focus();
			return false;
		}
		 if (matchPw == null || $('#join_memPw').val() <  6 || $('#join_memPw').val() > 20) { 
			 alert("비밀번호는 6~20글자, 대,소문자와 숫자만 사용해 주세요.");
             $('#join_memPw').focus();
             return false; 
 		}
		if($('#memName').val() == ""){
			alert("이름을 입력하세요");
			$('#memName').focus();
			return false;
		}
		if($('#memPaddr').val() == ""){
			alert("주소를 입력하세요");
			$('#memPaddr').focus();
			return false;
		}
		if($('#memDaddr').val() == ""){
			alert("주소를 입력하세요");
			$('#memDaddr').focus();
			return false;
		}
		if($('#memRaddr').val() == ""){
			alert("나머지주소 입력하세요");
			$('#memRaddr').focus();
			return false;
		}
		if($('#memPhone2').val() == ""){
			alert("휴대전화를 입력하세요");
			$('#memPhone2').focus();
			return false;
		}
		if($('#memPhone3').val() == ""){
			alert("휴대전화를 입력하세요");
			$('#memPhone3').focus();
			return false;
		}
		if($('#memFemail').val() == ""){
			alert("이메일을 입력하세요");
			$('#memFemail').focus();
			return false;
		}
		if($('#memBemail').val() == ""){
			alert("이메일을 입력하세요");
			$('#memBemail').focus();
			return false;
		}
		return true;
	})
});


	function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				/* console.log(data.zonecode);
				console.log(fullRoadAddr);
				document.getElementById('postNum').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('detailAddr').value = fullRoadAddr; */

				$("#memPaddr").val(data.zonecode);
				$("#memDaddr").val(fullRoadAddr);

				/* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
				document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
			}
		}).open();
	}
</script>
<link href="<c:url value="/css/view/join.css?var=1"/>" rel="stylesheet" />
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<!-- id="frm_join" action="actionjoin.do" modelAttribute="join" method="post" cssClass="join_wrap" -->
	<div id="wrap">
		<div class="frm_title">
			<label>JOIN US - 회원가입</label>
		</div>
		<form:form modelAttribute="joinVoList" action="joinAction.do" method="post" id="frm">
		<c:forEach items="${joinVoList.memberlist }" varStatus="i">
			<div class="frm_row">
				<div class="frm_list">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;아이디 <font>*</font></label>
				</div>
				<div class="frm_input">
					<form:input path="memberlist[${i.index}].join_memId" id="join_memId" />
					&nbsp;<label class="wLabel">(영문소문자/숫자, 4~16자)</label>
				</div>
			</div>
			<div class="frm_row">
				<div class="frm_list">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 <font>*</font></label>
				</div>
				<div class="frm_input">
					<form:input path="memberlist[${i.index}].join_memPw" id="join_memPw"/>
					&nbsp;<label class="wLabel">(영문 대소문자/숫자 4자~16자)</label>
				</div>
			</div>
			<div class="frm_row">
				<div class="frm_list">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;비밀번호 확인 <font>*</font></label>
				</div>
				<div class="frm_input">
					<form:input path="memberlist[${i.index}].memPwchk" id="memPwchk"/>
				</div>
			</div>
			<div class="frm_row">
				<div class="frm_list">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;이름 <font>*</font></label>
				</div>
				<div class="frm_input">
					<form:input path="memberlist[${i.index}].memName" id="memName"/>
				</div>
			</div>
			<div id="frm_row_addr">
				<div id="frm_list_addr">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;주소 <font>*</font></label>
				</div>
				<div id="frm_input_addr">
					<ul>
						<li><form:input path="memberlist[${i.index}].memPaddr" readonly="true" id="memPaddr" name="memPaddr" /> 
						<input type="button" value="우편번호" id="postbtn" onclick="execPostCode();"></li>
						<li><form:input path="memberlist[${i.index}].memDaddr" readonly="true" id="memDaddr" name="memDaddr" /></li>
						<li><form:input path="memberlist[${i.index}].memRaddr" id="memRaddr"/></li>
					</ul>
				</div>
			</div>
			<div class="frm_row">
				<div class="frm_list">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;휴대전화 <font>*</font></label>
				</div>
				<div id="frm_input_phone">
					<ul>
						<li><form:select path="memberlist[${i.index}].memPhone1" id="memPhone1">
								<form:option value="010">010</form:option>
								<form:option value="011">011</form:option>
								<form:option value="016">016</form:option>
								<form:option value="017">017</form:option>
								<form:option value="018">018</form:option>
								<form:option value="019">019</form:option>
							</form:select></li>
						<li>-</li>
						<li><form:input path="memberlist[${i.index}].memPhone2" id="memPhone2"/></li>
						<li>-</li>
						<li><form:input path="memberlist[${i.index}].memPhone3" id="memPhone3"/></li>
					</ul>
				</div>
			</div>
			<div class="frm_row">
				<div class="frm_list">
					<label>&nbsp;&nbsp;&nbsp;&nbsp;이메일 <font>*</font></label>
				</div>
				<div id="frm_input_email">
					<ul>
					
						<li><form:input path="memberlist[${i.index}].memFemail" id="memFemail"/></li>
						<li>@</li>
						<li><form:input path="memberlist[${i.index}].memBemail" id="memBemail" /></li>
						<li><select id="choice_mail">
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
						</li>
					</ul>
				</div>
			</div>
			<div class="frm_submit">
				<input type="submit" value="회원 가입" />
			</div>
			</c:forEach>
		</form:form>
	</div>
</body>
</html>