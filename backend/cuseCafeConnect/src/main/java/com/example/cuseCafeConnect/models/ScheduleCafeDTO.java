package com.example.cuseCafeConnect.models;

import java.time.LocalDateTime;

public class ScheduleCafeDTO {
	
	private int cafeID;
	private int scheduleID;;
	private int timeSlotId;
	private String timeSlot;
	private String timeSlotDay;
	private String cafeName;
	private int userId;
	
	
	
	public int getCafeID() {
		return cafeID;
	}
	public void setCafeID(int cafeID) {
		this.cafeID = cafeID;
	}
	public int getScheduleID() {
		return scheduleID;
	}
	public void setScheduleID(int scheduleID) {
		this.scheduleID = scheduleID;
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
	public ScheduleCafeDTO(int cafeID, int scheduleID, int timeSlotId, String timeSlot, String timeSlotDay,
			String cafeName, int userId) {
		super();
		this.cafeID = cafeID;
		this.scheduleID = scheduleID;
		this.timeSlotId = timeSlotId;
		this.timeSlot = timeSlot;
		this.timeSlotDay = timeSlotDay;
		this.cafeName = cafeName;
		this.userId = userId;
	}
	@Override
	public String toString() {
		return "ScheduleCafeDTO [cafeID=" + cafeID + ", scheduleID=" + scheduleID + ", timeSlotId=" + timeSlotId
				+ ", timeSlot=" + timeSlot + ", timeSlotDay=" + timeSlotDay + ", cafeName=" + cafeName + ", userId="
				+ userId + "]";
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
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	

}
