package com.example.cuseCafeConnect.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "stu_cafe_group")
public class StuCafeGroup {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int stuCafeGrpID;
    private int userID;
    private int cafeID;
    private int isAccepted;

    // Constructors
    public StuCafeGroup() {}

    public StuCafeGroup(int stuCafeGrpID, int userID, int cafeID, int isAccepted) {
        this.stuCafeGrpID = stuCafeGrpID;
        this.userID = userID;
        this.cafeID = cafeID;
        this.isAccepted = isAccepted;
    }

    public StuCafeGroup(int userId, int cafeId, int isAccepted) {
        this.userID = userId;
        this.cafeID = cafeId;
        this.isAccepted = isAccepted;
    }

    /**
     * @return int return the stuCafeGrpID
     */
    public int getStuCafeGrpID() {
        return stuCafeGrpID;
    }

    /**
     * @param stuCafeGrpID the stuCafeGrpID to set
     */
    public void setStuCafeGrpID(int stuCafeGrpID) {
        this.stuCafeGrpID = stuCafeGrpID;
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

    @Override
    public String toString() {
        return "StuCafeGroup [stuCafeGrpID=" + stuCafeGrpID + ", userID=" + userID + ", cafeID=" + cafeID
                + ", isAccepted=" + isAccepted + "]";
    }

    

}
