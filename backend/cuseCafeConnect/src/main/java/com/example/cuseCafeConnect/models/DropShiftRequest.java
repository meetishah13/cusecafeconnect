package com.example.cuseCafeConnect.models;

import java.time.LocalDateTime;

public class DropShiftRequest {
    private int scheduleId;
    public DropShiftRequest(int scheduleId, int subTypeId, int userId, int cafeId, LocalDateTime dropDate,
                            int isAccepted, String comments) {
        super();
        this.scheduleId = scheduleId;
        this.subTypeId = subTypeId;
        this.userId = userId;
        this.cafeId = cafeId;
        this.dropDate = dropDate;
        this.isAccepted = isAccepted;
        this.comments = comments;
    }
    public int getScheduleId() {
        return scheduleId;
    }
    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }
    public int getSubTypeId() {
        return subTypeId;
    }
    public void setSubTypeId(int subTypeId) {
        this.subTypeId = subTypeId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public int getCafeId() {
        return cafeId;
    }
    public void setCafeId(int cafeId) {
        this.cafeId = cafeId;
    }
    public LocalDateTime getDropDate() {
        return dropDate;
    }
    public void setDropDate(LocalDateTime dropDate) {
        this.dropDate = dropDate;
    }
    public int getIsAccepted() {
        return isAccepted;
    }
    public void setIsAccepted(int isAccepted) {
        this.isAccepted = isAccepted;
    }
    public String getComments() {
        return comments;
    }
    public void setComments(String comments) {
        this.comments = comments;
    }
    private int subTypeId;
    private int userId;
    private int cafeId;
    private LocalDateTime dropDate;
    private int isAccepted;
    private String comments;


}