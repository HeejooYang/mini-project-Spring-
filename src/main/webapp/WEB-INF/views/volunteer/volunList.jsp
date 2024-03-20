<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/resources/assets/bootstrap/css/style.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.2/dist/tailwind.min.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<style type="text/css">
  body {
    font-family: 'Open+Sans', sans-serif;
  }

	a:hover {
	  color : pink;
	}
	a:visited {
  color : black;
}
</style>
<script>
function fn_view(volunSeq){
	document.bbsForm.volunSeq.value=volunSeq;
	document.bbsForm.action="/volunteer/volunView";
	document.bbsForm.submit();
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
<!-- 현재날짜 -->
<c:set var="today" value="<%=new java.util.Date()%>" />

<!-- breadcrumb-section -->
   <div class="breadcrumb-section breadcrumb-bg" style="height:80px">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 offset-lg-2 text-center">
               <div class="breadcrumb-text">
                  <h1 id="font" style="color: #554838; font-size: 50px">봉사활동</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <br/>
    <!-- Main Content -->
    <div class="container" >
      <div class="row">
          <div class="col-md-12">
              <div class="product-filters">
                  <ul>
                      <li class="active" data-filter="*">All</li>
                      <li data-filter=".">최신순</li>
                      <li data-filter=".">추천순</li>
                  </ul>
              </div>
          </div>
      </div>
      <div style="display: flex; justify-content: center;">
         <table class="table-auto " style="width:900px; justify-content: center;" >
           <tbody>
           <!--  
             <tr >
               <td class="align-center" style="width:300px; height:200px; margin-right:10px">
                 <img src="/resources/images/child.png" style="width:300px; height:170px;">
               </td>
               <td class="px-4" style="width:500px; height:200px; margin-right:10px">
                 <p style="font-size: 20px;" class="font-semibold"><a href="/volunteer/volunView">광주학습관 어린이집 봉사활동!</a></p>
                 <p class="text-sm text-gray-600" style="font-size: 15px">모집기간 : 2024.02.27 ~ 2019.04.09</p>
               </td>
               <td>
                 <button type="button" id="btnReply" style="float: right; background-color: #dede9e;margin-top:35px; padding:10%">모 집 중</button>
               </td>
             </tr>
             <tr>
               <td colspan="4" class="py-4">
                 <div class="border-t-2 border-gray-200"></div>
               </td>
             </tr>
             -->
             
     <c:if test="${!empty list}">
		<c:forEach var="volun" items="${list}" varStatus = "status">
             <tr>
               <td class="align-top">
               <c:if test="${!empty fileList}">
					<c:forEach var="volunFile" items="${fileList}" varStatus="status">
						<c:if test='${volunFile.volunSeq eq volun.volunSeq }'>
                 			<a onclick="fn_view(${volun.volunSeq})"><img src="/resources/upload/volun/${volunFile.fileOrgName}"  style="width:300px; height:170px;"></a>
                 		</c:if>
					</c:forEach>
			  </c:if>
               </td>
               <td class="px-4"   >
                 <p style="font-size: 20px;" class="font-semibold"><a onclick="fn_view(${volun.volunSeq})">${volun.volunTitle}</a></p>
                 <p class="text-sm text-gray-600" style="font-size: 15px">모집기간 : ${volun.regdate} ~ ${donate.expDate}</p>
               </td>
               <td>
               <fmt:parseDate var="_expDate" value="${volun.expDate}" pattern="yyyy.MM.dd"/>
               <fmt:formatDate var="expDate" type="date" value="${_expDate}" pattern="yyyy.MM.dd"/>
               <c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy.MM.dd" /></c:set> 
			  <c:choose>
               <c:when test="${expDate < date}">
               
                 <button type="button" id="btnReply" style="float: right; background-color: #d7ccc8; margin-top:35px; padding-right:20px;padding-left:20px;padding-top:10px;padding-bottom:10px;"><b>마 감</b></button>
               
               </c:when>
               <c:otherwise>
                 <button type="button" id="btnReply" style="float: right; background-color: #ffcc80; margin-top:35px; padding-right:20px;padding-left:20px;padding-top:10px;padding-bottom:10px;"><b>모집중</b></button>
               </c:otherwise>
              
               </c:choose>
               </td>
             </tr>
             <tr>
               <td colspan="4" class="py-4">
                 <div class="border-t-2 border-gray-200"></div>
               </td>
             </tr>
        </c:forEach>
      </c:if>     
             
             

           </tbody>
         </table>
      </div>
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
    </div>
    <br><br>
    
    <form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="volunSeq" id="volunSeq" value="" />
	</form>

</body>
</html>
</body>
</html>