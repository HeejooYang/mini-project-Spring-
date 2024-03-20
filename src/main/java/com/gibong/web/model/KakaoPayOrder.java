package com.gibong.web.model;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class KakaoPayOrder implements Serializable{

	
private static final long serialVersionUID = 1L;
	
	//order는 담기 위한 용도지만 ready 카카오에서 꼭 그 이름으로 값을 던지라고 되어 있기 때문에 이름 바꾸면 안된다.
	
	
	private String partnerOrderId;	//가맹점 주문번호, 최대 100자
	private String partnerUserId;		//가맹점 회원 id, 최대 100자
	private String itemName;			//상품명, 최대 100자
	private String itemCode;			//상품코드, 최대 100자
	private int quantity;				//상품 수량
	private int totalAmount;			//상품 총액
	private int taxFreeAmount;		//상품 비과세 금액
	private int vatAmount;				//상품 부가세 금액
										//값을 보내지 않을 경우 다음과 같이 VAT 자동 계산
										//(상품총액 - 상품 비과세 금액)/11 : 소숫점 이하 반올림
	
	private String tId;					//결제 고유 번호, 20자
	private String pgToken;				//결제 승인 요청을 인증하는 토큰
										//사용자 결제 수단 선택 완료시, approval_url로 redirection해줄때
										//pg_token을 query string으로 전달
	
	
	public KakaoPayOrder() {  
		partnerOrderId = "";
		partnerUserId ="";
		itemName = "";
		itemCode = "";
		quantity = 0;
		totalAmount = 0;
		taxFreeAmount = 0;
		vatAmount = 0;
		 
		tId ="";
		pgToken = "";
	}
}
