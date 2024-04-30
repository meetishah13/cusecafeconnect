package com.example.cuseCafeConnect.models;

import java.time.LocalDateTime;

public class SubBookSchedule {
    private int subId;
    private String cafeName;
    private String dropUserName;
    private String timeSlot;
    private String timeSlotDay;
    private LocalDateTime dropDate;
    private String status;
    private String pickUpUserName;
    private String comments;

    // Parameterized constructor
    public SubBookSchedule(int subId, String cafeName, String dropUserName, String timeSlot, String timeSlotDay, LocalDateTime dropDate,String status,String pickUpUserName,String comments) {
        this.subId = subId;
        this.cafeName = cafeName;
        this.dropUserName = dropUserName;
        this.timeSlot = timeSlot;
        this.timeSlotDay = timeSlotDay;
        this.dropDate = dropDate;
        this.status = status;
        this.pickUpUserName = pickUpUserName;
        this.comments = comments;
    }

    // Getter and Setter methods
    public int getSubId() {
        return subId;
    }

    public String getComments() {
        return comments;
    }

    public void setSubId(int subId) {
        this.subId = subId;
    }

    public String getCafeName() {
        return cafeName;
    }

    public void setCafeName(String cafeName) {
        this.cafeName = cafeName;
    }

    public String getDropUserName() {
        return dropUserName;
    }

    public void setDropUserName(String dropUserName) {
        this.dropUserName = dropUserName;
    }

    public String getPickUpUserName() {
        return pickUpUserName;
    }

    public void setPickUpUserName(String pickUpUserName) {
        this.pickUpUserName = pickUpUserName;
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

    public LocalDateTime getDropDate() {
        return dropDate;
    }

    public void setDropDate(LocalDateTime dropDate) {
        this.dropDate = dropDate;
    }

    public void setComments(String comments){
        this.comments = comments;
    }

    // toString method
    @Override
    public String toString() {
        return "SubBookSchedule{" +
                "subId=" + subId +
                ", cafeName='" + cafeName + '\'' +
                ", dropUserName='" + dropUserName + '\'' +
                ", timeSlot='" + timeSlot + '\'' +
                ", timeSlotDay='" + timeSlotDay + '\'' +
                ", dropDate=" + dropDate +
                '}';
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}