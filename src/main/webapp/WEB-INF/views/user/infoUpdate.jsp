<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$("#userId").keyup(function(){
		var userId = $("#userId").val();
		 $.ajax({
		        url : "/user/idCheck",
		        type:"POST",
		        data : {userId : userId},
		        datatype:"JSON",
				beforeSend:function(xhr){
					xhr.setRequestHeader("AJAX","true");
				},
				success:function(response){
					if(response.code == 100){
						document.getElementById('id_check').innerHTML = "중복된 아이디입니다.";
						return; 
						
					}else{
						document.getElementById('id_check').innerHTML = "";
						return; 
					}
				},
				error:function(xhr,status,error){
					icia.common.error(error);
				}
		    });//ajax
	});
	
	
	var test="";
	
	//mail인증하기 버튼 클릭 
	$("#emailChk").on("click",function(e){
		if($.trim($("#userEmail").val()).length > 0 ){
		    isMailAuthed=true;
		    $.ajax({
		        url : "/email/mailAuth.wow",
		        data : {mail : $("#userEmail").val()},
		        success: function(data){
		           alert("인증메일이 발송 되었습니다.");
		           test=data;
		        },
		        error : function(req,status,err){
		            console.log(req);
		        }
		    });//ajax
	    }else{
	    	alert("이메일을 입력하세요.");
	    	$("#userEmail").focus();
	    }
	    
	});//mailCheck
	
	//mail인증번호 확인 버튼 클릭 
	$("#emailChk2").on("click",function(){
		if($.trim($("#userEmail2").val())== test){
			alert("메일 인증 성공");			
			$("#userPhone").focus();
		}else{
			alert("인증번호가 틀렸습니다. ");			
			$("#userEmail2").focus();
		}
	});//mailCheck
	
	

});


function fn_userReg()
{ 
	$("#userPwd").val($("#userPwd1").val());
   $.ajax({
	   type:"POST",
	   url:"/user/updateProc",
	   data: {
		 userId:$("#userId").val(),
		 userPwd:$("#userPwd").val(),
		 userPhone:$("#userPhone").val(),
		 userName:$("#userName").val(),
		 userEmail:$("#userEmail").val(),
		 userZipcode:$("#zipCode").val(),
		 userAddr1:$("#addr1").val(),
		 userAddr2:$("#addr2").val()
	   },
	   datatype:"JSON",
	   beforeSend:function(xhr){
		 xhr.setRequestHeader("AJAX","true");
	   },
	   success:function(response){
		   if(response.code==0){
 			  alert("회원 정보가 수정되었습니다.");
 			  location.href="/user/myPage";
 		  }else if(response.code==400){
 			  alert("파라미터 값이 올바르지 않습니다.");
 			  $("#userPwd1").focus();
 		  }else if(response.code==404){
 			  alert("=존재하지 않는 회원입니다.");
 			  location.href="/"; //이 경우 controller에서 쿠키 날렸으니까 
 		  }else if(response.code==410){
 			  alert("로그인을 먼저 하세요.");
 			  location.href="/user/login";//쿠키가 없으니 
 		  }else if(response.code==430){
 			  alert("로그인한 아이디와 정보가 다릅니다.");
 			  location.href="/";
 		  }else if(response.code=500){
 			  alert("수정중 오류가 발생했습니다.");
 			  $("#userPwd1").focus();
 		  }else{
 			  alert("회원정보 수정 중 알수없는 오류가 발생했습니다.");
 			  $("#userPwd1").focus();
 		  }
	   },
	   error:function(xhr,status,error){
			icia.common.error(error);
		}

   });
}


</script>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
.error {
    display: block;
    color: #fd8505;
    border-color: #fd8505;
    font-size: 14px;
}

</style>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">회원 정보 수정</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!--  
   <br/>
   <h2 class="" style="padding-top: 200px; color:#554838" align="center"><b>회원가입</b></h2>
   -->
   <br/>
   <div class="container" style="font-size: 20px;"> 
      <div class="form-join" style="font-size: 20px;"> 
         <form id="regForm" name="regForm" action="#" method="post" novalidate class="sendForm"> 
        
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>회원구분</b></label>
               </div>
               <div class="col-sm-4">
               		<c:if test="${user.userFlag eq 'U'}">
						일반회원
					</c:if>
					<c:if test="${user.userFlag eq 'G'}">
						기업회원
					</c:if>
               
               </div>
            </div>
         
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label for="userId" style="color:#554838"><b>아이디</b></label>
               </div>
               <div class="col-sm-4"> 
                  ${user.userId}
               </div>
            </div>

            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>비밀번호</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="password" class="form-control" name="userPwd1" id="userPwd1" placeholder="4 ~ 20자의 영문, 숫자만 사용가능" style="font-size: 20px;" >
               </div>
            </div>
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>비밀번호확인</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="password" class="form-control" name="userPwd2" id="userPwd2" style="font-size: 20px;" >
               </div>
            </div>
                  
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>이름</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" class="form-control" name="userName" id="userName" value="" style="font-size: 20px;" >
               </div>
            </div>        
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>이메일</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="email" class="form-control" name="userEmail" id="userEmail" value="" placeholder="(ex)email@gibong.com" style="font-size: 20px;" >
               </div>
               <div class="col-sm-1-1">
                  <a id="emailChk" style="width:53pt;background-color: #FFB74D; color: #554838; font-size: 13px" class="cart-btn"><b>전송</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div> 
              
            
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>이메일인증</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="text" class="form-control" name="userEmail2" id="userEmail2" value="" placeholder="" style="font-size: 20px;">
               </div>
               <div class="col-sm-1-1">
                  <a id="emailChk2"style="width:53pt;background-color: #FFB74D; color: #554838; font-size: 13px" class="cart-btn"><b>인증</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div>  
            
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>휴대전화</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" class="form-control" name="userPhone" id="userPhone" value="" placeholder="'-'빼고 숫자만 입력" style="font-size: 20px;" >
               </div>
            </div>
            
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>우편번호</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="text" id="zipCode" name="zipCode" class="form-control" value="" style="font-size: 20px;">
               </div>
               <div class="col-sm-1-1">
                  <a onclick="sample6_execDaumPostcode()" style="width:53pt;background-color: #FFB74D; color: #554838; font-size: 13px" class="cart-btn"><b>검색</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div>   
            
            <div class="form-join d-flex justify-content-center" >
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>주소</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" id="addr1" name="addr1" class="form-control" value="" style="font-size: 20px;">
               </div>   
            </div>
               
            <div class="form-join d-flex justify-content-center"> 
               <div class="col-sm-2 control-label">
                  <label style="color:#554838"><b>상세주소</b></label>
               </div>
               <div class="col-sm-4"> 
                  <input type="text" id="addr2" name="addr2" class="form-control" value="" style="font-size: 20px;">
               </div>
            </div>
                   
            <div class="text-center">
                 <input name="agree1" id="agree1" type="checkbox" class="form-check-input" >
                 <label class="agree1">
                     <a style="color:#554838">이용약관 동의(필수)</a>
                 </label><br/>
                 <input name="agree2" id="agree2" type="checkbox" class="form-check-input"  >
                 <label class="agree2">
                     <a style="color:#554838">개인정보 수집∙이용 동의(필수)</a>
                 </label>
      
            </div>
            <input type="hidden" id="userId" name="userId" value="${user.userId}" />
            <input type="hidden" id="userPwd" name="userPwd" value="" /><br/>
            <div class="col-sm-12 text-center" >
            <input class="cart-btn" id="submitCheck" type="submit" value="수정" style="font-size: 20px;padding:1.6%;">
               &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               <a href="/user/myPage" style="background-color: #FFCC80; color: #554838; font-size: 20px" class="cart-btn"><b>취소</b></a>
            </div>
            
         </form>  
      </div>
   </div>
<script src="/resources/js/validate/jquery.validate.js"></script>
<script src="/resources/js/validate/additional-methods.js"></script>
<script type="text/javascript" src="/resources/js/validate/localization/messages_ko.min.js"></script>
<script>
$.validator.addMethod("regex", function(value, element, regexpr) { 
	return regexpr.test(value);}, "");
	$(".sendForm").validate({
		rules:{

			userId:{
				required: true,
				regex: /^[a-zA-Z0-9]{4,12}$/
			},
			userPwd1:{
				required: true,
				regex: /^[a-zA-Z0-9]{4,12}$/
			},
			userPwd2:{
				required: true,
				equalTo: userPwd1
			},
			userName:{
				required: true,
				minlength:2
			},
			userEmail:{
				required:true,
				email:true
			},
			userEmail2:{
				required:true
			},
			userPhone:{
				required: true,
				regex: /^01(0|1|[6-9])[0-9]{3,4}[0-9]{4}$/
			},
			zipCode:{
				required: true,
				digits: true  
			},
			addr1:{
				required: true
			},
			addr2:{
				required: true
			},
			agree1:{
				required: true
			},
			agree2:{
				required: true
			}
		},
		messages:{

			userId:{
				required:'아이디는 필수입니다.',
				regex:'4~12자의 영문 대소문자와 숫자로만 입력하세요.'
			},
			userPwd1:{
				required:'비밀번호는 필수입니다.',
				regex:'4~12자의 영문 대소문자와 숫자로만 입력하세요.'
			},
			userPwd2:{
				required: '비밀번호 확인을 입력하세요.',
				equalTo: '동일한 비밀번호를 입력하세요.'
			},
			userName:{
				required: '이름은 필수입니다.',
				minlength:'최소 2글자 이상 입력하세요.'
			},
			userEmail:{
				required:'이메일은 필수입니다.',
				email:'이메일 형식이 옳지 않습니다.'
			},
			userEmail2:{
				required:'이메일 인증번호를 입력하세요.'
			},
			userPhone:{
				required: '전화번호는 필수입니다.',
				regex: '전화번호 형식이 옳지 않습니다.'
			},
			zipCode:{
				required: '우편번호를 검색하세요.',
				digits: '올바른 우편번호를 입력하세요.'  
			},
			addr1:{
				required: '주소를 검색하세요.'
			},

			addr2:{
				required: '상세주소는 필수입니다.'
			},
			agree1:{
				required: '필수 체크 항목입니다.'
			},
			agree2:{
				required: '필수 체크 항목입니다.'
			}
		},
	     submitHandler: function(form) {
	    	  fn_userReg();
	       }
	});

	
</script>
<input type="hidden" id="sample6_postcode" placeholder="우편번호">
<input type="hidden" id="sample6_address" placeholder="주소"><br>
<input type="hidden" id="sample6_detailAddress" placeholder="상세주소">
<input type="hidden" id="sample6_extraAddress" placeholder="참고항목">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipCode').value = data.zonecode;
                document.getElementById("addr1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addr2").focus();
            }
        }).open();
    }
</script>
</body>
</html>