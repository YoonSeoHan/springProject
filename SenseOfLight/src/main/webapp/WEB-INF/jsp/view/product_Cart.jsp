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
<link href="<c:url value="/css/view/cartForm.css"/>" rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script type="text/javascript">


$(document).ready(function () {
	
	CartList();
})
	

/* 체크박스 전체선택,해제 */
$(function () {
	$('#chkBox').click(function () {
		if($('#chkBox').prop("checked")){
			$("input[type=checkbox]").prop("checked",true); 
		} else{
			$("input[type=checkbox]").prop("checked",false); 
		}
	})
})

/* 개수 up,down */
    function Up(n) {
		var stat = $('#productCount'+n).val();
		var num = parseInt(stat, 10);
		num++;
		$('#productCount'+n).val(num);
	}
	function Down(n) {
		var stat = $('#productCount'+n).val();
		var num = parseInt(stat, 10);
		num--;
		if (num <= 0) {
			alert('더이상 줄일수 없습니다.');
			num = 1;
		}
		$('#productCount'+n).val(num);
	}
	
	function Order(num) {
		if(!$('.cart_content').attr('class')){
			alert('상품이 없습니다.');
			return false;
		}
		if(num == "all"){
			Order_Link('all');
		} else if(num == "select"){
			var list =[];
			 /* input 체크박스 : 체크된것들중 id가 selectBox로 시작하는  */
		    $("input:checkbox:checked[id^='selectBox']").each(function (index) {  
		        list[index] = $(this).val();
		    });
			if(list.length == 0){
				alert('선택한 상품이 없습니다.');
				return false;
			} else {
				Order_Link(list);
			}
		} else{
			var list =[num];
			Order_Link(num);
		} 
		
	}
	
	function Delete(num) {
		var CRUD = 'delete';
		
		/* 장바구니가 없을때 삭제시 처리로직 */
		if(!$('.cart_content').attr('class')){
			alert('상품이 없습니다.');
			return false;
		}
		/* 개별삭제 체크박스삭제 전체삭제 구분후 처리*/
		if(num == "all"){
			CartService(CRUD,'all');
		} else if(num == "select"){
			var list =[];
			 /* input 체크박스 : 체크된것들중 id가 selectBox로 시작하는  */
		    $("input:checkbox:checked[id^='selectBox']").each(function (index) {  
		        list[index] = $(this).val();
		    });
			if(list.length == 0){
				alert('선택한 상품이 없습니다.');
				return false;
			} else {
				CartService(CRUD, list);
			}
		} else{
			CartService(CRUD, num);
		} 
	}
	function Update(num) {
		var CRUD = 'update';
		var count = $('#productCount'+num).val();
		var list = [num , count];

		CartService(CRUD, list);
	}
	
	/* 함수 호출시 판단하는 루트 */
	/*
	1. delete,update 함수로 보냄 ()
	2. cartservice 호출
	3. 해당 함수에서 어떤삭제인지, 어떤업데이트인지 판단
	4. 리턴 
	*/
	function CartService(CRUD, params) {
		/* params는 문자열, 및 리스트를 받음 */
		var jsonList = { "CRUD" : CRUD, "params" : params};
		
		$.ajax({
			type: "post",
			url : "<c:url value='/CartService.ajax' />",
			data : JSON.stringify(jsonList),
			dataType : "text",
			async : true, // 비동기식 
			contentType: "application/json; charset=utf-8",
			success : function(data) {
				console.log(data);
				var obj = JSON.parse(data);
				var message = obj.message;
				alert(message);
				CartList();
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

	function CartList() {
		/* var productNum = $('#productNum').val();
		var productCount = $('#productCount').val();
		var TOKEN_KEY = $('#TOKEN_KEY').val();
		var list = []; */
		$.ajax({
			type: "post",
			url : "<c:url value='/CartList.ajax' />",
			/* data : "TOKEN_KEY="+TOKEN_KEY, */
			dataType : "json",
			async : true, // 비동기식 
			success : function(data) {
				var html = '';
				console.log(data);
				var length = data.length;
				
				 
				$.each(data , function (key, val) {	
					html += '<div class="cart_content">';
					html += '<ul><li style="position: relative;"><div style="width: 30px; position: relative; top: 61px;">';
					html +=	'<input type="checkbox" id="selectBox' + val.productNum + '" value="' + val.productNum + '">';
					html += '</div></li>';
					html += '<li><div style="width: 80px; height: 100%">';
					html += '<a href="javascript:" onclick="Link(' + val.productNum + ')"><img src="images/list/' + val.imgList + '.gif" style="width: 95%; height: 85%; margin-top: 10px;"></a>';
					html += '</div></li>';
					html += '<li><div style="width: 560px; text-align: left; height: 100%; line-height: initial; margin-top: 20px; color: #807f7f;">';
					html += '<a href="javascript:" onclick="Link(' + val.productNum + ')">';
					html += val.productName +'<br>';
					html += val.productAccount+'<br>';
					html += '<br> 옵션[' + val.productOption1 + '/';
					html += val.productOption2 + ']';
					html += '</a></div></li>';
					html += '<li><div style="width: 100px;">';	
					html += val.productPrice + '원';
					html += '</div></li>';
					html += '<li style="width: 80px; position: relative;">';
					html += '<div style="width: 80px;" class="cart_count">';
					html += '<div>';
					html += '<input type="text" value="' + val.productCount + '" id="productCount' + val.productNum + '">';
					html += '<div>';
					html += '<a href="javascript:Up(' + val.productNum + ')" ><img alt="haha"  src="images/common/btn_count_up.gif"></a>';
					html += '<a href="javascript:Down(' + val.productNum + ')"><img alt="haha"  src="images/common/btn_count_down.gif"></a>';
				
					html += '</div></div><div style="display: inline-block;"><a href="javascript:Update(' + val.productNum + ')">변경</a></div>';
					html += '</div></li>';
					
					html += '<li><div style="width: 100px; color: #807f7f;">';
					html += '<img alt="수정중입니다." style="width: 10px; height: 10px;" src="images/common/untitled.png">&nbsp;';
					html += val.productMileage + '원';
					html += '</div></li>';
					html += '<li><div style="width: 100px; color: #807f7f;">기본배송</div></li>';
					html += '<li><div style="width: 80px;">무료</div></li>';
					html += '<li><div style="width: 110px;">';
					html += val.productPriceTotal + '원';
					html += '</div></li>';
					html += '<li><div style="width: 104.5px;" class="cart_func">';
					html += '<div><a href="javascript:Order(' + val.productNum + ')">주문하기</a></div>';
					html += '<div><a href="javascript:Delete(' + val.productNum + ')">X&nbsp;삭제</a></div>';
					html += '</div></li>';
					html += '</ul></div>';
					html += '<input type="hidden" name="productNum' + val.productNum + '" value="' + val.productNum + '" disabled="">';
					html += '<input type="hidden" name="productCount' + val.productNum + '" value="' + val.productCount + '" disabled="">';
				});
				
				$('#Cart_ajax').html(html);
				
				if(data.length != 0){
					html = '';
					html += '<div>[기본배송]</div>';
					html += '<div>';
					html += '<pre>상품구매금액 ' + data[0].productAmount + '  + 배송비 0 (무료)  = 합계 : <font style="font-size: 16px; font-weight: bold;">' + data[0].productAmount + '</font>원   </pre>' ;
					html += '</div>';
				} else {
					html = '';
				}
				$('.cart_total').html(html);
			},error : function(request,status, error) {
				alert("code:"+ request.status+ "\n"
						+ "message:"+ request.responseText+ "\n"
						+ "error:"+ error);
			}
		})
	};
	


function Order_Link(params) {
	if(params == 'all'){
		$("input[name^=productNum]").attr("disabled", false);
		$("input[name^=productCount]").attr("disabled", false);
	} else {
		if(params.length > 1){
			for(var i in params){
				$('input[name=productNum'+params[i]+']').attr("disabled", false);
				$('input[name=productCount'+params[i]+']').attr("disabled", false);
			}
		} else{
			$('input[name^=productNum'+params+']').attr("disabled", false);
			$('input[name^=productCount'+params+']').attr("disabled", false);
		}
	} 
	var f = frm;
	f.method="post";
	f.action="product_Order.do";
	f.submit();
}




</script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
<form id="frm" name="frm">
		<div id="cart_wrap">
			<div class="cart_title">타이틀입니다.</div>
			<div class="cart_tab">
				<ul>
					<li style="position: relative; height: 50px;">
						<div style="width: 30px; position: relative; top: 20;">
							<input type="checkbox" id="chkBox">
						</div>
					</li>
					<li><div style="width: 80px;">이미지</div></li>
					<li><div style="width: 560px;">상품정보</div></li>
					<li><div style="width: 100px;">판매가</div></li>
					<li><div style="width: 80px;">수량</div></li>
					<li><div style="width: 100px;">적립금</div></li>
					<li><div style="width: 100px;">배송구분</div></li>
					<li><div style="width: 80px;">배송비</div></li>
					<li><div style="width: 110px;">합계</div></li>
					<li><div style="width: 104.5px;">선택</div></li>
				</ul>
			</div>
			<div id="Cart_ajax">
			</div>
			<div class="cart_total">
			</div>
			
			<div style="height: 40px; border-bottom: 0.5px solid #e5e5e5; float: left; display: inline-block;">
				<img style="width: 15px; height: 15px; float: left; margin: 5px; margin-top: 13.2px;" src='<c:url value="images/common/ico_information.gif"/>' /> <label style="float: left; line-height: 40px;">할인 적용 금액은 주문서작성의 결제예정금액에서 확인 가능합니다.</label>
			</div>
			<div class="cart_func2">
				<div>
					&nbsp;선택 상품을 &nbsp;<a href="javascript:Delete('select')">&nbsp;&nbsp;삭제하기 X&nbsp;&nbsp;</a>
				</div>
				<div>
					<a href="javascript:Delete('all')">&nbsp;&nbsp;장바구니 비우기&nbsp;&nbsp;</a>
				</div>
			</div>
			<div class="cart_order">
				<div>
					<a href="javascript:Order('all')">전체상품주문</a>
				</div>
				<div>
					<a href="javascript:Order('select')">선택상품주문</a>
				</div>
			</div>
		</div>
</form>
</body>
</html>