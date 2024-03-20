package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.gibong.common.model.FileData;
import com.gibong.common.util.FileUtil;
import com.gibong.web.dao.ReviewDao;
import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;

@Service("reviewService")
public class ReviewService {
	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);
	
	@Autowired
	private ReviewDao reviewDao;
	
	//파일 저장 경로
	@Value("#{env['upload.review.save.dir']}")
	private String UPLOAD_REVIEW_SAVE_DIR;
	
	//reviewList
	public List<Review> reviewList(Review review){  
		List<Review> list = null;
		
		try {
			list = reviewDao.reviewList(review);
		} catch (Exception e) {
			logger.error("[ReviewService] reviewList Exception",e);
		}
		
		return list;
		
	}
	//리뷰글 총 수
	public long reviewListCount(Review review) {  
		long count = 0;
		
		try {
			count =reviewDao.reviewListCount(review);
		} catch (Exception e) {
			logger.error("[ReviewService] reviewListCount Exception",e);
		}

		return count;

	}
	
	public Review reviewSelect(long reviewSeq) {  
		Review review = null;
		
		try {
			review = reviewDao.reviewSelect(reviewSeq);
		} catch (Exception e) {
			logger.error("[ReviewService] reviewSelect Exception",e);

		}
		return review;
	}
	
	//리뷰글 상세보기(조회수 증가포함)(reviewSelect)
	public Review reviewView(long reviewSeq) { 
		Review review = null;
		try {
			review = reviewDao.reviewSelect(reviewSeq);
			
			if(review != null) {  
				reviewDao.boardReadCntPlus(reviewSeq);
				//첨부파일 조회 추가하기
				
			}
		} catch (Exception e) {
			logger.error("[ReviewService] reviewView Exception", e);

		}
		
		return review;
	}
	
	//게시물 등록 
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int reviewInsert(Review review, List<FileData> fileData ) throws Exception{ 
		int count = 0;

			reviewDao.reviewInsert(review);//글 먼저 등록
			
			long reviewSeq = reviewDao.reviewSeqNow(review.getUserId());//방금등록한 글 번호조회
  		    
			logger.debug("1111111111111111111");
		    logger.debug("reviewSeq : " + reviewSeq);
		    logger.debug("1111111111111111111");
		    
			ReviewFile reviewFile = new ReviewFile();

  		  if(fileData != null && fileData.size() > 0 ) { 
  			  
	    		  int i = 0;
	    		  
	    		  for(i = 0;i < fileData.size();i++){ 

	    			  reviewFile.setReviewSeq(reviewSeq);
	    			  reviewFile.setFileSeq((short)(i + 1));
	    			  reviewFile.setFileName(fileData.get(i).getFileName());
	    			  reviewFile.setFileOrgName(fileData.get(i).getFileOrgName());
	    			  reviewFile.setFileExt(fileData.get(i).getFileExt());
	    			  reviewFile.setFileSize(fileData.get(i).getFileSize());
	    			  //파일인서트를 for문돌면서 하나씩 넣기 어디에? 해당글에
	    			  
	    			  count += reviewDao.reviewFileInsert(reviewFile); //해당 글번호에 파일 인서트
	    			  logger.debug("fileResult파일인서트 처리 누적 건수 : " + count);
	    		  
	    		  }	  
	     }
  		  
			
		return count;
	}
	
	//첨부파일 등록
	public int reviewFileInsert(ReviewFile reviewFile) {  
		
		int count = 0;
		
		//방금 userId가 인서트한 글 번호를 조회해옴
		
		try {
			reviewDao.reviewFileInsert(reviewFile);

		} catch (Exception e) {
			logger.error("[ReviewService] reviewFileInsert Exception", e);
		}
		return count;
	}
	
	//방금 등록한 글 번호 가져오기
	public long reviewSeqNow(String userId) {  
		
		long reviewSeq = 0;
		try {
			reviewSeq = reviewDao.reviewSeqNow(userId);

		} catch (Exception e) {
			logger.error("[ReviewService] reviewSeqNow Exception", e);
		}
		return reviewSeq;
		
	}
	
	//첨부파일 조회
	public List<ReviewFile> reviewFileSelect(long reviewSeq) {
		List<ReviewFile> list = null;
		try {
			list = reviewDao.reviewFileSelect(reviewSeq);
		} catch (Exception e) {
			logger.error("[ReviewService] reviewFileSelect Exception", e);
		}		
		return list;
	}
	
	//게시물 수정물 조회(첨부파일 포함)
	public Review reviewViewUpdate(long reviewSeq) {  
		Review review = null;
		try {
			review = reviewDao.reviewSelect(reviewSeq);
			
			if(review != null) {
				List<ReviewFile> reviewFileList = reviewDao.reviewFileSelect(reviewSeq);
				if(reviewFileList != null) {
					//파일 불러오는게 list로 변하면서(다중파일. 여러파일 업로드한 글인 경우, 그 여러개의 파일을 조회해와야 하는 로직을 작성하기)
					//review.setReviewFile(reviewFileList);
				}
			}
		} catch (Exception e) {
			logger.error("[ReviewService] reviewViewUpdate Exception", e);
		}
		return review;
	}
	
	//게시물수정
		public int reviewUpdate(Review review, List<FileData> fileData ) {  
			int count = 0;
			
			reviewDao.reviewUpdate(review);//글수정
  		    logger.debug("1111111111111111111");
		    logger.debug("review.getReviewSeq() : " + review.getReviewSeq());
		    logger.debug("1111111111111111111");
			ReviewFile reviewFile = new ReviewFile();
			logger.debug("2222222222222222222");
			 
  		  if(fileData != null && fileData.size() > 0 ) { 
  			  logger.debug("3333333333333333333333");
  			if(reviewDao.reviewFileDelete(review.getReviewSeq()) > 0) {
	    		  int i = 0;
	    		  
	    		  for(i = 0;i < fileData.size();i++){ 

	    			  reviewFile.setReviewSeq(review.getReviewSeq());
	    			  reviewFile.setFileSeq((short)(i + 1));
	    			  reviewFile.setFileName(fileData.get(i).getFileName());
	    			  reviewFile.setFileOrgName(fileData.get(i).getFileOrgName());
	    			  reviewFile.setFileExt(fileData.get(i).getFileExt());
	    			  reviewFile.setFileSize(fileData.get(i).getFileSize());
	    			  //파일인서트를 for문돌면서 하나씩 넣기 어디에? 해당글에
	    			  count += reviewDao.reviewFileInsert(reviewFile);
    			  logger.debug("fileResult파일인서트 처리 누적 건수 : " + count);

	    		  }	  
  			}
  		}

	
			return count;
		}
	
	//첨부파일 삭제(수정을 위한 삭제)
	public int reviewFileDelete(long reviewSeq) {  
		int count = 0;
		try {
			count = reviewDao.reviewFileDelete(reviewSeq);
		} catch (Exception e) {
			logger.error("[ReviewService] reviewFileDelete Exception", e);

		}
		
		return count;
	}
	
	//게시물 삭제(첨부파일 함께 삭제)
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public int reviewDelete(long reviewSeq) throws Exception{ 
		int count = 0;
		
		Review review = reviewViewUpdate(reviewSeq);
		
		if(review != null) {  
			count = reviewDao.reviewDelete(reviewSeq);
			
			if(count > 0) {  
				ReviewFile reviewFile = review.getReviewFile();
				
				if(reviewFile != null) {  
					if(reviewDao.reviewFileDelete(reviewSeq) > 0 ) {  
						FileUtil.deleteFile(UPLOAD_REVIEW_SAVE_DIR + FileUtil.getFileSeparator() + reviewFile.getFileName());
					}
				}
			}
		}
		return count;
		
	}
	//리스트 사진 조회(전부)
	public List<ReviewFile> fileList() {  
		List<ReviewFile> reviewFile = null;
		try {
			reviewFile = reviewDao.fileList();
		} catch (Exception e) {
			logger.error("[ReviewService] fileList Exception", e);
		}
		
		return reviewFile;

	}
	
	//썸네일 조회 fileSeq 1
	public List<ReviewFile> thumbnailList(){  
		List<ReviewFile> reviewFile = null;
		try {
			reviewFile = reviewDao.thumbnailList();
		} catch (Exception e) {
			logger.error("[ReviewService] thumbnailList Exception", e);
		}
		
		return reviewFile;
	}
	
	////////////////////////////////////////////
	//트랜젝션 처리 게시글 등록 서비스
	
	
	
	
	
	
	
	
	
	
	
}
