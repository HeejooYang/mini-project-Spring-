<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
.font {
	color: #554838;
	font-size: 20px;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	$("#btnReset").on("click",function(){
			if(confirm("탈퇴하시겠습니까?")){
				fn_userDelete();
			}
	});
});


function fn_userDelete(){
	var userId = $("#userId").val();
	$.ajax({
		type:"POST",
		url:"/user/userDeleteProc",
		data : {
			 userId:userId
		},
		datatype:"JSON",
		   beforeSend:function(xhr){
			 xhr.setRequestHeader("AJAX","true");
		   },
		   success:function(response){
				if(response.code==0){
					alert("회원 탈퇴가 정상적으로 처리 되었습니다.");
					location.href="/";
				}else if(response.code==410){
					alert("로그인을 먼저 하세요.");
					location.href="/user/login";
				}else if(response.code==430){
					alert("로그인한 아이디가 아닙니다. 다시 로그인 하세요");
					location.href="/user/login";
				}else if(response.code==400){
					alert("회원이 존재하지 않습니다.");
					location.href="/user/login";
				}else if(response.code==500){
					alert("회원 탈퇴중 오류가 발생했습니다.");
				}else{
					alert("회원 탈퇴중 알수없는 오류가 발생했습니다.");
				}
		   },
		   error:function(xhr,status,error){
				icia.common.error(error);
			}
	});
}



</script>



</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">회원정보수정</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
	<div class="container">
	<br>
		<div style="width:100%" align="center" class="font"> 
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="flag"><b>회원구분</b></label>
					</div>
					<div class="col-sm-2" style="font-size: 20px">
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
						<label><b>아이디</b></label>
					</div>
					<div class="col-sm-2"> 
						${user.userId}
					</div>
				</div>
			         
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="name"><b>이름</b></label>
					</div>
					<div class="col-sm-2">
						${user.userName}
					</div>
				</div>        
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="email"><b>이메일</b></label>
					</div>
					<div class="col-sm-2">
						${user.userEmail}
					</div>
				</div>   
			          
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="phone"><b>휴대전화</b></label>
					</div>
					<div class="col-sm-2">
						${user.userPhone}
					</div>
				</div>
				
				<div class="form-join d-flex justify-content-center">
					<div class="col-sm-2 control-label">
						<label id="postcode"><b>우편번호</b></label>
					</div>
					<div class="col-sm-2">
						${user.userZipcode}
					</div>
				</div>   
			   
				<div class="form-join d-flex justify-content-center" >
					<div class="col-sm-2 control-label">
						<label id="address"><b>주소</b></label>
					</div>
					<div class="">
						 ${user.userAddr1}
					</div>   
				</div>
			      
				<div class="form-join d-flex justify-content-center"> 
					<div class="col-sm-2 control-label">
						<label id="detailAddress"><b>상세주소</b></label>
					</div>
					<div class="col-sm-2"> 
						 ${user.userAddr2}
					</div>
				</div>
			    <br>      
				<input type="hidden" id="userId" name="userId" value="${user.userId}" /> 
				<div class="col-sm-12 text-center" >
					<button type="button" id="btnReg" class="btn btn-lg" onclick="location.href='/user/infoUpdate'" style="font-size: 20px;background-color:#FFB74D;">수정</button>&nbsp;&nbsp;
					<button type="button" id="btnReset" class="btn btn-lg" onclick="" style="font-size: 20px;background-color:#FFB74D;">탈퇴</button>
				</div><br>
		</div>
	</div>
	   

	
</body>
</html>

ml>