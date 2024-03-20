package com.gibong.web.model;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class Volun implements Serializable{
	
	private static final long serialVersionUID = 1L;

	
	private long volunSeq;			//봉사 글 번호
	private String volunDelFlag;	//삭제 여부
	private String userId;			//유저아이디
	private String volunType;		//봉사유형
	private String volunTitle;		//글 제목
	private String volunContent;	//글 내용
	private String volunFlag;		//봉사 승인 상태(승인대기중(W), 승인완료(C) , 봉사완료(D) )
	private String regdate;			//등록일
	private String volunDae;		//봉사 대상
	private long volunTo;			//모집인원
	private long volunHour;			//봉사시간
	private String volunDate;		//봉사 날짜
	private String volunLoca;		//봉사 장소
	private String expDate;			//마감일
	

	private String userName;		//기관 이름
	private String userPhone;		//기관 연락처
	private String userEmail;		//기관 이메일
	private String userZipcode;		//기관 우편번호
	private String userAddr1;		//기관 주소
	private String userAddr2;		//기관 상세주소
	
	

	private VolunFile volunFile;	//이미지파일

	public Volun() {  
		volunSeq = 0;
		volunDelFlag = "N";
		userId = "";
		volunType = "";
		volunTitle = "";
		volunContent = "";
		volunFlag = "";
		regdate = "";
		volunDae = "";
		volunTo = 0;
		volunHour = 0;
		volunDate = "";
		volunLoca = "";
		expDate = "";
		userName = "";
		userPhone = "";
		userEmail = "";
		userZipcode = "";
		userAddr1 = "";
		userAddr2 = "";
		volunFile = null;
		
	}

	

}
