package com.pksh.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.pksh.model.Search;
import com.pksh.model.User;

@Controller
public class MOMController 
{
	@Value("${LoginURL}")
	String LoginURL;
	
	@Value("${SearchParticipants}")
	String SearchParticipants;
	
	@RequestMapping("/")
	public String login() 
	{
		return "login";
	}
	
	@RequestMapping(value = "/loginForm", method=RequestMethod.POST)
	public @ResponseBody ModelAndView loginData(HttpServletRequest request,@RequestParam(name="email") String email,@RequestParam(name="password") String password) 
	{
		String msg = "";
		String viewName = "";
		ModelAndView mv = new ModelAndView();
		Map<String, String>  map = new HashMap<String, String>();
		map.put("email", email);
		map.put("password", password);
		
		try
		{
			RestTemplate restTemplate = new RestTemplate();
			
			HttpEntity<Map<String, String>> entity = new HttpEntity<>(map, getAuthHeader());
			
			ResponseEntity<User> result = restTemplate.exchange(LoginURL, HttpMethod.POST, entity, User.class);
			User user= result.getBody();
			
			HttpSession session = request.getSession();
			if(user != null && user.getFirstname() != null && user.getLastname() != null)
			{
				session.setAttribute("firstname", user.getFirstname());
				session.setAttribute("lastname", user.getLastname());
			}
			
			mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
			viewName = "home";
			
			
			
		}
		catch(HttpClientErrorException e)
		{
			System.out.println("EXCEPTION OCCURS DURING LOGIN ::: "+e);
			msg = "Invalid email or password.";
			viewName = "login";
		}
		if(!msg.isEmpty())
		{
			mv.addObject("type", "alert");
			mv.addObject("message", msg);
		}
		mv.setViewName(viewName);
		return mv;
	}
	
	@RequestMapping(value = "/logout")
	public ModelAndView getlogoutRequest(HttpServletRequest request)
	{
		ModelAndView mv = new ModelAndView();
		
		HttpSession session = request.getSession(false);
		if(session != null)
		{
			session.invalidate();
		}
		
		mv.addObject("type","success");
		mv.addObject("message", "You have been successfully logged out.");
		mv.setViewName("login");
		
		return mv;
	}
	
	@RequestMapping("/dashboard")
	public String dashboard() 
	{
		return "dashboard";
	}
	
	@RequestMapping("/createMeeting")
	public String createMeeting() 
	{
		return "createMeeting";
	}
	
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
	
	@RequestMapping("/searchParticipants")
	public @ResponseBody List<Search> searchParticipants(@RequestParam String paramName) 
	{
		List<String> userList = null;
		List<Search> searchList = new ArrayList<Search>();
		try
		{
			RestTemplate restTemplate = new RestTemplate();
			HttpEntity entity = new HttpEntity(getAuthHeader());
			
			ResponseEntity<List> result = restTemplate.exchange(SearchParticipants + paramName, HttpMethod.GET, entity, List.class);
			userList = result.getBody();
			
			for(String user : userList)
			{
				Search search = new Search();
				search.setEmail(user);
				search.setUsername(user);
		
				searchList.add(search);
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception during searching ::: "+e);
		}
		return searchList;
	}
	
	@RequestMapping("/registerAccount")
	public String signUp() 
	{
		return "signUp";
	}
	
}
