package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.gibong.web.dao.ReviewReplyDao;
import com.gibong.web.model.ReviewReply;

@Service("reviewReplyService")
public class ReviewReplyService {

	private static Logger logger = LoggerFactory.getLogger(ReviewReplyService.class);

	@Autowired
	private ReviewReplyDao reviewReplyDao;
	
	//리뷰에 해당하는 댓글 조회
	public List<ReviewReply> replySelect(long reviewSeq){  
		
		List<ReviewReply> list = null;
		
		try {  
			 list = reviewReplyDao.replySelect(reviewSeq);
		}catch (Exception e) {
			logger.error("[ReviewReplyService] replySelect Exception",e);

		}
		return list;
		
		
	}
	
	//리뷰 댓글 등록
	public int replyInsert(ReviewReply reviewReply) {  
		int count = 0;
		try {
			count =reviewReplyDao.replyInsert(reviewReply);
		} catch (Exception e) {
			logger.error("[ReviewReplyService] reviewInsert Exception",e);

		}
		
		return count;
	}
	
	//리뷰 대댓글 등록
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int reReplyInsert(ReviewReply reviewReply) throws Exception{  
		int count = 0;
			
		reviewReplyDao.reviewReplyGroupUpdate(reviewReply);
			count = reviewReplyDao.reReplyInsert(reviewReply);
		

		
		return count;
	}
	
	
	//리뷰 댓글 그룹내의 순서 변경
	public int reviewReplyGroupUpdate(ReviewReply reviewReply) {  
		int count = 0;
		
		try {
			count = reviewReplyDao.reviewReplyGroupUpdate(reviewReply);
		} catch (Exception e) {
			logger.error("[ReviewReplyService] reviewReplyGroupUpdate Exception",e);

		}
		return count;
		
	}
	
	//리뷰 댓글 삭제
	public int replyDelete(long reviewReplySeq) {  
		
		int count = 0;
		
		try {
			count = reviewReplyDao.replyDelete(reviewReplySeq);
		} catch (Exception e) {
			logger.error("[ReviewReplyService] replyDelete Exception",e);

		}
		return count;
		
		
		
		
		
		
	}
	
	
}
