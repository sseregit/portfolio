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
</style>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>

<script type="text/javascript">
	$(document).ready(function() {
		//Tab
		$("#tabs").tabs();

		$('#btnsearch').click(

		function() {
			var type = $('#searchType option:selected').val();
			var text = $('#searchText').val();

			var frm = $('#searchForm')[0];
			frm.action = "${pageContext.request.contextPath}/list.do";
			frm.submit();
		});

	});
</script>
</head>
<body>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">자유게시판</a></li>
		</ul>
		<div id="tabs-1">
			<!-- wrap -->
			<div id="wrap">

				<!-- container -->
				<div id="container">

					<!-- content -->
					<div id="content">

						<!-- board_search -->
						<div class="board_search">
							<form id="searchForm">
								<select title="선택메뉴" id="searchType" name="searchType">
									<option value="all"
										<c:if test="${searchType == 'all'}">selected</c:if>>전체</option>
									<option value="userId"
										<c:if test="${searchType == 'userId'}">selected</c:if>>작성자</option>
									<option value="title"
										<c:if test="${searchType == 'title'}">selected</c:if>>제목</option>
								</select> <input type="text" id="searchText" name="searchText"
									value="${searchText}" title="검색어 입력박스" class="input_100" /> <input
									type="button" id="btnsearch" value="검색" title="검색버튼"
									class="btn_search" />
						</div>
						<!-- //board_search -->
						</form>

						<!-- board_area -->
						<div class="board_area">
							<form method="get">
								<fieldset>
									<legend>Ses & Food 게시물 목록</legend>
									<!-- board list table -->
									<table summary="표 내용은 Ses & Food 게시물의 목록입니다."
										class="board_list_table">
										<caption>Ses & Food 게시물 목록</caption>
										<colgroup>
											<col width="5%" />
											<col width="40%" />
											<col width="10%" />
											<col width="25%" />
											<col width="10%" />
											<col width="10%" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">제목</th>
												<th scope="col">작성자</th>
												<th scope="col">작성일</th>
												<th scope="col">조회</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${result}" var="o">
												<tr>
													<td>${o.board_number}</td>
													<td class="tleft"><span class="bold"><a
															href="<c:url value = "read.do?boardNumber=${o.board_number}&currentPageNo=${currentPageNo}"/>">${o.title}</a></span>
													</td>
													<td>${o.user_id}</td>
													<td>${o.reg_date}</td>
													<td class="tright">${o.hits}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<!-- //board list table -->

									<!--paginate start -->
									<div class="paginate">
										<c:if test="${pageBlockStart != 1}">
											<a class="pre"
												href="/web_portfolio/list.do?currentPageNo=1&searchType=<c:out value = '${searchType}'/>&searchText=<c:out value = '${searchText}'/>">

												처음으로 
										</c:if>
										<c:if test="${pageBlockStart != 1}">
											<a class="pre"
												href="/web_portfolio/list.do?currentPageNo=${pageBlockStart - 1 }&searchType=<c:out value = '${searchType}'/>&searchText=<c:out value = '${searchText}'/>">

												이전페이지 
										</c:if>
										</a>
										<c:forEach var="i" begin="${pageBlockStart}"
											end="${pageBlockEnd}" step="1">

											<a
												href="/web_portfolio/list.do?currentPageNo=${i}&searchType=<c:out value = '${searchType}'/>&searchText=<c:out value = '${searchText}'/>">
												<c:choose>

													<c:when test="${ i == currentPageNo }">
														<!-- 조건1 -->


														<strong>${ i }</strong>

													</c:when>

													<c:otherwise>
														<!-- 조건1 가 아니면 \ 단독사용 불가능 -->
												
                                            ${i}
										</c:otherwise>

												</c:choose>
											</a>
										</c:forEach>



										<c:if test="${pageBlockStart + pageBlockSize <= totalPage}">
											<a class="next"
												href="/web_portfolio/list.do?currentPageNo=${pageBlockEnd + 1 }&searchType=<c:out value = '${searchType}'/>&searchText=<c:out value = '${searchText}'/>">

												다음페이지 
										</c:if>
										<c:if test="${pageBlockStart + pageBlockSize <= totalPage}">
											</a>
											<a class="next"
												href="/web_portfolio/list.do?currentPageNo=${totalPage}&searchType=<c:out value = '${searchType}'/>&searchText=<c:out value = '${searchText}'/>">
												끝으로 
										</c:if>
										</a>
									</div>
									<!--//paginate end -->

									<!-- bottom button -->
									<div class="btn_bottom">
										<c:if test="${sessionScope.userId != null }">
											<a
												href="<c:url value = "gowrite.do?currentPageNo=${currentPageNo }" />">
												<div class="btn_bottom_right">
													<input type="button" value="글쓰기" title="글쓰기" />
												</div>
											</a>
										</c:if>
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