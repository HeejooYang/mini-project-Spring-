<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<style>
		textarea{
		    min-width: 100%;
		    min-height: 100rem;
		    overflow-y: hidden;
		    resize: none;
		    border: 0 white;
		}
		textarea:focus{
			outline: none;
		}
	</style>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<script>
$(document).ready(function(){
		
		$("#reviewTitle").focus();
		
		$("#btnUpload").on("click",function(){
			$("#btnUpload").prop("disabled",true);
			
			if($.trim($("#reviewTitle").val()).length <= 0){
				alert("제목을 입력하세요.");
				$("#reviewTitle").val("");
				$("#reviewTitle").focus();
				
				$("#btnUpload").prop("disabled",false);	//글쓰기 버튼 재활성화
				
				return;
			}
			if($.trim($("#reviewContent").val()).length <= 0){
				alert("내용을 입력하세요.");
				$("#reviewContent").val("");
				$("#reviewContent").focus();
				
				$("#btnUpload").prop("disabled",false);	//글쓰기 버튼 재활성화
				
				return;
			}
		
		
		var form = $("#writeForm")[0];
		var formData = new FormData(form);

			$.ajax({
				type:"POST",
				enctype:"multipart/form-data",
				url:"/review/reviewUpdateProc",
				data:formData,
				processData:false,
				contentType:false,
				cache:false,
				beforeSend:function(xhr)
				{
					xhr.setRequestHeader("AJAX", "true");
				},
				success: function(response){
					if(response.code==0){
						alert("게시물이 수정되었습니다.");
						location.href = "/review/reviewList";	//글 작성 후 돌아가면 메인 1페이지 (등록한 후니까 내 글을 보기 위해서)
	
					}else if(response.code==401){
						alert("파라미터 값이 올바르지 않습니다.");
						$("#btnUpload").prop("disabled",false);	//글쓰기 버튼 재활성화
						$("#reviewTitle").focus();
					}else if(response.code==500){
						alert("글수정이 되지않았습니다.");
						$("#btnUpload").prop("disabled",false);	//글쓰기 버튼 재활성화
						$("#reviewTitle").focus();
					}
					else{
						alert("게시물 수정 중 오류가 발생하였습니다.")
						$("#btnUpload").prop("disabled",false);	//글쓰기 버튼 재활성화
						$("#reviewTitle").focus();
						
					}
				},
				error: function(error){
					icia.common.error(error);
					alert("게시물 등록 중 오류가 발생하였습니다.");
					$("#btnWrite").prop("disabled",false);	//글쓰기 버튼 재활성화
				}
					
			});
		});
	
		 $("#btnList").on("click", function() {
			   document.bbsForm.action="/review/reviewList";
			   document.bbsForm.submit();
		   });
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	function resize(obj) {
	    obj.style.height = '1px';
	    obj.style.height = (12 + obj.scrollHeight) + 'px';
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
						<p>후기 수정</p>
						<h1>후기 수정</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- end breadcrumb section -->
	
	<!-- single article section -->
	<div class="mt-150 mb-150">
		<div class="container">
				<div class="col-lg-8" style="margin: 0 auto;">
					<div class="single-article-section" style="margin: 0 auto;">
						<div class="single-article-text">
							<div>
							</div>
						<div class="bbttnnw" style="text-align: right;">
						 <button type="button" id="btnUpload">등록</button>
						 <button type="button" id="btnList">리스트</button>
						</div>
						<p>
								 <table>
								    <thead>
								      <tr>
								        <th><i class="fas fa-calendar"></i>봉사활동 내역</th>
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
								        <td>어린이집</td>
								      </tr>
								      <tr>
								        <td>모집기관</td>
								        <td>맨발의 기봉이</td>
								      </tr>
								       <tr>
								        <td>조회수</td>
								        <td>${review.reviewReadCnt} 회</td>
								      </tr>
								    </tbody>
								  </table>
						</p>	  
							<!-- 이미지 미리보기 시작 -->
							<form name="writeForm" id="writeForm" method="post" enctype="multipart/form-data">
							  <div id='image_preview'>
							      <input type='file' id="btnAtt" name="reviewFile" multiple='multiple'/>
							    <div id='att_zone'
							      data-placeholder='파일을 첨부 하려면 파일 선택 버튼을 클릭하거나 파일을 드래그앤드롭 하세요'></div>
							  </div>
							  
							  	<script type="text/javascript">
						        ( /* att_zone : 이미지들이 들어갈 위치 id, btn : file tag id */
								  imageView = function imageView(att_zone, btn){
					
								    var attZone = document.getElementById(att_zone);
								    var btnAtt = document.getElementById(btn)
								    var sel_files = [];
								    
								    // 이미지와 체크 박스를 감싸고 있는 div 속성
								    var div_style = 'display:inline-block;position:relative;'
								                  + 'width:150px;height:120px;margin:5px;border:1px solid #00f;z-index:1';
								    // 미리보기 이미지 속성
								    var img_style = 'width:100%;height:100%;z-index:none';
								    // 이미지안에 표시되는 체크박스의 속성
								    var chk_style = 'width:30px;height:30px;position:absolute;'
								                  + 'right:0px;bottom:0px;z-index:999;background-color:white;color:black';
								  
								    btnAtt.onchange = function(e){
								      var files = e.target.files;
								      var fileArr = Array.prototype.slice.call(files)
								      for(f of fileArr){
								        imageLoader(f);
								      }
								    }  
								    
								  
								    // 탐색기에서 드래그앤 드롭 사용
								    attZone.addEventListener('dragenter', function(e){
								      e.preventDefault();
								      e.stopPropagation();
								    }, false)
								    
								    attZone.addEventListener('dragover', function(e){
								      e.preventDefault();
								      e.stopPropagation();
								      
								    }, false)
								  
								    attZone.addEventListener('drop', function(e){
								      var files = {};
								      e.preventDefault();
								      e.stopPropagation();
								      var dt = e.dataTransfer;
								      files = dt.files;
								      for(f of files){
								        imageLoader(f);
								      }
								      
								    }, false)
								    
					
								    
								    /*첨부된 이미지들을 배열에 넣고 미리보기 */
								    imageLoader = function(file){
								      sel_files.push(file);
								      var reader = new FileReader();
								      reader.onload = function(ee){
								        let img = document.createElement('img')
								        img.setAttribute('style', img_style)
								        img.src = ee.target.result;
								        attZone.appendChild(makeDiv(img, file));
								      }
								      
								      reader.readAsDataURL(file);
								    }
								    
								    /*첨부된 파일이 있는 경우 checkbox와 함께 attZone에 추가할 div를 만들어 반환 */
								    makeDiv = function(img, file){
								      var div = document.createElement('div')
								      div.setAttribute('style', div_style)
								      
								      var btn = document.createElement('input')
								      btn.setAttribute('type', 'button')
								      btn.setAttribute('value', 'x')
								      btn.setAttribute('delFile', file.name);
								      btn.setAttribute('style', chk_style);
								      btn.onclick = function(ev){
								        var ele = ev.srcElement;
								        var delFile = ele.getAttribute('delFile');
								        for(var i=0 ;i<sel_files.length; i++){
								          if(delFile== sel_files[i].name){
								            sel_files.splice(i, 1);      
								          }
								        }
								        
								        dt = new DataTransfer();
								        for(f in sel_files) {
								          var file = sel_files[f];
								          dt.items.add(file);
								        }
								        btnAtt.files = dt.files;
								        var p = ele.parentNode;
								        attZone.removeChild(p)
								      }
								      div.appendChild(img)
								      div.appendChild(btn)
								      return div
								    }
								  }
								)('att_zone', 'btnAtt')
							</script>
							<!-- 이미지 미리보기 끝 -->
							
							<p>
							<div style = "padding: 5px 1px 7px 3px;"></div>
							<h2><input type="text" name="reviewTitle" id="reviewTitle" value="${review.reviewTitle }" style="outline: none; border:0px;"/></h2>
							<hr class="hr-3">
							<img id="preview" onchange="readURL(this);" onkeydown="resize(this)" onkeyup="resize(this)"/>
						
							<textarea name="reviewContent" id="reviewContent" value="${review.reviewContent}" class="newTweetContent" onkeydown="resize(this)" onkeyup="resize(this)" >${review.reviewContent}</textarea>
							</p>
							<input type="hidden" name="reviewSeq" value="${review.reviewSeq}"/>
					   		<input type="hidden" name="searchType" value="${searchType}"/>
					   		<input type="hidden" name="searchValue" value="${searchValue}"/>
					   		<input type="hidden" name="curPage" value="${curPage}"/>
							</form>
							<form name="bbsForm" id="bbsForm" method="post" >
						   		<input type="hidden" name="reviewSeq" value="${review.reviewSeq}"/>
						   		<input type="hidden" name="searchType" value="${searchType}"/>
						   		<input type="hidden" name="searchValue" value="${searchValue}"/>
						   		<input type="hidden" name="curPage" value="${curPage}"/>
						   </form>
							
						</div>
					</div>
				</div>
		</div>
	</div>
	<!-- end single article section -->
</body>
</html>

