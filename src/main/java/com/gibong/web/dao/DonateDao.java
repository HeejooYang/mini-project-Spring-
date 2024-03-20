package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Donate;
import com.gibong.web.model.DonateFile;

@Repository("donateDao")
public interface DonateDao {
	
	//후원게시물 리스트
	public List<Donate> donateList();
	
	//후원게시물 이미지 리스트 (썸네일)
	public List<DonateFile> donateFileList();
	
	//후원글 상세보기 글 조회
	public Donate donateSelect(long donateSeq);
	
	//후원글 상세보기 이미지 (글 번호로 조회)
	public DonateFile donateFile(long donateSeq);
	

}
