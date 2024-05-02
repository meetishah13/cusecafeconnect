package com.example.cuseCafeConnect.models;

public class PendingScheduleDTO {
    private String userName;
    private String cafeName;
    private String timeSlot;
    private String timeSlotDay;
    private int scheduleId;


    public PendingScheduleDTO() {
    }

    public int setScheduleId(int scheduleId) {
        return this.scheduleId = scheduleId;
    }
    public int getScheduleId() {
        return scheduleId;
    }

    public String getTimeSlotDay() {
        return timeSlotDay;
    }

    public void setTimeSlotDay(String timeSlotDay) {
        this.timeSlotDay = timeSlotDay;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }

    public String getCafeName() {
        return cafeName;
    }

    public void setCafeName(String cafeName) {
        this.cafeName = cafeName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }



    public PendingScheduleDTO(String userName, String cafeName, String timeSlot, String timeSlotDay, int scheduleId) {
        this.userName = userName;
        this.cafeName = cafeName;
        this.timeSlot = timeSlot;
        this.timeSlotDay = timeSlotDay;
        this.scheduleId = scheduleId;
    }
}
