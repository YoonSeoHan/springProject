<%@page import="light.board.service.BoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href='/css/view/boardWriteForm.css?var=1' rel="stylesheet" />
<script src="jquery/jquery-3.3.1.js"></script>
<script src="jquery/jquery.cookie.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		
		/* if($('#boardNum').val())
			alert($('#boardNum').val()); */
		
		/* $('#frm').on("submit", function(e) { */
			
		/* }); */
		
		$('#choice_mail').change(function() {
			var os = $('#choice_mail option:selected').val();
			if (os == '직접입력') {
				$('#boardBemail').val('');
			} else {
				$('#boardBemail').val(os);
			}
		});
		
		/* alert("${BoardVo.boardNum}"); */
	});

	function Link(action) {
		var rs = empty();
		if(rs == false)
			return false;
		var f = frm;
		var a = action;
		var productNum = $('#productNum').val();
		if(a == 'delete'){
			var rs = confirm('게시글을 삭제하시겠습니까 ?');
			if(rs){
				f.method="post"
				f.action="deleteAction.do"
				f.submit();	
			} else{
				return false;
			}
		} else if(a == 'update'){
			f.method="post";
			f.action="updateAction.do";
			f.submit();
		} else if(a == 'list'){
			f.method="get";
			location="product_Detail.do?list="+a+"&productNum="+productNum;
		} else if(a == 'write'){
			a = $('#action').val();
			if(a == 'reple'){
				f.method="post";
				f.action="insertRepleAction.do";
				f.submit();
			} else{
				f.method="post";
				f.action="insertAction.do";
				f.submit();
			}
		} 
	}
	
	function empty() {
		if ($('#boardSubject').val() == "") {
			alert("제목을 입력하세요");
			$('#boardSubject').focus();
			return false;
		}
		if ($('#boardWriter').val() == "") {
			alert("작성자명을 입력하세요");
			$('#boardWriter').focus();
			return false;
		}
		if ($('#boardFemail').val() == "") {
			alert("이메일을 입력하세요");
			$('#boardFemail').focus();
			return false;
		}
		if ($('#boardBemail').val() == "") {
			alert("이메일을 입력하세요");
			$('#boardBemail').focus();
			return false;
		}
		if ($('#boardContents').val() == "") {
			alert("문의 내용을 입력하세요");
			$('#boardContents').focus();
			return false;
		}
		if ($('#boardPwd').val() == "") {
			alert("비밀번호를 입력하세요");
			$('#boardPwd').focus();
			return false;
		}
		
		return true;
	};
</script>
<meta charset=UTF-8>
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test="${action eq 'write' or action eq 'reple'}">
			<c:set var="display1" value="" />
			<c:set var="display2" value="display:none;" />
		</c:when>
		<c:when test="${action eq 'update'}">
			<c:set var="display1" value="display:none;" />
			<c:set var="display2" value="" />
		</c:when>
	</c:choose>
	<input type="hidden" id="action" name="action" value="${action }">
	<form:form modelAttribute="BoardVo" action="insertAction.do" method="post" id="frm">
		<div id="write_wrap">
			<div class="content_title">
				<div>
					<h2 style="display: inline-block;">Q n A</h2>
					&nbsp;&nbsp;<img alt="수정중입니다." src='<c:url value="images/common/line_title.png"/>'>&nbsp;&nbsp;&nbsp;상품 QnA 입니다.
				</div>
			</div>
			<div id="board_subject">
				<div>
					<p>제목</p>
				</div>
				<div>
					<form:input path="boardSubject" id="boardSubject" name="boardSubject" />
				</div>
			</div>

			<div id="board_writer">
				<div>
					<p>작성자</p>
				</div>
				<div>
					<form:input path="boardWriter" id="	boardWriter" name="boardWriter" />
				</div>
			</div>
			<div id="board_email">
				<div>
					<p>이메일</p>
				</div>
				<div>
					<form:input path="boardFemail" id="boardFemail" name="boardFemail" />
					&nbsp;&nbsp;@&nbsp;&nbsp;
					<form:input path="boardBemail" id="boardBemail" name="boardBemail" />
					&nbsp;&nbsp; <select id="choice_mail">
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

			<div id="board_content">
				<form:textarea path="boardContents" id="boardContents" name="boardContents" />
			</div>
			<div id="board_pwd">
				<div>
					<p>비밀번호</p>
				</div>
				<div>
					<form:password path="boardPwd" id="boardPwd" name="boardPwd" />
				</div>
			</div>
			
			<div id="board_action">
				<div>
					<a href="javascript:" onclick="Link('list')">목록</a>
				</div>
				<div id="board_insert" style="${display1}">
					<a href="javascript:" onclick="Link('write')">등록</a>
				</div>
				<div id="board_delete" style="${display2}">
					<a href="javascript:" style="color:black;" onclick="Link('delete')">삭제</a>
				</div>
				<div id="board_update" style="${display2}">
					<a href="javascript:" onclick="Link('update')">수정</a>
				</div>
			</div>
			<div style="display: none;">
				<form:hidden path="productNum" id="productNum" name="productNum" />
				<form:hidden path="boardSeq" id="boardSeq" name="boardSeq" />
			</div>
		</div>
	</form:form>

</body>
</html>