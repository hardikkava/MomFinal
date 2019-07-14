package com.pksh.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.pksh.model.Meeting;



@Controller
public class MeetingvsTask {
	
	@Value("${displayEditMeeting}")
	String displayEditMeeting;
	
	public static HttpHeaders getAuthHeader()
	{
		String plainCreds = "avengers:pksh@28012528"; 
		byte[] plainCredsBytes = plainCreds.getBytes(); 
		byte[] base64CredsBytes = Base64.encodeBase64(plainCredsBytes); 
		String base64Creds = new String(base64CredsBytes); 
		HttpHeaders headers = new HttpHeaders();
		
		headers.add("Authorization", "Basic " + base64Creds);
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		return headers;
	}
	
	@RequestMapping(value = "/getMeetingDetail")
	public ModelAndView getMeetingDetail(HttpSession session, @RequestParam(value="meetid") String meetid) 
	{
		ModelAndView mv = new ModelAndView();
		if(session.getAttribute("firstname") == null) {
			mv.setViewName("login");
			return mv; 
		}else {
			
			RestTemplate restTemplate = new RestTemplate();
			try
			{
				HttpEntity entity = new HttpEntity(getAuthHeader());
				
				ResponseEntity<Meeting> result = restTemplate.exchange(displayEditMeeting + meetid, HttpMethod.GET, entity, Meeting.class);
				Meeting meeting = result.getBody();
				
				mv.addObject("meeting", meeting);
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
			
			}
			mv.setViewName("mettingDetail");
			return mv;
		}
		
	}

}
