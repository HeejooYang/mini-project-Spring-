package com.gibong.web.model;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ReviewReply implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	private String userId;		//유저아이디
	private long reviewReplySeq;//댓글번호
	private long reviewSeq;//후기 글번호
	private String replyDelFlag;//삭제여부
	private String reviewReplyContent;//댓글내용
	private long reviewReplyGroup;//그룹 번호
	private int reviewReplyOrder;//그룹 내 순번
	private int reviewReplyIndent;//들여쓰기
	private String regdate;//등록일
	
	private String userName;	//유저 이름
	
	
	public ReviewReply() {  
		userId = "";
		reviewReplySeq = 0;
		reviewSeq = 0;
		replyDelFlag = "N";
		reviewReplyContent = "";
		reviewReplyGroup = 0;
		reviewReplyOrder = 0;
		reviewReplyIndent = 0;
		regdate = "";
		userName ="";
		
	}
	

	
	
	
	
	

}
