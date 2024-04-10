package com.example.cuseCafeConnect.models;

import javax.persistence.*;

@Entity
@Table(name = "schedule")
public class Schedule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int scheduleID;
    private int timeSlotID;
    private int userID;
    private int cafeID;
    private int isAccepted;
    private String requestComments;

    // Constructors
    public Schedule() {}

    public Schedule(int scheduleID, int timeSlotID, int userID, int cafeID, int isAccepted, String requestComments) {
        this.scheduleID = scheduleID;
        this.timeSlotID = timeSlotID;
        this.userID = userID;
        this.cafeID = cafeID;
        this.isAccepted = isAccepted;
        this.requestComments = requestComments;
    }

    /**
     * @return int return the scheduleID
     */
    public int getScheduleID() {
        return scheduleID;
    }

    /**
     * @param scheduleID the scheduleID to set
     */
    public void setScheduleID(int scheduleID) {
        this.scheduleID = scheduleID;
    }

    /**
     * @return int return the timeSlotID
     */
    public int getTimeSlotID() {
        return timeSlotID;
    }

    /**
     * @param timeSlotID the timeSlotID to set
     */
    public void setTimeSlotID(int timeSlotID) {
        this.timeSlotID = timeSlotID;
    }

    /**
     * @return int return the userID
     */
    public int getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(int userID) {
        this.userID = userID;
    }

    /**
     * @return int return the cafeID
     */
    public int getCafeID() {
        return cafeID;
    }

    /**
     * @param cafeID the cafeID to set
     */
    public void setCafeID(int cafeID) {
        this.cafeID = cafeID;
    }

    /**
     * @return int return the isAccepted
     */
    public int getIsAccepted() {
        return isAccepted;
    }

    /**
     * @param isAccepted the isAccepted to set
     */
    public void setIsAccepted(int isAccepted) {
        this.isAccepted = isAccepted;
    }

    /**
     * @return String return the requestComments
     */
    public String getRequestComments() {
        return requestComments;
    }

    /**
     * @param requestComments the requestComments to set
     */
    public void setRequestComments(String requestComments) {
        this.requestComments = requestComments;
    }

}
