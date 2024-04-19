package com.example.cuseCafeConnect.models;

public class UserSchedulePojo {
	private int scheduleId;
	private int timeSlotId;
	private int cafeId;
	private String timeSlot;
	private String timeSlotDay;
	private String cafeName;
	
	
	
	
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
	public int getCafeId() {
		return cafeId;
	}
	public void setCafeId(int cafeId) {
		this.cafeId = cafeId;
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
	public UserSchedulePojo(int scheduleId, int timeSlotId, int cafeId, String timeSlot, String timeSlotDay,
			String cafeName) {
		super();
		this.scheduleId = scheduleId;
		this.timeSlotId = timeSlotId;
		this.cafeId = cafeId;
		this.timeSlot = timeSlot;
		this.timeSlotDay = timeSlotDay;
		this.cafeName = cafeName;
	}
	@Override
	public String toString() {
		return "UserSchedulePojo [scheduleId=" + scheduleId + ", timeSlotId=" + timeSlotId + ", cafeId=" + cafeId
				+ ", timeSlot=" + timeSlot + ", timeSlotDay=" + timeSlotDay + ", cafeName=" + cafeName + "]";
	}
	
	
	

}
