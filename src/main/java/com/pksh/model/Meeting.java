package com.pksh.model;

import java.sql.Timestamp;

public class Meeting 
{
	private int meetingid;
    private String subject;
    private String participants;
    private String owner;
    private String place;
    private String note;
    private String file;
    private String category;
    private int recurring;
    private int recurringapproch;
    private int recurringperiod;
    private int referancemeeting;
    private String custom1;
    private String custom2;
    private String custom3;
    private Timestamp startdate;
    private Timestamp enddate;
    private Timestamp createddate;
    private Timestamp updateddate;
    private String updatedby;
    
	public int getMeetingid() {
		return meetingid;
	}
	public void setMeetingid(int meetingid) {
		this.meetingid = meetingid;
	}
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
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getRecurring() {
		return recurring;
	}
	public void setRecurring(int recurring) {
		this.recurring = recurring;
	}
	public int getRecurringapproch() {
		return recurringapproch;
	}
	public void setRecurringapproch(int recurringapproch) {
		this.recurringapproch = recurringapproch;
	}
	public int getRecurringperiod() {
		return recurringperiod;
	}
	public void setRecurringperiod(int recurringperiod) {
		this.recurringperiod = recurringperiod;
	}
	public int getReferancemeeting() {
		return referancemeeting;
	}
	public void setReferancemeeting(int referancemeeting) {
		this.referancemeeting = referancemeeting;
	}
	public String getCustom1() {
		return custom1;
	}
	public void setCustom1(String custom1) {
		this.custom1 = custom1;
	}
	public String getCustom2() {
		return custom2;
	}
	public void setCustom2(String custom2) {
		this.custom2 = custom2;
	}
	public String getCustom3() {
		return custom3;
	}
	public void setCustom3(String custom3) {
		this.custom3 = custom3;
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
	public Timestamp getCreateddate() {
		return createddate;
	}
	public void setCreateddate(Timestamp createddate) {
		this.createddate = createddate;
	}
	public Timestamp getUpdateddate() {
		return updateddate;
	}
	public void setUpdateddate(Timestamp updateddate) {
		this.updateddate = updateddate;
	}
	public String getUpdatedby() {
		return updatedby;
	}
	public void setUpdatedby(String updatedby) {
		this.updatedby = updatedby;
	}

	
	
}
