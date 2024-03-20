<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js" integrity="sha512-rstIgDs0xPgmG6RX1Aba4KV5cWJbAMcvRCVmglpam9SoHZiUCyQVDdH2LPlxoHtrv17XWblE/V/PP+Tr04hbtA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript" src="/resources/js/icia.common.js"></script>
<script type="text/javascript" src="/resources/js/icia.ajax.js"></script>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
   .form-signin {
     max-width: 700px;
     padding: 200px;
     margin: 0 auto;
   }
   .form-signin .form-signin-heading,
   .form-signin .checkbox {
     margin-bottom: 10px;
   }
   .form-signin .checkbox {
     font-weight: 400;
   }
   .form-signin .form-control {
     position: relative;
     -webkit-box-sizing: border-box;
     -moz-box-sizing: border-box;
     box-sizing: border-box;
     height: auto;
     padding: 10px;
     font-size: 20px;
   }
   .form-signin .form-control:focus {
     z-index: 2;
   }
   .form-signin input[type="text"] {
     margin-bottom: 5px;
     border-bottom-right-radius: 0;
     border-bottom-left-radius: 0;
   }
   .form-signin input[type="password"] {
     margin-bottom: 10px;
     border-top-left-radius: 0;
     border-top-right-radius: 0;
   }
</style>

<script>

$(document).ready(function(){

    $("#userId").on("focus input", function() {
	    	
	    if($.trim($("#userId").val()) <= 0){
			document.getElementById('id_check').innerHTML = "아이디를 입력하세요.";
			return;
	    }else{
			document.getElementById('id_check').innerHTML = "";
	
	    }
    
    });

    $("#userPwd").on("focus input", function() {
	    if($.trim($("#userPwd").val()) <= 0){
			document.getElementById('pwd_check').innerHTML = "비밀번호를 입력하세요.";
			return;
	    }else{
			document.getElementById('pwd_check').innerHTML = "";
	
	    }
    	
    	
    
    });
   



	$("#btnLogin").on("click",function(){
		fn_loginCheck();
	});
	$("#btnReg").on("click",function(){
		location.href="/user/join";
	});
	$("#findId").on("click",function(){
		location.href = "/user/findId";
	});
	$("#findPwd").on("click",function(){
		location.href = "/user/findPwd";
	});

});

function fn_loginCheck(){
if($.trim($("#userId").val()).length <= 0){
	alert("아이디를 입력하세요.");
	$("#userId").val("");
	$("#userId").focus();
	return;
}
if($.trim($("#userPwd").val()).length <= 0){
	alert("비밀번호를 입력하세요.");
	$("#userPwd").val("");
	$("#userPwd").focus();
	return;
}

// 아이디 비번 모두 들어왔을때
$.ajax({
	type:"POST",
	url:"/user/login", 
	// @RequestMapping(value="/user/login", method=RequestMethod.POST)  //POST방식으로 넘어오는 것만 한다 // 이 매핑정보로 간다. 컨트롤러를 불러서 M: service dao xml( d, x가 마이바티스) v: jsp c: controller // 이제 서비스 호출
	//@ResponseBody
	//public Response<Object> login(HttpServletRequest request, HttpServletResponse response){ 를 찾는것
	data:{
		userId:$("#userId").val(),
		userPwd:$("#userPwd").val()
	},
	datatype:"JSON",
	beforeSend:function(xhr){
		xhr.setRequestHeader("AJAX","true");
	},
	success:function(response){
		if(!icia.common.isEmpty(response)){ //브라우저에서 head.jsp에서 돌아감 (StringUtil은 자바 백엔드에서 돌아가는것)
			icia.common.log(response);
			var code = icia.common.objectValue(response,"code",-500); //code가 즉 flag
			if(code == 0){
				location.href="/";
				alert("로그인 성공");
			}else{
		 		if(code == -1){
					alert("비밀번호가 올바르지 않습니다.");
					$("#userPwd").focus();
				}else if(code == -99){
					alert("정지된 사용자 입니다.");
					$("#userId").focus();
				}else if(code == 404){
					alert("아이디와 일치하는 사용자 정보가 없습니다.");
					$("#userId").focus();
				}else if(code == 400){
					alert("파라미터 값이 올바르지 않습니다.");
					$("#userId").focus();
				}else{
					alert("오류가 발생하였습니다.");
					$("#userId").focus();
				}
			}
			
		}else{
			alert("오류가 발생하였습니다.");
			$("#userId").focus();
		}
	},
	complite:function(data){
		//응답이 종료되면 실행, 잘 사용하지 않는다.
		icia.common.log(data);
	},
	error:function(xhr, status, error){
		icia.common.error(error);
	}
});
}



</script>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">로그인</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="container" style="padding-top: 10px; margin-top: 10px">
      <form name="loginForm" id="loginForm" method="post" action="/user/loginProc.jsp" class="form-signin" style="padding-top: 10px; margin-top: 10px">
         <!--  <br/>
          <h2 class="form-signin-heading m-b3" align="center" style="color:#554838"><b>로그인</b></h2><br/>-->
         <label for="userId" style="font-size: 20px; color:#554838;"><b>아이디</b></label>
         <input type="text" id="userId" name="userId" class="form-control" maxlength="20" placeholder="아이디" value="">
         <p class="check_font" id="id_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
         <label for="userPwd" style="font-size: 20px; color:#554838;"><b>비밀번호</b></label>
         <input type="password" id="userPwd" name="userPwd" class="form-control" maxlength="20" placeholder="비밀번호">
         <p class="check_font" id="pwd_check" style="color:#fd8505; font-size: 13px; margin-top: 0px"></p>
         <div align="center">
              <a id="findId" style="font-size: 16px; text-decoration:none; color:#554838" >아이디 찾기</a>
              <span style="color: #554838; font-size: 16px;">/</span>
              <a id="findPwd" style="font-size: 16px; text-decoration:none; color:#554838">비밀번호 찾기</a>
           </div><br/>  
           <div class="d-grid gap-2 col-12 mx-auto">
              <a id="btnLogin" style="background-color: #FFCC80; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>로그인</b></a>
              <a id="btnReg" style="background-color: #FFCC80 ; color: #554838; font-size: 20px; text-align: center" class="cart-btn"><b>회원가입</b></a>
          </div>
      </form>
   </div>
</body>
</html>