package com.pksh.model;

import java.sql.Timestamp;

public class MeetingVsTask {

	private int taskid;
	private String tasktype;
	private int meetingid;
    private String responsible;
    private String assignee;
    private Timestamp duedate;
    private String subject;
    private String description;
    private int status;
    private Timestamp createddate;
    private Timestamp updateddate;
    
    
	public int getTaskid() {
		return taskid;
	}
	public void setTaskid(int taskid) {
		this.taskid = taskid;
	}
	public String getTasktype() {
		return tasktype;
	}
	public void setTasktype(String tasktype) {
		this.tasktype = tasktype;
	}
	public int getMeetingid() {
		return meetingid;
	}
	public void setMeetingid(int meetingid) {
		this.meetingid = meetingid;
	}
	public String getResponsible() {
		return responsible;
	}
	public void setResponsible(String responsible) {
		this.responsible = responsible;
	}
	public String getAssignee() {
		return assignee;
	}
	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}
	public Timestamp getDuedate() {
		return duedate;
	}
	public void setDuedate(Timestamp duedate) {
		this.duedate = duedate;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
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
	
	@Override
	public String toString() {
		return "MeetingVsTask [taskid=" + taskid + ", tasktype=" + tasktype + ", meetingid=" + meetingid
				+ ", responsible=" + responsible + ", assignee=" + assignee + ", duedate=" + duedate + ", subject="
				+ subject + ", description=" + description + ", status=" + status + ", createddate=" + createddate
				+ ", updateddate=" + updateddate + "]";
	}
	
	

}
