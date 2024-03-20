package com.gibong.web.model;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class VolunFile implements Serializable{

	private static final long serialVersionUID = 1L;

	   
	private long volunSeq;		//봉사 글 번호
	private long fileSeq;		//파일 번호
	private String fileOrgName;	//파일 원래 이름
	private String fileName;	//파일 이름
	private String fileExt;		//파일 확장자
	private long fileSize;		//파일 크기
	private String regdate;		//등록일

	public VolunFile() {  

		volunSeq = 0;
		fileSeq= 0;
		fileOrgName = "";
		fileName = "";
		fileExt = "";
		fileSize= 0;
		regdate = "";

	}
	
	
	
	
	
	
	
	
	
	
	
	
}
