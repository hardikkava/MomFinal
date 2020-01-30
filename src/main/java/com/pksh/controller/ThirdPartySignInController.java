package com.pksh.controller;

import java.security.Principal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.json.*;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pksh.model.GmailUser;
import com.pksh.model.User;

@Controller
public class ThirdPartySignInController {

	@Value("${searchUserByEmail}")
	String searchUserByEmail;
	
	@Value("${RegisterURL}")
	String RegisterURL;
	
	@RequestMapping("/SignInWithGoogle")
	public ModelAndView SignInWithGoogle(Principal principal,HttpServletRequest request) throws Exception {
		ModelAndView mv=new ModelAndView();
		ObjectMapper mapper = new ObjectMapper();
		User addUserObj=new User();
		String msg = "";
		String viewName = "";
		HttpEntity entity=new HttpEntity(MOMController.getAuthHeader());
		try {
		GmailUser userObj = null;
		if (principal != null) {
			String user = mapper.writeValueAsString(principal);
			if (user != null || !user.equals("")) {
				JSONObject jsonResult = new JSONObject(user);
				if (jsonResult != null) {
					String userData = jsonResult.getJSONObject("userAuthentication").getJSONObject("details")
							.toString();
					if (userData != null || !userData.equals("")) {
						userObj = mapper.readValue(userData, GmailUser.class);
						System.out.println(userObj.toString());
						
						try {
							ResponseEntity<List> result=null;
							List<User> userList=null;
							RestTemplate searchEmailTemplate =new RestTemplate();
							result=searchEmailTemplate.exchange(searchUserByEmail+userObj.getEmail(), HttpMethod.GET, entity, List.class);
							userList=result.getBody();
							HttpSession session = request.getSession();
							session.setAttribute("firstname", userObj.getGiven_name());
							session.setAttribute("lastname", userObj.getFamily_name());
							session.setAttribute("email", userObj.getEmail());
							if(result!=null) {
								System.out.println("Result is not null ");
								viewName="home";
							}
						}catch (Exception  e) {
							System.out.println(e);
							if(userObj!=null) {
								addUserObj.setUsername(userObj.getEmail());
								addUserObj.setFirstname(userObj.getGiven_name());
								addUserObj.setLastname(userObj.getFamily_name());
								addUserObj.setEmail(userObj.getEmail());
								addUserObj.setGuest("no");
								addUserObj.setAddress("New Address");
								addUserObj.setPassword("TestPassword");
								addUserObj.setCompany("TestComp");
								HttpEntity<User> entityuser = new HttpEntity<>(addUserObj, MOMController.getAuthHeader());
								try {
									RestTemplate restTemplate = new RestTemplate();
								ResponseEntity<Boolean> result = restTemplate.exchange(RegisterURL, HttpMethod.POST, entity, Boolean.class);
								viewName="home";
								}catch (Exception b) {
									System.out.println(b);
									msg = "Invalid email or password.";
									viewName = "login";
								}							
							}
							
						}
					}
				}
			}
		}else {
			viewName="login";
			msg="Something Went Wrong!";
		}
		}catch (Exception e) {
			System.out.println("Exception "+ e);
		}

		

		
		if(!msg.isEmpty())
		{
			mv.addObject("type", "alert");
			mv.addObject("message", msg);
		}
			
		 mv.setViewName(viewName); 
		 return mv;
		 
	}
}
