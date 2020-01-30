package com.pksh.model;

public class MeetingVsTask {

	private int taskid;
	private String tasktype;
	private int meetingid;
    private String responsible;
    private String assignee;
    private String duedate;
    private String subject;
    private String description;
    private int status;
    private String createddate;
    private String updateddate;
    private String updatedBy;
    
    
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
	public String getDuedate() {
		return duedate;
	}
	public void setDuedate(String duedate) {
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
	public String getCreateddate() {
		return createddate;
	}
	public void setCreateddate(String createddate) {
		this.createddate = createddate;
	}
	public String getUpdateddate() {
		return updateddate;
	}
	public void setUpdateddate(String updateddate) {
		this.updateddate = updateddate;
	}
	public String getUpdatedBy() {
		return updatedBy;
	}
	public void setUpdatedBy(String updatedBy) {
		this.updatedBy = updatedBy;
	}
	
	
	@Override
	public String toString() {
		return "MeetingVsTask [taskid=" + taskid + ", tasktype=" + tasktype + ", meetingid=" + meetingid
				+ ", responsible=" + responsible + ", assignee=" + assignee + ", duedate=" + duedate + ", subject="
				+ subject + ", description=" + description + ", status=" + status + ", createddate=" + createddate
				+ ", updateddate=" + updateddate + ", updatedBy=" + updatedBy + "]";
	}
	
	

}
