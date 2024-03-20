<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>	
<style type="text/css">
	.excerpt {
        display: block;
        font-size: 14px;
        font-weight: bolder !important;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        line-height: 1.2;
/*        height: 4.8em;*/
        text-align: left;
        word-wrap: break-word;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
	}
	
	.img {
	    width:350px;
	    height:200px;
	    overflow:hidden;
	    margin:0 auto;
	}

	#author {
		font-size : 15px;
	}
	
	#date {
		font-size : 15px;
	}
	
	#title {
        display: block;
        font-weight: bolder !important;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        line-height: 1.2;
/*        height: 4.8em;*/
        text-align: left;
        word-wrap: break-word;
        display: -webkit-box;
        -webkit-line-clamp: 1 ;
        -webkit-box-orient: vertical;
	}
	
	#news {
		width: 350px; height: 500px
	}
	
	.select {
  width: 150px;
  height: 30px;
  background: url('https://freepikpsd.com/media/2019/10/down-arrow-icon-png-7-Transparent-Images.png') calc(100% - 5px) center no-repeat;
  background-size: 20px;
  padding: 5px 30px 5px 10px;
  border-radius: 4px;
  outline: 0 none;
}
.select option {
  background: black;
  color: #fff;
  padding: 3px 0;
}

 .btn55{
  background-color: #bccc80;
  color: #051922;
  font-weight: 700;
  text-transform: uppercase;
  font-size: 15px;
  border: none !important;
  cursor: pointer;
  padding: 4px 20px;
  border-radius: 8px;
}


    .word {
        margin:100px;
        outline: 1px solid black;
        display: block;
        color: black;
        width: 630px;
        font-size: 20px;
        font-weight: bolder !important;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
}
	
</style>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js" ></script>
<script type="text/javascript">
$(document).ready(function(){
	
	   $("#_reviewFilter1").on("click", function() {
		   document.bbsForm.reviewFilter.value=$("#_reviewFilter1").val();
		   document.bbsForm.action="/review/reviewList";
		   document.bbsForm.submit();

	   });
	   $("#_reviewFilter2").on("click", function() {
		   document.bbsForm.reviewFilter.value=$("#_reviewFilter2").val();
		   document.bbsForm.action="/review/reviewList";
		   document.bbsForm.submit();

	   });
	   $("#_reviewFilter3").on("click", function() {
		   document.bbsForm.reviewFilter.value=$("#_reviewFilter3").val();
		   document.bbsForm.action="/review/reviewList";
		   document.bbsForm.submit();

	   });
	   
	   $("#btnSearch").on("click", function() {
			  document.bbsForm.reviewSeq.value="";
			  document.bbsForm.searchType.value=$("#_searchType").val();
			  document.bbsForm.searchValue.value=$("#_searchValue").val();
			  document.bbsForm.curPage.value = "1";
			  document.bbsForm.action = "/review/reviewList";
			  document.bbsForm.submit();
		   });

	
});
function fn_view(reviewSeq){
	document.bbsForm.reviewSeq.value=reviewSeq;
	document.bbsForm.action="/review/reviewView";
	document.bbsForm.submit();
}

function fn_list(curPage){
	document.bbsForm.reviewSeq.value = "";
	document.bbsForm.curPage.value = curPage;
	document.bbsForm.action="/review/reviewList";
	document.bbsForm.submit();
}


</script>


</head>
<body>
<%@ include file="/WEB-INF/views/include/navigation.jsp" %>	
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg" style="height:80px" >
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						<h1 id="font" style="color: #554838; font-size: 50px">봉사후기</h1>
					</div>
				</div>
			</div>
		</div>
	</div><br />
	

	<div style="float:right;width:35%;">
	<select class="select" name="_searchType" id="_searchType" >
		<option value="">조회 항목</option>
		<option value="1" <c:if test='${searchType eq "1"}'>selected</c:if>>작성자</option>
		<option value="2" <c:if test='${searchType eq "2"}'>selected</c:if>>제목</option>
		<option value="3" <c:if test='${searchType eq "3"}'>selected</c:if> >내용</option>
	</select>
	<input type="text" name="_searchValue" id="_searchValue" value="${searchValue}" />
	<input type="button" name="btnSearch" id="btnSearch" class="btn55" value="조회" style="background-color:#FFCC80"></button>
	</div>
	
	<!-- end breadcrumb section -->
	<!-- latest news -->
	<div class="latest-news mt-150 mb-150" style="margin-top: 50px" >
		<div class="container">
			<div class="row">
                <div class="col-md-12">
                    <div class="product-filters">
                        <ul>
                        
                            <li onclick="" id="_reviewFilter1" name="_reviewFilter1" value="1" <c:if test='${reviewFilter eq "1" or ""}'>class="active"</c:if>>최신순</li>
                            <li onclick="" id="_reviewFilter2" name="_reviewFilter2" value="2" <c:if test='${reviewFilter eq "2"}'>class="active"</c:if>>조회순</li>
                            <li onclick="" id="_reviewFilter3" name="_reviewFilter3" value="3" <c:if test='${reviewFilter eq "3"}'>class="active"</c:if>>추천순</li>
                        
                        </ul>
                    </div>
                </div>
            </div>
			<div class="row">

				
	<c:if test="${!empty list}">
		<c:forEach var="review" items="${list}" varStatus = "status">
				<div class="col-lg-4 col-md-6">
					<div class="single-latest-news" id="news">
						<div class="latest-news-bg" >
						<c:if test="${!empty fileList}">
							<c:forEach var="reviewFile" items="${fileList}" varStatus="status">
								<c:if test='${reviewFile.reviewSeq eq review.reviewSeq}'>
								
									<img class="img" src="/resources/upload/review/${reviewFile.fileName}"/>
									
								</c:if>
							</c:forEach>
						</c:if>
						</div>
						<div class="news-text-box">
							<h3 id="title"><a onclick="fn_view(${review.reviewSeq})">${review.reviewTitle}</a></h3>
							<p class="blog-meta">
								<span class="author" id="author"><i class="fas fa-user"></i>${review.userName}</span>
								<span class="date" id="date"><i class="fas fa-calendar"></i>${review.regdate}</span>
						 	</p>
							<p id="excerpt" class="excerpt">${review.reviewContent}</p>
							<div>
								<div align="left" style="font-size: 16px">
									<i class="bi bi-suit-heart-fill"></i>&nbsp;${review.reviewLikeCnt}&nbsp; 
									<i class="bi bi-eye-fill"></i>&nbsp;${review.reviewReadCnt}
								</div>
							</div>
							
							<a onclick="fn_view(${review.reviewSeq})" class="read-more-btn">  자세히 <i class="fas fa-angle-right"></i></a>
						</div>
					</div>
				</div>
		</c:forEach>
	</c:if>

			</div>
	<c:if test="${!empty paging}">
			<div class="row">
				<div class="container">
					<div class="row">
						<div class="col-lg-12 text-center">
							<div class="pagination-wrap">
								<ul>
						<c:if test="${paging.prevBlockPage gt 0 }"><!-- 0보다 크다는 것 -->
									<li><a   onclick="fn_list(${paging.prevBlockPage})">Prev</a></li>
						</c:if>
						<c:forEach var = "i" begin="${paging.startPage}" end="${paging.endPage}">
						<c:choose>
						<c:when test="${i ne curPage}">
									<li><a href="javascript:void(0)" onclick="fn_list(${i})">${i}</a></li>
						</c:when>
						<c:otherwise>
									<li><a href="javascript:void(0)" style="cursor:default;">${i}</a></li>
						</c:otherwise>
						</c:choose>
						</c:forEach>
						
						<c:if test="${paging.nextBlockPage gt 0}">
									<li><a  onclick="fn_list(${paging.nextBlockPage})">Next</a></li>
						</c:if>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
	</c:if>
		</div>
	</div>
	
	<form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
		<input type="hidden" name="searchType" id="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" id="searchValue" value="${searchValue}" />
		<input type="hidden" name="reviewSeq" id="reviewSeq" value="" />
		<input type="hidden" name="reviewFilter" id="reviewFilter" value="${reviewFilter}" />
	</form>
</body>
</html>