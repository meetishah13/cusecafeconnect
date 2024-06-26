package com.example.cuseCafeConnect.models;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

public class ScheduleCafeDTO {
	
	private String timeSlot;
	private String timeSlotDay;
	private String userName;
	private String phoneNo;
	private String emailId;

	
	public String getPhoneNo() {
		return phoneNo;
	}
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getEmailId() {
		return emailId;
	}
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public String getTimeSlotDay() {
		return timeSlotDay;
	}
	
	public ScheduleCafeDTO(String timeSlot, String timeSlotDay, String userName, String phoneNo, String emailId) {
		this.timeSlot = timeSlot;
		this.timeSlotDay = timeSlotDay;
		this.userName = userName;
		this.phoneNo = phoneNo;
		this.emailId = emailId;
	}
	public void setTimeSlotDay(String timeSlotDay) {
		this.timeSlotDay = timeSlotDay;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	@Override
	public String toString() {
		return "ScheduleCafeDTO [timeSlot=" + timeSlot + ", timeSlotDay=" + timeSlotDay + ", userName=" + userName
				+ "]";
	}
	
	
	
	
	
	
	
	
	

}
