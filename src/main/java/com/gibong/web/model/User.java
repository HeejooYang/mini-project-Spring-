package com.gibong.web.model;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class User implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	private String userId;			//회원 아이디
	private String userPwd; 		//회원 비밀번호
	private String userPhone;		//회원 전화번호
	private String userEmail;		//회원 이메일
	private String userEmailFlag;	//이메일 인증여부 (o: 인증, x: 미인증)
	private String userName;		//회원 이름
	private String userStatus;		//회원 상태(y:정상, n:정지)
	private String userFlag;		//회원 구분 (g: 기업 회원, u: 일반 회원)
	private String userRegdate;		//회원 가입일
	private String userZipcode;		//우편 번호
	private String userAddr1;		//도로명 주소
	private String userAddr2;		//상세 주소
	private String mailKey;			//메일인증 난수 저장
	
	public User() {
		userId = "";			//회원 아이디
		userPwd = ""; 		//회원 비밀번호
		userPhone = "";		//회원 전화번호
		userEmail = "";		//회원 이메일
		userEmailFlag = "0";	//이메일 인증여부 (1: 인증, 0: 미인증)
		userName = "";		//회원 이름
		userStatus = "Y";		//회원 상태(y:정상, n:정지)
		userFlag = "";		//회원 구분 (g: 기업 회원, u: 일반 회원)
		userRegdate = "";	//회원 가입일
		userZipcode = "";	//우편 번호
		userAddr1 = "";		//도로명 주소
		userAddr2 = "";		//상세 주소
		mailKey = "";		//메일인증 난수저장
	}

}
