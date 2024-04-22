package com.example.cuseCafeConnect.models;

import java.time.LocalDateTime;

public class ScheduleCafeDTO {
	
	private int cafeID;
	private int timeSlotId;
	private String timeSlot;
	private String timeSlotDay;
	private String cafeName;
	private String userName;
	
	
	
	public ScheduleCafeDTO(int cafeID,  int timeSlotId, String timeSlot, String timeSlotDay,
			String cafeName, String userName) {
		super();
		this.cafeID = cafeID;
		this.timeSlotId = timeSlotId;
		this.timeSlot = timeSlot;
		this.timeSlotDay = timeSlotDay;
		this.cafeName = cafeName;
		this.userName = userName;
	}
	
	
	
	public int getCafeID() {
		return cafeID;
	}
	public void setCafeID(int cafeID) {
		this.cafeID = cafeID;
	}
	
	public int getTimeSlotId() {
		return timeSlotId;
	}
	public void setTimeSlotId(int timeSlotId) {
		this.timeSlotId = timeSlotId;
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
	public void setTimeSlotDay(String timeSlotDay) {
		this.timeSlotDay = timeSlotDay;
	}
	public String getCafeName() {
		return cafeName;
	}
	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}
	public String userName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	
	
	@Override
	public String toString() {
		return "ScheduleCafeDTO [cafeID=" + cafeID + ", timeSlotId=" + timeSlotId + ", timeSlot=" + timeSlot
				+ ", timeSlotDay=" + timeSlotDay + ", cafeName=" + cafeName + ", userName=" + userName + "]";
	}
	
	

}
