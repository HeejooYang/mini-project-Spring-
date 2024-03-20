<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/head.jsp" %>
<link rel="stylesheet" href="/resources/css/progress-bar.css" type="text/css">
<script type="text/javascript">
$(document).ready(function(){
	$("#btnClose").on("click",function(){
		opener.movePage();//나를 연 곳에서 movePage()를 호출하라 (나는 iframe)
		window.close();//나를 닫아 
	});
});

</script>
</head>
<body>
<div class="container">
</br></br></br>
<c:choose>
	<c:when test="${!empty kakaoPayApprove}">
		<h2>카카오페이 결제가 정상적으로 완료되었습니다.</h2>
		결제일시 : ${kakaoPayApprove.approved_at}<br/>
		주문번호 : ${kakaoPayApprove.partner_order_id}<br/>
		상품명 : ${kakaoPayApprove.item_name}<br/>
		상품수량 : ${kakaoPayApprove.quantity}<br/>
		결제금액 : ${kakaoPayApprove.amount.total}<br/>
		결제방법 : ${kakaoPayApprove.payment_method_type}<br/>
		
	</c:when>
	<c:otherwise>
		<h2>카카오페이 결제 중 오류가 발생하였습니다.</h2>
	</c:otherwise>

</c:choose>


</div>
<button id="btnClose" name="btnClose" type="button" style="float: center; margin:40px;background-color: #FFCC80;
																		color: #051922;
																		font-weight: 700;
																		text-transform: uppercase;
																		font-size: 15px;
																		border: none !important;
																		cursor: pointer;
																		padding: 10px 15px;
																		border-radius: 3px;">닫기</button>
</body>
</html>

















