package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Volun;
import com.gibong.web.model.VolunFile;

@Repository("volunDao")
public interface VolunDao {
	
	//봉사활동 리스트
	public List<Volun> volunList();
	
	//봉사활동글 상세보기volunView 글 조회
	public Volun volunView(long volunSeq);
	
	//리스트 이미지 모두 조회
	public List<VolunFile> volunFileList();
	
	//volunView에 해당하는 이미지 조회
	public VolunFile volunFile(long volunSeq);
	

}
