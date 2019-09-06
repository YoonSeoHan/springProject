
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import="java.io.*, java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="light.common.service.Token" %>
<html>
<head>
<%
	String styleCss = application.getRealPath("/css/style.css");
	File style = new File(styleCss);
	Date lastModifiedStyle = new Date(style.lastModified());
	SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link href="<c:url value="/css/view/detailForm.css"/>" rel="stylesheet" />
<!-- <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<!-- <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script> -->
<script type="text/javascript">
	$(document).ready(function() {
		/* DetailForm 처음접속시 */
		boardLink(1);
		if($('#list').val())
			fnMove(3);
		/* 개수 숫자 이외 입력방지 */
		/* $("#productQuantity").keyup(function() {
			$(this).val($(this).val().replace(/[^0-9]/g, "1"));
			if(quantityChk($(this).val())){
				$('#productQuantity').val(num);
			} else{
				alert('재고가 부족합니다.');	
			}
		}); */
		
		/* 개수 up,down */
		$(function() {
			$('#countUp').click(function(e) {
				e.preventDefault();
				var stat = $('#productQuantity').val();
				var num = parseInt(stat, 10);
				num++;
				if(quantityChk(num)){
					$('#productQuantity').val(num);
				} else{
					alert('재고가 부족합니다.');	
				}
			});
			$('#countDown').click(function(e) {
				e.preventDefault();
				var stat = $('#productQuantity').val();
				var num = parseInt(stat, 10);
				num--;
				if (num <= 0) {
					alert('더이상 줄일수 없습니다.');
					num = 1;
				}
				$('#productQuantity').val(num);
			});
		});
		
		function quantityChk(quantity) {
			var productCount = $('#productCount').val();
			if(quantity <= productCount){
				/* 재고보다 주문수량이 적거나 같을경우 */
				return true;
			} else{
				/* 재고보다 주문수량이 많을경우 */
				return false;
			}
		}
		
		
		/* 옵션 선택후 초기화*/
		$('#delete').click(function(event) {
			event.preventDefault();
			optReset();
		});
		
		/* 옵션2선택 방지 */
		$('#choice_option1').change(function() {
			var os1 = $('#choice_option1 option:selected').val();
			if (os1.length > 2) {
				$('#opt2').attr('disabled', false);
			}
			/* removeAttr */
		});
		
		/* 옵션1, 옵션2 선택후 show */
		$('#choice_option2').change(function() {
			var os1 = $('#choice_option1 option:selected').val();
			var os2 = $('#choice_option2 option:selected').val();
			var productNum = $('#productNum').val();
			if (os1.length > 2 && os2.length > 2) {
				$('.info_hide').show();
			} else {
				$('.info_hide').hide();
			}
		});
	});
	
	function order(productNum) {
		var test = stockChk(productNum);
		if(test == false){
			alert('해당 상품의 재고가 부족합니다');
			return false;
		}
		 if(optChk()){
			$('#productCount').val($('#productQuantity').val());
			var f = frm;
			f.method="post"
			f.action="product_Order.do"
			f.productNum.value = productNum;
			f.submit();
		} 
	}
	
	function cart(productNum) {
		var test = stockChk(productNum);
		if(test == false){
			alert('해당 상품의 재고가 부족합니다');
			return false;
		}
		alert(test);
		var judgment = confirm('장바구니로 이동하시겠습니까 ?'); 
		var productQuantity = $('#productQuantity').val();
		var TOKEN_KEY = $('#TOKEN_KEY').val();
		var url = "product_Cart.do?TOKEN_KEY="+TOKEN_KEY;
		var CRUD = "insert";
		var params = [productNum, productQuantity];
		var jsonList = { "CRUD" : CRUD, "params" : params};
		$.ajax({
			type : "post",
			url : "<c:url value='/CartService.ajax'/>",
			data: JSON.stringify(jsonList),
			dataType: "text",
			async: true,
			contentType: "application/json; charset=utf-8",
			success : function(data) {
				
				
				if(judgment){
					if(optChk())
						location.href=url;
				} else{
					return false;
				} 
			}, error: function (request, status, error) {
				alert("code:"+ request.status+ "\n"
						+ "message:"+ request.responseText+ "\n"
						+ "error:"+ error);
			}
		}) 
	} 
	
	function test() {
	    $('#dialog-confirm').dialog({
	      resizable: false,
	      height: "auto",
	      width: 400,
	      modal: true,
	      buttons: {
	        "Delete all items": function() {
	          $( this ).dialog( "close" );
	        },
	        Cancel: function() {
	          $( this ).dialog( "close" );
	        }
	      }
	    });
	  } 
	
	function optChk() {
		/* 옵션1, 옵션2를 선택한 후 구매하기 버튼 */
		if($('.info_hide').is(":visible")){
			return true;
		} else{
			alert("옵션을 선택해 주십시오.");
			return false;
		}
	}
	
	function stockChk(productNum) {
		var productCount = $('#productQuantity').val();
		var json ={"productNum" : productNum, "productCount" : productCount};
		var judge = false;
		$.ajax({
			type: "post",
			url: "<c:url value='/stockChk.ajax'/>",
			async: false,
			data: JSON.stringify(json),
			dataType: "json",
			contentType: "application/json; charset=utf-8",
			success: function (data) {
				if(data.stockChk == true){
					judge = true;
				} else{
					judge = false;
				}
			},
			error: function (request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
		return judge;
	}
	
	function optReset() {
		$("#choice_option1 option:eq(0)").prop("selected", true);
		$("#choice_option2 option:eq(0)").prop("selected", true);
		$('.info_hide').hide();
		$('#opt2').attr('disabled', true);
		$('#productQuantity').val("1");
	}
	
	function fnMove(seq) {
		var offset = $("#div" + seq).offset();
		$('html, body').animate({
			scrollTop : offset.top
		}, 400);
	};
	
	function pwdShow(num) {
		var update = 'update' + num;
		var check = 'check' + num;
		var pwd = 'pwd' + num;
		$('#'+update).hide();
		$('#'+check).show();
		$('#'+pwd).show();
	};
	
	function boardDetail(num) {
		var content = 'content' + num;
		var update = 'update' + num;
		var check = 'check' + num;
		var pwd = 'pwd' + num;
		if($('#' + content).css("display") == "none"){
			$('#' + content).fadeIn().show();
		} else {
			$('#' + content).hide();
			/* 수정 버튼을 눌렀을때 나타나는 비밀번호 입력창을 다시 숨김 */
			$('#'+update).show();
			$('#'+check).hide();
			$('#'+pwd).hide();
		}
	}
	
	function pwdChk(seq,num) {
		var pwd = $('#pwd'+seq).val();
		alert(pwd);
		var test = {
		        "boardSeq" : seq,
		        "pwd"    : pwd,
		}
		 $.ajax({
			type: "post",
			url : "<c:url value='/boardPwdChk.ajax' />",
			/* data : JSON.stringify({"pwd": pwd, "boardSeq": seq}),  */
			/* data : {"pwd" : pwd, "boardSeq": seq}, */
			data : JSON.stringify(test),
			dataType: "JSON",
			async: true,
			contentType: "application/json; charset=utf-8",
			success: function (data) {
				console.log(data);
				if(data == true){
					location.href = "board_UpdateForm.do?boardSeq="+seq+"&productNum="+num+"&action=update";
				} else{
					alert("비밀번호가 다릅니다.");
					return false;
				}
			},error : function(request,status, error) {
				alert("code:"+ request.status+ "\n"
						+ "message:"+ request.responseText+ "\n"
						+ "error:"+ error);
			}
		}); 
	}
	
	function boardLink(page) {
		var productNum = $('#productNum').val();
		$.ajax({
			type : "get",
			url : "<c:url value='/boardList.ajax' />",
			data : "productNum="+productNum+"&page="+page,
			dataType : "json",
			async : true, // 비동기식 
			success : function(data) {
				var html = '';
				console.log(data);
				/* 전체 레코드 수 - ( (현재 페이지 번호 - 1) * 한 페이지당 보여지는 레코드 수 + 현재 게시물 출력 순서 ) */
				$.each(data , function (key, val) {
					html += '<div class="Qna_test">';
					html += '<ul>';
					html += '<li><div style="width: 50px;">' + val.boardNum +'</div></li>';
					html += '<li><div style="width: 120px;">문의</div></li>';
					html += '<li><div style="width: 945px; text-align: left;">';
					html += '&nbsp;&nbsp;&nbsp;<img src="images/common/titlerock.png"/>&nbsp;';
					for(var i = 0; i < val.depth; i++){
						html += '<img style="width:24px; height=11px;" src="images/common/reple.png"/>&nbsp;';	
					}
					html += '<a href="javascript:" onclick="boardDetail('+ val.boardSeq + ')">' + val.boardSubject + '</a></div></li>'; 
					html += '<li><div style="width: 90px;">' + val.boardWriter + '</div></li>';
					html += '<li><div style="width: 100px;">' + val.boardDate + '</div></li>';
					html += '<li><div style="width: 41.5px;">' + val.boardCnt + '</div></li>';
		    	  	html += '</ul>';
					html += '</div>';
					html += '<div class="Qna_content" id="content' + val.boardSeq + '"><br>'+ val.boardContents + '<br><br>';
					if(val.boardOrgContents != null){
						html += '[Orignal Message]<br>' + val.boardOrgContents + '<br><br>';	
					}
					html += '<div id="Qna_update">';
					html += '<input type="password" id="pwd' + val.boardSeq + '" class="pwd_chk">&nbsp;'
					html += '<a href="javascript:" onclick="pwdChk(' + val.boardSeq + ',' + val.productNum + ')" id="check' + val.boardSeq + '" class="btn_check">확인</a>'
					html += '<a href="javascript:" onclick="pwdShow(' + val.boardSeq + ')" id="update' + val.boardSeq + '" class="btn_update">수정</a>'
					html += '<a href="board_RepleForm.do?boardSeq=' + val.boardSeq + '&productNum=' + val.productNum + '&action=reple" class="btn_reple">Reple</a>';
					html += '</div>';
					html += '</div>';
				});
				$('#Qna_ajax').html(html);
				
				html = '';

				html += '<ul>';
				if(data[0].prev == true){
					html += '<li>';
					html += '<a href="javascript:void(0);" onclick="boardLink(' + (data[0].StartPage - 1) + ')">이전&nbsp;</a>';
					html += '</li>';
				}
				for(var i = data[0].StartPage; i <= data[0].EndPage; i++){
					html += '<li>';
					html += '<a href="javascript:void(0);" onclick="boardLink(' + i + ')">' + i + '&nbsp;</a>'; 
					html += '</li>';
				}
				if(data[0].next == true && data[0].EndPage > 0) {
					html += '<li>';
					html += '<a href="javascript:void(0);" onclick="boardLink(' + (data[0].EndPage + 1) + ')">다음</a>';
					html += '</li>';
				}
				html += '</ul>';
			$('.Qna_pagenum').html(html);
			},error : function(request,status, error) {
				alert("code:"+ request.status+ "\n"
						+ "message:"+ request.responseText+ "\n"
						+ "error:"+ error);
			}
		});
	}
	
	
	
</script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<c:set var="productNum" value="${fileVo[0].productNum }" />
	<c:set var="productName" value="${fileVo[0].productName }" />
	<c:set var="productAccount" value="${fileVo[0].productAccount }" />
	<c:set var="productPrice" value="${fileVo[0].productPrice }" />
	<c:set var="productConsuPrice" value="${fileVo[0].productConsuPrice }" />
	<c:set var="productOption1" value="${fileVo[0].productOption1 }" />
	<c:set var="productOption2" value="${fileVo[0].productOption2 }" />
	<c:set var="productPriceTotal" value="${fileVo[0].productPriceTotal }" />
	<c:set var="productMileage" value="${fileVo[0].productMileage }" />
	<c:set var="productCount" value="${fileVo[0].productCount }" />
	<c:set var="imgDetail" value="${fileVo[0].imgDetail }" />
	<c:set var="imgAccount" value="${fileVo[0].imgAccount }" />
	<c:set var="imgInfo" value="${fileVo[0].imgInfo }" />
	<form id="frm">
	<input type="hidden" id="productNum" name="productNum" value="${productNum }">
	<input type="hidden" id="productCount" name="productCount" value="${productCount }">
	</form>
	<input type="hidden" id="list" value="${list }">
	<%
		if(request.getAttribute("TOKEN_KEY")==null){
			Token.set(request);
		}
	%>
	<!-- <div id="dialog-confirm" title="Empty the recycle bin?">
  	<p><span class="ui-icon ui-icon-alert" style="float:left; margin:12px 12px 20px 0;"></span>These items will be permanently deleted and cannot be recovered. Are you sure?</p>
	</div> -->
	<input type="hidden" name="TOKEN_KEY" id="TOKEN_KEY" value="<%=request.getAttribute("TOKEN_KEY")%>"/>
	<div id="div0"></div>
	<div id="detail_wrap">
		<div id="detail_top">
			<div id="top_img">
				<img src='<c:url value="images/detail/${imgDetail }.jpg"/>'>
			</div>
			<div id="top_info">
				<div id="top_information">
					<ul>
						<li><div class="info_name">
								<p>
									<c:out value="${productName }" />
								</p>
							</div></li>
						<li><div class="info_account">
								<p>
									<c:out value="${productAccount }" />
									<br> [디자인 출원중]
								</p>
							</div></li>
						<li style="height: 45px">
							<div class="info_consuprice1">
								<p>판매가</p>
							</div>
							<div class="info_consuprice2">
								<c:out value="${productPrice }" />
							</div>
						</li>
						<li style="height: 45px">
							<div class="info_price1">
								<p>소비자가</p>
							</div>
							<div class="info_price2">
								<p>
									<c:out value="${productConsuPrice }" />
								</p>
							</div>
						</li>
						<li style="height: 25px">
							<div style="width: 25%; float: left; height: 25px;">
								<p>국내산 LED 기판</p>
							</div>
							<div class="info_op1">
								<select id="choice_option1" name="choice_option1">
									<option value="" selected="selected">-[필수]옵션을 선택해 주세요-</option>
									<option value="<c:out value="${productOption1 }"/>">
										<c:out value="${productOption1 }" />
									</option>
								</select>
							</div>
						</li>
						<li style="height: 25px">
							<div style="width: 25%; float: left; height: 25px;">
								<p>기판 색상</p>
							</div>
							<div class="info_op2">
								<select id="choice_option2" name="choice_option2">
									<option value="" selected="selected">-[필수]옵션을 선택해 주세요-</option>
									<c:choose>
										    <c:when test="${!empty productOption2}">
        										<option value="<c:out value="${productOption2 }"/>" disabled="disabled" id="opt2">
        										${productOption2 }
        										</option>
    										</c:when>
    										<c:otherwise>
    											<option value="<c:out value="- 옵션없음"/>" disabled="disabled" id="opt2">
    											- 옵션없음
    											</option>
    										</c:otherwise>
									</c:choose>
									
									
								</select>
							</div>
						</li>
						<li>
							<div class="require">
								<img alt="수정중입니다." src='<c:url value="images/common/ico_information.gif"/>'>
								<p>위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</p>
								<br> <img alt="수정중입니다." src='<c:url value="images/common/ico_information.gif"/>'>
								<p>옵션 추가 금액은 마지막 옵션에 합산되어 표시됩니다.</p>
							</div>
						</li>
						<li>
							<div class="info_hide" style="display: none;">
								<div class="last_info1">
									<ul>
										<li class="info1_li1"><c:out value="${productName }" /></li>
										<li class="info1_li2"><c:out value="${productAccount }" /></li>
										<li class="info1_li3"><c:out value="${productOption1 }" />&nbsp;/&nbsp;<c:out value="${productOption2 }" /></li>
									</ul>
								</div>
								<div class="last_info2">
									<div>
										<input type="text" value="1" id="productQuantity" disabled="disabled" 
										style="background-color: white; outline: none; padding-left: 3px; border: 0.5px solid;">
										<div>
											<a href="#"><img alt="haha" id="countUp" src='<c:url value="images/common/btn_count_up.gif"/>'></a> 
											<a href="#"><img alt="haha" id="countDown" src='<c:url value="images/common/btn_count_down.gif"/>'></a>
										</div>
									</div>
								</div>
								<div class="last_info3">
									<a href="#"><img alt="수정중입니다." id="delete" src='<c:url value="images/common/btn_price_delete.gif"/>'></a>
								</div>
								<div class="last_info4">
									<p style="margin: 0; padding: 0; font-size: 13px">
										<c:out value="${productPriceTotal }" />
									</p>
									(<img alt="수정중입니다." src='<c:url value="images/common/untitled.png"/>'>
									<c:out value="${productMileage }" />
									원)

								</div>
							</div>
						</li>
						<li>
							<div style="width: 100%; height: 30px;"></div>
						</li>
						<li><div class="info_order">
								<a href="javascript:" class="buy_btn" onclick="order(${productNum})">구매하기</a>
							</div>
							<div class="info_basket">
								<a href="javascript:" class="bas_btn" onclick="cart(${productNum})">장바구니</a>
							</div></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="detail_content">
			<div class="space"></div>
			<div class="content_title">
				<div>
					<h2 style="display: inline-block;">WHY SENSE?</h2>
					&nbsp;&nbsp;<img alt="수정중입니다." src='<c:url value="images/common/line_title.png"/>'>&nbsp;&nbsp;&nbsp;왜 센스일까?
				</div>
			</div>
			<div class="common_img">
				<img alt="수정중입니다." src='<c:url value="images/common/detailimg_why.png"/>'>
			</div>
			<div class="space"></div>
			<div class="menu_bar" id="div1">
				<ul>
					<li style="border: 1.5px solid #CE723D; border-bottom: 0"><a href="javascript:void(0);" onclick="fnMove('1')">상세정보</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('2')">사이즈/설치방법</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('3')">상품QnA</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('4')">전구정보</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('5')">배송/반품/교환</a></li>
				</ul>
			</div>
			<div class="account_img">
				<img alt="수정중입니다." src='<c:url value="images/account/${imgAccount }.jpg"/>'>
			</div>
			<div class="menu_bar" id="div2">
				<ul>
					<li><a href="javascript:void(0);" onclick="fnMove('1')">상세정보</a></li>
					<li style="border: 1.5px solid #CE723D; border-bottom: 0"><a href="javascript:void(0);" onclick="fnMove('2')">사이즈/설치방법</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('3')">상품QnA</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('4')">전구정보</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('5')">배송/반품/교환</a></li>
				</ul>
			</div>
			<div class="space"></div>
			<div class="common_img">
				<img alt="수정중입니다." src='<c:url value="images/info/${imgInfo }.jpg"/>'>
			</div>
			<div class="menu_bar" id="div3">
				<ul>
					<li><a href="javascript:void(0);" onclick="fnMove('1')">상세정보</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('2')">사이즈/설치방법</a></li>
					<li style="border: 1.5px solid #CE723D; border-bottom: 0"><a href="javascript:void(0);" onclick="fnMove('3')">상품QnA</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('4')">전구정보</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('5')">배송/반품/교환</a></li>
				</ul>
			</div>
			<div class="space"></div>
			<div class="content_title">
				<div>
					<h2 style="display: inline-block;">Q & A</h2>
					&nbsp;&nbsp;<img alt="수정중입니다." src='<c:url value="images/common/line_title.png"/>'>&nbsp;&nbsp;&nbsp;상품 Q&A 입니다.
				</div>
			</div>
			<div id="Qna_board">
				<ul>
					<li><div style="width: 50px;">번호</div></li>
					<li><div style="width: 120px;">카테고리</div></li>
					<li><div style="width: 945px;">제목</div></li>
					<li><div style="width: 90px;">작성자</div></li>
					<li><div style="width: 100px;">작성일</div></li>
					<li><div style="width: 41.5px;">조회</div></li>
				</ul>
				<div id="Qna_ajax">
				<!-- ajax .html() -->
				</div>
				<div class="Qna_btn">
					<a href="board_WriteForm.do?action=write&productNum=${productNum }">WRITE</a>
				</div>
				<div class="Qna_pagenum">
				<!-- ajax .html() -->
				</div>
			</div>
			<div class="space"><%-- <c:out value="${pageMaker.startPage }"></c:out>
							<c:out value="${pageMaker.next }"/>
							<c:out value="${pageMaker.endPage }"/> --%></div>
			<div class="menu_bar" id="div4">
				<ul>
					<li><a href="javascript:void(0);" onclick="fnMove('1')">상세정보</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('2')">사이즈/설치방법</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('3')">상품QnA</a></li>
					<li style="border: 1.5px solid #CE723D; border-bottom: 0"><a href="javascript:void(0);" onclick="fnMove('4')">전구정보</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('5')">배송/반품/교환</a></li>
				</ul>
			</div>
			<div class="space"></div>
			<div class="common_img">
				<img alt="수정중입니다." src='<c:url value="images/common/bulb_guide.png"/>'>
			</div>
			<div class="space"></div>
			<div class="menu_bar" id="div5">
				<ul>
					<li><a href="javascript:void(0);" onclick="fnMove('1')">상세정보</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('2')">사이즈/설치방법</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('3')">상품QnA</a></li>
					<li><a href="javascript:void(0);" onclick="fnMove('4')">전구정보</a></li>
					<li style="border: 1.5px solid #CE723D; border-bottom: 0"><a href="javascript:void(0);" onclick="fnMove('5')">배송/반품/교환</a></li>
				</ul>
			</div>
			<div class="space"></div>
			<div class="content_title">
				<div>
					<h2 style="display: inline-block;">DELIVERY INFORMATION</h2>
					&nbsp;&nbsp;<img alt="수정중입니다." src='<c:url value="images/common/line_title.png"/>'>&nbsp;&nbsp;&nbsp;배송 / 교환 / 반품 / 취소 안내
				</div>
			</div>
			<div class="common_img">
				<img alt="수정중입니다." src='<c:url value="images/common/detailimg_delivery.png"/>'>
			</div>
		</div>
	</div>
	
</body>
</html>