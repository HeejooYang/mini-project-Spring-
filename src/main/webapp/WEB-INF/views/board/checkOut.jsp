<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<!-- title -->
	<title>Check Out</title>

	<!-- favicon -->
	<link rel="shortcut icon" type="image/png" href="/resources/assets/img/favicon.png">
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

</style>

<%@ include file="/WEB-INF/views/include/head.jsp" %>

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
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						
						<h1>후원금액 결제</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->

	<!-- check out section -->
	<div class="checkout-section mt-150 mb-150" >
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
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
						        		<p><input type="text" placeholder="아이디"></p>
						        		<p><input type="text" placeholder="이름"></p>
						        		<p><input type="email" placeholder="이메일"></p>
						        		<p><input type="tel" placeholder="전화번호"></p>
						        		<p><textarea name="bill" id="bill" cols="30" rows="10" placeholder="남기고 싶은 말"></textarea></p>
						        	</form>
						        </div>
						      </div>
						    </div>
						  </div>
						  <div class="card single-accordion">
						    <div class="card-header" id="headingTwo">
						      <h5 class="mb-0">
						        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
						          후원 기업 정보
						        </button>
						      </h5>
						    </div>
						    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
						      <div class="card-body">
						        <div class="billing-address-form">
						        	<form action="index.html">
						        		<p><input type="text" placeholder="기업명"></p>
						        		<p><input type="email" placeholder="기업 이메일"></p>
						        		<p><input type="tel" placeholder="기업 전화번호"></p>
						        		
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
						        <input type="checkbox" name="카카오페이" checked/>카카오페이
						        
						        	
						        </div>
						      </div>
						    </div>
						  </div>
						  <div class="card-header" id="headingThree">
						      <h5 class="mb-0">
						          결제금액 : 50000원
						      </h5>
						    </div>
						    <br/>
						    <div>
						    <a href="#" class="boxed-btn" style="width:50%">결제하기</a>
						    </div>
						</div>

					</div>
				</div>

			</div>
		</div>
	</div>
	<br/><br/>
	<!-- end check out section -->

	

	
	
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