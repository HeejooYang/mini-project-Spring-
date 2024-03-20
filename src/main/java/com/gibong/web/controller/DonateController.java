package com.gibong.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gibong.web.model.Donate;
import com.gibong.web.model.DonateFile;
import com.gibong.web.service.DonateService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("donateController")
public class DonateController {
	
	@Autowired
	private DonateService donateService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);

	
	//후원글 리스트
	@RequestMapping(value="/donate/donateList")
	public String donateList(Model model, HttpServletRequest request, HttpServletResponse response) {  
		//쿠키아이디
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//후원 글 리스트
		List<Donate> list = null;
		//이미지 리스트
		List<DonateFile> fileList = null;
		
		//글 불러오기
		list = donateService.donateList();
		
		//이미지(썸네일 불러오기)
		fileList = donateService.donateFileList();
		
		model.addAttribute("list",list);
		model.addAttribute("fileList",fileList);

		return "/donate/donateList";

	}
	
	//후원상세페이지
	@RequestMapping(value="/donate/donateView")
	public String donateView(ModelMap model, HttpServletRequest request, HttpServletResponse response) {  
		//쿠키 값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물 번호
		long donateSeq = HttpUtil.get(request, "donateSeq",(long)0);
		//후원 글
		Donate donate = new Donate();
		//이미지 
		DonateFile donateFile = new DonateFile();
		
		
		if(donateSeq > 0) {  
			donate = donateService.donateSelect(donateSeq);
			if(donate != null) {
				donateFile = donateService.donateFile(donateSeq);
			}
		}
		
		model.addAttribute("donate", donate);
		model.addAttribute("donateFile", donateFile);

		return "/donate/donateView";
	
	}	
	
	
	

}
