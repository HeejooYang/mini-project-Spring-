package com.gibong.web.model;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class Donate implements Serializable {

	private static final long serialVersionUID = 1L;

	private long donateSeq;			//글 번호
	private String userId;			//유저 아이디
	private String donateFlag;		//후원 글 상태
	private String donateTitle;		//글 제목
	private String donateContent;	//글 내용
	private String regdate;			//등록일
	private String donateNowAmt;	//현재 금액
	private String donateGoalAmt;	//목표 금액
	private String finishFlag;		//목표 달성 여부 (Y/N)
	
	private String userName;		//사용자 이름
	
	private DonateFile donateFile;	//첨부파일 변수
	
	public Donate() { 
		donateSeq = 0;
		userId = "";
		donateFlag = "Y";
		donateTitle = "";
		donateContent = "";
		regdate = "";
		donateNowAmt = "0";
		donateGoalAmt = "10000000";
		finishFlag = "N";
		
		userName="";
		donateFile = null;
		
		
		
	}

	
	
	
	
	
	
	
	
	
	
	
	
}
