package com.gibong.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gibong.web.model.Response;
import com.gibong.web.service.MailSendService;
import com.gibong.web.service.UserService;

import com.gibong.web.util.HttpUtil;
import com.gibong.common.util.StringUtil;
import com.gibong.web.model.User;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.JsonUtil;

@Controller("gibongController")
public class GibongUserController {

		private static Logger logger = LoggerFactory.getLogger(IndexController.class);

		@Autowired
		private UserService userService;
		
		@Autowired
		private MailSendService mailSendService; 
		
		@Value("#{env['auth.cookie.name']}")
		private String AUTH_COOKIE_NAME;
		
		
		//로그인 페이지
		@RequestMapping(value = "/user/login", method=RequestMethod.GET)
		public String login(HttpServletRequest request, HttpServletResponse response)
		{
			return "/user/login";
		}
		
		//로그인
		@RequestMapping(value = "/user/login", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> loginProc(HttpServletRequest request, HttpServletResponse response){
			Response<Object> ajaxResponse = new Response<Object>();
			
			String userId = HttpUtil.get(request, "userId");
			String userPwd = HttpUtil.get(request,"userPwd");
			
			if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd)) {
				User user = userService.userSelect(userId);
				
				if(user != null) {
					if(StringUtil.equals(user.getUserPwd(), userPwd)) {
						if(StringUtil.equals(user.getUserStatus(),"Y")) {
							
							CookieUtil.addCookie(response,"/", -1,AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));
							ajaxResponse.setResponse(0,"success");
						
						}else {  
							ajaxResponse.setResponse(-99,"server error");
						}
					}else {//비밀번호 불일치
						ajaxResponse.setResponse(-1, "password mismatch");
					}
				}else {//해당 user 정보가 없음
					ajaxResponse.setResponse(404, "Not found");
				}
			}else {//userId, userPwd값이 안넘어오는게 있을 때 
				ajaxResponse.setResponse(400, "Bad Request");
			}
			
			if(logger.isDebugEnabled()) {
				logger.debug("[UserController] /user/login response \n" + JsonUtil.toJsonPretty(ajaxResponse));
			}
			
			
			return ajaxResponse;
		}
		
		//로그아웃
		@RequestMapping(value="/user/loginOut",method=RequestMethod.GET)
		public String loginOut(HttpServletRequest request,HttpServletResponse response) {  
			if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {  
				CookieUtil.deleteCookie(request, response, "/" , AUTH_COOKIE_NAME);

			}
			
			return "redirect:/"; // 재접속
		}
		
		//메일인증
		@RequestMapping("/email/mailAuth.wow")
		@ResponseBody
		public String mailAuth(String mail, HttpServletResponse resp) throws Exception {
		    String authKey = mailSendService.sendAuthMail(mail); //사용자가 입력한 메일주소로 메일을 보냄
		    return authKey;
		}

		
		//메일 임시번호 발급
		@RequestMapping("/email/mailPwd.wow")
		@ResponseBody
		public String sendPwdMail(String mail,String userId, HttpServletResponse resp) throws Exception {
			String authKey = mailSendService.sendPwdMail(mail,userId); //사용자가 입력한 메일주소로 메일을 보냄
		    
		    
		    return authKey;
		}
		
		//비밀번호 찾기 시 유저 확인
		  @RequestMapping(value="/user/findPwdNameEmail", method=RequestMethod.POST)
		  @ResponseBody
		  public Response<Object> findPwdNameEmail(HttpServletRequest request, HttpServletResponse response) {
		      Response<Object> ajaxResponse = new Response<Object>();
				String userId =HttpUtil.get(request, "userId");
				String userEmail =HttpUtil.get(request, "userEmail");
		      
				if( !StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userEmail) ) {  
					User user = new User();
					user.setUserId(userId);
					user.setUserEmail(userEmail);

					if(userService.findPwdNameEmail(user) > 0 ) {  
						ajaxResponse.setResponse(0, "Success");
						

					}else {  
						ajaxResponse.setResponse(100, "No User");
					}
					
				}else {  
					ajaxResponse.setResponse(401, "Bad Request");
				}
			  return ajaxResponse;
		  }

		
		//회원가입
		@RequestMapping(value="/user/join", method=RequestMethod.GET)
		public String regForm(HttpServletRequest request,HttpServletResponse response) {
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			if(!StringUtil.isEmpty(cookieUserId)) {
				CookieUtil.deleteCookie(request,response,"/",AUTH_COOKIE_NAME);
				return "redirect:/";		//재접속하라는 명령
						
			}else {
				return "/user/join"; //리턴타입이 스트링이면  뷰 리졸버로 리턴타입을 보냄 (servlet-context.xml로 보내서 디폴트경로 세팅)
						//스프링mvc의 정의는 스픨ㅇ위에 돌아감 스프링이 돌아갈때 톰캣 스타트하면 여러 파일 읽는 것 중 server.xml읽음
						//host별로 읽는다. appBase가 디폴트 경로 ""이면 dockBase 읽음. 그래서 webapp읽음.
						//그리고 web.xml을 보고 맨 밑에 welcomfilelist보고 index찾아감.
						//webapp 밑에 web-INF가 톰캣의 기본 폴ㅇ더임. 이 밑의 web.xml을 실행함.이를 읽으면서 spring mvc 환경이 시작 되는 것! 이게 roo-context.xml, env.xml, servelt-context.xml읽음
						//빨간색은 톰캣, 검정색은 스프링에서 찍는 로그
		
			}
		}
	
				//아이디 중복 체크
				@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
				@ResponseBody
				public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response){
					Response<Object> ajaxResponse = new Response<Object>();
					String userId = HttpUtil.get(request, "userId");
					
					if(!StringUtil.isEmpty(userId)) {
						if(userService.userSelect(userId) == null) {
							//사용가능한 아이디
							ajaxResponse.setResponse(0,"Success");
						}else {
							ajaxResponse.setResponse(100,"Duplicated id");
						}
					}else {
						ajaxResponse.setResponse(400,"Bad Request");//값이 안넘어올경우
					}
					if(logger.isDebugEnabled()) {
						logger.debug("[UserController] /user/idCheck response\n" + 
																JsonUtil.toJsonPretty(ajaxResponse));
					}
					
					return ajaxResponse;
				}
				

				//회원등록
				@RequestMapping(value="/user/regProc", method=RequestMethod.POST)
				@ResponseBody
				public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response){
					Response<Object> ajaxResponse = new Response<Object>();
					
					//이 밑의 값들이 ajax에서 data 값이다
					String userId =HttpUtil.get(request, "userId");
					String userPwd =HttpUtil.get(request, "userPwd");
					String userPhone =HttpUtil.get(request, "userPhone");
					String userName =HttpUtil.get(request, "userName");
					String userEmail =HttpUtil.get(request, "userEmail");
					String userFlag =HttpUtil.get(request, "userFlag");
					String userZipcode =HttpUtil.get(request, "userZipcode");
					String userAddr1 =HttpUtil.get(request, "userAddr1");
					String userAddr2 =HttpUtil.get(request, "userAddr2");

					if( !StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && 
							 !StringUtil.isEmpty(userPhone) && !StringUtil.isEmpty(userName) && 
							!StringUtil.isEmpty(userEmail)&& !StringUtil.isEmpty(userFlag)&& !StringUtil.isEmpty(userZipcode)
							&& !StringUtil.isEmpty(userAddr1) && !StringUtil.isEmpty(userAddr2)) { 
						if(userService.userSelect(userId) == null) { // url로 중복아이디를 가입하는 경우가 있을 테니 ( 500번 오류가 안뜨게 하는 예외처리과정을 항상 생각하자)
							//중복 아이디가 없을 경우 정상적으로 등록
							User user =new User();
							user.setUserId(userId);
							user.setUserPwd(userPwd);
							user.setUserPhone(userPhone);
							user.setUserEmail(userEmail);
							user.setUserName(userName);
							user.setUserEmailFlag("1");
							//user.setUserStatus("Y");
							user.setUserFlag(userFlag);
							user.setUserZipcode(userZipcode);
							user.setUserAddr1(userAddr1);
							user.setUserAddr2(userAddr2);
						
							if(userService.userInsert(user) >0) {
								ajaxResponse.setResponse(0,"Success");
							}else {
								ajaxResponse.setResponse(500, "Internal Server Error");
							}
						}else { 
							//중복 아이디일경우
							ajaxResponse.setResponse(100, "Dulicated Id");
						}
							
					}else {
						ajaxResponse.setResponse(400,"Bad Request");//값이 안넘어올경우
					}
					if(logger.isDebugEnabled()){
						logger.debug("[UserController] /user/regProc response\n" + 
																JsonUtil.toJsonPretty(ajaxResponse));
					}

					return ajaxResponse;
				}
				
				
		//아이디 찾기
		@RequestMapping(value="/user/findIdResult")
		public String findIdResultis(ModelMap model,HttpServletRequest request, HttpServletResponse response) {  
			String userId = null;
			String userName =HttpUtil.get(request, "userName");
			String userEmail =HttpUtil.get(request, "userEmail");
			User user = new User();

			if( !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) ) {  
				
				user.setUserName(userName);
				user.setUserEmail(userEmail);
				userId=userService.findId(user);

			}

			model.addAttribute("userId", userId);
			
			return "/user/findIdResult";
			
		}
		//회원정보 수정
		@RequestMapping(value = "/user/infoUpdate")
		public String infoUpdate(ModelMap model, HttpServletRequest request, HttpServletResponse response)
		{
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			User user = userService.userSelect(cookieUserId);
			
			model.addAttribute("user", user); 
			
			return "/user/infoUpdate";
		}
		
		//회원정보수정(ajax통신용)
		@RequestMapping(value="/user/updateProc")
		@ResponseBody
		public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response){  
			Response<Object> ajaxResponse = new Response<Object>();
			String userId =HttpUtil.get(request,"userId");
			String userPwd =HttpUtil.get(request,"userPwd");
			String userName =HttpUtil.get(request,"userName");
			String userEmail =HttpUtil.get(request,"userEmail");
			String userPhone =HttpUtil.get(request, "userPhone");
			String userZipcode =HttpUtil.get(request, "userZipcode");
			String userAddr1 =HttpUtil.get(request, "userAddr1");
			String userAddr2 =HttpUtil.get(request, "userAddr2");
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			if(!StringUtil.isEmpty(cookieUserId)) { //로그인이 되어있는지
				if(StringUtil.equals(userId, cookieUserId)) {// 로그인한 아이디와 수정하는 아이디가 다른 경우
					User user = userService.userSelect(cookieUserId); // 여기서는 userId랑 cookieUserId가 같으니까 바꿔써도 됨
					if(user != null) {  //db에 아이디에 해당하는 정보가 있는지
						if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) ) {  
							user.setUserPwd(userPwd); //아이디는 동일한거 확인했고 재설정하는거 아니니까 setUserId안함
							user.setUserName(userName);
							user.setUserEmail(userEmail);
							user.setUserId(userId);
							user.setUserPwd(userPwd);
							user.setUserPhone(userPhone);
							user.setUserEmail(userEmail);
							user.setUserName(userName);
							user.setUserEmailFlag("1");
							user.setUserZipcode(userZipcode);
							user.setUserAddr1(userAddr1);
							user.setUserAddr2(userAddr2);
							if(userService.userUpdate(user)>0) {
								ajaxResponse.setResponse(0, "Success");
							}else {  //update문이 안됐을때
								ajaxResponse.setResponse(500, "internal server error");
							}

						}else {  //파라미터 값이 올바르지 않을 경우
							ajaxResponse.setResponse(400, "Bad Request");
						}
					}else {// 일치하는 사용자 정보가 없는 경우
							CookieUtil.deleteCookie(request, response, "/" , AUTH_COOKIE_NAME);
							ajaxResponse.setResponse(404, "Not found");
					}
				}else {  //쿠키아이디와 넘어온 아이디 값이 다른 경우 
					CookieUtil.deleteCookie(request, response, "/" , AUTH_COOKIE_NAME);
					ajaxResponse.setResponse(430,"Id Information is different");
					
				}
			}else {  
				ajaxResponse.setResponse(410,"Login Fail");
			}
			if(logger.isDebugEnabled()){
				logger.debug("[UserController] /user/updateProc response\n" + 
											JsonUtil.toJsonPretty(ajaxResponse));
			}
			
			return ajaxResponse;
		}
		
		//회원정보화면
		@RequestMapping(value = "/user/infoList", method=RequestMethod.GET)
		public String infoList(ModelMap model, HttpServletRequest request, HttpServletResponse response)
		{
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			User user = userService.userSelect(cookieUserId);
			
			model.addAttribute("user", user); 
			
			return "/user/infoList";
		}
		
		//회원 탈퇴
		@RequestMapping(value="/user/userDeleteProc", method=RequestMethod.POST)
		@ResponseBody
		public Response<Object> userDelete(HttpServletRequest request, HttpServletResponse response){  			
			Response<Object> ajaxResponse = new Response<Object>();
			String userId =HttpUtil.get(request,"userId");
			String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
			
			logger.debug("111111111111111111111111111111");
			logger.debug("cookieUserId : " +cookieUserId);
			logger.debug("userId : " +userId);
			logger.debug("111111111111111111111111111111");
			
			if(!StringUtil.isEmpty(cookieUserId)) { //로그인이 되어있는지
				if(StringUtil.equals(userId, cookieUserId)) {// 로그인한 아이디와 수정하는 아이디가 다른 경우
					User user = userService.userSelect(cookieUserId); // 여기서는 userId랑 cookieUserId가 같으니까 바꿔써도 됨
					if(user != null) {  //db에 아이디에 해당하는 정보가 있는지
						
							if(userService.userDelete(userId) > 0 ) {
								CookieUtil.deleteCookie(request, response, "/" , AUTH_COOKIE_NAME);
								ajaxResponse.setResponse(0, "Success");
							}else {  //update문이 안됐을때
								ajaxResponse.setResponse(500, "internal server error");
							}

						}else {  //파라미터 값이 올바르지 않을 경우
							CookieUtil.deleteCookie(request, response, "/" , AUTH_COOKIE_NAME);
							ajaxResponse.setResponse(400, "Bad Request");
						
						}

				}else {  //쿠키아이디와 넘어온 아이디 값이 다른 경우 
					CookieUtil.deleteCookie(request, response, "/" , AUTH_COOKIE_NAME);
					ajaxResponse.setResponse(430,"Id Information is different");
				}
			}else {  
				ajaxResponse.setResponse(410,"Login Fail");
			}
			if(logger.isDebugEnabled()){
				logger.debug("[UserController] /user/updateProc response\n" + 
											JsonUtil.toJsonPretty(ajaxResponse));
			}

			return ajaxResponse;

		}

		//////////////////////////////////상세기능 미구현//////////////////////////////////////
	
	
		@RequestMapping(value = "/board/checkOut", method=RequestMethod.GET)
		public String checkOut(HttpServletRequest request, HttpServletResponse response)
		{
			return "/board/checkOut";
		}
		
		@RequestMapping(value = "/board/fundDetail", method=RequestMethod.GET)
		public String fundDetail(HttpServletRequest request, HttpServletResponse response)
		{
			return "/board/fundDetail";
		}

		@RequestMapping(value = "/donate/donatePay", method=RequestMethod.GET)
		public String donatePay(HttpServletRequest request, HttpServletResponse response)
		{
			return "/donate/donatePay";
		}
		@RequestMapping(value = "/donate/donateWrite", method=RequestMethod.GET)
		public String donateWrite(HttpServletRequest request, HttpServletResponse response)
		{
			return "/donate/donateWrite";
		}
		
		@RequestMapping(value = "/user/findId", method=RequestMethod.GET)
		public String findId(HttpServletRequest request, HttpServletResponse response)
		{
			return "/user/findId";
		}
		@RequestMapping(value = "/user/findIdResult", method=RequestMethod.GET)
		public String findIdResult(HttpServletRequest request, HttpServletResponse response)
		{
			return "/user/findIdResult";
		}

		@RequestMapping(value = "/user/findPwd", method=RequestMethod.GET)
		public String findPwd(HttpServletRequest request, HttpServletResponse response)
		{
			return "/user/findPwd";
		}

		@RequestMapping(value = "/user/myPage")
		public String myPage(HttpServletRequest request, HttpServletResponse response)
		{
			return "/user/myPage";
		}

		@RequestMapping(value = "/manager/admin", method=RequestMethod.GET)
		public String admin(HttpServletRequest request, HttpServletResponse response)
		{
			return "/manager/admin";
		}
		
		@RequestMapping(value = "/manager/adminUpdate", method=RequestMethod.GET)
		public String adminUpdate(HttpServletRequest request, HttpServletResponse response)
		{
			return "/manager/adminUpdate";
		}
		
		
		
		
	
}
