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
import org.springframework.web.bind.annotation.RequestMethod;

import com.gibong.web.model.Volun;
import com.gibong.web.model.VolunFile;
import com.gibong.web.service.VolunService;
import com.gibong.web.util.CookieUtil;
import com.gibong.web.util.HttpUtil;

@Controller("volunController")
public class VolunController {
	
	@Autowired
	private VolunService volunService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	private static Logger logger = LoggerFactory.getLogger(VolunController.class);

	//봉사글 리스트 
	@RequestMapping(value = "/volunteer/volunList")
	public String volunList(Model model, HttpServletRequest request, HttpServletResponse response)
	{
		//쿠키아이디
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//봉사 글 리스트
		List<Volun> list = null;
		//이미지 리스트
		List<VolunFile> fileList = null;

				//글 불러오기
				list = volunService.volunList();
				
				//이미지(썸네일 불러오기)
				fileList = volunService.volunFileList();
				
				model.addAttribute("list",list);
				model.addAttribute("fileList",fileList);

		return "/volunteer/volunList";
	}

	
	
	
	
	//volunView 봉사 상세
	@RequestMapping(value = "/volunteer/volunView")
	public String volunView(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		//쿠키아이디
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//게시물 번호
		long volunSeq = HttpUtil.get(request, "volunSeq",(long)0);
		//봉사 글 
		Volun volun = new Volun();
		//이미지 
		VolunFile volunFile = new VolunFile();
		
		if(volunSeq > 0) {  
			volun = volunService.volunView(volunSeq);
			if(volun != null) {
				volunFile = volunService.volunFile(volunSeq);
			}
		}
		
		model.addAttribute("volun", volun);
		model.addAttribute("volunFile", volunFile);

	return "/volunteer/volunView";
	}
	
	
	
	//////////////////상세기능 미구현////////////////////////
	@RequestMapping(value = "/user/myVolun", method=RequestMethod.GET)
	public String myVolun(HttpServletRequest request, HttpServletResponse response)
	{

		return "/user/myVolun";
	}

	@RequestMapping(value = "/volunteer/volunWrite", method=RequestMethod.GET)
	public String volunWrite(HttpServletRequest request, HttpServletResponse response)
	{
		return "/volunteer/volunWrite";
	}
	@RequestMapping(value = "/volunteer/volunUpdate", method=RequestMethod.GET)
	public String volunUpdate(HttpServletRequest request, HttpServletResponse response)
	{
		return "/volunteer/volunUpdate";
	}


	
	
	
	
	
	
	
	
	
	
	
	

}
