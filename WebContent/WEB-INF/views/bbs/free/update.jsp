<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>게시물 목록페이지</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/common.css" />" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" />
<style type="text/css">
body {
	margin-right: 0px;
}

.ui-tabs .ui-tabs-panel {
	padding: 0px;
	!
	important;
}
</style>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>
<script src="https://cdn.ckeditor.com/4.9.1/standard/ckeditor.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		//Tab
		$("#tabs").tabs();
	});
	
	function update() {
		
		var title = $('#title').val();
		 if(title == '' || title == undefined){
			 alert("제목이 빈칸입니다")
			 $('#title').focus();
			 return;
		 }

		 var content = $('#o').val();
		 if(content == '' || content == undefined){
			 alert("내용이 빈칸입니다")
			 $('#o').focus();
			 return;
		 }
		 
		 var frm = document.updateForm;
		  frm.action = "/web_portfolio/update.do?currentPageNo=${currentPageNo}";
		  frm.method = "POST";
		  frm.submit();		
	}
	 
	  // 자바 스크립트 매개변수 타입없음
	  function deleteAttach(attachSeq){
		  
		  var frm = document.updateForm;
		  frm.action = "/web_portfolio/delAttach.do?attachSeq="+attachSeq+"&currentPageNo=${currentPageNo}&boardNumber=${boardNumber}";
		  frm.method = "POST";
		  frm.submit();		
	  }
</script>
</head>
<meta charset="utf-8">
	<title>CKEditor</title> <script
		src="https://cdn.ckeditor.com/4.9.1/standard/ckeditor.js"></script>
	<body>
		<div id="tabs">
			<ul>
				<li><a href="#tabs-1">자유게시판 게시글 수정</a></li>
			</ul>
			<div id="tabs-1">
				<!-- wrap -->
				<div id="wrap">

					<!-- container -->
					<div id="container">

						<!-- content -->
						<div id="content">

							<!-- board_area -->
							<div class="board_area">
								<form name="updateForm" enctype="multipart/form-data">
									<input type="hidden" name="currentPageNo"
										value="${currentPageNo}" />
									<fieldset>
										<legend>게시글 수정</legend>

										<!-- board write table -->
										<table summary="표 내용은 게시글 수정 박스입니다." class="board_write_table">
											<caption>게시글 수정 박스</caption>
											<colgroup>
												<col width="20%" />
												<col width="80%" />
											</colgroup>
											<tbody>
												<tr>
													<th class="tright"><label for="board_write_name">글번호</label></th>
													<td class="tleft"><input type="text" id="seq"
														name="boardNumber" title="글번호 입력박스"
														value="${board.boardNumber }" readonly="readonly"
														class="input_100"></td>

													<tr>
														<th class="tright"><label for="board_write_name">작성자</label></th>
														<td class="tleft"><input type="text" id="name"
															name="userId" title="작성자 입력박스" value="${board.userId }"
															class="input_100" readonly="readonly" /></td>
													</tr>
													<tr>
														<th class="tright"><label for="board_write_title">제목</label></th>
														<td class="tleft"><input type="text" name="title"
															id="title" value="${board.title }" title="제목 입력박스"
															class="input_380" /></td>
													</tr>
													<tr>
														<th class="tright"><label for="board_write_title">내용</label></th>
														<td class="tleft">
															<div class="editer">
																<p>
																	<textarea rows="30" id="o" name="content" cols="100">${board.content }</textarea>
																	<script>
																	CKEDITOR
																			.replace('o');
																</script>
																</p>
															</div>
														</td>
                                            
														<c:if test="${board.hasFile == 0}">
													</tr>
													<th class="tright"><label for="board_write_title">첨부파일</label></th>
													<td class="tleft"><input type="file" name="attachFile"
														title="제목 입력박스" class="input_380" /> 
														<input type="file" name="attachFile" title="제목 입력박스" class="input_380" /></td>
												</tr>
												</c:if>
												
												<c:if test="${board.hasFile == 1}">
													</tr>
													<th class="tright"><label for="board_write_title">첨부파일</label></th>
													<td class="tleft"><c:forEach items="${attachment}"
															var="i">
															<a
																href="<c:url value ="fileDownLoad.do?attachSeq=${i.attachSeq}"/>">
																${i.fileName} (${df.format(i.fileSize/1024)}KB) </a>
															<input type="button"
																onclick="deleteAttach(${i.attachSeq})" value="삭제" />
															<br />
														</c:forEach></td>
													</tr>
												</c:if>

											</tbody>
										</table>
										<!-- //board write table -->

										<!-- bottom button -->
										<div class="btn_bottom">
											<div class="btn_bottom_right">
												<a
													href="<c:url value = "read.do?boardNumber=${boardNumber}&currentPageNo=${currentPageNo }" /> ">
													<input type="button" value="취소" title="취소" />
												</a> 
												<input type="button" onclick="update()" value="완료"
													title="완료" />
											</div>
										</div>
										<!-- //bottom button -->

									</fieldset>
								</form>
							</div>
							<!-- //board_area -->

						</div>
						<!-- //content -->

					</div>
					<!-- //container -->

				</div>
				<!-- //wrap -->
			</div>
		</div>

	</body>
</html>