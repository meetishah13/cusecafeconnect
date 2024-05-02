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



	private String phoneNumber;
	private String userEmail;

	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public String getTimeSlotDay() {
		return timeSlotDay;
	}
	public ScheduleCafeDTO(String timeSlot, String timeSlotDay, String userName,String phoneNumber, String userEmail) {
		super();
		this.timeSlot = timeSlot;
		this.timeSlotDay = timeSlotDay;
		this.userName = userName;
		this.phoneNumber = phoneNumber;
		this.userEmail = userEmail;
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
	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	@Override
	public String toString() {
		return "ScheduleCafeDTO [timeSlot=" + timeSlot + ", timeSlotDay=" + timeSlotDay + ", userName=" + userName
				+ "]";
	}
	
	
	
	
	
	
	
	
	

}
