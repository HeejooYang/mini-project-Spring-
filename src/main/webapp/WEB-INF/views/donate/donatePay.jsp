<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<!-- title -->
	<title>후원결제상세페이지</title>



	<!-- google font -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet">
	<!-- fontawesome -->
	<link rel="stylesheet" href="/resources/assets/css/all.min.css">
	<!-- bootstrap -->
	<link rel="stylesheet" href="/resources/assets/bootstrap/css/bootstrap.min.css">
	<!-- owl carousel -->
	<link rel="stylesheet" href="/resources/assets/css/owl.carousel.css">
	<!-- magnific popup -->
	<link rel="stylesheet" href="/resources/assets/css/magnific-popup.css">
	<!-- animate css -->
	<link rel="stylesheet" href="/resources/assets/css/animate.css">
	<!-- mean menu css -->
	<link rel="stylesheet" href="/resources/assets/css/meanmenu.min.css">
	<!-- main style -->
	<link rel="stylesheet" href="/resources/assets/css/main.css">
	<!-- responsive -->
	<link rel="stylesheet" href="/resources/assets/css/responsive.css">
	
<style>
.breadcrumb-text p {
  font-size: 20px;
}
a.boxed-btn4 {
  font-family: 'Poppins', sans-serif;
  display: inline-block;
  background-color: #FFCC80 ;
  color: #fff;
  padding: 10px 20px;

}
.center-align{
	align:center;
}

</style>

<%@ include file="/WEB-INF/views/include/head.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
    
   $("#btnPay").on("click", function() {

	   $("#btnPay").prop("disalbled", true);
	   
	   if($.trim($("#itemCode").val()).length <= 0){
		   alert("상품 코드를 입력하세요.");
		   $("#itemCode").val("");
		   $("#itemCode").focus();
		   
		   $("#btnPay").prop("disalbled", false);
		   return;

	   }
	   
	   if($.trim($("#itemName").val()).length <= 0){
		   alert("상품명을 입력하세요.");
		   $("#itemName").val("");
		   $("#itemName").focus();
		   
		   $("#btnPay").prop("disalbled", false);
		   return;
	   }
	   if($.trim($("#quantity").val()).length <= 0){
		   alert("수량을 입력하세요.");
		   $("#quantity").val("");
		   $("#quantity").focus();
		   
		   $("#btnPay").prop("disalbled", false);
		   return;
	   }
	   if(!icia.common.isNumber($("#quantity").val())){
		   alert("수량은 숫자만 입력 가능합니다.");
		   $("#quantity").val("");
		   $("#quantity").focus();
		   
		   $("#btnPay").prop("disalbled", false);
		   return;
	   }
	   if($.trim($("#totalAmount").val()).length <= 0){
		   alert("금액을 입력하세요.");
		   $("#totalAmount").val("");
		   $("#totalAmount").focus();
		   
		   $("#btnPay").prop("disalbled", false);
		   return;
	   }
	   if(!icia.common.isNumber($("#totalAmount").val())){
		   alert("금액은 숫자만 입력 가능합니다.");
		   $("#totalAmount").val("");
		   $("#totalAmount").focus();
		   
		   $("#btnPay").prop("disalbled", false);
		   return;
	   }
	   icia.ajax.post({//카카오페이 할거라고 보내면 큐알 보냄. 그럼 그 페이지를 받으면 그 다음 프로세스를 적용
		   url:"/kakao/payReady",
		   data:{
			   itemCode:$("#itemCode").val(),
			   itemName:$("#itemName").val(),
			   quantity:$("#quantity").val(),
			   totalAmount:$("#totalAmount").val()
		   },
		   success:function(response){
			   icia.common.log(response);
			   if(response.code == 0){
				   var orderId = response.data.orderId;
				   var tId = response.data.tId;
				   var pcUrl = response.data.pcUrl;
				   
				   $("#orderId").val(orderId);
				   $("#tId").val(tId);
				   $("#pcUrl").val(pcUrl);
				   
				   //윈도우 오픈(하나의 브라우저가 더 띄워 짐 유알앨이 하나도 없다는건 하얀 페이지에 보인다는 말. 이름이 kakaoPopUp (핸들링 하기 위한 이름) 그 뒤로는 옵션. 스크롤바는 있고, 사이즈조절 불가, 메뉴바 없고 등등)
				   var win = window.open('','kakaoPopUp','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=540,height=700,left=100,top=100');
				   
				   //띄워놓고 서브밋 서버 이름은 액션값인 /kakao/payPopUp 이게 컨트롤러에 요청되면 jsp를 리턴함. 그결과를 kakaoPopUp에 뿌림. 즉 해당 jsp를 윈도우 오픈 한거에 띄우라는 말. 순간적으로 먼저 만든 비어있는 페이지가 보일 수도 있ㅇㅁ
				   
				   $("#kakaoForm").submit();
				   
				   $("#btnPay").prop("disabled",false);

			   }else{
				   alert("오류가 발생하였습니다.");
				   $("#btnPay").prop("disabled",false);
			   }
		   },
		   error:function(error){
			   icia.common.error(error);
			   $("#btnPay").prop("disalbled", false);
		   },
	   });

   });
});

function movePage()
{
   location.href = "/donate/donateList"; //처리가 끝나고 결제 성공하면 이 함수로 리스트로 보낸다.
}




</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	
	<!--PreLoader-->
    <div class="loader">
        <div class="loader-inner">
            <div class="circle"></div>
        </div>
    </div>
    <!--PreLoader Ends-->
	

	
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg" style="margin: auto;">
		<div class="container">
			<div class="">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						
						<h1>후원금액 결제</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->

	<!-- 결제정보 시작 -->
	<div class="center-align mt-150 mb-150" >
		<div class="center-align">
			<div class="center-align">
				<div class="col-lg-8" style="margin: 0 auto; width:50%;">
					<div class="checkout-accordion-wrap">
						<div class="accordion" id="accordionExample">
						  <div class="card single-accordion">
						    <div class="card-header" id="headingOne">
						      <h5 class="mb-0">
						        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
						          후원자 정보 
						        </button>
						      </h5>
						    </div>
						
						    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
						      <div class="card-body">
						        <div class="billing-address-form">
						        	<form action="index.html">
						        		<p>아이디<input type="text" placeholder="test"></p>
						        		<p>이름<input type="text" placeholder="홍길동"></p>
						        		<p>이메일<input type="email" placeholder="neeioo0503@gmail.com"></p>
						        		<p>전화번호<input type="tel" placeholder="01099048010"></p>
						        		<p>남기고 싶은 말<textarea name="bill" id="bill" cols="30" rows="10" placeholder="후원하는 아동에게 남기고 싶은 말을 적어주세요"></textarea></p>
						        		<!-- 남기고 싶은 말 항목은 추후 DB칼럼 추가 필요해보임 -->
						        	</form>
						        </div>
						      </div>
						    </div>
						  </div>
						  <div class="card single-accordion">
						    <div class="card-header" id="headingTwo">
						      <h5 class="mb-0">
						        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						          후원 프로그램 정보
						        </button>
						      </h5>
						    </div>
						    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
						      <div class="card-body">
						        <div class="billing-address-form">
						        	<form action="index.html">
						        		<p>후원 항목<input type="text"  name="itemName" id="itemName" placeholder="후원하기" value="후원하기"></p><!-- 카카오 결제시 '상품명'파라미터로 적용(상품코드와 수량은 '1'로 적용 -->
						        		<p>후원 방식<input type="email" placeholder="정기 후원"></p><!-- 후원상세 페이지에서 선택한 값 적용 -->
						        		<p>총괄 기업명<input type="tel" placeholder="맨발의 기봉이"></p>
						        		
						        	</form>						        </div>
						      </div>
						    </div>
						  </div>
						  <div class="card single-accordion">
						    <div class="card-header" id="headingThree">
						      <h5 class="mb-0">
						        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
						          결제수단
						        </button>
						      </h5>
						    </div>
						    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionExample">
						      <div class="card-body">
						        <div class="card-details">
						        <input type="checkbox" name="카카오페이" style="accent-color: #FFB74D;" checked/>카카오페이&nbsp;
						        <input type="checkbox" name="카카오페이" style="accent-color: #FFB74D;"/>무통장입금
						        
						        	
						        </div>
						      </div>
						    </div>
						  </div>
						  <div class="card-header" id="headingThree">
						      <h5 class="mb-0">
						          결제 후원 금액 : 30000원 <!-- 카카오페이 결제 시 '금액' 파라미터 값으로 적용. 후원상세 페이지에서 선택한 값 적용 -->
						      </h5>
						    <input type="hidden" name="itemCode" id="itemCode" value="0123456789" />
						    <input type="hidden" name="totalAmount" id="totalAmount" value="30000" />
						    <input type="hidden" name="quantity" id="quantity"  value="1" />
						    
						      
						    </div>
						    <br/>
						    <div style=" float: right;">
						    <a id="btnPay"  class="boxed-btn" >결제진행</a>&nbsp;&nbsp;
						    <a href="/review/reviewList" class="boxed-btn" >결제취소</a>
						    </div>
						</div>

					</div>
				</div>

			</div>
		</div>
	</div>
	<br/><br/>
	<!-- 결제정보 끝 -->
   <form name="kakaoForm" id="kakaoForm" method="POST" target="kakaoPopUp" action="/kakao/payPopUp">
   		<input type="hidden" name="orderId" id="orderId" value="" />
   		<input type="hidden" name="tId" id="tId" value="" />
   		<input type="hidden" name="pcUrl" id="pcUrl" value="" />
   </form>
	

	
	
	<!-- jquery -->
	<script src="/resources/assets/js/jquery-1.11.3.min.js"></script>
	<!-- bootstrap -->
	<script src="/resources/assets/bootstrap/js/bootstrap.min.js"></script>
	<!-- count down -->
	<script src="/resources/assets/js/jquery.countdown.js"></script>
	<!-- isotope -->
	<script src="/resources/assets/js/jquery.isotope-3.0.6.min.js"></script>
	<!-- waypoints -->
	<script src="/resources/assets/js/waypoints.js"></script>
	<!-- owl carousel -->
	<script src="/resources/assets/js/owl.carousel.min.js"></script>
	<!-- magnific popup -->
	<script src="/resources/assets/js/jquery.magnific-popup.min.js"></script>
	<!-- mean menu -->
	<script src="/resources/assets/js/jquery.meanmenu.min.js"></script>
	<!-- sticker js -->
	<script src="/resources/assets/js/sticker.js"></script>
	<!-- main js -->
	<script src="/resources/assets/js/main.js"></script>

</body>
</html>