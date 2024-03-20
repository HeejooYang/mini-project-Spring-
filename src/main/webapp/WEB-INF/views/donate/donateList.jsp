<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style>

p.product-price span {
  display: block;
  opacity: 0.8;
  font-size: 15px;
  font-weight: 400;
  width: 300px; 
  height: 50px;
  color: #000;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: normal;
  word-wrap: break-word;
  display: -webkit-box;
  -webkit-line-clamp: 2 ;
  -webkit-box-orient: vertical;
}
.single-product-item h3 {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 10px;
  color: #000;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: normal;
  word-wrap: break-word;
  display: -webkit-box;
  -webkit-line-clamp: 1 ;
  -webkit-box-orient: vertical;
}

</style>
<script>
function fn_view(donateSeq){
	document.bbsForm.donateSeq.value=donateSeq;
	document.bbsForm.action="/donate/donateView";
	document.bbsForm.submit();
}

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
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
                  <h1>후원</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->

   <!-- products -->
   <div class="product-section mt-150 mb-150">
      <div class="container">

         <div class="row">
                <div class="col-md-12">
                    <div class="product-filters">
                        <ul>
                            <li class="active" data-filter="*">All</li>
                            <li data-filter=".정기후원">일시후원</li>
                            <li data-filter=".일시후원">정기후원</li>
                        </ul>
                    </div>
                </div>
            </div>

         <div class="row product-lists">
    <c:if test="${!empty list}">
		<c:forEach var="donate" items="${list}" varStatus = "status">
            <div class="col-lg-4 col-md-6 text-center 정기후원">
               <div class="single-product-item">
                  <div class="product-image">
                  		<c:if test="${!empty fileList}">
							<c:forEach var="donateFile" items="${fileList}" varStatus="status">
								<c:if test='${donateFile.donateSeq eq donate.donateSeq }'>
								<a onclick="fn_view(${donate.donateSeq})"><img src="/resources/upload/donate/${donateFile.fileOrgName}" alt=""></a>
								</c:if>
							</c:forEach>
						</c:if>
                  </div>
                  <h3>${donate.donateTitle}</h3>
                  <p class="product-price"><span>${donate.donateContent}</span></p>
                  <div class="progress">
                 <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                   <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="75" aria-valuemin="0" aria-valuemax="100" style="width: 50%"></div>
                   <!-- 다수의 프로그래스바 --><div class="progress-bar bg-info" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
              </div>
              <br/><span>후원금액 </span><br />
              <span>현재모금액/목표액 : ${donate.donateNowAmt}원 / ${donate.donateGoalAmt}원</span><br />
              <span>후원기간 ${donate.regdate} ~ </span><br /><br />
            <a onclick="fn_view(${donate.donateSeq})"  class="cart-btn"><span class="material-symbols-outlined">volunteer_activism</span></i>후원하러 가기</a>
               </div>
 
            
            </div>
        </c:forEach>
	</c:if>   
            
            
            
            
            
            
     <!-- 후원글작성       
            <div class="col-lg-4 col-md-6 text-center ">
               <div class="single-product-item">
                  <div class="product-image">
                  <br/><br/><br/>
                    <a href="/write" ><img src="/resources/assets/img/products/20.jpg" alt=""></a><br/>
                    <h3>후원모금을 시작해보세요.</h3><br /><br /><br/><br/><br/><br />
                  </div>
               </div>
            </div>
         </div>
     --> 
         
         
<!--  페이징
         <div class="row">
            <div class="col-lg-12 text-center">
               <div class="pagination-wrap">
                  <ul>
                     <li><a href="#">Prev</a></li>
                     <li><a href="#">1</a></li>
                     <li><a class="active" href="#">2</a></li>
                     <li><a href="#">3</a></li>
                     <li><a href="#">Next</a></li>
                  </ul>
               </div>
            </div>
         </div>
-->
      </div>
   </div>
   <!-- end products -->

  	<form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="donateSeq" id="donateSeq" value="" />
	</form>
   
   

</body>
</html>