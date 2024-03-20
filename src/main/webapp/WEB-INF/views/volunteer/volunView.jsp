<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<style>
		#volunForm button[type="button"] {
		    /* background-color: #FFCC80; */
		    color: #051922;
		    font-weight: 700;
		    text-transform: uppercase;
		    font-size: 15px;
		    /* border: none !important; */
		    cursor: pointer;
		    /* padding: 15px 25px; */
		    /* border-radius: 3px;
		    }
	    element.style {
		    height: 900px;
		}
		table{
			border:0 white;
		}
		#btnTogether button{
			float: right;   
			background-color: #FFCC80;
			color: #051922;
			font-weight: 700;
			text-transform: uppercase;
			font-size: 15px;
			border: none !important;
			cursor: pointer;
			padding: 10px 15px;
			border-radius: 3px;"
		}
	</style>
	
<script>

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
                  <h1 id="font" style="color: #554838; font-size: 50px">${volun.volunTitle}</h1>
               </div>
            </div>
         </div>
      </div>
   </div>
   <!-- end breadcrumb section -->
   
   <div class="container"><br />
   <div class="bbttnnw" style="text-align: right;">
		<button type="button" id="btnUpdate">수정</button>
		<button type="button" id="btnList" >리스트</button>
		<button type="button" id="btnTogether" >신청하기</button>
   </div> 
      </div>
      
      <br>
      <form name="volunForm" id="volunForm" method="post" >
      <div class="form-join d-flex justify-content-center">
         <table style="width:650px; height: 170px">
            
            <tr>
            	<th><i class="bi bi-calendar"></i>&nbsp;모집 기간</th>
            	<td>${volun.regdate} - ${volun.expDate}</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-bank"></i>&nbsp;봉사 대상</th>
               <td>&nbsp;${volun.volunDae}</td>
               <th>&nbsp;<i class="bi bi-pin-map"></i>&nbsp;봉사 장소</th>
               <td>${volun.volunLoca}</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 분야</th>
               <td>&nbsp;${volun.volunType}</td>
               <th>&nbsp;<i class="bi bi-person"></i>&nbsp;모집 인원</th>
               <td>${volun.volunTo} 명</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-card-list"></i>&nbsp;봉사 날짜</th>
               <td>&nbsp;${volun.volunDate}</td>
               <th>&nbsp;<i class="bi bi-card-list"></i>&nbsp;봉사 시간</th>
               <td>${volun.volunHour} 시간</td>
            </tr>
            
         </table>
      </div><br />
      <div class="form-join d-flex justify-content-center" style="width:650px; border-bottom:1px solid black; margin: 0 auto;"></div><br />
      <div class="form-join d-flex justify-content-center">
         <table style="width:650px; height: 100px">
            <tr>
               <th><i class="bi bi-building"></i>&nbsp;봉사기관</th>
               <td>&nbsp;${volun.userName}</td>
            </tr>
            
            <tr>
               <th><i class="bi bi-envelope"></i>&nbsp;이메일</th>
               <td>&nbsp;n${volun.userEmail}</td>
               <th><i class="bi bi-telephone"></i>&nbsp;전화</th>
               <td>&nbsp;${volun.userPhone}${volun.userAddr1}</td>
            </tr>
         </table>
      </div>
      </form>
	<!-- end breadcrumb section -->

	<!-- single article section -->
	<div class="mt-150 mb-150">
		<div class="container">
				<div class="col-lg-8" style="margin: 0 auto;">
					<div class="single-article-section" style="margin: 0 auto;">
						<div class="single-article-text">
							<div>
							<img style="width:100%;" src="/resources/upload/volun/${volunFile.fileOrgName}" />
							</div>
							 <div style = "padding: 5px 1px 7px 3px;"></div>
							<pre>${volun.volunContent}</pre>
						</div>
						
						<br />
						<div class="form-join d-flex justify-content-center" style="width:700px; border-bottom:1px solid black; margin: 0 auto;"></div><br />
						
<!-- 지도에 표시할 기관주소, 주소명값 -->						
<input type="hidden" id="userAddr1" name="userAddr1" value="${volun.userAddr1}" />	
<input type="hidden" id="userName" name="userName" value="${volun.userName}" />	

					
<div class="single-article-text">
<p style="margin-top:-6px">
   &nbsp;&nbsp;&nbsp;&nbsp;<h5 style="color:#3e2723">봉사 위치</h5>
</p>
    <div id="map" style="width:650px;height:400px;"></div>
</div>
	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=216974698ba1fa3133568aecd8d4d9d6&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//검색할 주소
var addr = $("#userAddr1").val();

//장소설명
var locaName = $("#userName").val();

// 주소로 좌표를 검색합니다
geocoder.addressSearch(addr, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+locaName+'</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    
</script>

						
						
					</div>
				</div>
		</div>
	</div>
	<!— end single article section —>
	 
</body>
</html>