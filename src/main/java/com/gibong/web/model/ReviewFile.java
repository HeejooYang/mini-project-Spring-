package com.gibong.web.model;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ReviewFile implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long reviewSeq;			//게시물 번호(SEQ_REVIEW_SEQ)
	private short fileSeq;			//파일번호(MX+1)
	private String fileOrgName;		//원본 파일명
	private String fileName;		//파일명
	private String fileExt;			//파일 확장자
	private long fileSize;			//파일크기
	private String regdate;			//등록일

	public ReviewFile() {
		reviewSeq = 0;
		fileSeq = 0;
		fileOrgName = "";
		fileName = "";
		fileExt = "";
		fileSize = 0;
		regdate = "";
	}
	
	
	
}
