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
	
	@Value("${RegisterURL}")
	String RegisterURL;
	
	@Value("${SearchParticipants}")
	String SearchParticipants;
	
	@Value("${getAllMeeting}")
	String getAllMeeting;
	
	@Value("${createMeeting}")
	String createMeeting;
	
/*	@Value("${fileLocation}")
	String fileLocation;*/
	
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
	public  ModelAndView dashboard(HttpServletRequest request) 
	{
		ModelAndView mv=new ModelAndView();
		List<Meeting> meetingList=null;
		try {
			RestTemplate restTemplate =new RestTemplate();
			HttpEntity entity=new HttpEntity(getAuthHeader());
			ResponseEntity<List> result= restTemplate.exchange(getAllMeeting, HttpMethod.GET,entity,List.class);
			meetingList=result.getBody();
			if(meetingList.isEmpty() || meetingList==null) {
				
			}
			
			
		}catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println("Meeting List is : "+meetingList);
		mv.addObject("meetingList",meetingList);
		mv.setViewName("dashboard");
		return mv;
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
	
	@RequestMapping("/registerForm")
	public ModelAndView registerForm(User user, @RequestParam(value = "bdate") String bdate) 
	{
		ModelAndView mv = new ModelAndView();
		try
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date date = sdf.parse(bdate);
			Timestamp ts=new Timestamp(date.getTime());
			user.setBirthdate(ts);;
			
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
	public void saveMeeting(HttpServletRequest req, Meeting meeting, /*@RequestParam("uploadfile") MultipartFile uploadfile,*/ @RequestParam(value = "fromdate") String fromdate, @RequestParam(value = "todate") String todate) 
	{
		try
		{
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
			Date sdate = sdf.parse(fromdate);
			Timestamp startTs=new Timestamp(sdate.getTime());
			meeting.setStartdate(startTs);
			
			Date edate = sdf.parse(todate);
			Timestamp endTs=new Timestamp(edate.getTime());
			meeting.setEnddate(endTs);
			
			/* FILE SAVE */
		/*	byte[] bytes = file.getBytes(); 
			Path path = Paths.get(fileLocation + file.getOriginalFilename().toString());
			Files.write(path, bytes);*/
			
			RestTemplate restTemplate = new RestTemplate();
			
			HttpEntity<Meeting> entity = new HttpEntity<>(meeting, getAuthHeader());
			
			ResponseEntity<Boolean> result = restTemplate.exchange(createMeeting, HttpMethod.POST, entity, Boolean.class);
			
			if(result.getStatusCodeValue() == 200)
			{
				//	calenderInvite(req, meeting.getSubject(), fromdate, todate);
				//	sendMail(req, meeting.getParticipants(), meeting.getSubject());
			}
		
		}
		catch(Exception e)
		{
			System.out.println("Exception during saveMeeting ::: " + e);
		}
		//return "createMeeting";
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
	
	public static void sendMail(HttpServletRequest req, String toMailId, String subject)
	{
		try
		{
		   String[] path = req.getServletContext().getRealPath("/").split("webapp/");
		   String realPath = path[0]+"resources/static/";
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
	
	
}
