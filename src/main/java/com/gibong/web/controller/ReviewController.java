package com.gibong.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gibong.web.model.Paging;
import com.gibong.web.model.Response;
import com.gibong.web.model.Review;
import com.gibong.web.model.ReviewFile;
import com.gibong.web.model.ReviewReply;
import com.gibong.web.model.User;
import com.gibong.web.service.ReviewReplyService;
import com.gibong.web.service.ReviewService;
import com.gibong.web.service.UserService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.gibong.common.model.FileData;
import com.gibong.common.util.StringUtil;

@Controller("reviewController")
public class ReviewController {
	
	@Autowired
	private ReviewReplyService reviewReplyService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private UserService userService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Value("#{env['upload.review.save.dir']}")
	private String UPLOAD_REVIEW_SAVE_DIR;
	
	private static final int LIST_COUNT = 6;
	private static final int PAGE_COUNT = 5;
	
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	//게시판 리스트 ( get은 메뉴 클릭시, 조회 누를때는 post라서 구분없이 안씀)
	@RequestMapping(value="/review/reviewList")
	public String reviewList(Model model, HttpServletRequest request, HttpServletResponse response) {  
		//조회항목(1: 작성자, 2:제목, 3:내용)
		//조회항목(1: 작성자, 2: 제목, 3:내용)
		String searchType = HttpUtil.get(request, "searchType","");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue","");
		//정렬값
		String reviewFilter = HttpUtil.get(request, "reviewFilter","");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage",(long)1);
		//게시물 리스트
		List<Review> list = null;
		//썸네일 리스트
		List<ReviewFile> fileList = null;
		//조회 객체
		Review review = new Review();
		//페이징 객체
		Paging paging = null;
		//총 게시물 수 
		long totalCount = 0;
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue) ) { 
			review.setSearchType(searchType);
			review.setSearchValue(searchValue);
		}
		review.setReviewFilter(reviewFilter);
		
		totalCount = reviewService.reviewListCount(review);
		
		if(totalCount > 0) {  
			paging = new Paging("review/reviewList",totalCount,LIST_COUNT,PAGE_COUNT ,curPage,"curPage");
			review.setStartRow(paging.getStartRow());
			review.setEndRow(paging.getEndRow());
			
			list = reviewService.reviewList(review);
		}
		
		//썸네일 파일리스트
		 fileList = reviewService.thumbnailList();
		 
		model.addAttribute("list",list);
		model.addAttribute("searchType",searchType);
		model.addAttribute("searchValue",searchValue);
		model.addAttribute("reviewFilter",reviewFilter);
		model.addAttribute("curPage",curPage);
		model.addAttribute("paging",paging);
		model.addAttribute("fileList",fileList);

		return "/review/reviewList";
		
	}
	
	//리뷰글 상세페이지
	@RequestMapping(value="/review/reviewView")
	public String reviewView(ModelMap model, HttpServletRequest request, HttpServletResponse response) {  
		//쿠키 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물 번호
		long reviewSeq = HttpUtil.get(request, "reviewSeq",(long)0);
		//조회항목(1: 작성자, 2: 제목, 3: 내용)
		String searchType = HttpUtil.get(request, "searchType" , "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//정렬값
		String reviewFilter = HttpUtil.get(request, "reviewFilter","");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage",(long)1);

		//최근 게시물 리스트
		List<Review> list = null;
		//총 게시물 수 
		long totalCount = 0;
		//페이징 객체
		Paging paging = null;
		//해당 글에 작성한 이미지파일 리스트로 받아오기
		List<ReviewFile> fileList = null;
	
				
		//본인 글 여부에 대한 변수(jsp에서는 보여지는 것만 하기 때문. 나머지는 컨트롤러에서 따로!할듯!)
		String boardMe = "N";
		
		Review review = null;

		if(reviewSeq > 0 ) {  
			review = reviewService.reviewView(reviewSeq);
			if(review != null && StringUtil.equals(review.getUserId(),cookieUserId)) {  
				boardMe = "Y";
			}
			
			fileList = reviewService.reviewFileSelect(reviewSeq);
			
		}
		
		//최근게시물
		totalCount = reviewService.reviewListCount(review);
		
		if(totalCount > 0) {  
			paging = new Paging("review/reviewList",totalCount,4,PAGE_COUNT ,curPage,"curPage");
			review.setStartRow(paging.getStartRow());
			review.setEndRow(paging.getEndRow());
			
			list = reviewService.reviewList(review);
		}
		
		List<ReviewReply> replyList = null;
		if(!StringUtil.isEmpty(reviewSeq)) {
			replyList = reviewReplyService.replySelect(reviewSeq);
		}

		model.addAttribute("boardMe", boardMe);
		model.addAttribute("reviewSeq", reviewSeq);
		model.addAttribute("review", review);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("reviewFilter",reviewFilter);
		model.addAttribute("curPage", curPage);
		model.addAttribute("list", list);
		model.addAttribute("fileList", fileList);
		model.addAttribute("replyList", replyList);
		model.addAttribute("cookieUserId", cookieUserId);
		
		return "/review/reviewView";
	}
	
	//게시글 작성화면
	@RequestMapping(value = "/review/reviewWrite")
	
	public String reviewWrite(ModelMap model, HttpServletRequest request, HttpServletResponse response){
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//조회항목
		String searchType = HttpUtil.get(request,"searchType");
		//조회값
		String searchValue=HttpUtil.get(request,"searchValue");
		//현재페이지
		long curPage = HttpUtil.get(request,"curPage",(long)1);
		
		//사용자 이름 , 이메일 뿌리기
		User user = userService.userSelect(cookieUserId);
		
		//위에 가져온 값들을 model에 담기
		model.addAttribute("user", user);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("cookieUserId", cookieUserId);
	
		return "/review/reviewWrite";
	}
	
	//게시글 등록
	@RequestMapping(value="/review/reviewWriteProc",method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response){  
		Response<Object> ajaxResponse = new Response<Object>();
	      
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
	      String reviewTitle = HttpUtil.get(request, "reviewTitle", "");
	      String reviewContent = HttpUtil.get(request, "reviewContent", "");	 
	      List<FileData> fileData = HttpUtil.getFiles(request, "reviewFile", UPLOAD_REVIEW_SAVE_DIR);
	      
	      // 제목, 내용 
	      long reviewSeq = 0;	      
	      if(!StringUtil.isEmpty(reviewTitle) && !StringUtil.isEmpty(reviewContent)) {  
	    	  Review review = new Review();
	    	  review.setUserId(cookieUserId);
	    	  review.setReviewTitle(reviewTitle);
	    	  review.setReviewContent(reviewContent);
	    	  
	    	  //글 인서트
	    	  try {
		    	  if(reviewService.reviewInsert(review, fileData) == fileData.size()) {  
		    			ajaxResponse.setResponse(0, "success");
		    	  }
				}catch (Exception e) {
				        logger.error("[ReviewController] writeProc Exception" , e);
				        ajaxResponse.setResponse(500,"Internal server error");
				}
	  
		}else {
			ajaxResponse.setResponse(401, "Bad Request");
		}
		return ajaxResponse;
	}
	
	//후기글 수정페이지
	@RequestMapping(value = "/review/reviewUpdate")
	public String reviewUpdate(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물 번호
		long reviewSeq = HttpUtil.get(request, "reviewSeq",(long)0);
		//조회항목(1: 작성자, 2: 제목, 3: 내용)
		String searchType = HttpUtil.get(request, "searchType" , "");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue", "");
		//정렬값
		String reviewFilter = HttpUtil.get(request, "reviewFilter","");
		//현재페이지
		long curPage = HttpUtil.get(request, "curPage",(long)1);
		//최근 게시물 리스트
		List<Review> list = null;
		//해당 글에 작성한 이미지파일 리스트로 받아오기
		List<ReviewFile> fileList = null;
	
				
		//본인 글 여부에 대한 변수(jsp에서는 보여지는 것만 하기 때문. 나머지는 컨트롤러에서 따로!할듯!)
		String boardMe = "N";
		
		Review review = null;

		if(reviewSeq > 0 ) {  
			review = reviewService.reviewView(reviewSeq);
			if(review != null && StringUtil.equals(review.getUserId(),cookieUserId)) {  
				boardMe = "Y";
			}
			fileList = reviewService.reviewFileSelect(reviewSeq);
		}

		model.addAttribute("boardMe", boardMe);
		model.addAttribute("reviewSeq", reviewSeq);
		model.addAttribute("review", review);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("reviewFilter",reviewFilter);
		model.addAttribute("curPage", curPage);
		model.addAttribute("list", list);
		model.addAttribute("fileList", fileList);

		return "/review/reviewUpdate";
	}
	
	//후기글 수정
	//게시글 등록
	@RequestMapping(value="/review/reviewUpdateProc",method=RequestMethod.POST)
	@ResponseBody
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
	public Response<Object> reviewUpdateProc(MultipartHttpServletRequest request, HttpServletResponse response){  
		Response<Object> ajaxResponse = new Response<Object>();
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String reviewTitle = HttpUtil.get(request, "reviewTitle", "");
		String reviewContent = HttpUtil.get(request, "reviewContent", "");	 
		long reviewSeq = HttpUtil.get(request, "reviewSeq", 0);	 
		List<FileData> fileData = HttpUtil.getFiles(request, "reviewFile", UPLOAD_REVIEW_SAVE_DIR);
     

		      
		if(!StringUtil.isEmpty(reviewTitle) && !StringUtil.isEmpty(reviewContent)) {  
			Review review = new Review();
		    review.setUserId(cookieUserId);
		    review.setReviewTitle(reviewTitle);
		    review.setReviewContent(reviewContent);
		    review.setReviewSeq(reviewSeq);
		    	  
		    //글 등록하기 
		    try {
			    if(reviewService.reviewUpdate(review, fileData) == fileData.size()) {  
			    	ajaxResponse.setResponse(0, "success");
			    }
			}catch (Exception e) {
				logger.error("[ReviewController] reviewUpdateProc Exception" , e);
				ajaxResponse.setResponse(500,"Internal server error");
			}
  		  
			}else {
				ajaxResponse.setResponse(401, "Bad Request");
			}
			return ajaxResponse;
		}
	
	//글 삭제
	//게시물 삭제
		@RequestMapping(value="/review/delete",method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> delete(HttpServletRequest request, HttpServletResponse response){  
			Response<Object> ajaxResponse = new Response();
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			long reviewSeq = HttpUtil.get(request,"reviewSeq",(long)0);
			
			if(reviewSeq > 0) { 
				Review review = reviewService.reviewView(reviewSeq);
				if(review != null) {  
					if(StringUtil.equals(cookieUserId,review.getUserId())) {  
						try {
							
								if(reviewService.reviewDelete(reviewSeq) > 0 ) {  //글 삭제
									if(reviewService.reviewFileDelete(reviewSeq) > 0) { //첨부파일 삭제 
									ajaxResponse.setResponse(0,  "success");
									}else {
										ajaxResponse.setResponse(200,"File is not deleted");
										
									}
								}else {  
									ajaxResponse.setResponse(500,  "server error 1111");
								}
							
						} catch (Exception e) {
							logger.error("[HiBoardController] delete Exception" , e);
							ajaxResponse.setResponse(500, "server error 1111");
						}
					}else {  
						// 내 게시글이 아닐 경우
						ajaxResponse.setResponse(403, "server error");
					}
				}else {  
					ajaxResponse.setResponse(404, "not found");
				}
			}else {  
				ajaxResponse.setResponse(400, "bad request");
			}

			return ajaxResponse;

		}
		
		//댓글 등록
		@RequestMapping(value="/review/replyInsert")
		@ResponseBody
		public void replyInsert(HttpServletRequest request,HttpServletResponse response) throws IOException {

			//댓글 내용
			String reviewReplyContent = HttpUtil.get(request, "reviewReplyContent");
			//리뷰글 번호
			long reviewSeq = HttpUtil.get(request, "reviewSeq",(long)0);
			//부모 댓글 번호(= group번호)
			long reviewReplyGroup = HttpUtil.get(request, "reviewReplyGroup",(long)0);
			//쿠키아이디
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			ReviewReply reviewReply = new ReviewReply();
			reviewReply.setReviewReplyContent(reviewReplyContent);
			reviewReply.setReviewSeq(reviewSeq);
			reviewReply.setUserId(cookieUserId);
			reviewReply.setReviewReplyGroup(reviewReplyGroup);
			
			int result = 0;
			
				result = reviewReplyService.replyInsert(reviewReply);
			
			
			response.getWriter().print(result);

			
			
		}
		
		//대댓글 등록
		@RequestMapping(value="/review/rerReplyInsert")
		@ResponseBody
		public void rerReplyInsert(HttpServletRequest request,HttpServletResponse response) throws IOException {

			//댓글 내용
			String reviewReplyContent = HttpUtil.get(request, "reviewReplyContent");
			//리뷰글 번호
			long reviewSeq = HttpUtil.get(request, "reviewSeq",(long)0);
			//부모 댓글 번호(= group번호)
			long reviewReplyGroup = HttpUtil.get(request, "reviewReplyGroup",(long)0);
			//쿠키아이디
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
						
			ReviewReply reviewReply = new ReviewReply();
			reviewReply.setReviewReplyContent(reviewReplyContent);
			reviewReply.setReviewSeq(reviewSeq);
			reviewReply.setUserId(cookieUserId);
			reviewReply.setReviewReplyGroup(reviewReplyGroup);
			
			
			int result = 0;
			
			try {
				result = reviewReplyService.reReplyInsert(reviewReply);

			} catch (Exception e) {
    			logger.error("[ReviewController] rerReplyInsert Exception" , e);
			}
			response.getWriter().print(result);
			
		}

		//댓글 조회
		@RequestMapping(value="/review/replySelect")
		@ResponseBody
		public void replySelect(HttpServletRequest request,HttpServletResponse response) throws JsonIOException, IOException {
			Response<Object> ajaxResponse = new Response<Object>();
			long reviewSeq = HttpUtil.get(request, "reviewSeq",(long)0);
			List<ReviewReply> list = null;
			if(!StringUtil.isEmpty(reviewSeq)) {
				list = reviewReplyService.replySelect(reviewSeq);				
			}
			response.setContentType("application/json;charset=utf-8");
			new Gson().toJson(list, response.getWriter());
		}
		
		//댓글 삭제
		@RequestMapping(value="/review/replyDelete")
		@ResponseBody
		public void replyDelete(HttpServletRequest request,HttpServletResponse response) throws IOException {

			//댓글 번호
			long reviewReplySeq = HttpUtil.get(request, "reviewReplySeq",0);

			int result = 0;
				result = reviewReplyService.replyDelete(reviewReplySeq);

			response.getWriter().print(result);

		}

	
}
