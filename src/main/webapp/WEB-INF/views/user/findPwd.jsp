<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	var userPwd = "";
	
	$("#emailChk").on("click",function(e){

	$.ajax({
		   type:"POST",
		   url:"/user/findPwdNameEmail",
		   data: {
			 userId:$("#userId").val(),
			 userEmail:$("#userEmail").val()
		   },
		   datatype:"JSON",
		   beforeSend:function(xhr){
			 xhr.setRequestHeader("AJAX","true");
		   },
		   success:function(response){
				if(response.code==0){
					fn_email();
				}else if(response.code==100){
					alert("회원정보가 존재하지 않습니다.");
					$("#userId").focus();
				}else if(response.code==401){
					alert("아이디와 이메일을 입력하세요");
					$("#userId").focus();
				}else{
					alert("비밀번호 찾기 중 알수없는 오류가 발생했습니다.");
					$("#userId").focus();
				}
		   },
		   error:function(xhr,status,error){
				icia.common.error(error);
			}
	   });
	
	});//
	
	
	
	

	
	
});
function fn_email(){
	
	
	//mail인증하기 버튼 클릭 
	    isMailAuthed=true;

	    $.ajax({
	        url : "/email/mailPwd.wow",
	        data : {mail : $("#userEmail").val(),
	        		userId : $("#userId").val()},
	        success: function(data){
	           alert("임시 비밀번호가 이메일로 발송 되었습니다.");
	           userPwd=data;
	        },
	        error : function(req,status,err){
	            console.log(req);
	        }
	    });//ajax

}
function fn_imsiPwd(){
	
	
	
}


</script>





</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">비밀번호 찾기</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   </br></br>
   <div class="container">
   </br></br></br>
   <form name="findPwdForm" id="findPwdForm" class="form-signin" action="" method="POST">
                  <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838; font-size:18px;float:right;"><b>아이디</b></label>
               </div>
               <div class="col-sm-4">
                  <input type="text" class="form-control" name="userId" id="userId" value="" placeholder="아이디를 입력하세요." style="font-size: 20px;width:350px;">
               </div>
            </div>        
                   
            <div class="form-join d-flex justify-content-center">
               <div class="col-sm-2 control-label">
                  <label style="color:#554838;font-size:18px;float:right"><b>이메일</b></label>
               </div>
               <div class="col-sm-3">
                  <input type="email" class="form-control" name="userEmail" id="userEmail" value="" placeholder="이메일을 입력하세요." style="font-size: 20px; width:260px;">
               </div>
               <div class="col-sm-1-1">
               <a></a>
                  <a id="emailChk" name="emailChk" style="width:52pt;background-color: #FFB74D; color: #554838; font-size:13px;float:right" class="cart-btn"><b>전 송</b></a>
                  <!-- <input type="button" onclick="execDaumPostcode();" value="우편번호찾기" class="btn btn-purple"> -->
               </div>
            </div>   
      <br/><br/>
  
                <div class="col-sm-12 text-center"  >
               <a href="/user/login" style="background-color: #FFCC80; color: #554838; font-size: 20px" class="cart-btn"><b>로그인 페이지로 이동</b></a>
               </div>
   </form>
</div>
</body>
</html>