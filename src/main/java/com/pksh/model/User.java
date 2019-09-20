package com.pksh.model;

import java.sql.Timestamp;

public class User 
{
	private int userid;
	private String username;
	private String password;
	private String email;
	private String firstname;
	private String lastname;
	private String address;
	private String company;
	private Timestamp birthdate;
	private Timestamp createddate;
	private Timestamp updateddate;
	private String guest;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public Timestamp getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(Timestamp birthdate) {
		this.birthdate = birthdate;
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
	public String getGuest() {
		return guest;
	}
	public void setGuest(String guest) {
		this.guest = guest;
	}
	
	@Override
	public String toString() {
		return "User [userid=" + userid + ", username=" + username + ", password=" + password + ", email=" + email
				+ ", firstname=" + firstname + ", lastname=" + lastname + ", address=" + address + ", company="
				+ company + ", birthdate=" + birthdate + ", createddate=" + createddate + ", updateddate=" + updateddate
				+ ", guest=" + guest + "]";
	}
	



}
