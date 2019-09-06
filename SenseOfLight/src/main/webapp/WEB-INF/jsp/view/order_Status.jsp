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
<link href="<c:url value="/css/view/orderStatusForm.css"/>" rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>   
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />


<script type="text/javascript">
	$(document).ready(function() {
		datepicker();
		
		$("ul.tabs li").click(function () {
			$("ul.tabs li").removeClass("select").css("color", "black");
			$(this).addClass("select").css("color", "white");
			var activeTab = $(this).attr("rel");
	      $("#" + activeTab).fadeIn();
		});
		
		$("ul.picker li").click(function () {
			$("ul.picker li").removeClass("select").css("color", "black");
			$(this).addClass("select").css("color", "white");
			
			var fromDate = setDate($(this).val());
			
			$('#fromDate').val(fromDate);
			/* $("#fromDate").val($.datepicker.formatDate($.datepicker.ATOM, fromDate)); */
		});
		
		var filenameArr = new Array();
		var filesrcArr = new Array();
		
	});
	
	function base_css() {
		$('.filebox_preview').parent().css("height", "10px");
		$('.layer_inner').css("height", "280px");
		$('.upload-name').val("파일선택");
	}
	
	function delete(orderDtlnum) {
		$.ajax({
			type: "post",
			url:"<c:url value='/OrderBuyDelete.ajax'/>",
			async: false,
			data: orderDtlnum,
			success : function(data) {
				alert('성공');
			},error : function(request,status, error) {
				alert("code:"+ request.status+ "\n"
						+ "message:"+ request.responseText+ "\n"
						+ "error:"+ error);
			}
		})
	}
	/* 호출 중복되는 문제 있음. 켰다 껐다 켰다 껐다하면 두번째 껐을때 두번호출 */
	function exchange_Layer(orderDtlnum) {
		var filenameArr = new Array();
		var filesrcArr = new Array();
		
		$('#exchange_layer, #overlay_o').show();
		$('#exchange_layer').css("top", Math.max(0, $(window).scrollTop() + 120)+ "px");
		
		$('#overlay_o, .close').click(function(e) {
			e.preventDefault();
			
			$('#exchange_layer, #overlay_o').hide();
			$('.filebox_preview').children().remove();
			base_css();
			/* .selectOpt의 0번째 값을 추출하여 초기화 */
			var selectedVal = $('.selectOpt option:eq(0)').val();
			$('.selectOpt').val(selectedVal).attr('selected', 'selected');
			$('.filebox_preview').empty();
			filenameArr = new Array();
			filesrcArr = new Array();
			$('.upload-hidden').off();
			$('#area').val('');
		});
		
		/* 삽입 / 삭제로 나눔 */
		var filename = "";
		var fileTarget = $('.upload-hidden');
		
		$('.upload-hidden').on('change', function(e){
			// 값이 변경되면
			alert('filenameArr.length11 : ' + filenameArr.length);
			if(filenameArr.length < 4){
				if(window.FileReader){
					// modern browser 
					filename = $(this)[0].files[0].name;
				} else {
					// old IE 
					filename = $(this).val().split('/').pop().split('\\').pop(); 
					// 파일명만 추출
				} 
				// 추출한 파일명 삽입
				$(this).siblings('.upload-name').val(filename);
				filenameArr[filenameArr.length] = filename;
				alert('filenameArr.length22 : ' + filenameArr.length);
			} else{
				alert('이미지는 3장까지 등록이 가능합니다.');
			}
		});
		
		var imgTarget = $('.preview-image .upload-hidden'); 
		$('.upload-hidden').on('change', function(){ 
			alert('filenameArr.length33 : ' + filenameArr.length);
			
			if(filenameArr.length < 4){
				var preview = $('.filebox_preview');
				preview.children('.upload-display').remove(); 
				if(window.FileReader){
					//image 파일만 
					/* if (!$(this)[0].files[0].type.match(/image\//)) 
						return; */
					var html = "";
					var reader = new FileReader();
					reader.onload = function(e){
						var src = e.target.result;	
						
						filesrcArr[filenameArr.length-1] = src;
						alert('filenameArr.length44 : ' + filenameArr.length);
						filesrcArr.forEach(function(e){
							html += '<div class="upload-display">';
							html += '<div class="upload-thumb-wrap">';
							html += '<img src="'+ e +'" class="upload-thumb">';
							html += '<img src="images/common/img_delete.png" class="delete_img">';
							html += '</div></div>';
						});
						/* preview.append('<div class="upload-display"><div class="upload-thumb-wrap"><img src="'+src+'" class="upload-thumb"></div></div>'); */
						if(filenameArr.length >0){
							$('.filebox_preview').parent().css("height", "120px");
							$('.layer_inner').css("height", "390px");
						}
						preview.append(html);	
					}
					
					reader.readAsDataURL($(this)[0].files[0]);
				}
				
				else { 
					$(this)[0].select();
					$(this)[0].blur(); 
					var imgSrc = document.selection.createRange().text; 
					preview.append('<div class="upload-display"><div class="upload-thumb-wrap"><img class="upload-thumb"></div></div>');
					var img = $(this).siblings('.upload-display').find('img'); 
					img[0].style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";
				}
			} else{
				alert('이미지는 3장까지 등록이 가능합니다.');
			}
			
		});
		
		
		$(document).on("click", ".delete_img" ,function () {
			
			var index = $('.delete_img').index(this);
			
			filenameArr.splice(index, 1);
			filesrcArr.splice(index, 1);
			
			$(this).parent().parent().remove();
			if(filesrcArr.length == 0)
				base_css();
			
			/* 삭제 했을때 해당 this 의 부모를 삭제한것을  exchange_product에도 삭제하도록 */
		})

	}
	
	
	
	function datepicker() {
		
		$.datepicker.setDefaults({
			showOn: "both",
			buttonImage: "images/common/ico_cal.gif",
			buttonImageOnly: false,
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd',
			nextText: '다음 달',
			prevText: '이전 달' ,
			dayNames: ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'],
			dayNamesMin: ['월', '화', '수', '목', '금', '토', '일'], 
			monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']                   
		});
		
		var toDate = new Date();
		
		var fromDate = setDate(4);
		
		$("#toDate").val($.datepicker.formatDate($.datepicker.ATOM, toDate));
		/* $("#fromDate").val($.datepicker.formatDate($.datepicker.ATOM, fromDate)); */
		$('#fromDate').val(fromDate);
		
		$('#fromDate').datepicker();
		$('#fromDate').datepicker("option", "maxDate", $("#toDate").val());
		$('#fromDate').datepicker("option", "onClose", function ( selectedDate ) {
			$("#toDate").datepicker( "option", "minDate", selectedDate );
  		});
		
		$('#fromDate').datepicker();
		$('#fromDate').datepicker("option", "maxDate", $("#edate").val());
		$('#fromDate').datepicker("option", "onClose", function ( selectedDate ) {
			$("#toDate").datepicker( "option", "minDate", selectedDate );
  		});
	
	
		$('#toDate').datepicker({maxDate: 0});
		$('#toDate').datepicker("option", "minDate", $("#fromDate").val());
		$('#toDate').datepicker("option", "onClose", function ( selectedDate ) {
			$("#sdate").datepicker( "option", "maxDate", selectedDate );
		});
	}
	
	function setDate(value) {
		var toDate = new Date();
		var fromDate;
		if(value == '2'){
			/* 1주일전 */
			fromDate = dateCalc(-7,'d');
		} else if(value == '3'){
			/* 1달전 */
			fromDate = dateCalc(-1,'m');
		} else if(value == '4'){
			/* 3달전 */
			fromDate = dateCalc(-3,'m');
		} else if(value == '5'){
			/* 6달전 */
			fromDate = dateCalc(-6,'m');
		} else{
			/* 오늘 */
			fromDate = dateCalc(0,'d');
		}
		OrderBuyList(fromDate);
		return fromDate;
	}
	
	
	function dateCalc(nNum, type) {
		
		var d = new Date(), month = '' + (d.getMonth() + 1), day = '' + d.getDate(), year = d.getFullYear(); 
		if (month.length < 2) month = '0' + month; 
		if (day.length < 2) day = '0' + day; 
		
		var nDate = [year, month, day].join('-');
		var yy  = parseInt(nDate.substr(0, 4), 10);
		var mm = parseInt(nDate.substr(5, 2), 10);
		var dd = parseInt(nDate.substr(8), 10);

	    if (type == "d") {
	        d = new Date(yy, mm - 1, dd + nNum);
	    }
	    else if (type == "m") {
	        d = new Date(yy, mm - 1, dd + (nNum * 31));
	    }
	    else if (type == "y") {
	        d = new Date(yy + nNum, mm - 1, dd);
	    }
	    yy = d.getFullYear();
	    mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
	    dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
	    
	    return yy + '-' +  mm  + '-' + dd;
	}
	
	
	function OrderBuyList(fromDate) {
		$.ajax({
			type: "post",
			url:"<c:url value='/OrderBuyList.ajax'/>",
			async: false,
			data: "fromDate=" + fromDate,
			success : function(data) {
				console.log(data);
				$('.order_list').remove();
				var change = "";
				var html = "";
				if(data == "" || data == null || typeof data == "undefined"){
					/* 값이 없음 */
					html += '<ul class="order_list"><li style="float:none; border:0; margin-top:40px;">주문 내역이 없습니다.</li></ul>';
				} else {
					$.each(data , function (key, val) {
						html += '<ul class="order_list">';
						html += '<li style="width: 120px;">' + val.orderDtlnum + '</li>';
						html += '<li style="width: 101px;"><img src="images/list/' + val.imgList + '.gif"/></li>';
						html += '<li style="width: 706px; padding-top: 20px; height: 115px; line-height:inherit; text-align:left;">'
						html += val.productName +'<br>';
						html += val.productAccount+'<br>';
						html += '<br> 옵션[' + val.productOption1 + '/';
						html += val.productOption2 + ']';
						html += '</li>';
						html += '<li style="width: 61px;">' + val.productCount + '</li>';
						html += '<li style="width: 120px;">' + val.productPrice + '</li>';
						html += '<li style="width: 121px;">' + val.codeValue + '</li>';
						html += '<li style="width: 120px;" id="test">';
						html += '<a href="javascript:void(0)" onclick="exchange_Layer(' + val.orderDtlnum + ')">교환</a>';
						html += '<a href="javascript:">반품</a>';
						html += '<a href="javascript:void(0)" onclick="delete(' + val.orderDtlnum + ')">취소</a>';
						html += '</li>';
						html += '</ul>';
					});
				}
				var height = "";
				if(Object.keys(data).length < 1){
					$('#order_paging').remove();
					$('#order_info').removeAttr("style");
				} else{
					height = (135 * Object.keys(data).length) + 80;
					$('#order_info').css("height", height + 'px');
					
				}
				$('#order_infoList').append(html).trigger("create");
				ajax_request_abort();
				
			},error : function(request,status, error) {
				alert("code:"+ request.status+ "\n"
						+ "message:"+ request.responseText+ "\n"
						+ "error:"+ error);
			}
		});
	};
	
	$.ajaxSetup({
        beforeSend: function(jqXHR) {
            xhrPool.push(jqXHR);
        },
        complete: function(jqXHR) {
            var index = xhrPool.indexOf(jqXHR);
            if (index > -1) {
                xhrPool.splice(index, 1);
            }
        }
	});
	
	var xhrPool = [];
	
	function ajax_request_abort(){
	    xhrPool.forEach(function(jqXHR, idx) {
	        if(jqXHR && jqXHR.readyState != 4){
	            jqXHR.abort();
	        }
	    });
	    xhrPool.length = 0;
	}
	
</script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<div id="orderStatus_wrap">
		<div id="orderStatus_tabbox">
			<div>
				<div>
					<a href="myPage.do">마이페이지</a>
				</div>
				<div>
					<a href="#">장바구니</a>
				</div>
				<div style="background-color: #c28562;">
					<a href="order_Status.do" style="color: white;">주문/배송 조회</a>
				</div>
				<div>
					<a href="order_Modify.do">회원정보 수정</a>
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
		
		<div id="order_tab">
			<ul class="tabs">
				<li class="select" >주문내역조회(0)</li>
				<li >교환/반품/취소 내역(0)</li>
			</ul>
		</div>
		<form id="historyForm">
		<div id="order_historyForm">
			<div>
				<select>
					<option>전체주문처리상태</option>
					<option>상품준비</option>
					<option>배송중</option>
					<option>배송완료</option>
				</select>
				<ul class="picker">
					<li class="select" value="1">오늘</li>
					<li value="2">1주일</li>
					<li value="3">1개월</li>
					<li value="4">3개월</li>
					<li value="5">6개월</li>
				</ul>
				<input type="text"  id="fromDate" readonly="readonly">
				<button type="button">
					<%-- <img src="<c:url value='images/common/ico_cal.gif'/>" id="fromImage"> --%>
				</button>
				<p>~</p>
				<input type="text" id = "toDate" readonly="readonly">
				<button type="button">
					<%-- <img src="<c:url value='images/common/ico_cal.gif'/>" id="toImage"> --%>
				</button>
			</div>
			<ul>
				<li>·기본적으로 최근 3개월간의 자료가 조회되며, 기간 검색시 지난 주문내역을 조회하실 수 있습니다.</li>
				<li>·주문번호를 클릭하시면 해당 주문에 대한 상세내역을 확인하실 수 있습니다.</li>
			</ul>
		</div>
		</form>
		
		<div id="order_info">
			<label>주문 상품 정보</label>
			<ul class="order_infoTab">
				<li style="width: 120px;">주문번호</li>
				<li style="width: 100px;">이미지</li>
				<li style="width: 706px;">상품정보</li>
				<li style="width: 60px;">수량</li>
				<li style="width: 120px;">상품구매금액</li>
				<li style="width: 120px;">주문처리상태</li>
				<li style="width: 120px;">교환/반품/취소</li>
			</ul>
			<!-- if문으로 주문내역이 있으면 표시 없으면 가져온 정보 표시 -->
			<div id="order_infoList">
				
			</div>
		</div>
		<div id="order_paging">
			<a href="javascript:" style="right: -8px;"><img src="<c:url value='/images/common/btn_page_first.gif'/>"></a>
			<a href="javascript:" style="right: -4px;"><img src="<c:url value='/images/common/btn_page_prev.gif'/>"></a>
			<ul>
				<li><a href="javascript:">1</a></li>
				<li><a href="javascript:">2</a></li>
				<li><a href="javascript:">3</a></li>
			</ul>
			<a href="javascript:" style="left: -3px;"><img src="<c:url value='/images/common/btn_page_next.gif'/>"></a>
			<a href="javascript:" style="left: -7px;"><img src="<c:url value='/images/common/btn_page_last.gif'/>"></a>
			
		</div>
	</div>
	
	<!-- EXCHANGE(교환) ,RETURN(반품) layer -->
	<div id="overlay_o"></div>
	<div id="exchange_layer">
		<div class="layer_inner">
			<div class="inner_title">EXCHANGE / 교환</div>
		
			<div class="inner_table">
				<div class="inner_table_row">
					<div class="inner_table_cell">사유선택</div>
					<div class="inner_table_cell">
						<select class="selectOpt">
							<option selected="selected">-사유선택-</option>
							<option>구매의사 취소</option>
							<option>다른 상품 잘못 질문</option>
							<option>서비스 불만족</option>
							<option>배송 지연</option>
							<option>상품 누락</option>
							<option>상품정보 상이</option>
							<option>오배송</option>
						</select>
					</div>
				</div>
				<div class="inner_table_row">
					<div class="inner_table_cell">사유입력</div>
					<div class="inner_table_cell">
						<textarea rows="6" cols="50" id="area"></textarea>
					</div>
				</div>
				<div class="inner_table_row">
					<div class="inner_table_cell">사진등록</div>
					<div class="inner_table_cell">
						<ul>
							<li>
								<!-- <a href="#javascript">사진 등록</a> -->
								<div class="filebox preview-image">
									<input class="upload-name" value="파일선택" disabled="disabled">
		
									<label for="input-file">업로드</label>
									<input type="file" id="input-file" class="upload-hidden">
								</div>
							</li>
							<li>∙교환 및 취소 사유를 확인할 수 있는 사진을 등록하시면 보다 신속하게 진행됩니다.</li>
							<li>∙사진은 최대 3개, 각 10MB이하로 등록 가능합니다.</li>
							<li>
								<div class="filebox_preview"></div>
							</li>
							
							<li>
								<a href="javascript:">교환 요청</a>
								<a href="javascript:">이전 페이지</a>
							</li>
						</ul>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>