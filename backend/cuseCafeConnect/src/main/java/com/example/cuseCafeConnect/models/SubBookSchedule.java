package com.example.cuseCafeConnect.models;

import java.time.LocalDateTime;

public class SubBookSchedule {
    private int subId;
    private String cafeName;
    private String dropUserName;
    private String timeSlot;
    private String timeSlotDay;
    private LocalDateTime dropDate;

    // Parameterized constructor
    public SubBookSchedule(int subId, String cafeName, String dropUserName, String timeSlot, String timeSlotDay, LocalDateTime dropDate) {
        this.subId = subId;
        this.cafeName = cafeName;
        this.dropUserName = dropUserName;
        this.timeSlot = timeSlot;
        this.timeSlotDay = timeSlotDay;
        this.dropDate = dropDate;
    }

    // Getter and Setter methods
    public int getSubId() {
        return subId;
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
}
