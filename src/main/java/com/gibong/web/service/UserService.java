package com.gibong.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gibong.web.dao.UserDao;
import com.gibong.web.service.UserService;
import com.gibong.web.model.User;

@Service("userService")
public class UserService {
	private static Logger logger = LoggerFactory.getLogger(UserService.class);

	@Autowired
	private UserDao userDao;
	
	//User 조회
	public User userSelect(String userId) {
		User user = null;
		
		try {
			user = userDao.userSelect(userId);
		}catch(Exception e) {
			logger.error("[UserService]userSelect Exception",e);
		}
		
		return user;
		
	}

	
	//User 등록
	public int userInsert(User user) {
		int count = 0;
		
		try {
			count = userDao.userInsert(user);
		} catch (Exception e) {
			logger.error("[UserService]userInsert Exception",e);
		}
		return count;
	}

	
	//User 수정
	public int userUpdate(User user) {  
		int count =0;
		try {
			count=userDao.userUpdate(user);
		} catch (Exception e) {
			logger.error("[UserService]userUpdate Exception",e);
		}
		return count;
	}
	
	//메일인증
	//비밀번호 찾기 : 난수 저장 (임시비밀번호)
	public int updateImsiPwdKey(User user) { 
		int count = 0;
		try {
			count = userDao.updateImsiPwdKey(user);
		} catch (Exception e) {
			logger.error("[UserService]updateMailKey Exception",e);

		}
		return count;
	}
//	//메일인증한 경우 emailFlag값 1로 업데이트 
//	public int updateMailFlag(String userEmail) {
//		int count = 0;
//		try {
//			count = userDao.updateMailFlag(userEmail);
//		} catch (Exception e) {
//			logger.error("[UserService]updateMailFlag Exception",e);
//		}
//
//		return count;
//	}
//	
//	//메일 인증 여부 체크
//	public int emailAuthFail(String userId) {  
//		int count = 0;
//		
//		try {
//			count = userDao.emailAuthFail(userId);
//		} catch (Exception e) {
//			logger.error("[UserService]emailAuthFail Exception",e);
//		}
//
//		return count;
//		
//	}

	
	//비밀번호찾기 시 유저 찾기
	public int findPwdNameEmail(User user) { 
		int count = 0;
		try {
			count=userDao.findPwdNameEmail(user);
		} catch (Exception e) {
			logger.error("[UserService]findPwdNameEmail Exception",e);

		}
		
		return count;
	}
	
	
	//아이디 찾기
	public String findId(User user) {
		String userId=null;
		try {
			userId = userDao.findId(user);
		} catch (Exception e) {
			logger.error("[UserService]findId Exception",e);
		}
		return userId;
	}
	
	//회원탈퇴
	public int userDelete (String userId) {  
		int count = 0;
		
		try {
			count = userDao.userDelete(userId);
		} catch (Exception e) {
			logger.error("[UserService]userDelete Exception",e);

		}
		
		
		
		return count;
	}
	
	

}
