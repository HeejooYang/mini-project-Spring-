<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Responsive Bootstrap4 Shop Template, Created by Imran Hossain from https://imransdesign.com/">

	<!-- title -->
	<title>후원상세페이지</title>

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
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>
input[type="submit"] {
  -webkit-transition: 0.3s;
  -o-transition: 0.3s;
  transition: 0.3s;
  border-radius: 50px !important;
  background-color:#f4a0a0;
  color:#fff;
}
input[type="submit"]:hover {
  background-color: #ff6e6e;
  color: #fff;
}
.breadcrumb-text p {
  font-size: 20px;
}
.breadcrumb-text h1 {
  font-size: 40px;

}

</style>


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
	
	

	<!-- search area -->
	<div class="search-area">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<span class="close-btn"><i class="fas fa-window-close"></i></span>
					<div class="search-bar">
						<div class="search-bar-tablecell">
							<h3>Search For:</h3>
							<input type="text" placeholder="Keywords">
							<button type="submit">Search <i class="fas fa-search"></i></button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end search arewa -->
	
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						<p>후원하기</p>
						<h1>${donate.donateTitle}</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->
	
	<!-- single article section -->
	<div class="mt-150 mb-150">
		<div class="container">
			<div class="row">
				<div class="col-lg-8">
					<div class="single-article-section">
						<div class="single-article-text">
							<div class="single-artcile-bg" ><img src="/resources/upload/donate/${donateFile.fileOrgName}"></div>
							<p class="blog-meta">
								<span class="date"><i class="fas fa-calendar"></i>${donate.regdate}</span>
							</p>
							<pre style="font-size:16px;"><b>${donate.donateContent}</b></pre>
						</div>

					</div>
				</div>

	<!-- 기봉 후원 금액 버튼 html 시작-->
				<div class="col-lg-4">
					<div class="sidebar-section"><br/>
						<div class="cart-buttons">
								<a href="#" class="boxed-btn4" ><b>정기후원</b></a>
								<a href="#" class="boxed-btn4 black"><b>일시후원</b></a>
						</div>
						<div class="vote_tab_contbx">
							<ul class="no_dot" >
								<li class="step1 active">
									<!-- <form id="pay-frm1" action="https://with.oxfam.or.kr/oxfam/pay/step1_direct?" target="_blank"> -->
									<input type="hidden" style="display:none;" name="dontype" value="P10101">
									<input type="hidden" style="display:none;" name="period" value="pledge">
									<input type="hidden" style="display:none;" name="price" value="30000"><!--밑에 선택하는 대로 value값 설정 -->
									<h5>후원금 선택</h5>
									<div class="price-buttons">
										<a class="boxed-btn3">50000</a>
										<a class="boxed-btn3">30000</a>
										<a class="boxed-btn3">20000</a>
									</div>
									<br/>
									<p>
										<input type="text"  placeholder="후원금액 직접입력" style="width:85%">
									</p>
									<br/>
										<a href="/donate/donatePay" class="boxed-btn4" style="background-color: #f4a0a0;color:#fff;  -webkit-transition: 0.3s;
  -o-transition: 0.3s;
  transition: 0.3s;
  border-radius: 50px !important;width:270px;"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;후원하기</b></a>
									
 
									<br/><br/>
									<p style="width:87%"><img src="/resources/images/free-icon-padlock-159069.png" width="15"> 후원을 위해 제공해주신 개인정보는 맨발의기봉이의 <a href="/privacy-policy/" class="color" target="_blank">개인정보처리방침</a>에 따라 안전하게 보호됩니다.</p>
									
								</li>
							</ul>
						</div>
					</div>
				</div>
	<!-- 기봉 후원 금액 버튼 html 끝 -->
			</div>
		</div>
	</div>
	<!-- end single article section -->
	<br/><br/>

</body>
</html>