<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>회원 목록</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<style type="text/css">
body {
	margin-right: 0px;
}
/* container layout */
#container {
	margin: 0 auto;
	padding: 20px 0;
}

#content {
	display: table-cell;
	width: 750px;
	padding: 0 0 0 0px;
}
/* //container layout */
.search {
	margin-bottom: 5px;
	text-align: right;
}

.search .btn_search {
	height: 20px;
	line-height: 20px;
	padding: 0 10px;
	vertical-align: middle;
	border: 1px solid #e9e9e9;
	background-color: #f7f7f7;
	font-size: 12px;
	text-align: center;
	cursor: pointer;
}

.ui-widget .ui-widget {
	font-size: 0.7em !important;
}
</style>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/jquery-ui/css/jquery-ui.css" />" />

<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-3.2.1.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery-ui/js/jquery-ui.js" />"></script>
<script type="text/javascript"
	src="<c:url value="/resources/jquery/js/jquery-migrate-1.4.1.js" />"></script>

<script type="text/javascript"
	src="<c:url value ="/resources/jqgrid/js/i18n/grid.locale-kr.js" />">
	
</script>

<script type="text/javascript"
	src="<c:url value ="/resources/jqgrid/js/jquery.jqGrid.min.js" />">
	
</script>

<link rel="stylesheet" type="text/css" media="screen"
	href="<c:url value ="/resources/jqgrid/css/ui.jqgrid.css"/>" />

<script type="text/javascript">
	$(document).ready(
			function() {
				//Tab
				$("#tabs").tabs();

				var tabHeight = $('#tabs').height();
				// jqGrid가 생성이 되면 최초가로를 설정할 변수
				var initGridWidth = 0;
				// jqGrid가 생성이 되면 최초세로를 설정할 변수
				var initGridHeight = 0;

				var userGrid = jQuery("#userGrid")
						.jqGrid(
								{
									// 데이터를 가지고 오기위한 URL
									url : '<c:url value="/getUser.do"/>',
									mtype : "POST",
									// URL 에 보낼 파라미터 {key:value} Object
									data : {},
									datatype : "json",
									page : $('#currentPageNo').val(), // 보여줄 페이지 번호
									jsonReader : {
										root : "rows", // 실제 데이터 15건
										page : "page", // 현재 페이지
										total : "total", // 총 페이지수
										records : "records", // 총 데이터 건수
										repeatitems : false,
										cell : "cell",
										id : "seq" // pk 컬럼/변수 
									},
									colNames : [ "번호", "아이디", "이름", "닉네임",
											"이메일", "isAdmin", "생성일" ],
									colModel : [ {
										// DTO
										name : "seq",
										// DB명
										index : 'seq',
										width : 30,
										editrules:{required:true},
										editable : true,
										hidden : false,
										editoptions : {
										readonly : true
										},
										align : 'center'
									}, {
										name : "userId",
										index : 'user_id',
										width : 100,
										editrules:{required:true},
										editable : true,
										hidden : false,
										editoptions : {
											readonly : true
										},
										align : 'center'
									}, {
										name : "userName",
										index : 'user_name',
										width : 150,
										editrules:{required:true},
										editable : true,
										hidden : false,
										align : 'center'
									}, {
										name : "nickName",
										index : 'nickname',
										width : 80,
										editrules:{required:true},
										editable : true,
										hidden : false,
										align : 'center'
									}, {
										name : "email",
										index : 'email',
										width : 80,
										editrules:{required:true},
										editable : true,
										editoptions : {
											size : "20",
											maxlength : "50"
										},
										hidden : false,
										align : 'center'
									}, {
										name : "isAdmin",
										index : 'is_admin',
										width : 80,
										editrules:{required:true},
										editable : true,
										edittype : 'select',
										editoptions : {
											value : {
												'-' : '선택',
												'1' : '예',
												'0' : '아니오'
											}
										},
										hidden : true,
										align : 'center'
									}, {
										name : "createDate",
										index : 'create_date',
										width : 70,
										editable : true,
										editoptions : {
											readonly : true
										},
										hidden : false,
										align : 'center'
									} ],
									autowidth : false,
									width : 740,
									height : 400,
									rowNum : 15,
									rownumbers : false,
									sortname : "seq",
									sortorder : "desc",
									scrollrows : true,
									viewrecords : true,
									gridview : true,
									autoencode : true,
									altRows : true,
									pager : '#userGrid-pager',
									caption : "게시판", // set caption to any string you wish and it will appear on top of the grid
									loadComplete : function() {
										var gridId = 'userGrid';
										var gridParentWidth = $(
												'#gbox_' + gridId).parent()
												.width();
										var gridParentHeight = $(
												'#gbox_' + gridId).parent()
												.height();
										// 그리드 가로 길이 맞춤
										$('#' + gridId).jqGrid('setGridWidth',
												gridParentWidth);
										// index.jsp - iframe 길이맞춤
										var t = $('#demoFrame',
												window.parent.document);
										$(t).height(
												tabHeight + gridParentHeight
														+ 30);

										if (initGridWidth == 0)
											initGridWidth = $('#gbox_userGrid')
													.parent().width();
										// 그리드 가로 길이 고정시키기
										$('#gbox_userGrid').jqGrid(
												'setGridWidth', initGridWidth);

										/*
										// 세로길이 고정시키기
										if(initGridHeight == 0) initGridHeight = $('#gbox_userGrid').parent().Height();
										// index.jsp - iframe 길이맞춤
										var t = $('#demoFrame',window.parent.documnet);
										$(t).height(tabHeight + initGridHeight);
										 */
									},
									// 셀을 선택할시
									onCellSelect : function(rowId, cellIdx,
											value, event) {

										console.log(rowId); // 선택한곳의 seq
										console.log(cellIdx); // 선택한곳의 위치 
										console.log(value);
										console.log(event);

									},
									onSelectRow : function(rowId, tf, event) {
										console.log(rowId); // 선택한곳의 seq
										console.log(tf); // 값을모르겟는 boolean
										console.log(event);

										$.ajax({

											url : '/web_portfolio/checkPk.do',
											type : "post",
											//  키                값
											data : {
												'rowId' : rowId
											},
											// callback 함수 결과가 돌아옴 통신성공
											success : function(result,
													textStatus, jqXHR) {
												// result 는 controller에서 보내주는값 

											},
											// 통신 실패
											error : function(jqXHR, textStatus,
													errorThrown) {
												console.log(jqXHR);
												console.log(textStatus);
												console.log(errorThrown);
											}
										});

									}

								});

				//navButtons
				jQuery(userGrid).jqGrid(
						'navGrid',
						"#userGrid-pager",
						{ //navbar options
							edit : true,
							add : false,
							del : true,
							search : false,
							refresh : false,
							view : true
						},
						{
							width : 'auto',
							editCaption : '회원 정보 수정',
							url : '<c:url value="editUser.do"/>',
							closeOnEscape : true,
							closeAfterEdit : true,
							reloadAfterSubmit : true,
							recreateForm : true,
							viewPagerButtons : false,
							beforeShowForm : function(form) {
								console.log($(form[0]).html());
								var rowId = $("#userGrid").jqGrid(
										'getGridParam', 'selrow');
								// rowId로 row값 가져오기 : return type = Object
								var rowData = $('#userGrid').jqGrid(
										'getRowData', rowId);

								console.log(rowData);

								// alert(rowData.isAdmin);

								$('tr#tr_isAdmin', form[0]).show();

								$(
										'select#isAdmin option[value='
												+ rowData.isAdmin + ']',
										form[0]).attr({
									'selected' : true
								});

							},
							beforeSubmit : function(post, formId) {
								console.log('beforeSubmit : ' + post)
								if(post.userName == ''){
									return [false, "사용자명을 입력하세요."];
								}
								
								if(post.nickName == ''){
									return [false, "닉네임을 입력하세요."];
								}
								
								if(post.isAdmin == ''){
									return [false, "isAdmin을 입력하세요."];
								}
								if(post.email.length < 8){
									return [false, "이메일은 8자 이상입니다."]
								}
								var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{3,4}$/i;
								if(post.email.match(regExp) == null){
									return [false, "이메일형식이 개판입니다."]
								}
								return [true,"",""];
								
							},
							afterComplete : function(response, postdata) {
								console.log('editOption - afterComplete');
								console.log(response);

							},
							afterSubmit : function(response, postdata) {
								var msg = response.responseText;
								
								alert(msg)
								
								return [ true, '', '' ];
							}
						}, // edit 설정 순서지켜야댐
						{}, // add

						{
							caption : '회원정보 삭제',
							msg : "선택한 회원을 삭제 하시겟습니까?",
							recreateForm : true,
							url : '<c:url value = "/delUser.do"/>',
							beforeShowForm : function(e) {
								var form = $(e[0]);
								return;
							},
							afterComplete : function(result, postdata) {
								console.log('delOption - afterComplete');
								console.log(result.responseJSON);
								console.log('-------------------------');
								// return 1 : data = 1;
								// return "ERROR" = data = "ERROR"; String = result.responseText 문자열만!
								// return Map : data={key:value} -> data.key

								var data = result.responseJSON;

								alert(data.del)

							},
							onClick : function() {

							}
						}

				);

				$('#btnsearch').click(

				function() {

					var searchType = $('#searchType option:selected').val();
					var searchText = $('#searchText').val();

					$('#userGrid').jqGrid('setGridParam', {
						postData : {
							//    키           와      값
							'searchType' : searchType,
							'searchText' : searchText
						},
						page : 1

					}).trigger("reloadGrid");
				}

				);

			});
</script>
</head>
<body>
	<div id="tabs">
		<ul>
			<li><a href="#tabs-1">회원 목록</a></li>
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

							<!-- board_search -->
							<div class="search">

								<select id="searchType" title="선택메뉴">

									<option value="all" selected="selected">전체</option>

									<option value="userId">ID</option>

									<option value="userName">이름</option>

								</select> <input type="text" id="searchText" title="검색어 입력박스"
									class="input_100" /> <input type="button" id="btnsearch"
									value="검색" title="검색버튼" class="btn_search" />

							</div>
							<!-- //board_search -->

							<table id="userGrid"></table>
							<div id="userGrid-pager"></div>
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