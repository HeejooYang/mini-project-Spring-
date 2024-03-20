package com.gibong.web.model;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class Amount implements Serializable{

private static final long serialVersionUID = 1L;
	
	private int total;			//전체 결제 금액
	private int tax_free;		//비과세 금액
	private int vat;			//부가세 금액
	private int point;			//사용한 포인트 금액
	private int discount;		//할인 금액
	private int green_deposit;	//컵 보증금
	
	public Amount() {
		total = 0;				
		tax_free = 0;			
		vat = 0;				
		point = 0;				
		discount = 0;			
		green_deposit = 0;		
	}
	
}
