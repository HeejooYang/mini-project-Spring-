package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gibong.web.dao.DonateDao;
import com.gibong.web.model.Donate;
import com.gibong.web.model.DonateFile;

@Service("donateService")
public class DonateService {
	private static Logger logger = LoggerFactory.getLogger(ReviewService.class);

	
	@Autowired
	private DonateDao donateDao;
	
	
	public List<Donate> donateList(){  
		List<Donate> list = null;
		
		try {
			list = donateDao.donateList();
		} catch (Exception e) {
			logger.error("[DonateService] donateList Exception",e);

		}
		
		
		return list;
	}
	
	public List<DonateFile> donateFileList(){  
		List<DonateFile> list = null;
		
		try {
			list = donateDao.donateFileList();
		} catch (Exception e) {
			logger.error("[DonateService] donateList Exception",e);

		}
		return list;
	}
	
	//리뷰글 상세보기(조회수 증가 포함 X)
	public Donate donateSelect(long donateSeq) {  
		Donate donate = null;
		try {
			donate = donateDao.donateSelect(donateSeq);
		} catch (Exception e) {
			logger.error("[DonateService] donateSelect Exception",e);

		}
		
		return donate;
	}
	
	//후원글 상세보기 이미지 (글 번호로 조회)
	public DonateFile donateFile(long donateSeq) {  
		DonateFile donateFile = null;
		try {  
			donateFile = donateDao.donateFile(donateSeq);
		} catch (Exception e) {
		logger.error("[DonateService] donateFile Exception",e);
		}
		 return donateFile;
		
	}
	
	
}
