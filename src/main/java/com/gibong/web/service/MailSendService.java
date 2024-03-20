package com.gibong.web.service;




import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

import com.gibong.web.controller.IndexController;
import com.gibong.web.dao.UserDao;
import com.gibong.web.model.User;

@Service
public class MailSendService {
	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

	 @Autowired   //context-mail에서 빈 등록했기 때문에 주입받을 수 있다. Spring에서 제공하는 MailSender. 
	 private JavaMailSenderImpl mailSender;
	 
	 @Autowired
	 private UserDao userDao;
	 
	
	    
	    private String getKey(int size) {
	    	int random = (int)(Math.random() * 899999) + 100000;
	    	String key = random+"";
	        return key;
	    }
	    //회원가입 시 이메일 인증번호 
	    public String sendAuthMail(String mail)  throws MessagingException{
	        String authKey = getKey(6);
	        MimeMessage mailMessage = mailSender.createMimeMessage();
	        String mailContent = "안녕하세요 맨발의 기봉이입니다.\n"
	        		+ "회원가입 메일 인증번호는  "+authKey+ "  입니다." ;     //보낼 메시지 
	            mailMessage.setSubject("[맨발의 기봉이] 메일 인증번호 발송", "utf-8"); 
	            mailMessage.setText(mailContent, "utf-8");  
	            mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(mail));
	            mailSender.send(mailMessage);
	        
	          return authKey;
	    }
	    
	    //비밀번호 찾기 시 임시비밀번호 이메일 전공
	    public String sendPwdMail(String mail, String userId)  throws MessagingException{
	        String authKey = getKey(6);
	        MimeMessage mailMessage = mailSender.createMimeMessage();
	        String mailContent = "안녕하세요 맨발의 기봉이입니다.\n"
	        		+ "임시 비밀번호는  "+authKey+ "  입니다. \n"
	        		+ "임시 비밀번호로 로그인 후 비밀번호를 꼭 변경하세요." ;     //보낼 메시지 
	            mailMessage.setSubject("[맨발의 기봉이] 임시비밀번호 발송", "utf-8"); 
	            mailMessage.setText(mailContent, "utf-8");  
	            mailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(mail));
	            mailSender.send(mailMessage);
	            
	            User user = new User();
	            user.setUserId(userId);
	            user.setUserEmail(mail);
	            user.setUserPwd(authKey);
	            
	            try {
		            userDao.updateImsiPwdKey(user);

				} catch (Exception e) {
					logger.error("[MailSendService]updateImsiPwdKey Exception",e);
				}
	            
	            logger.debug("111111111111111111111");
	            logger.debug("userDao.updateImsiPwdKey(user) : " + userDao.updateImsiPwdKey(user));
	            logger.debug("111111111111111111111");

	          return authKey;
	    }
	
	
	
	
	
}
