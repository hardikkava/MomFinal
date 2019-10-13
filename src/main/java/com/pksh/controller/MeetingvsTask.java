package com.pksh.controller;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pksh.model.Meeting;
import com.pksh.model.MeetingVsTask;
import com.pksh.model.User;

import edu.emory.mathcs.backport.java.util.Arrays;



@Controller
public class MeetingvsTask {
	
	@Value("${displayEditMeeting}")
	String displayEditMeeting;
	
	@Value("${updateMeeting}")
	String updateMeeting;
	
	@Value("${getAllUsers}")
	String getAllUsers;
	
	@Value("${getAllUserMeeting}")
    String getAllUserMeeting;
	
	@Value("${getUserTaskList}")
    String getUserTaskList;
	
	@Value("${getTaskListbyMeetingId}")
    String getTaskListbyMeetingId;
	
	@Value("${addNewTask}")
    String addNewTask;
	
	
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
	
	private ResponseEntity<List> getAllUserMeetings(String eid)
    {
        //ModelAndView mv=new ModelAndView();
        List<Meeting> meetingList=null;
        ResponseEntity<List> result=null;
        try 
        {
            RestTemplate restTemplate =new RestTemplate();
            HttpEntity entity=new HttpEntity(getAuthHeader());
            result= restTemplate.exchange(getAllUserMeeting+eid, HttpMethod.GET,entity,List.class);
        }
        catch (Exception e) 
        {
            // TODO: handle exception
        }
        
        return result;
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
				List<User> selectuserList= null;
				List<User> userList = null;
				List<MeetingVsTask> meetVsTaskList = null;
				String[] tempselectuserList=null;
				
				ResponseEntity<List> userresult= getAllUsers();
				userList = userresult.getBody();
				
				ResponseEntity<Meeting> result = restTemplate.exchange(displayEditMeeting + meetid, HttpMethod.GET, entity, Meeting.class);
				Meeting meeting = result.getBody();
				tempselectuserList = meeting.getParticipants().split(",");
				
				String email = session.getAttribute("email").toString();
				ResponseEntity<List> resultmeet= getAllUserMeetings(email);
				List<Meeting> refmeetList = resultmeet.getBody();
				String[] finalRefmeetList = meeting.getReferancemeeting().split(",");
				
				System.out.println(meeting.getStartdate()+"__"+meeting.getEnddate()+"____"+finalRefmeetList.length);
				
				// Task section
//				ResponseEntity<List> meetVsTaskResult = getUserMeetVsTask(meetid);
//				meetVsTaskList = meetVsTaskResult.getBody();
				
				System.out.println("list: "+refmeetList);
				//System.out.println(meetVsTaskList);
				
				
				mv.addObject("meeting", meeting);
				mv.addObject("refermeetings",refmeetList);
				mv.addObject("finalRefmeetList",finalRefmeetList);
				mv.addObject("participants",userList);
				mv.addObject("tempselectuserList",tempselectuserList);
			//	mv.addObject("meetVsTaskList",meetVsTaskList);
				mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
				//mv.addObject("selectedparticipants",selectuserList);
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
			
			}
			mv.setViewName("mettingDetail");
			return mv;
		}
		
	}

	public ResponseEntity<List> getAllUsers(){
       ResponseEntity<List> result=null;
       try {
           RestTemplate restTemplate =new RestTemplate();
           HttpEntity entity=new HttpEntity(getAuthHeader());
           result= restTemplate.exchange(getAllUsers, HttpMethod.GET,entity,List.class);
       }catch (Exception e) {
           System.out.println(e);
       }
       
       return result;
	 }
	
	public ResponseEntity<List> getUserMeetVsTask(String meetid){
       ResponseEntity<List> result=null;
       try {
           RestTemplate restTemplate =new RestTemplate();
           HttpEntity entity=new HttpEntity(getAuthHeader());
           result =  restTemplate.exchange(getTaskListbyMeetingId+meetid, HttpMethod.GET, entity, List.class);
         
       }catch (Exception e) {
           System.out.println(e);
       }
       
       return result;
	 }
	   
	@RequestMapping(value = "/updateMeeting")
	public ModelAndView updateMeeting(HttpSession session, @RequestParam("meetingid") String meetingid, @RequestParam("subject") String subject, @RequestParam("cat") String cat, @RequestParam(value="notes", required = false) String notes, @RequestParam("updatedparticipant[]") String[] participants, @RequestParam(value = "updatedrefermeeting[]", required = false) String[] refmeetings, @RequestParam(value = "enddate", required = false) String enddate) throws ParseException
	{
		ModelAndView mv = new ModelAndView();
		Meeting meeting = new Meeting();
		if(enddate != null && !enddate.isEmpty()) {
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy hh:mm a");
			Date edate = sdf.parse(enddate);
			Timestamp edateTs=new Timestamp(edate.getTime());
			meeting.setEnddate(edateTs);
		}
		meeting.setMeetingid(Integer.parseInt(meetingid));
		meeting.setSubject(subject);
		meeting.setCategory(cat);
		if(notes != null && !notes.isEmpty())
			meeting.setNote(notes);
		
		meeting.setParticipants(Arrays.toString(participants).replace("[", "").replaceAll("]", "").trim().replaceAll(" +", ""));
		meeting.setOwner(session.getAttribute("email").toString()!=null ? session.getAttribute("email").toString() : "-");
		meeting.setUpdatedby(session.getAttribute("email").toString()!=null ? session.getAttribute("email").toString() : "-");
		
		if(refmeetings != null && refmeetings.length > 0)
			meeting.setReferancemeeting(Arrays.toString(refmeetings).replace("[", "").replaceAll("]", "").trim().replaceAll(" +", ""));
		
		RestTemplate restTemplate = new RestTemplate();
		
		HttpEntity<Meeting> entity = new HttpEntity<>(meeting, getAuthHeader());
		
		ResponseEntity<Boolean> result = restTemplate.exchange(updateMeeting+meeting.getMeetingid(), HttpMethod.PUT, entity, Boolean.class);
		
		if(result.getStatusCodeValue() == 200)
		{
			HttpEntity getmeet_entity = new HttpEntity(getAuthHeader());
			List<User> selectuserList= null;
			List<User> userList = null;
			String[] tempselectuserList=null;
			
			ResponseEntity<List> userresult= getAllUsers();
			userList = userresult.getBody();
			
			ResponseEntity<Meeting> meetresult = restTemplate.exchange(displayEditMeeting + Integer.parseInt(meetingid), HttpMethod.GET, getmeet_entity, Meeting.class);
			Meeting getmeeting = meetresult.getBody();
			tempselectuserList = getmeeting.getParticipants().split(",");
			
			String email = session.getAttribute("email").toString();
			ResponseEntity<List> resultmeet= getAllUserMeetings(email);
			List<Meeting> refmeetList = resultmeet.getBody();
			String[] finalRefmeetList = meeting.getReferancemeeting().split(",");
			
			System.out.println(meeting.getStartdate()+"__"+meeting.getEnddate()+"____"+finalRefmeetList.length);
			
			mv.addObject("meeting", meeting);
			mv.addObject("refermeetings",refmeetList);
			mv.addObject("finalRefmeetList",finalRefmeetList);
			mv.addObject("participants",userList);
			mv.addObject("tempselectuserList",tempselectuserList);
			mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
			
		}
		mv.setViewName("mettingDetail");
		return mv;
		
	}
	
	
	@RequestMapping(value = "/addNewTask")
	public ModelAndView addNewTask(HttpSession session, @RequestParam(value = "tasktype") String tasktype, @RequestParam(value = "tasksubject") String tasksubject, @RequestParam(value = "tasksumry") String tasksumry, @RequestParam(value = "assignperson[]") String[] assignperson, @RequestParam(value = "duedate") String duedate, @RequestParam(value = "meetingid") String meetingid) throws ParseException 
	{
		MeetingVsTask meetingVsTask = new MeetingVsTask();
		ModelAndView mv = new ModelAndView();
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy hh:mm a");
		Date ddate = sdf.parse(duedate);
		Timestamp ddate_timestamp=new Timestamp(ddate.getTime());
		String email = session.getAttribute("email").toString();
		
		meetingVsTask.setMeetingid(Integer.parseInt(meetingid));
		meetingVsTask.setSubject(tasksubject);
		meetingVsTask.setDescription(tasksumry);
		meetingVsTask.setResponsible(Arrays.toString(assignperson).replace("[", "").replaceAll("]", "").trim().replaceAll(" +", ""));
		meetingVsTask.setAssignee(email);
		meetingVsTask.setDuedate(ddate_timestamp);
		
		
//		mv.addObject("meeting", meeting);
//		mv.addObject("refermeetings",refmeetList);
//		mv.addObject("finalRefmeetList",finalRefmeetList);
//		mv.addObject("participants",userList);
//		mv.addObject("tempselectuserList",tempselectuserList);
//		mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
//		
//	
//		mv.setViewName("mettingDetail");
//		return mv;
//	
	   return null;
	} 
	   
	   
	   
	   
	   
}
