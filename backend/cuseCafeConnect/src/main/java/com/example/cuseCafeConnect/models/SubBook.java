package com.example.cuseCafeConnect.models;

import javax.persistence.*;
import java.time.LocalDateTime;
@Entity
@Table(name = "subBook")
public class SubBook {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int subID;

    private int subTypeID;
    private LocalDateTime dropDate;
    private int dropUser;
    private int pickUpUser;
    private int acceptSub;
    private int cafeID;
    private int scheduleID;
    private String comments;

    // Constructors
    public SubBook() {}

    /**
     * @return int return the subID
     */
    public int getSubID() {
        return subID;
    }

    /**
     * @param subID the subID to set
     */
    public void setSubID(int subID) {
        this.subID = subID;
    }

    /**
     * @return int return the subTypeID
     */
    public int getSubTypeID() {
        return subTypeID;
    }

    /**
     * @param subTypeID the subTypeID to set
     */
    public void setSubTypeID(int subTypeID) {
        this.subTypeID = subTypeID;
    }

    /**
     * @return LocalDateTime return the dropDate
     */
    public LocalDateTime getDropDate() {
        return dropDate;
    }

    /**
     * @param dropDate the dropDate to set
     */
    public void setDropDate(LocalDateTime dropDate) {
        this.dropDate = dropDate;
    }

    /**
     * @return int return the dropUser
     */
    public int getDropUser() {
        return dropUser;
    }

    /**
     * @param dropUser the dropUser to set
     */
    public void setDropUser(int dropUser) {
        this.dropUser = dropUser;
    }

    /**
     * @return int return the pickUpUser
     */
    public int getPickUpUser() {
        return pickUpUser;
    }

    /**
     * @param pickUpUser the pickUpUser to set
     */
    public void setPickUpUser(int pickUpUser) {
        this.pickUpUser = pickUpUser;
    }

    /**
     * @return int return the acceptSub
     */
    public int getAcceptSub() {
        return acceptSub;
    }

    /**
     * @param acceptSub the acceptSub to set
     */
    public void setAcceptSub(int acceptSub) {
        this.acceptSub = acceptSub;
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
     * @return String return the comments
     */
    public String getComments() {
        return comments;
    }

    /**
     * @param comments the comments to set
     */
    public void setComments(String comments) {
        this.comments = comments;
    }

}
