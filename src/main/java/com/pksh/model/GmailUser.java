package com.pksh.model;

public class GmailUser {

	private String name;
	private String id;
	private boolean verified_email;
	private String given_name;
	private String locale;
	private String family_name;
	private String email;
	private String picture;
	private String hd;
	
	
	/**
	 * @return the hd
	 */
	public String getHd() {
		return hd;
	}
	/**
	 * @param hd the hd to set
	 */
	public void setHd(String hd) {
		this.hd = hd;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @return the id
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return the verified_email
	 */
	public boolean isVerified_email() {
		return verified_email;
	}
	/**
	 * @param verified_email the verified_email to set
	 */
	public void setVerified_email(boolean verified_email) {
		this.verified_email = verified_email;
	}
	/**
	 * @return the given_name
	 */
	public String getGiven_name() {
		return given_name;
	}
	/**
	 * @param given_name the given_name to set
	 */
	public void setGiven_name(String given_name) {
		this.given_name = given_name;
	}
	/**
	 * @return the locale
	 */
	public String getLocale() {
		return locale;
	}
	/**
	 * @param locale the locale to set
	 */
	public void setLocale(String locale) {
		this.locale = locale;
	}
	/**
	 * @return the family_name
	 */
	public String getFamily_name() {
		return family_name;
	}
	/**
	 * @param family_name the family_name to set
	 */
	public void setFamily_name(String family_name) {
		this.family_name = family_name;
	}
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the picture
	 */
	public String getPicture() {
		return picture;
	}
	/**
	 * @param picture the picture to set
	 */
	public void setPicture(String picture) {
		this.picture = picture;
	}
	@Override
	public String toString() {
		return "GmailUser [name=" + name + ", id=" + id + ", verified_email=" + verified_email + ", given_name="
				+ given_name + ", locale=" + locale + ", family_name=" + family_name + ", email=" + email + ", picture="
				+ picture + "]";
	}
	
	
	
}
