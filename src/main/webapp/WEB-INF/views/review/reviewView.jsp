<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<style>
		table {
		  border-collapse: collapse;
		  width: 100%;
		  background-color: white;
		}
		
		thead{
		  box-shadow: 4px 4px 10px rgba(0,0,0,0.1);
		}
		
		/* 테이블 행 */
		td {
		  padding: 5px;
		  text-align: left;
		  border-bottom: 1px solid #ddd;
		  text-align: center;
		}
		
		th {
			padding: 7px;
		}
		
		/* 테이블 비율 */
		th:nth-child(1),
		td:nth-child(1) {
		  width:20%;
		}
		
		th:nth-child(2),
		td:nth-child(2) {
		  width: 40%;
		}
		
		th:nth-child(3),
		td:nth-child(3) {
		  width: 90%;
		}
		
		th, td {
		  border-left: none;
		  border-right: none;
		}
		
		textarea, button {
			vertical-align: middle;
		}
		#btnUpload button[type="button"] {
  background-color: #FFCC80;
  color: #051922;
  font-weight: 700;
  text-transform: uppercase;
  font-size: 15px;
  border: none !important;
  cursor: pointer;
  padding: 15px 25px;
  border-radius: 3px;
}
#btnList button[type="button"] {
  background-color: #FFCC80;
  color: #051922;
  font-weight: 700;
  text-transform: uppercase;
  font-size: 15px;
  border: none !important;
  cursor: pointer;
  padding: 15px 25px;
  border-radius: 3px;
}
</style>
<script type="text/javascript">
		$(document).ready(function(){

			   $("#btnList").on("click", function() {
					document.bbsForm.action="/review/reviewList";
					document.bbsForm.submit();
					
			   });
			   $("#btnReply1").on("click",function(){  // 댓글
				   insertReply1();
			   });

			   
		<c:if test="${boardMe eq 'Y'}">
			   $("#btnUpdate").on("click", function() {
				    document.bbsForm.action = "/review/reviewUpdate";
					document.bbsForm.submit();
			   });

			   $("#btnDelete").on("click", function(){
					if(confirm("해당 게시물을 삭제 하시겠습니까?") == true){
						$.ajax({
							type:"POST",
							url:"/review/delete",
							data:{
								reviewSeq:<c:out value="${reviewSeq}" />
							},
							datatype:"JSON",
							beforeSend:function(xhr){
								xhr.setRequestHeader("AJAX","true");
							},
							success:function(response){
								if(response.code == 0){
									alert("게시물이 삭제 되었습니다.");
									location.href = "/review/reviewList";
									
								}else if(response.code == 200){
									alert("첨부파일이 삭제되지 않았습니다.");

								}else if(response.code == 400){
									alert("파라미터 값이 올바르지 않습니다.");

								}else if(response.code == 403){
									alert("본인글이 아니므로 삭제할 수 없습니다.");

									
								}else if(response.code == 404){
									alert("해당 게시글을 찾을 수 없습니다.");
									location.href = "/review/reviewList";

								}else{
									alert("게시물 삭제 시 오류가 발생하였습니다.");

								}
							},
							error:function(xhr,status,error){
								icia.common.error(error);
							}
						});
					}
					
			   });
		</c:if>
			
		});

		
		function fn_view(reviewSeq){
			document.bbsForm.reviewSeq.value=reviewSeq;
			document.bbsForm.action="/review/reviewView";
			document.bbsForm.submit();
		}	
		function insertReply1(){//댓글 등록
			$.ajax({
				url:"/review/replyInsert",
				data:{
					reviewReplyContent:$("#_reviewReplyContent").val(),
					reviewSeq:$("#reviewSeq").val()
				},
				type:"POST",
				success:function(result){
					if(result > 0){ 
						alert("댓글이 등록 되었습니다.");
						document.bbsForm.action="/review/reviewView";
						document.bbsForm.submit();
					}
				}
				
			});
		}
		function insertReply2(i){//대댓글 등록
			$.ajax({
				url:"/review/rerReplyInsert",
				data:{
					reviewReplyContent:$("#reviewReplyContent"+i).val(),
					reviewSeq:$("#reviewSeq").val(),
					reviewReplyGroup:$("#reviewReplyGroup"+i).val(),
					index:i
					
				},
				type:"POST",
				success:function(result){
					if(result > 0){ 
						alert("대댓글이 등록 되었습니다.");
						document.bbsForm.action="/review/reviewView";
						document.bbsForm.submit();
					}
				}
				
			});
		}
		function fnDel3(i){ // 댓글,대댓글 삭제
			$.ajax({
				url:"/review/replyDelete",
				data:{
					reviewReplySeq:$("#reviewReplySeq"+i).val(),
					index:i
					
				},
				type:"POST",
				success:function(result){
					if(result > 0){ 
						alert("대댓글이 삭제 되었습니다.");
						document.bbsForm.action="/review/reviewView";
						document.bbsForm.submit();
					}
				}
				
			});
		}
		
		
	    function fnReply2(i) {
	        var replyFormContainer = $("#replyFormContainer"+i);
	        if (replyFormContainer.is(":visible")) {
	            replyFormContainer.hide(); // 보이는 상태면 숨김
	        } else {
	            replyFormContainer.show(); // 숨겨진 상태면 보임
	        }
	    }
	</script>
</head>
<body>
	
	<!--PreLoader-->
    <div class="loader">
        <div class="loader-inner">
            <div class="circle"></div>
        </div>
    </div>
    <!--PreLoader Ends-->
    
	<%@ include file="/WEB-INF/views/include/navigation.jsp" %>
	<!-- breadcrumb-section -->
	<div class="breadcrumb-section breadcrumb-bg">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 offset-lg-2 text-center">
					<div class="breadcrumb-text">
						<p>기봉이와 함께했던 봉사 후기</p>
						<h1>${review.reviewTitle}</h1><!-- 글제목이 아니라 참여한 봉사활동 이름 -->
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
							<div>
							<c:if test="${!empty fileList }">
								<c:forEach var="reviewFile" items="${fileList}" varStatus="status">
							
									<img style="width:100%;" src="/resources/upload/review/${reviewFile.fileName}"/>
								</c:forEach>
							</c:if>
							</div>
								 <table>
								    <thead>
								      <tr>
								        <th><i class="fas fa-calendar"></i> 봉사활동 내역</th>
								      </tr>
								    </thead>
								    <tbody>
								      <tr>
								        <td>글쓴이</td>
								        <td>${review.userName}</td>
								      </tr>
								      <tr>
								        <td>작성일자</td>
								        <td>${review.regdate}</td>
								      </tr>

								      <tr>
								        <td>봉사분야</td>
								        <td>생활편의지원</td>
								      </tr>
								      <tr>
								        <td>모집기관</td>
								        <td>사랑의 집</td>
								      </tr>
								      <tr>
								        <td>조회수</td>
								        <td>${review.reviewReadCnt} 회</td>
								      </tr>
								    </tbody>
								  </table>
							 <div style = "padding: 5px 1px 7px 3px;"></div>
							<h2>${review.reviewTitle}</h2>
							<pre>${review.reviewContent}</pre>						
						</div>
						
						<div class="comments-list-wrap">
						
						<div class="bbttnnw" style="text-align: right;">
						<c:if test="${boardMe eq 'Y'}">
						 <button type="button" id="btnList">리스트</button>
						 <button type="button" id="btnUpdate">수정</button>
						 <button type="button" id="btnDelete">삭제</button>
						 </c:if>
						</div>
						
							<hr class="hr-8" style="border: 0; background-color: #fff; border-top: 2px dotted #8c8c8c;">
							
                  <!-- 댓글 -->   
                  <div class="comment-template"><br/>
                     <h4>댓글달기</h4><br>
                     <!-- 댓글 작성 -->   
                     <form action="">
                        <div>
                           <textarea name="_reviewReplyContent" id="_reviewReplyContent" cols="10" rows="10" placeholder="댓글을 남겨보세요."></textarea>
                           <button type="button" id="btnReply1" style="float: right; margin-top:35px;background-color: #FFCC80;
																										  color: #051922;
																										  font-weight: 700;
																										  text-transform: uppercase;
																										  font-size: 15px;
																										  border: none !important;
																										  cursor: pointer;
																										  padding: 10px 15px;
																										  border-radius: 3px;">등록</button>
                        </div>   
                     </form>
                  </div>
                  <!-- 댓글 목록 -->   
                  <div class="comment-list">
                     <div class="single-comment-body">
                        <br /><br />
                        <c:if test="${!empty replyList}">
                           <c:forEach items="${replyList}" var="reviewReply" varStatus="status">
                           <c:choose>
                              <c:when test="${reviewReply.reviewReplyIndent eq 1}">
                                 <div class="single-comment-body child">
                                 <div class="comment-user-avater">
                                 </div>
                                 <div class="comment-text-body">
                                 
                                    <h5><img src="/resources/images/free-icon-down arrow.png" width="22px" style="padding:2px;">${reviewReply.userName} 
                                       <span class="comment-date">${reviewReply.regdate}</span> 
                                       <c:if test="${reviewReply.userId eq cookieUserId}">
                                       <a href="javascript:void(0);" onclick="fnDel3(${status.index});">삭제</a>
                                       </c:if>
                                       <input type="hidden" id="reviewReplySeq${status.index}" name="reviewReplySeq${status.index}" value="${reviewReply.reviewReplySeq}" />
                                       
                                    </h5>
                                       <p>${reviewReply.reviewReplyContent}</p>
                                       
                                 </div>
                                 </div>
                              </c:when>
                              <c:otherwise>
                                 <div class="comment-text-body">
                                    <h5>${reviewReply.userName}
                                       <span class="comment-date">${reviewReply.regdate}</span>
                                       <a href="javascript:void(0);" onclick="fnReply2(${status.index});">답글쓰기</a>
                                       <c:if test="${reviewReply.userId eq cookieUserId}">
                                       <a href="javascript:void(0);" onclick="fnDel3(${status.index});">삭제</a>
                                       </c:if>
                                       <input type="hidden" id="reviewReplySeq${status.index}" name="reviewReplySeq${status.index}" value="${reviewReply.reviewReplySeq}" />
                                       
                                    </h5>
                                    <pre>${reviewReply.reviewReplyContent}</pre>
                                 </div>
                                 <div class="comment-template" id="replyFormContainer${status.index}" style="display: none;">
                                 <form id="replyForm2" name="replyForm2" method="POST">
                                 <div class="single-comment-body child">
                                    <textarea name="reviewReplyContent${status.index}" id="reviewReplyContent${status.index}" cols="10" rows="10" placeholder="답글을 남겨보세요." style="height: 100px"></textarea>
                                    <button type="button" id="btnReply2" onclick="insertReply2(${status.index})" style="float: right; margin-top:35px;margin-top:35px;background-color: #FFCC80;
																										  color: #051922;
																										  font-weight: 700;
																										  text-transform: uppercase;
																										  font-size: 15px;
																										  border: none !important;
																										  cursor: pointer;
																										  padding: 10px 15px;
																										  border-radius: 3px;">등록</button>
                                   <input type="hidden" id="reviewReplyGroup${status.index}" name="reviewReplyGroup${status.index}" value="${reviewReply.reviewReplyGroup}" />
                                   
                                 </div>   
                                 </form>
                                 <br/>
                                 </div>
                              </c:otherwise>
                           </c:choose>
                                                        
                           </c:forEach>
                          </c:if>
                           
                        <!-- -->                           
                  </div>
                  </div>
						
						</div>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="sidebar-section">

				
						<div class="recent-posts">
							<h4>최근 게시물</h4>
							<ul>
			<c:if test="${!empty list}">
				<c:forEach var="review" items="${list}" varStatus = "status">
								<li><a onclick="fn_view(${review.reviewSeq})">${review.reviewTitle}</a></li>
				</c:forEach>
			</c:if>
							</ul>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- end single article section -->
		
	<form name="bbsForm" id="bbsForm" method="post" >
		<input type="hidden" name="curPage" id="curPage" value="${curPage}" />
		<input type="hidden" name="searchType" id="searchType" value="${searchType}" />
		<input type="hidden" name="searchValue" id="searchValue" value="${searchValue}" />
		<input type="hidden" name="reviewSeq" id="reviewSeq" value="${review.reviewSeq}" />
		<input type="hidden" name="reviewFilter" id="reviewFilter" value="${reviewFilter}" />                 
	</form>
	

</body>
</html>