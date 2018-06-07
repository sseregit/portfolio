<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- tag library 선언 : c tag --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<title>로그인 & 회원가입</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value="/resources/css/login.css" />" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		var panelOne = $('.form-panel.two').height(), 
			panelTwo = $('.form-panel.two')[0].scrollHeight;
	
		$('.form-panel.two').not('.form-panel.two.active').on('click', function(e) {
			e.preventDefault();
	
		    $('.form-toggle').addClass('visible');
		    $('.form-panel.one').addClass('hidden');
		    $('.form-panel.two').addClass('active');
		    $('.form').animate({
		      'height': panelTwo
		    }, 200);
		});
	
		$('.form-toggle').on('click', function(e) {
		    e.preventDefault();
		    $(this).removeClass('visible');
		    $('.form-panel.one').removeClass('hidden');
		    $('.form-panel.two').removeClass('active');
		    $('.form').animate({
		      'height': panelOne
		    }, 200);
		});
	});
	function dojoin(){
	
		var regExp = /^[A-Za-z0-9+]{4,12}$/;

		
     var userId = $('#j_userId').val();
     if(userId == ''){
		 alert("아이디를 입ㄺ하세요")
		 $('#j_userId').focus();
		 return;
	 }
     if(!regExp.test(userId)){
    	 alert("형식이 맞지 않습니다");
    	 $('#j_userId').focus();
    	 return;
     }
	 var userPw = $('#j_userPw').val();
	  if(userPw == ''){
		  alert("패스워드 입ㄺ하세요")
		  $("#j_userPw").focus();
		  return;
	  }
	  var cUserPw = $("#j_cUserPw").val();
	  if(cUserPw == ''){
		  alert("패스워드 입ㄺ하세요")
		  $("#j_cUserPw").focus();
		  return;
	  }
	  if(userPw != cUserPw){
		  alert("패스워드가 다르게 입ㄺ")
		  $("#j_userPw").focus();
		  return;
	  }
	  var userName = $("#j_userName").val();
	   if(userName == ''){
		   alert("NAME을 입ㄺ하세요")
		   $("#j_userName").focus();
		   return;
	   }
	  var nickName = $("#j_nickname").val();
	   if(nickName == ''){
		   alert("닉네임을 입ㄺ하세요")
		   $("#j_nickname").focus();
		   return;
	   }
	   
     
	   
		 // ajax 이용하여 ID중복 확인 후 중복 아닐 때 폼 전송
		 $.ajax({
			 
		 url: '/web_portfolio/chkId.do',
		 type: "post",
		      //  키                값
		 data: {'userId' : userId},
		 // callback 함수 결과가 돌아옴
		 success: function(result, textStatus, jqXHR){
			if(result == 0){
				var frm = $('form[name=joinForm]')[0];
				frm.action = "/web_portfolio/login.do";
				frm.method = "post";
				frm.submit();
			}
			else{
				alert("아이디 중복")
				$('#j_userId').focus();
			}
		 },
		 error: function(jqXHR, textStatus, errorThrown){
			 console.log(jqXHR);
			 console.log(textStatus);
			 console.log(errorThrown);
		   }		 
		 });	
	}
	
	function dologin(){
		
		var userId = $('#userId').val();
		if(userId == '' || userId == undefined){
			alert("아이디를입력하세요");
			$('#userId').focus();
			return;
			}
		
		var userPw = $('#userPw').val();
		if(userPw == '' || userPw == undefined){
			alert("비미일버언호오를입력하세요");
			$('#userPw').focus();
			return;
			}
		
	    var frm = document.loginForm;
	     frm.action = "/web_portfolio/join.do";
	     frm.method = "POST";
	     frm.submit();
		
	}
 	function init(){
		var msg = '${msg}';
		if(msg != ''){ 
			alert(msg);
		}
	}
    
	
	
</script>
</head>
<body onload = "init()">
	<!-- 디자인 출처 : http://www.blueb.co.kr/?c=2/34&where=subject%7Ctag&keyword=%EB%A1%9C%EA%B7%B8%EC%9D%B8&uid=4050 -->
	<!-- Form-->
	<div class="form">
		<div class="form-toggle"></div>
		<div class="form-panel one">
			<div class="form-header">
				<h1>Account Login</h1>
				${msg}
			</div>
			<!-- 로그인 -->
			<div class="form-content">
				<form name = "loginForm">
					<div class="form-group">
						<label for="username">User Id</label> <input type="text"
							id="userId" name = "userId" required="required" />
					</div>
					<div class="form-group">
						<label for="password">Password</label> <input type="password"
							id="userPw" name = "userPw" required="required" />
					</div>
					<div class="form-group">
						<label class="form-remember"> <input type="checkbox" />Remember
							Me
						</label> <a href="#" class="form-recovery">Forgot Password?</a>
					</div>
					<div class="form-group">
						<button type="button" onclick="dologin()">Log In</button>
					</div>
				</form>
			</div>
		</div>

		<!-- 회원가입 -->
		<div class="form-panel two">
			<div class="form-header">
				<h1>Register Account</h1>
			</div>
			<div class="form-content">
				<form name="joinForm">
					<div class="form-group">
						<label for="username">User Id</label> <input type="text"
							name="userId" id="j_userId" required="required" />
					</div>
					<div class="form-group">
						<label for="password">Password</label> <input type="password"
						name="userPw"	id="j_userPw" required="required" />
					</div>
					<div class="form-group">
						<label for="cpassword">Confirm Password</label> <input
							type="password" id="j_cUserPw" required="required" />
					</div>
					<div class="form-group">
						<label for="username">User Name</label> <input type="text"
						name="userName"	id="j_userName" required="required" />
					</div>
					<div class="form-group">
						<label for="nickname">Nickname</label> <input type="text"
						name="nickName"	id="j_nickname" required="required" />
					</div>
					<div class="form-group">
						<button type="button" onclick="dojoin()">Register</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
