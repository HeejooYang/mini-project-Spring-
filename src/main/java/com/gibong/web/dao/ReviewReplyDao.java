package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.ReviewReply;

@Repository("reviewReplyDao")
public interface ReviewReplyDao {
	
	//리뷰글에 해당하는 댓글 조회
	public List<ReviewReply>replySelect(long reviewSeq);
	
	//리뷰 댓글 등록
	public int replyInsert(ReviewReply reviewReply);	
	
	//리뷰 대댓글 등록
	public int reReplyInsert(ReviewReply reviewReply);
	
	//리뷰 댓글 그룹내의 순서 변경
	public int reviewReplyGroupUpdate(ReviewReply reviewReply);
	
	//리뷰 댓글 삭제
	public int replyDelete(long reviewReplySeq);
}
