<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link href="<c:url value="/css/view/orderForm.css"/>" rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
				memberList();

				$('#order_Bemail1').change(function() {
					var os = $('#order_Bemail1 option:selected').val();
					if (os == '직접입력') {
						$('#order_Bemail').val('');
					} else {
						$('#order_Bemail').val(os);
					}
				}); 
				/* product_Mileage 마일리지
				product_Amount 총결제 */
				function numberWithCommas(x) {
				    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				}
				$(document).on("change", "#mileageChange", function () {
					var Input_mileage = $('#mileageChange').val();
					var amount = $('#Amount').val();
					var amount = amount.replace(",","");
					var Serviceable_mileage = $('#Mileage').val();
					alert(Serviceable_mileage);
					
					 if(parseInt(Input_mileage) < 3000){
						alert('적립금의 최소 사용금액은 3000원 이상입니다.');
						return false;
					} else if(Input_mileage >= 3000 && Input_mileage <=Serviceable_mileage){
						$('.product_Mileage').text('- '+numberWithCommas(Input_mileage));
						amount = parseInt(amount) - parseInt(Input_mileage);
						$('.product_Amount').text('= '+numberWithCommas(parseInt(amount)));
					} else{
						alert('회원님의 사용 가능 마일리지는 ' + Serviceable_mileage + '원 입니다.');
						 return false;
					}
				});

				$('input[type=radio][name=payment]').on(
						'click',
						function() {
							var chkValue = $(
									'input[type=radio][name=payment]:checked')
									.val();
							var size = $('input[name=payment]').length;

							$('.payment' + chkValue).css('display',
									'inline-block');
							for (var i = 1; i <= size; i++) {
								if (i == chkValue) {
									continue;
								}
								$('.payment' + i).css('display', 'none');
							}
						})
						


				 $('input[type="checkbox"][class="box_chice"]').click(
						 function() {
							//클릭 이벤트 발생한 요소가 체크 상태인 경우
							if ($(this).prop('checked')) {
								//체크박스 그룹의 요소 전체를 체크 해제후 클릭한 요소 체크 상태지정
								$('input[type="checkbox"][class="box_chice"]')
										.prop('checked', false);
								$(this).prop('checked', true);
						} 
						
				}); 

			})

	function memberList() {
		$.ajax({
			type : "post",
			url : "<c:url value='/MemberList.ajax'/>",
			dataType : "json",
			async : true, // 비동기식 
			success : function(data) {
				var memPhone1 = data[0].memPhone1;
				var memBemail = data[0].memBemail;
				$('#order_Name').val(data[0].memName);
				$('#order_Paddr').val(data[0].memPaddr);
				$('#order_Daddr').val(data[0].memDaddr);
				$('#order_Raddr').val(data[0].memRaddr);
				$('#order_Phone1 option[value=' + memPhone1 + ']').attr(
						'selected', true);
				$('#order_Phone2').val(data[0].memPhone2);
				$('#order_Phone3').val(data[0].memPhone3);
				$('#order_Femail').val(data[0].memFemail);
				$('#order_Bemail').val(data[0].memBemail);
				var html = '';
				html += '<br> <input type="text" id="mileageChange"/>원 (총 사용가능 적립금 ' + data[0].memMileage + '원)<br> <br>';
				$('#Mileage').val(data[0].memMileage);
				$('#Mileage_ajax').append(html);
				
			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		})
	}
	
	function execPostCode(separator) {
	
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
				if (separator == '1') {
					$("#order_Paddr").val(data.zonecode);
					$("#order_Daddr").val(fullRoadAddr);
				} else {
					$("#recipient_Paddr").val(data.zonecode);
					$("#recipient_Daddr").val(fullRoadAddr);
				}

				/* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
				document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
				document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
			}
		}).open();
	}

	function equally() {
		var recipient_Phone1 = $('#order_Phone1').val();
		var recipient_Landline1 = $('#order_Landline1').val();
		$('#recipient_Name').val($('#order_Name').val());
		$('#recipient_Paddr').val($('#order_Paddr').val());
		$('#recipient_Daddr').val($('#order_Daddr').val());
		$('#recipient_Raddr').val($('#order_Raddr').val());
		$('#recipient_Phone1 option[value=' + recipient_Phone1 + ']')
				.attr('selected', true);
		$('#recipient_Phone2').val($('#order_Phone2').val());
		$('#recipient_Phone3').val($('#order_Phone3').val());
		$('#recipient_Landline1 option[value='+ recipient_Landline1 + ']').attr('selected', true);
		$('#recipient_Landline2').val($('#order_Landline2').val());
		$('#recipient_Landline3').val($('#order_Landline3').val());
	}

	function new_recipient() {
		$('#recipient_Name').val('');
		$('#recipient_Paddr').val('');
		$('#recipient_Daddr').val('');
		$('#recipient_Raddr').val('');
		$('#recipient_Phone1 option:eq(0)').attr('selected', true);
		$('#recipient_Phone2').val('');
		$('#recipient_Phone3').val('');
	}
	
	function empty() {
		
		if($('#order_Name').val().replace(/\s/g,"").length == 0){
			alert('주문정보의 이름을 입력해주십시오.');
			return false;
		} else if($('#order_Paddr').val().replace(/\s/g,"").length == 0){
			alert('주문정보의 우편번호를 입력해주십시오.');
			return false;
		} else if($('#order_Daddr').val().replace(/\s/g,"").length == 0){
			alert('주문정보의 기본주소를 입력해주십시오.');
			return false;
		} else if($('#order_Raddr').val().replace(/\s/g,"").length == 0){
			alert('주문정보의 나머지주소를 입력해주십시오.');
			return false;
		} else if($('#order_Landline2').val().replace(/\s/g,"").length == 0
				|| $('#order_Landline3').val().replace(/\s/g,"").length == 0){
			alert('주문정보의 전화번호를 입력해주십시오.');
			return false;
		} else if($('#order_Phone2').val().replace(/\s/g,"").length == 0 
				|| $('#order_Phone3').val().replace(/\s/g,"").length == 0){
			alert('주문정보의 휴대폰번호를 입력해주십시오.');
			return false;
		} else if($('#order_Femail').val().replace(/\s/g,"").length == 0
				|| $('#order_Bemail').val().replace(/\s/g,"").length == 0){
			alert('주문정보의 이메일을 입력해주십시오.');
			return false;
		} else if($('#recipient_Name').val().replace(/\s/g,"").length == 0){
			alert('배송정보의 이름을 입력해주십시오.');
			return false;
		} else if($('#recipient_Paddr').val().replace(/\s/g,"").length == 0){
			alert('배송정보의 우편번호를 입력해주십시오.');
			return false;
		} else if($('#recipient_Daddr').val().replace(/\s/g,"").length == 0){
			alert('배송정보의 기본주소를 입력해주십시오.');
			return false;
		} else if($('#recipient_Raddr').val().replace(/\s/g,"").length == 0){
			alert('배송정보의 나머지주소를 입력해주십시오.');
			return false;
		} else if($('#recipient_Landline2').val().replace(/\s/g,"").length == 0
				|| $('#recipient_Landline3').val().replace(/\s/g,"").length == 0){
			alert('배송정보의 전화번호를 입력해주십시오.');
			return false;
		}  else if($('#recipient_Phone2').val().replace(/\s/g,"").length == 0
				|| $('#recipient_Phone3').val().replace(/\s/g,"").length == 0){
			alert('배송정보의 휴대폰번호를 입력해주십시오.');
			return false;
		}
		
		
		 var jsonArray = $('.orderform').serializeArray();
		 console.log(jsonArray);
		 /* formData.push({name:'paramName', value:'paramValue'}); */
		 $.ajax({
			 type: "post",
			 url: "<c:url value='/orderAction.ajax'/>",
			 data: JSON.stringify(jsonArray),
			 dataType: "json",
			 async : true,
			 contentType: "application/json; charset=utf-8",
			 success : function(data) {
					alert('성공');
			},error : function(request,status, error) {
					alert("code:"+ request.status+ "\n"
							+ "message:"+ request.responseText+ "\n"
							+ "error:"+ error);

			}
		 })
		
	}
	function Link(num) {
		location.href ="product_Detail.do?productNum=" + num;
	}
</script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
<input type="hidden" id="Amount" value="${orderVoList.orderlist[0].productAmount }">
<input type="hidden" id="Mileage" value="${orderVoList.orderlist[0].productAmount }">

	<div id="order_wrap">
		<div class="order_title">ORDER FORM</div>
		<div class="order_tab">
			<ul>
				<li><div>이미지</div></li>
				<li><div>상품정보</div></li>
				<li><div>판매가</div></li>
				<li><div>수량</div></li>
				<li><div>적립금</div></li>
				<li><div>배송구분</div></li>
				<li><div>배송비</div></li>
				<li><div>합계</div></li>
			</ul>
		</div>
		<form action="OrderAction.ajax" class="orderForm">
		<div id="order_ajax">
			<c:forEach items="${orderVoList.orderlist }" varStatus="i">
			<input type="hidden" name="productNum" value="${orderVoList.orderlist[i.index].productNum }">
			<input type="hidden" name="productCount" value="${orderVoList.orderlist[i.index].productCount }">
			<input type="hidden" name="productPriceTotal" value="${orderVoList.orderlist[i.index].productPriceTotal }">
				<div class="order_products">
					<ul>
						<li><div><a href="javascript:" onclick="Link(${orderVoList.orderlist[i.index].productNum })">
								<img alt="수정중입니다." src="<c:url value="images/list/${orderVoList.orderlist[i.index].imgList }.gif"/>">
								</a>
							</div></li>
						<li>
							<div><a href="javascript:" onclick="Link(${orderVoList.orderlist[i.index].productNum })">
								${orderVoList.orderlist[i.index].productName }<br> ${orderVoList.orderlist[i.index].productAccount }<br> <br> 옵션[${orderVoList.orderlist[i.index].productOption1 } / ${orderVoList.orderlist[i.index].productOption2}]
								</a>
							</div>
						</li>
						<li><div>${orderVoList.orderlist[i.index].productPrice }원</div></li>
						<li><div>${orderVoList.orderlist[i.index].productCount }</div></li>
						<li><div>
								<img alt="수정중입니다." src="images/common/untitled.png" />&nbsp;${orderVoList.orderlist[i.index].productMileage }원
							</div></li>
						<li><div>기본배송</div></li>
						<li><div>[무료]</div></li>
						<li><div>${orderVoList.orderlist[i.index].productPriceTotal }원</div></li>
					</ul>
				</div>
			</c:forEach>
		</div>
		</form>
		<div class="order_total">
			<div>[기본배송]</div>
			<div>
				<pre>상품구매금액 ${orderVoList.orderlist[0].productAmount }  + 배송비 0 (무료)  = 합계 : <font> ${orderVoList.orderlist[0].productAmount }</font>원   </pre>
			</div>
		</div>
		<div>
			<img src='<c:url value="images/common/ico_information.gif"/>' /> <label>상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</label>
		</div>
		<div style="width: 100%; height: 150px; display: inline-block;"></div>
		<form action="OrderAction.ajax" class="orderForm">
		<div id="buyer_order_info">
			<div class="buyer_title">
				&nbsp;&nbsp; <label style="float: left;">주문 정보</label> <label style="float: right;">필수입력사항</label> <img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
			</div>
			<div id="buyer_order_form">
			
				<ul>
					<li>
						<div>
							주문하시는분&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<input type="text" id="order_Name" name="orderName">
						</div>
					</li>
					<li>
						<div>
							주소&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<ul>
								<li><input type="text" id="order_Paddr" readonly="readonly" name="orderPaddr">
								<input type="button" value="우편번호" id="postbtn" onclick="execPostCode(1);"></li>
								<li><input type="text" id="order_Daddr" readonly="readonly" name="orderDaddr"> 
								<label> 기본 주소</label></li>
								<li><input type="text" id="order_Raddr" name="orderRaddr"> <label> 나머지 주소</label></li>
							</ul>
						</div>
					</li>
					<li>
						<div>
							일반전화&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<select id="order_Landline1" name="orderLandline">
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
							</select> &nbsp; <label>-</label> &nbsp; <input type="text" id="order_Landline2" name="orderLandline"> &nbsp; 
							<label>-</label> &nbsp; <input type="text" id="order_Landline3" name="orderLandline">
						</div>
					</li>
					<li>
						<div>
							휴대전화&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<select id="order_Phone1" name="orderPhone">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> &nbsp; 
							<label>-</label> &nbsp; <input type="text" id="order_Phone2" name="orderPhone"> &nbsp; 
							<label>-</label> &nbsp; <input type="text" id="order_Phone3" name="orderPhone">
						</div>
					</li>
					<li>
						<div>
							이메일&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<input type="text" id="order_Femail" name="orderEmail"> 
							<label>@</label> <input type="text" id="order_Bemail" name="orderEmail"> <select id="order_Bemail1">
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
					</li>
				</ul>
				
			</div>
		</div>
		</form>
		<div style="width: 1350px; height: 70px; display: inline-block;"></div>
		<form action="OrderAction.ajax" class="orderForm">
		<div id="buyer_addr_info">
			<div class="buyer_title">
				&nbsp;&nbsp;<label style="float: left;">배송 정보</label> <label style="float: right;">필수입력사항</label> <img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
			</div>
			<div id="buyer_addr_form">
			
				<ul>
					<li>
						<div>배송지 선택</div>
						<div>
							<input type="checkbox" onclick="equally()" class="box_chice"><label>주문자 정보와 동일</label>
							<input type="checkbox" onclick="new_recipient()" class="box_chice" checked="checked"><label>새로운 배송지</label>
						</div>
					</li>
					<li>
						<div>
							받으시는분&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<input type="text" id="recipient_Name" name="recipientName">
						</div>
					</li>
					<li>
						<div>
							주소&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<ul>
								<li><input type="text" id="recipient_Paddr" readonly="readonly" name="recipientPaddr">
								<input type="button" value="우편번호" id="postbtn" onclick="execPostCode(2);"></li>
								<li><input type="text" id="recipient_Daddr" readonly="readonly" name="recipientDaddr">
								<label> 기본 주소</label></li>
								<li><input type="text" id="recipient_Raddr" name="recipientRaddr"><label> 나머지 주소</label></li>
							</ul>
						</div>
					</li>
					<li>
					
						<div>
							일반전화&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<select id="recipient_Landline1" name="recipientLandline">
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
							</select> &nbsp; 
							<label>-</label> &nbsp; <input type="text" id="recipient_Landline2" name="recipientLandline"> &nbsp; 
							<label>-</label> &nbsp; <input type="text" id="recipient_Landline3" name="recipientLandline">
						</div>
					</li>
					<li>
						<div>
							휴대전화&nbsp;<img alt="수정중입니다." src="<c:url value="/images/common/ico_required.gif"/>">
						</div>
						<div>
							<select id="recipient_Phone1" name="recipientPhone">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> &nbsp; <label>-</label> &nbsp; <input type="text" id="recipient_Phone2" name="recipientPhone"> &nbsp; 
							<label>-</label> &nbsp; <input type="text" id="recipient_Phone3" name="recipientPhone">
						</div>
					</li>
					<li style="height: 70px;">
						<div>배송메시지</div>
						<div>
							<textarea rows="50" cols="3" name="recipientMessage"></textarea>
						</div>
					</li>
				</ul>
			</div>
		</div>
		</form>
		<div style="width: 1350px; height: 100px;"></div>
		<div id="pay_amount">
			<div class="title">
				&nbsp;&nbsp;<label style="float: left;">결제 예정 금액</label>
			</div>
			<div id="pay_amount_form">
				<ul>
					<li>
						<div>총 주문 금액</div>
						<div>총 할인 + 부가결제 금액</div>
						<div>총 결제예정 금액</div>
					</li>
					<li>
						<div>${orderVoList.orderlist[0].productAmount }</div>
						<div class="product_Mileage">- 0</div>
						<div class="product_Amount">= ${orderVoList.orderlist[0].productAmount }</div>
					</li>
					<li>
						<div>총 할인 금액</div>
						<div>&nbsp;&nbsp;0원</div>
					</li>
					<li>
						<div>총 부가결제 금액</div>
						<div>&nbsp;&nbsp;0원</div>
					</li>
					<li>
						<div>적립금</div>
						<div>
							<ul>
								<li id="Mileage_ajax"></li>
								<li>- 적립금은 50,000원 이상 구매 시, 사용가능합니다.</li>
								<li>- 최대 사용금액은 제한이 없습니다.</li>
								<li>- 1회 구매시 적립금 최대 사용금액은 3,000입니다.</li>
								<li>- 적립금으로만 결제할 경우, 결제금액이 0으로 보여지는 것은 정상이며 [결제하기] 버튼을 누르면 주문이 완료됩니다.</li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<div style="width: 1350px; height: 100px;"></div>
		<div id="payment_method">
			<div class="title">
				&nbsp;&nbsp;<label style="float: left;">결제 수단</label>
			</div>
			<div id="payment_method_form">
				<div>
					<ul>
						<li><input type="radio" name="payment" value="1" checked="checked">카드 결제</li>
						<li><input type="radio" name="payment" value="2">에스크로(실시간 계좌이체)</li>
						<li><input type="radio" name="payment" value="3">무통장 입금</li>
						<li><input type="radio" name="payment" value="4">케이페이(간편 결제)</li>
						<li><input type="radio" name="payment" value="5">PAYCO(간편 결제)</li>
						<li><input type="radio" name="payment" value="6">카카오 페이(간편 결제)</li>
					</ul>
				</div>
				<div id="credit_card" style="display: inline-block;" class="payment1">
					<div>
						<img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</label><br> <img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</label>
					</div>
				</div>
				<div id="realtime_transfer" style="display: none;" class="payment2">
					<div>
						<div>
							<div>입금자명</div>
							<div>
								&nbsp;&nbsp;<input type="text">
							</div>
						</div>
					</div>
					<div style="width: 1350px; height: 20px;"></div>
					<div>
						<div>
							<div>현금영수증 신청</div>
							<div>
								<input type="radio" name="CASH_RECEIPT">현금영수증 신청 <input type="radio" checked="checked" name="CASH_RECEIPT">현금영수증 신청안함
							</div>
						</div>
						<div>
							<div>세금계산서 신청</div>
							<div>
								<input type="radio" name="TAX_INVOICE">세금계산서 신청 <input type="radio" checked="checked" name="TAX_INVOICE">세금계산서 신청안함
							</div>
						</div>
					</div>
				</div>
				<div id="direct_deposit" style="display: none;" class="payment3">
					<div>
						<div>
							<div>입금자명</div>
							<div>
								&nbsp;&nbsp;<input type="text">
							</div>
						</div>
						<div>
							<div>계좌번호</div>
							<div>
								&nbsp;&nbsp;<select>
									<option>661102-04-078026국민은행</option>
									<option>661102-04-078026국민은행</option>
								</select>
							</div>
						</div>
					</div>
					<div style="width: 1350px; height: 20px;"></div>
					<div>
						<div>
							<div>현금영수증 신청</div>
							<div>
								<input type="radio" name="CASH_RECEIPT">현금영수증 신청 <input type="radio" checked="checked" name="CASH_RECEIPT">현금영수증 신청안함
							</div>
						</div>
						<div>
							<div>세금계산서 신청</div>
							<div>
								<input type="radio" name="TAX_INVOICE">세금계산서 신청 <input type="radio" checked="checked" name="TAX_INVOICE">세금계산서 신청안함
							</div>
						</div>
					</div>
				</div>
				<div id="k_pay" style="display: none;" class="payment4">
					<div>
						<img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>휴대폰에 설치된 케이페이 앱에서 비밀번호 입력만으로 빠르고 안전하게 결제가 가능한 서비스 입니다.</label><br> <img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>안드로이드의 경우 구글 플레이, 아이폰의 경우 앱 스토어에서 케이페이 앱을 설치 한 후, 최초 1회 카드정보를 등록하셔야 사용 가능합니다.</label>
					</div>
				</div>

				<div id="payco" style="display: none;" class="payment5">
					<div>
						<img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>페이코 결제 팝업창에서 비밀번호 입력만으로 빠르고 안전하게 결제가 가능한 서비스 입니다.</label><br> <img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>www.payco.com 에 회원가입 후, 최초 1회 카드 및 계좌 정보를 등록하셔야 사용 가능합니다.</label>
					</div>
				</div>

				<div id="cacao_pay" style="display: none;" class="payment6">
					<div>
						<img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>휴대폰에 설치된 카카오톡 앱에서 비밀번호 입력만으로 빠르고 안전하게 결제가 가능한 서비스 입니다.</label><br> <img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>안드로이드의 경우 구글 플레이, 아이폰의 경우 앱 스토어에서 카카오톡 앱을 설치 한 후, 최초 1회 카드 및 계좌 정보를 등록하셔야 사용 가능합니다.</label><br> <img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>인터넷 익스플로러의 경우 8 이상에서만 결제 가능합니다.</label><br> <img alt="수정중입니다." src="<c:url value="/images/common/ico_information.gif"/>"> <label>BC카드 중 신한, 하나, 국민카드는 결제가 불가능합니다.</label>
					</div>
				</div>
				<div>
					<div>
						<ul>
							<li>에스크로(실시간 계좌이체) 최종결제 금액</li>
							<li class="product_Amount">${orderVoList.orderlist[0].productAmount }</li>
							<li><a href="javascript:empty()">결제하기</a></li>
						</ul>
					</div>
					<div>
						<div>총 적립 예정 금액</div>
						<div>${orderVoList.orderlist[0].productMileageAmount }</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>