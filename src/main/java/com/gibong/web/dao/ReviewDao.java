package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.ReviewReply;

@Repository("reviewDao")
public interface ReviewDao {
	//리뷰게시물 리스트
	public List<Review> reviewList(Review review);
	
	//게시물 수 count
	public long reviewListCount(Review review);
	
	//게시물 조회(reviewView 상세보기)
	public Review reviewSelect(long reviewSeq);
	
	//조회수 증가
	public int boardReadCntPlus(long reviewSeq);
	
	//게시물 등록
	public int reviewInsert(Review review);
	
	//첨부파일 등록
	public int reviewFileInsert(ReviewFile reviewFile);
	
	//첨부파일 등록 new seq값
	public short reviewFileSeqNew(long reviewSeq);
	
	//방금 등록한 글 번호 가져오기
	public long reviewSeqNow(String userId);
	
	//첨부파일 조회
	public List<ReviewFile> reviewFileSelect(long reviewSeq);
	
	//게시물수정
	public int reviewUpdate(Review review);
	
	//첨부파일 삭제(수정을 위한 삭제)
	public int reviewFileDelete(long reviewSeq);
	
	//게시물 삭제
	public int reviewDelete(long reviewSeq);
	
	//썸네일 조회 FILELIST
	public List<ReviewFile> fileList();
	
	//썸네일 조회 fileSeq 1
	public List<ReviewFile> thumbnailList();

	
	
	

}
