package com.pksh.controller;

import java.security.Principal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import com.pksh.model.Meeting;
import com.pksh.model.MeetingVsTask;
import com.pksh.model.User;

@Controller
public class ThirdPartySignInController {

	@Value("${searchUserByEmail}")
	String searchUserByEmail;
	
	@Value("${RegisterURL}")
	String RegisterURL;
	
	@Value("${getMeetingsDueCountByUser}")
	String getMeetingsDueCountByUser;
	
	@Value("${getTasksDueCountByUser}")
	String getTasksDueCountByUser;
	
	@Value("${getMeetingsDueListByUser}")
	String getMeetingsDueListByUser;
	
	@Value("${getTasksDueListByUser}")
	String getTasksDueListByUser;
	
	@RequestMapping("/SignInWithGoogle")
	public ModelAndView SignInWithGoogle(Principal principal,HttpServletRequest request) throws Exception {
		ModelAndView mv=new ModelAndView();
		ObjectMapper mapper = new ObjectMapper();
		User addUserObj=new User();
		String msg = "";
		String viewName = "";
		boolean IsEmailExist=false;
		HttpEntity entity=new HttpEntity(MOMController.getAuthHeader());
		HttpSession session = request.getSession();
		Map<String, String>  map = new HashMap<String, String>();
		int meetingsDueCount=0;
		int tasksDueCount=0;	
		List<Meeting> meetingResult=null;
    	List<MeetingVsTask> taskResult=null;
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
							
							ResponseEntity<Boolean> isUserExist=null;
							RestTemplate searchEmailTemplate =new RestTemplate();
							isUserExist=searchEmailTemplate.exchange(searchUserByEmail+userObj.getEmail(), HttpMethod.GET, entity, Boolean.class);
							IsEmailExist=isUserExist.getBody();
							
							
							if(IsEmailExist) {
								
								session.setAttribute("firstname", userObj.getGiven_name());
								session.setAttribute("lastname", userObj.getFamily_name());
								session.setAttribute("email", userObj.getEmail());
								map.put("email", userObj.getEmail());
								map.put("password", userObj.getGiven_name());
							}else {
								System.out.println("In Else Condition");
								if(userObj!=null) {
									addUserObj.setUsername(userObj.getEmail());
									addUserObj.setFirstname(userObj.getGiven_name());
									addUserObj.setLastname(userObj.getFamily_name());
									addUserObj.setEmail(userObj.getEmail());
									addUserObj.setGuest("Yes");
									addUserObj.setAddress("New Address");
									addUserObj.setPassword("TestPassword");
									addUserObj.setCompany("TestComp");
									System.out.println("User Object is "+addUserObj.toString());
									RestTemplate restTemplate = new RestTemplate();
									HttpEntity<User> entityUser = new HttpEntity<>(addUserObj, MOMController.getAuthHeader());
									ResponseEntity<Boolean> result = restTemplate.exchange(RegisterURL, HttpMethod.POST, entityUser, Boolean.class);
									if(result.getBody()) {
										System.out.println("Inside The result IS true");
										
										session.setAttribute("firstname", userObj.getGiven_name());
										session.setAttribute("lastname", userObj.getFamily_name());
										session.setAttribute("email", userObj.getEmail());
										map.put("email", userObj.getEmail());
										map.put("password", userObj.getGiven_name());
									}
								}
							}
							
							String email = session.getAttribute("email").toString();
							
					        try {
					        	HttpEntity<Map<String, String>> entityMap = new HttpEntity<>(map, MOMController.getAuthHeader());
					        	ResponseEntity<Integer> result;
					        	ResponseEntity<List> meettaskresult;
					            RestTemplate meettaskRestTemplate =new RestTemplate();
					           
					            RestTemplate restTemplate =new RestTemplate();
					            result= restTemplate.exchange(getMeetingsDueCountByUser+email+"?date=test", HttpMethod.GET, entityMap, Integer.class);
					            meetingsDueCount = result.getBody();
					            result= restTemplate.exchange(getTasksDueCountByUser+email+"?date=test", HttpMethod.GET, entityMap, Integer.class);
					            tasksDueCount = result.getBody();
					            
					            meettaskresult= meettaskRestTemplate.exchange(getMeetingsDueListByUser+email+"?date=test", HttpMethod.GET, entityMap, List.class);
					            meetingResult = meettaskresult.getBody();
					            meettaskresult= meettaskRestTemplate.exchange(getTasksDueListByUser+email, HttpMethod.GET, entityMap, List.class);
					            taskResult = meettaskresult.getBody();
					            
					            viewName="home";
					        }catch (Exception e) {
					        	System.out.println("In this Catch Block");
								System.out.println(e);
								viewName="login";
								msg="Something Went Wrong!";
							}
							
							
						}catch (Exception  e) {
							System.out.println(e);
							viewName="login";
							msg="Something Went Wrong!";
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
		mv.addObject("meetingsDueCount",meetingsDueCount);
		mv.addObject("tasksDueCount",tasksDueCount);
		mv.addObject("meetingResult",meetingResult);
		mv.addObject("taskResult",taskResult);
		mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
		 mv.setViewName(viewName); 
		 return mv;
		 
	}
}
