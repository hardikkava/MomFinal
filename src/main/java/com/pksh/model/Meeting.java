package com.pksh.model;

import java.sql.Timestamp;

public class Meeting 
{
	private String subject;
	private String participants;
	private String owner;
	private String place;
	private String note;
	private String catagory;
	private String recurring;
	private String recurringPeriod;
	private String referancemeeting;
	private Timestamp startdate;
	private Timestamp enddate;
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getParticipants() {
		return participants;
	}
	public void setParticipants(String participants) {
		this.participants = participants;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getCatagory() {
		return catagory;
	}
	public void setCatagory(String catagory) {
		this.catagory = catagory;
	}
	public String getRecurring() {
		return recurring;
	}
	public void setRecurring(String recurring) {
		this.recurring = recurring;
	}
	public String getRecurringPeriod() {
		return recurringPeriod;
	}
	public void setRecurringPeriod(String recurringPeriod) {
		this.recurringPeriod = recurringPeriod;
	}
	public String getReferancemeeting() {
		return referancemeeting;
	}
	public void setReferancemeeting(String referancemeeting) {
		this.referancemeeting = referancemeeting;
	}
	public Timestamp getStartdate() {
		return startdate;
	}
	public void setStartdate(Timestamp startdate) {
		this.startdate = startdate;
	}
	public Timestamp getEnddate() {
		return enddate;
	}
	public void setEnddate(Timestamp enddate) {
		this.enddate = enddate;
	}
	
	
}
