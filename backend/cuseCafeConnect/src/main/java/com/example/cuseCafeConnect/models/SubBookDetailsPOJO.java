package com.example.cuseCafeConnect.models;

import java.time.LocalDateTime;

public class SubBookDetailsPOJO {
	private int subBookId;
	private LocalDateTime dropDate;
	private int scheduleId;
	private int timeSlotId;
	private String timeSlot;
	private int cafeId;
	private String cafeName;
	
	
	
	public SubBookDetailsPOJO(int subBookId, LocalDateTime dropDate, int scheduleId, int timeSlotId, String timeSlot,
			int cafeId, String cafeName) {
		super();
		this.subBookId = subBookId;
		this.dropDate = dropDate;
		this.scheduleId = scheduleId;
		this.timeSlotId = timeSlotId;
		this.timeSlot = timeSlot;
		this.cafeId = cafeId;
		this.cafeName = cafeName;
	}
	
	
	public int getSubBookId() {
		return subBookId;
	}
	public void setSubBookId(int subBookId) {
		this.subBookId = subBookId;
	}
	public LocalDateTime getDropDate() {
		return dropDate;
	}
	public void setDropDate(LocalDateTime dropDate) {
		this.dropDate = dropDate;
	}
	public int getScheduleId() {
		return scheduleId;
	}
	public void setScheduleId(int scheduleId) {
		this.scheduleId = scheduleId;
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
	public int getCafeId() {
		return cafeId;
	}
	public void setCafeId(int cafeId) {
		this.cafeId = cafeId;
	}
	public String getCafeName() {
		return cafeName;
	}
	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}
	@Override
	public String toString() {
		return "SubBookDetailsPOJO [subBookId=" + subBookId + ", dropDate=" + dropDate + ", scheduleId=" + scheduleId
				+ ", timeSlotId=" + timeSlotId + ", timeSlot=" + timeSlot + ", cafeId=" + cafeId + ", cafeName="
				+ cafeName + "]";
	}
	
	
	
	

}
