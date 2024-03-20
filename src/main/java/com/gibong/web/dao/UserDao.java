package com.gibong.web.dao;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.User;

@Repository("userDao")
public interface UserDao {
	
	//User 조회
	public User userSelect(String userId);
	
	//User 등록
	public int userInsert(User user);
	
	//User 수정
	public int userUpdate(User user);
	
	//메일인증
	//임시비밀번호 변경 
	public int updateImsiPwdKey(User user);
	
//	//메일인증한 경우 emailFlag값 1로 업데이트
//	public int updateMailFlag(String userEmail);
//	//메일인증여부 확인
//	public int emailAuthFail(String userId);
	
	//아이디 찾기
	public String findId(User user);
	
	//비밀번호찾기 시 유저 찾기
	public int findPwdNameEmail(User user);
	
	//회원 탈퇴
	public int userDelete (String userId);
	
	
	


}
