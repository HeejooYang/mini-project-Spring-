package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gibong.web.dao.VolunDao;
import com.gibong.web.model.Volun;
import com.gibong.web.model.VolunFile;

@Service("volunService")
public class VolunService {
	private static Logger logger = LoggerFactory.getLogger(VolunService.class);

	@Autowired
	private VolunDao volunDao;
	
	//봉사활동 리스트
		public List<Volun> volunList(){  
			List<Volun> list = null;
			try {
				list = volunDao.volunList();
			} catch (Exception e) {
				logger.error("[VolunService] volunList Exception",e);
			}
			
			
			return list;
		}
		
		//봉사활동글 상세보기volunView 글 조회
		public Volun volunView(long volunSeq) {  
			Volun volun = null;
			try {
				volun=volunDao.volunView(volunSeq);
			} catch (Exception e) {
				logger.error("[VolunService] volunView Exception",e);
			}
			
			return volun;
			
		}
		
		//리스트 이미지 모두 조회
		public List<VolunFile> volunFileList(){  
			List<VolunFile> list = null;
			try {
				list = volunDao.volunFileList();
			} catch (Exception e) {
				logger.error("[VolunService] volunFileList Exception",e);
			}
			
			return list;
			
		}
		
		//volunView에 해당하는 이미지 조회
		public VolunFile volunFile(long volunSeq) {  
			VolunFile volunFile = null;
			try {
				volunFile=volunDao.volunFile(volunSeq);
			} catch (Exception e) {
				logger.error("[VolunService] volunFile Exception",e);
			}
			
			return volunFile;
		}
	

}
