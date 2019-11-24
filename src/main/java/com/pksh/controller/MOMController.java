package com.pksh.controller;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.pksh.model.Meeting;
import com.pksh.model.MeetingVsTask;
import com.pksh.model.Search;
import com.pksh.model.User;

import net.fortuna.ical4j.data.CalendarBuilder;
import net.fortuna.ical4j.data.CalendarOutputter;
import net.fortuna.ical4j.model.Component;
import net.fortuna.ical4j.model.DateTime;
import net.fortuna.ical4j.model.Property;
import net.fortuna.ical4j.model.TimeZone;
import net.fortuna.ical4j.model.TimeZoneRegistry;
import net.fortuna.ical4j.model.TimeZoneRegistryFactory;
import net.fortuna.ical4j.model.component.VEvent;
import net.fortuna.ical4j.model.component.VTimeZone;
import net.fortuna.ical4j.model.parameter.TzId;
import net.fortuna.ical4j.model.property.CalScale;
import net.fortuna.ical4j.model.property.ProdId;
import net.fortuna.ical4j.model.property.Uid;
import net.fortuna.ical4j.util.UidGenerator;

@Controller
public class MOMController 
{
	@Value("${LoginURL}")
	String LoginURL;
	
	@Value("${getMeetingsDueCountByUser}")
	String getMeetingsDueCountByUser;	
	
	@Value("${getTasksDueCountByUser}")
	String getTasksDueCountByUser;
	
	@Value("${getMeetingsDueListByUser}")
	String getMeetingsDueListByUser;
	
	@Value("${getTasksDueListByUser}")
	String getTasksDueListByUser;
	
	@Value("${RegisterURL}")
	String RegisterURL;
	
	@Value("${SearchParticipants}")
	String SearchParticipants;
	
	@Value("${getAllMeeting}")
	String getAllMeeting;
	
	@Value("${createMeeting}")
	String createMeeting;
	
	@Value("${displayEditMeeting}")
	String displayEditMeeting;
	
	@Value("${getAllUserMeeting}")
    String getAllUserMeeting;
    
    @Value("${getUserMeetingsCounts}")
    String getUserMeetingsCounts;
    
    @Value("${getUserTaskCounts}")
    String getUserTaskCounts;
    
    @Value("${getUserCompletedTaskCounts}")
    String getUserCompletedTaskCounts;
	
	@Value("${docLocation}")
	String docLocation;
    
    @Value("${getAllUsers}")
    String getAllUsers;
    
    @Value("${updateMeetingV1}")
    String updateMeetingV1;
    
    String strParticipants = "";
	
	@RequestMapping("/")
	public String login() 
	{
			return "login";
	}
	
	@RequestMapping(value = "/loginForm", method=RequestMethod.POST)
	public @ResponseBody ModelAndView loginData(HttpServletRequest request,@RequestParam(name="email") String useremail,@RequestParam(name="password") String password) 
	{
		String msg = "";
		String viewName = "";
		ModelAndView mv = new ModelAndView();
		Map<String, String>  map = new HashMap<String, String>();
		map.put("email", useremail);
		map.put("password", password);
		
		try
		{
			RestTemplate restTemplateuser = new RestTemplate();
			
			HttpEntity<Map<String, String>> entity = new HttpEntity<>(map, getAuthHeader());
			
			ResponseEntity<User> resultuser = restTemplateuser.exchange(LoginURL, HttpMethod.POST, entity, User.class);
			User user= resultuser.getBody();
			
			HttpSession session = request.getSession();
			if(user != null && user.getFirstname() != null && user.getLastname() != null)
			{
				session.setAttribute("firstname", user.getFirstname());
				session.setAttribute("lastname", user.getLastname());
				session.setAttribute("email", user.getEmail());
			}

			String email = session.getAttribute("email").toString();
			int meetingsDueCount=0;
			int tasksDueCount=0;	
			List<Meeting> meetingResult=null;
        	List<MeetingVsTask> taskResult=null;
	        try {
	        	ResponseEntity<Integer> result;
	        	ResponseEntity<List> meettaskresult;
	            RestTemplate meettaskRestTemplate =new RestTemplate();
	           
	            RestTemplate restTemplate =new RestTemplate();
	            result= restTemplate.exchange(getMeetingsDueCountByUser+email+"?date=test", HttpMethod.GET, entity, Integer.class);
	            meetingsDueCount = result.getBody();
	            result= restTemplate.exchange(getTasksDueCountByUser+email+"?date=test", HttpMethod.GET, entity, Integer.class);
	            tasksDueCount = result.getBody();
	            
	            meettaskresult= meettaskRestTemplate.exchange(getMeetingsDueListByUser+email+"?date=test", HttpMethod.GET, entity, List.class);
	            meetingResult = meettaskresult.getBody();
	            meettaskresult= meettaskRestTemplate.exchange(getTasksDueListByUser+email+"?date=test", HttpMethod.GET, entity, List.class);
	            taskResult = meettaskresult.getBody();
	           
	        }catch (Exception e) {
	            // TODO: handle exception
	        }
	
			mv.addObject("meetingsDueCount",meetingsDueCount);
			mv.addObject("tasksDueCount",tasksDueCount);
			mv.addObject("meetingResult",meetingResult);
			mv.addObject("taskResult",taskResult);
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
	public ModelAndView dashboard(HttpSession session) 
	{
		ModelAndView mv=new ModelAndView();
		if(session.getAttribute("firstname") == null) {
			mv.setViewName("login");
			return mv; 
		}
		else {
			String email = session.getAttribute("email").toString();
			int meetingsDueCount=0;
			int tasksDueCount=0;	
			List<Meeting> meetingResult=null;
        	List<MeetingVsTask> taskResult=null;
	        try {
	        	ResponseEntity<Integer> result;
	        	ResponseEntity<List> meettaskresult;
	            RestTemplate meettaskRestTemplate =new RestTemplate();
	           
	            RestTemplate restTemplate =new RestTemplate();
	            HttpEntity entity=new HttpEntity(getAuthHeader());
	            result= restTemplate.exchange(getMeetingsDueCountByUser+email+"?date=test", HttpMethod.GET, entity, Integer.class);
	            meetingsDueCount = result.getBody();
	            result= restTemplate.exchange(getTasksDueCountByUser+email+"?date=test", HttpMethod.GET, entity, Integer.class);
	            tasksDueCount = result.getBody();
	            
	            meettaskresult= meettaskRestTemplate.exchange(getMeetingsDueListByUser+email+"?date=test", HttpMethod.GET, entity, List.class);
	            meetingResult = meettaskresult.getBody();
	            meettaskresult= meettaskRestTemplate.exchange(getTasksDueListByUser+email+"?date=test", HttpMethod.GET, entity, List.class);
	            taskResult = meettaskresult.getBody();
	           
	        }catch (Exception e) {
	            // TODO: handle exception
	        }
	
			mv.addObject("meetingsDueCount",meetingsDueCount);
			mv.addObject("tasksDueCount",tasksDueCount);
			mv.addObject("meetingResult",meetingResult);
			mv.addObject("taskResult",taskResult);
			mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
			mv.setViewName("home");
			return mv;
		}
		
		
	
	}
	
	@RequestMapping("/createMeeting")
	public ModelAndView createMeeting(HttpSession session) 
	{
		ModelAndView mv = new ModelAndView();
		if(session.getAttribute("firstname") == null) {
			mv.setViewName("login");
			return mv; 
		}else {
			
			List<User> userList= null;
			List<Meeting> refmeetList= null;
			
			ResponseEntity<List> result=getAllUsers();
			userList=result.getBody();
			
			String email = session.getAttribute("email").toString();
			ResponseEntity<List> resultmeet= getAllUserMeetings(email);
			refmeetList=resultmeet.getBody();
	
			mv.addObject("participants",userList);
			mv.addObject("refermeetings",refmeetList);
			mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
			mv.setViewName("createMeeting");
			return mv;
		}
	}
	
	public void getAllUserDynamic() {
		
		List<User> userList= null;
		ResponseEntity<List> result=getAllUsers();
		userList=result.getBody();
	}
	
	
	@RequestMapping("/viewMeeting")
	public ModelAndView viewMeeting(HttpSession session) {
		ModelAndView mv=new ModelAndView();
		if(session.getAttribute("firstname") == null) {
			mv.setViewName("login");
			return mv; 
		}else {
			System.out.println("Called");
			List<Meeting> meetingList=null;
			try {
					String email = session.getAttribute("email").toString();
					ResponseEntity<List> result= getAllUserMeetings(email);
					meetingList=result.getBody();
					if(meetingList.isEmpty() || meetingList==null) {
					}
					for(Meeting meet: meetingList) {
						System.out.println(meet.getStartdate()+"__"+meet.getEnddate());
					}
				
			}catch (Exception e) {
				// TODO: handle exception
			}
			System.out.println("Meeting List is : "+meetingList);
			mv.addObject("meetingList",meetingList);
			mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
			mv.setViewName("viewMeeting");
			return mv;
		}
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
	
	@RequestMapping(value="/isEmailAlreadyRegistered")
	public @ResponseBody String isEmailAlreadyRegistered(@RequestParam("useremail") String email) 
	{
		ResponseEntity<List> result = null;
		String msg="";
		try
		{
			RestTemplate restTemplate = new RestTemplate();
			HttpEntity entity = new HttpEntity(getAuthHeader());
			List<User> userList = null;
			
			result = restTemplate.exchange(SearchParticipants + email, HttpMethod.GET, entity, List.class);
			if(result.getStatusCodeValue() == 200) {
				System.out.println("Email is already registered");
				msg = "Email is already registered";
			}
		}
		catch(Exception e)
		{
			System.out.println("Exception during searching ::: "+e);
			msg = "Email is not registered";
		}
		
		return msg;

	}
	
	
	@RequestMapping("/registerAccount")
	public String signUp() 
	{
		return "signUp";
	}
	
	@RequestMapping("/registerForm")
	public ModelAndView registerForm(User user, @RequestParam(value = "bdate") String bdate) 
	{
		ModelAndView mv = new ModelAndView();
		try
		{
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy");
			
			Date date = sdf.parse(bdate);
			Timestamp ts=new Timestamp(date.getTime());
			user.setBirthdate(ts);
			user.setGuest("no");
			user.setEmail(user.getEmail().trim().replaceAll(" +", ""));
			
			RestTemplate restTemplate = new RestTemplate();
			
			HttpEntity<User> entity = new HttpEntity<>(user, getAuthHeader());
			
			ResponseEntity<Boolean> result = restTemplate.exchange(RegisterURL, HttpMethod.POST, entity, Boolean.class);
			
		}
		catch(Exception e)
		{
			System.out.println("Exception during signup ::: " + e);
		}
		
		mv.addObject("type","success");
		mv.addObject("message", "You have been successfully Registered.");
		mv.setViewName("login");
		
		return mv;
	}
	
	@RequestMapping("/saveMeeting")
	public ModelAndView saveMeeting(HttpSession session, HttpServletRequest req, Meeting meeting, @RequestParam("participant[]") String[] participants, @RequestParam(value = "refermeeting[]", required = false) String[] refmeetings, @RequestParam("uploadfile") MultipartFile[] uploadfile, @RequestParam(value = "fromdate") String fromdate, @RequestParam(value = "todate") String todate) 
	{
		ModelAndView mv = new ModelAndView();
		
		try
		{
			//System.out.println(fromdate+""+todate+"");
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy hh:mm a");
			Date sdate = sdf.parse(fromdate);
			
			Timestamp startTs=new Timestamp(sdate.getTime());
			meeting.setStartdate(startTs.toString());
			
			Date edate = sdf.parse(todate);
			Timestamp endTs=new Timestamp(edate.getTime());
			meeting.setEnddate(endTs.toString());
			
			System.out.println(startTs+""+endTs+"");
			//System.out.println(meeting.getStartdate()+""+meeting.getEnddate());
			
			meeting.setParticipants(Arrays.toString(participants).replace("[", "").replaceAll("]", "").trim().replaceAll(" +", ""));
			meeting.setOwner(session.getAttribute("email").toString()!=null ? session.getAttribute("email").toString() : "-");			
			
			if(refmeetings != null && refmeetings.length > 0)
				meeting.setReferancemeeting(Arrays.toString(refmeetings).replace("[", "").replaceAll("]", "").trim().replaceAll(" +", ""));
			
			
			/* FILE SAVE */
			//byte[] bytes = file.getBytes(); 
		//	Path path = Paths.get(docLocation + file.getOriginalFilename().toString());
		//	Files.write(path, bytes);
			
			for(int i=0;i<uploadfile.length;i++) {
				MultipartFile mfile = uploadfile[i];
			//	System.out.println(mfile.getOriginalFilename());
				if(!mfile.getOriginalFilename().isEmpty()) {
					try{
						byte[] bytes = mfile.getBytes();
						Path path = Paths.get(docLocation +"1"+ mfile.getOriginalFilename().toString());
						Files.write(path, bytes);
					}
					catch(Exception e){
						System.out.println("File Upload EXCEPTION :::: "+e);
					}
				}
			}
			
			
			RestTemplate restTemplate = new RestTemplate();
			
			HttpEntity<Meeting> entity = new HttpEntity<>(meeting, getAuthHeader());
			
			ResponseEntity<Boolean> result = restTemplate.exchange(createMeeting, HttpMethod.POST, entity, Boolean.class);
			
			if(result.getStatusCodeValue() == 200)
			{
					calenderInvite(req, meeting.getSubject(), fromdate, todate);
					sendMail(req, meeting.getParticipants(), meeting.getSubject());
				
				List<Meeting> meetingList=null;
				try {
						String email = session.getAttribute("email").toString();
						ResponseEntity<List> resultmeet= getAllUserMeetings(email);
						meetingList=resultmeet.getBody();
						if(meetingList.isEmpty() || meetingList==null) {
						}
					
					
				}catch (Exception e) {
					// TODO: handle exception
				}
				//System.out.println("Meeting List is : "+meetingList);
				mv.addObject("meetstatus","success");
				mv.addObject("meetingList",meetingList);
				mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
				mv.setViewName("viewMeeting");
				
			}
		
		}
		catch(Exception e)
		{
			System.out.println("Exception during saveMeeting ::: " + e);
		}
		
		return mv;
		
	}
	
	public static void calenderInvite(HttpServletRequest req, String subject, String fromDate, String toDate)
	{
		  String[] stDate = fromDate.split("-|T|:");
		  String[] eDate = toDate.split("-|T|:");
		
		  String[] path = req.getServletContext().getRealPath("/").split("webapp/");
		  String realPath = path[0]+"resources/static/";
		  String calFile = "mycalendar.ics";
		  
		  try
		  {
			// Create a TimeZone
			  TimeZoneRegistry registry = TimeZoneRegistryFactory.getInstance().createRegistry();
			  TimeZone timezone = registry.getTimeZone("Asia/Kolkata");
			  VTimeZone tz = timezone.getVTimeZone();
			  
			  java.util.Calendar startDate = new GregorianCalendar();
			  startDate.setTimeZone(timezone);
			  startDate.set(java.util.Calendar.MONTH, Integer.parseInt(stDate[1]) - 1);
			  startDate.set(java.util.Calendar.DAY_OF_MONTH, Integer.parseInt(stDate[2]));
			  startDate.set(java.util.Calendar.YEAR, Integer.parseInt(stDate[0]));
			  startDate.set(java.util.Calendar.HOUR_OF_DAY, Integer.parseInt(stDate[3]));
			  startDate.set(java.util.Calendar.MINUTE, Integer.parseInt(stDate[4]));
			  startDate.set(java.util.Calendar.SECOND, 00);
			  
			  java.util.Calendar endDate = new GregorianCalendar();
			  endDate.setTimeZone(timezone);
			  endDate.set(java.util.Calendar.MONTH, Integer.parseInt(eDate[1]) - 1);
			  endDate.set(java.util.Calendar.DAY_OF_MONTH, Integer.parseInt(eDate[2]));
			  endDate.set(java.util.Calendar.YEAR, Integer.parseInt(eDate[0]));
			  endDate.set(java.util.Calendar.HOUR_OF_DAY, Integer.parseInt(eDate[3]));
			  endDate.set(java.util.Calendar.MINUTE, Integer.parseInt(eDate[4]));	
			  endDate.set(java.util.Calendar.SECOND, 00);

			  // Create the event
			  String eventName = subject;
			  DateTime start = new DateTime(startDate.getTime());
			  DateTime end = new DateTime(endDate.getTime());
			  VEvent meeting = new VEvent(start, end, eventName);

			  // add timezone info..
			  meeting.getProperties().add(tz.getTimeZoneId());
			  
			  TzId tzParam=new TzId(tz.getProperties().getProperty(Property.TZID).getValue());
			  
			  meeting.getProperties().getProperty(Property.DTSTART).getParameters().add(tzParam);
			  
			  // generate unique identifier..
			  UidGenerator ug = new UidGenerator("uidGen");
			  Uid uid = ug.generateUid();
			  meeting.getProperties().add(uid);

			  

			  // Create a calendar
			  net.fortuna.ical4j.model.Calendar icsCalendar = new net.fortuna.ical4j.model.Calendar();
			  icsCalendar.getProperties().add(new ProdId("-//Events Calendar//iCal4j 1.0//EN"));
			  icsCalendar.getProperties().add(CalScale.GREGORIAN);


			  // Add the event and print
			  icsCalendar.getComponents().add(meeting);
			  
			  //Saving an iCalendar file
			  FileOutputStream fout = new FileOutputStream(realPath+calFile);
		
			  CalendarOutputter outputter = new CalendarOutputter();
			  outputter.setValidating(false);
			  outputter.output(icsCalendar, fout);
			  
			  //Now Parsing an iCalendar file
			  FileInputStream fin = new FileInputStream(realPath+calFile);
		
			  CalendarBuilder builder = new CalendarBuilder();
		
			  icsCalendar = builder.build(fin);
			  
			  //Iterating over a Calendar
			  for (Iterator i = icsCalendar.getComponents().iterator(); i.hasNext();) {
			      Component component = (Component) i.next();
			      System.out.println("Component [" + component.getName() + "]");
		
			      for (Iterator j = component.getProperties().iterator(); j.hasNext();) {
			          Property property = (Property) j.next();
			          System.out.println("Property [" + property.getName() + ", " + property.getValue() + "]");
			      }
			  }//for
			  
		  }
		  catch(Exception e)
		  {
			  System.out.println("Exception ::: " + e);
		  }
	}
	
	private ResponseEntity<List> getAllMeetings(String email){
        ResponseEntity<List> result=null;
        try {
            RestTemplate restTemplate =new RestTemplate();
            HttpEntity entity=new HttpEntity(getAuthHeader());
            result= restTemplate.exchange(getAllMeeting+email, HttpMethod.GET,entity,List.class);
        }catch (Exception e) {
            // TODO: handle exception
        }
        
        return result;
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
   
    
    
    private int getUserMeetingsCounts(String eid)
    {
        ResponseEntity<Integer> result=null;
        int count=0;
        try 
        {
            RestTemplate restTemplate =new RestTemplate();
            HttpEntity entity=new HttpEntity(getAuthHeader());
            result = restTemplate.exchange(getUserMeetingsCounts+eid, HttpMethod.GET,entity,Integer.class);
            count = result.getBody();
            
        }
        catch (Exception e) 
        {
            // TODO: handle exception
        }
        
        return count;
    }
    
    private int getUserTaskCounts(String eid)
    {
        ResponseEntity<Integer> result=null;
        int count=0;
        try 
        {
            RestTemplate restTemplate =new RestTemplate();
            HttpEntity entity=new HttpEntity(getAuthHeader());
            result = restTemplate.exchange(getAllUserMeeting+eid, HttpMethod.GET,entity,Integer.class);
            count = result.getBody();
        }
        catch (Exception e) 
        {
            // TODO: handle exception
        }
        
        return count;
    }

    private int getUserCompletedTaskCounts(String eid)
    {
        ResponseEntity<Integer> result=null;
        int count=0;
        try 
        {
            RestTemplate restTemplate =new RestTemplate();
            HttpEntity entity=new HttpEntity(getAuthHeader());
            result = restTemplate.exchange(getAllUserMeeting+eid, HttpMethod.GET,entity,Integer.class);
            count = result.getBody();
        }
        catch (Exception e) 
        {
            // TODO: handle exception
        }
        
        return count;
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
	public static void sendMail(HttpServletRequest req, String toMailId, String subject)
	{
		try
		{
		   String[] path = req.getServletContext().getRealPath("/").split("webapp/");
		   String realPath = path[0]+"WEB-INF/classes/static/";
		   String calFile = "mycalendar.ics";
		   String[] toMail = toMailId.split(",");
		   
		   Properties props = new Properties();
		   props.put("mail.smtp.auth", "true");
		   props.put("mail.smtp.starttls.enable", "true");
		   props.put("mail.smtp.host", "smtp.gmail.com");
		   props.put("mail.smtp.port", "587");
		   
		   Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		      protected PasswordAuthentication getPasswordAuthentication() {
		         return new PasswordAuthentication("hardik.kava007@gmail.com", "9824404380");
		      }
		   });
		   
		   Message msg = new MimeMessage(session);
		   msg.setFrom(new InternetAddress("hardik.kava007@gmail.com", false));
		   
		   for (int i = 0; i < toMail.length; i++)
	       {
			   msg.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail[i]));
	       }
		   msg.setSubject(subject);
		   msg.setContent("", "text/html");
		   msg.setSentDate(new Date());

		   MimeBodyPart messageBodyPart = new MimeBodyPart();
		   messageBodyPart.setContent("", "text/html");

		   Multipart multipart = new MimeMultipart();
		   multipart.addBodyPart(messageBodyPart);
		   MimeBodyPart attachPart = new MimeBodyPart();

		   attachPart.attachFile(realPath+calFile);
		   multipart.addBodyPart(attachPart);
		   msg.setContent(multipart);
		   Transport.send(msg);
		}
		catch(Exception e)
		{
			System.out.println("Exception During Sendmail ::: "+e);
		}
	}
	
	
	@RequestMapping(value = "/addGuestUser", method=RequestMethod.POST)
	public @ResponseBody String addGuestUser(HttpSession session, @RequestParam("fname") String fname, @RequestParam("lname") String lname, @RequestParam("email") String email){
		
		User user = new User();
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Boolean> result = null;
		String status="false";
		
		try {
			user.setFirstname(fname);
			user.setLastname(lname);
			user.setUsername(fname+""+lname);
			user.setEmail(email);
			user.setGuest("yes");
			
			HttpEntity<User> entity = new HttpEntity<>(user, getAuthHeader());
			result = restTemplate.exchange(RegisterURL, HttpMethod.POST, entity, Boolean.class);
			
			System.out.println(result.getStatusCodeValue());
			if(result.getStatusCodeValue() == 200)
				status="true";
			
		}catch(Exception e)
		{
			System.out.println("Exception during signup ::: " + e);
		}
		
		return status;
	}
	
	
	@RequestMapping("/displayEditMeeting")
	public ModelAndView displayEditMeeting(@RequestParam(value="meetingid") String meetingid) 
	{
		ModelAndView mv = new ModelAndView();
		try
		{
			RestTemplate restTemplate = new RestTemplate();
			HttpEntity entity = new HttpEntity(getAuthHeader());
			
			ResponseEntity<Meeting> result = restTemplate.exchange(displayEditMeeting + meetingid, HttpMethod.GET, entity, Meeting.class);
			Meeting meeting = result.getBody();
			
			strParticipants = meeting.getParticipants();
			
			List<Meeting> editMeetingList = new ArrayList<Meeting>();
			editMeetingList.add(meeting);
			
			mv.addObject("editMeetingList", editMeetingList);
		}
		catch(Exception e)
		{
			System.out.println("Exception during showEditMeeting ::: ");
		}
		mv.setViewName("editmeeting");
		return mv;
	}
	
//	@RequestMapping("/updateMeeting")
//	public void updateMeeting(Meeting meeting) 
//	{
//		ModelAndView mv = new ModelAndView();
//		try
//		{
//			ArrayList<String> newAddList = new ArrayList<String>();
//			ArrayList<String> deleteList = new ArrayList<String>();
//			ArrayList<String> sameList = new ArrayList<String>();
//			
//			String oldString = strParticipants.replaceAll("\\s+","");
//			String newString = meeting.getParticipants().replaceAll("\\s+","");
//			
//			if(!oldString.equals(newString))
//			{
//				String[] oldParticipant = oldString.split(",");
//				String[] newParticipant = newString.split(",");
//				
//				for(int i = 0; i < newParticipant.length; i++) 
//				{
//				      if(!Arrays.asList(oldParticipant).contains(newParticipant[i]))
//				    	  newAddList.add(newParticipant[i]);
//				}
//				
//				for(int i = 0; i < oldParticipant.length; i++) 
//				{
//				      if(!Arrays.asList(newParticipant).contains(oldParticipant[i]))
//				    	  deleteList.add(oldParticipant[i]);
//				}
//			}
//			else
//			{
//				sameList.add(oldString);
//			}
//			
//			
//		}
//		catch(Exception e)
//		{
//			System.out.println("Exception during updateMeeting ::: ");
//		}
//	}
	
//	@RequestMapping("/updateMeeting")
//	public ModelAndView updateMeeting(HttpSession session, HttpServletRequest req, Meeting meeting, @RequestParam("participant[]") String[] participants, @RequestParam(value = "refermeeting[]", required = false) String[] refmeetings, @RequestParam(value = "todate") String todate) 
//	{
//		ModelAndView mv = new ModelAndView();
//		
//		try
//		{
//			SimpleDateFormat sdf = new SimpleDateFormat("dd/MMM/yyyy hh:mm a");
//			Date edate = sdf.parse(todate);
//			Timestamp endTs=new Timestamp(edate.getTime());
//			meeting.setEnddate(endTs.toString());
//			
//			System.out.println(endTs+"");
//			//System.out.println(meeting.getStartdate()+""+meeting.getEnddate());
//			
//			meeting.setParticipants(Arrays.toString(participants).replace("[", "").replaceAll("]", "").trim().replaceAll(" +", ""));
//			meeting.setOwner(session.getAttribute("email").toString()!=null ? session.getAttribute("email").toString() : "-");			
//			
//			if(refmeetings != null && refmeetings.length > 0)
//				meeting.setReferancemeeting(Arrays.toString(refmeetings).replace("[", "").replaceAll("]", "").trim().replaceAll(" +", ""));
//			
//			
//			RestTemplate restTemplate = new RestTemplate();
//			
//			HttpEntity<Meeting> entity = new HttpEntity<>(meeting, getAuthHeader());
//			
//			ResponseEntity<Boolean> result = restTemplate.exchange(createMeeting, HttpMethod.POST, entity, Boolean.class);
//			
//			if(result.getStatusCodeValue() == 200)
//			{
//				//	calenderInvite(req, meeting.getSubject(), fromdate, todate);
//				//	sendMail(req, meeting.getParticipants(), meeting.getSubject());
//				
//				List<Meeting> meetingList=null;
//				try {
//						String email = session.getAttribute("email").toString();
//						ResponseEntity<List> resultmeet= getAllUserMeetings(email);
//						meetingList=resultmeet.getBody();
//						if(meetingList.isEmpty() || meetingList==null) {
//						}
//					
//					
//				}catch (Exception e) {
//					// TODO: handle exception
//				}
//				//System.out.println("Meeting List is : "+meetingList);
//				mv.addObject("meetstatus","success");
//				mv.addObject("meetingList",meetingList);
//				mv.addObject("LoginName", session.getAttribute("firstname")+" "+session.getAttribute("lastname"));
//				mv.setViewName("viewMeeting");
//				
//			}
//		
//		}
//		catch(Exception e)
//		{
//			System.out.println("Exception during saveMeeting ::: " + e);
//		}
//		
//		return mv;
//		
//	}
	
	
}
