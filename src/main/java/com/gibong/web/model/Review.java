package com.gibong.web.model;

import java.io.Serializable;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class Review implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long reviewSeq;		//후기 글번호
	private String userId;			//유저아이디
	private String reviewTitle;		//글번호
	private String reviewContent;	//글내용
	private String reviewDelFlag;	//삭제여부
	private int reviewReadCnt;		//조회수
	private int reviewLikeCnt;		//추천수
	private String regdate;			//등록일
	
	private String reviewFilter;	//정렬필터타입(1:최신순, 2: 조회, 3: 추천)
	private String searchType;			//검색 타입(1: 이름, 2: 제목, 3: 내용)
	private String searchValue;			//검색 값
	private long startRow;				//시작 rownum
	private long endRow;				//끝 rownum
	
	private String userName;		//사용자 이름
	
	private ReviewFile reviewFile;	//첨부파일 변수
	
	
	public Review() { 
		
		reviewSeq = 0;		
		userId = "";			
		reviewTitle = "";		
		reviewContent = "";	
		reviewDelFlag = "N";	
		reviewReadCnt = 0;		
		reviewLikeCnt = 0;		
		regdate = "";			
		
		reviewFilter = "";
		searchType = "";			
		searchValue = "";			
		startRow = 0;				
		endRow = 0;	
		
		userName = "";
		
		reviewFile = null;
	
	}

}
