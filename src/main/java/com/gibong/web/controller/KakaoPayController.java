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

import com.google.gson.JsonObject;
import com.gibong.common.util.StringUtil;
import com.gibong.web.model.KakaoPayApprove;
import com.gibong.web.model.KakaoPayOrder;
import com.gibong.web.model.KakaoPayReady;
import com.gibong.web.model.Response;
import com.gibong.web.service.KakaoPayService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("kakaoPayController")
public class KakaoPayController {
	
	private static Logger logger = LoggerFactory.getLogger(KakaoPayController.class);
	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	//쿠키
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@RequestMapping(value="/kakao/pay")
	public String pay(HttpServletRequest request, HttpServletResponse response) {  
		
		return "/kakao/pay";
	}
	
	@RequestMapping(value="/kakao/payReady", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payReady(HttpServletRequest request, HttpServletResponse response){  
		Response<Object> ajaxResponse = new Response<Object>();
		
		String orderId = StringUtil.uniqueValue();//우리사이트의 주문번호는 고유한 값으로 보낸다
		String userId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
		
		String itemCode = HttpUtil.get(request, "itemCode","");
		String itemName = HttpUtil.get(request, "itemName","");
		int quantity = HttpUtil.get(request, "quantity",(int)0);
		int totalAmount = HttpUtil.get(request, "totalAmount",(int)0);
		
		int taxFreeAmount = HttpUtil.get(request, "taxFreeAmount",(int)0);
		int vatAmount = HttpUtil.get(request, "vatAmount",(int)0);
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setItemCode(itemCode);
		kakaoPayOrder.setItemName(itemName);
		kakaoPayOrder.setQuantity(quantity);
		kakaoPayOrder.setTotalAmount(totalAmount);
		kakaoPayOrder.setTaxFreeAmount(taxFreeAmount);
		kakaoPayOrder.setVatAmount(vatAmount);
		
		KakaoPayReady kakaoPayReady = kakaoPayService.kakaoPayReady(kakaoPayOrder);
		
		if(kakaoPayReady != null) {  
			logger.debug("[KakaoPayController] kakaoPayReady : " + kakaoPayReady);
			kakaoPayOrder.setTId(kakaoPayReady.getTid()); //kakaoPayReady 메서드와 중복 ( 같은 걸 두번 한다 왜?)
			
			JsonObject json = new JsonObject();
			
			json.addProperty("orderId", orderId);//우리사이트의 우리 회원 여기 확인하기
			json.addProperty("tId", kakaoPayReady.getTid()); // 이게 쿠키같은거
			json.addProperty("appUrl", kakaoPayReady.getNext_redirect_app_url());
			json.addProperty("mobileUrl", kakaoPayReady.getNext_redirect_mobile_url());//이건 모바일 버전
			json.addProperty("pcUrl", kakaoPayReady.getNext_redirect_pc_url());//이걸로 큐알코드 팝업을 띄운다.
			
			
			
			ajaxResponse.setResponse(0, "Success", json);
			
		}else {  
			ajaxResponse.setResponse(-1, "fail", null);
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/kakao/payPopUp", method=RequestMethod.POST)
	public String payPopUp(ModelMap model, HttpServletRequest request, HttpServletResponse response) {  
		
		String pcUrl = HttpUtil.get(request, "pcUrl","");
		String orderId = HttpUtil.get(request, "orderId","");
		String tId = HttpUtil.get(request, "tId","");
		String userId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
		
		model.addAttribute("pcUrl",pcUrl);
		model.addAttribute("orderId",orderId);
		model.addAttribute("tId",tId);
		model.addAttribute("userId",userId);
		
		
		
		
		
		
		
		return "/kakao/payPopUp";
		
	}
	@RequestMapping(value="/kakao/paySuccess")
	public String paySuccess(ModelMap model, HttpServletRequest request, HttpServletResponse response) {  
		
		//큐알 찍으면 성공했다고 메세지 보내는거 받기
		String pgToken = HttpUtil.get(request, "pg_token","");
		
		model.addAttribute("pgToken",pgToken);
		
		return "/kakao/paySuccess";
		
	}
	
	
	@RequestMapping(value="/kakao/payResult")
	public String payResult(ModelMap model, HttpServletRequest request, HttpServletResponse response) {  
		
		KakaoPayApprove kakaoPayApprove = null;
		
		String tId = HttpUtil.get(request,"tId","");
		String orderId = HttpUtil.get(request,"orderId","");
		String userId = CookieUtil.getHexValue(request,AUTH_COOKIE_NAME);
		String pgToken = HttpUtil.get(request,"pgToken","");
		
		KakaoPayOrder kakaoPayOrder = new KakaoPayOrder();
		
		kakaoPayOrder.setPartnerOrderId(orderId);
		kakaoPayOrder.setPartnerUserId(userId);
		kakaoPayOrder.setTId(tId);
		kakaoPayOrder.setPgToken(pgToken);
		
		kakaoPayApprove = kakaoPayService.kakaoPayApprove(kakaoPayOrder);
		
		model.addAttribute("kakaoPayApprove",kakaoPayApprove);
		

		
		return "/kakao/payResult";
		
	}
	
	//결제 취소 시
	@RequestMapping(value="/kakao/payCancel")
	public String payCancel(HttpServletRequest request, HttpServletResponse response) {  
		
		return "/kakao/payCancel";
		
	}
	
	//결제 실패
	@RequestMapping(value="/kakao/payFail")
	public String payFail(HttpServletRequest request, HttpServletResponse response) {  
		
		return "/kakao/payFail";
	}
	

	
	
	
	
	
	
}
