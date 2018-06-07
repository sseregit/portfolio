<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>게시물 상세페이지</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/common.css" />" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript">

function dodelete(){
	
	var password = $("#password").val();
	if(password == "" || password == undefined){
		alert("비밀번호를 입력하세요");
		$("#password").focus();
		return;
	}
	
	var frm = document.readForm;
	frm.action = "/web_portfolio/delete.do?boardNumber=${boardNumber}&currentPageNo=${currentPageNo}";
	frm.method = "POST";
	frm.submit();
}

function doupdate() {
	
	var password = $("#password").val();
	if(password == "" || password == undefined){
		alert("비밀번호를 입력하세요");
		$("#password").focus();
		return;
	}
	
	var frm = document.readForm;
	 frm.action = "/web_portfolio/goupdate.do?boardNumber=${boardNumber}&currentPageNo=${currentPageNo}"
	 frm.method = "POST";
	 frm.submit();

	
}



</script>


</head>
<body>

	<!-- wrap -->
	<div id="wrap">

		<!-- container -->
		<div id="container">

			<!-- content -->
			<div id="content">

				<!-- title board detail -->
				<div class="title_board_detail">게시물 보기</div>
				${msg}
				<!-- //title board detail -->
				
					<!-- board_area -->
				<div class="board_area">
					<form name="readForm">
						<fieldset>
							<legend>Ses & Food 게시물 상세 내용</legend>

							<!-- board detail table -->
							<table summary="표 내용은 Ses & Food 게시물의 상세 내용입니다."
								class="board_detail_table">
								<caption>Ses & Food 게시물 상세 내용</caption>
								<colgroup>
									<col width="%" />
									<col width="%" />
									<col width="%" />
									<col width="%" />
									<col width="%" />
									<col width="%" />
								</colgroup>
								<tbody>
									<tr>
										<th class="tright">제목</th>
										<td colspan="5" class="tleft"><c:out
												value="${board.title }" /></td>
									</tr>
									<tr>
										<th class="tright">작성자</th>
										<td colspan="5" class="tleft"><c:out
												value="${board.name }" /></td>
									</tr>
									<tr>
										<th class="tright">작성일</th>
										<td><c:out value="${board.regDate }" /></td>
										<th class="tright">조회수</th>
										<td class="tright"><c:out value="${board.hits}" /></td>
									</tr>
									<tr>
										<td colspan="6" class="tleft">${board.content }
											<div class="body"></div>
										</td>
									</tr>
									
									<c:if test="${board.hasFile == 1}">
									<tr>
									    <th class="tright">첨부파일</th>
										<td colspan="5" class="tleft">											
										<c:forEach items="${attachment}" var="i">
											<a href="<c:url value ="fileDownLoad.do?attachSeq=${i.attachSeq}"/>">
												${i.fileName}  (${df.format(i.fileSize/1024)}KB) 
												</a>
												<br />
										</c:forEach>
										</td>
									</tr>
									</c:if>
									
									<tr>
										<c:if test="${sessionScope.userId == board.userId }">

											<th class="tright">비밀번호</th>
											<td colspan="5" class="tleft"><input type="password"
												name="password" id="password" title="비밀번호 입력박스"
												class="input_100" /></td>
										</c:if>
									</tr>
								</tbody>
							</table>
							<!-- //board detail table -->

							<!-- bottom button -->
							<div class="btn_bottom">
								<div class="btn_bottom_left">
									<input type="button" value="추천하기" title="추천하기" />
								</div>
								<div class="btn_bottom_right">
									<c:if test="${sessionScope.userId == board.userId }">

										<input type="button" onclick="doupdate()" value="수정"
											title="수정" />

										<input type="button" onclick="dodelete()" value="삭제"
											title="삭제" />
									</c:if>
									<a
										href="<c:url value = "list.do?currentPageNo=${currentPageNo}"/>">
										<input type="button" value="목록" title="목록" />
									</a>
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

</body>
</html>