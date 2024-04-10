package com.example.cuseCafeConnect.models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "user")
public class User {
	@Id
	private int userID;
	private String userEmail;
	private String fName;
	private String lName;
	private String password;
	private String phoneNo;
	private int roleID;
	private int cafeID;
	private byte[] photoPath;

	// Constructors
	public User() {
	}

	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getlName() {
		return lName;
	}

	public void setlName(String lName) {
		this.lName = lName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public int getRoleID() {
		return roleID;
	}

	public void setRoleID(int roleID) {
		this.roleID = roleID;
	}

	public int getCafeID() {
		return cafeID;
	}

	public void setCafeID(int cafeID) {
		this.cafeID = cafeID;
	}

	public byte[] getPhotoPath() {
		return photoPath;
	}

	public void setPhotoPath(byte[] photoPath) {
		this.photoPath = photoPath;
	}

	@Override
	public String toString() {
		return "User [userID=" + userID + ", userEmail=" + userEmail + ", fName=" + fName + ", lName=" + lName
				+ ", password=" + password + ", phoneNo=" + phoneNo + ", roleID=" + roleID + ", cafeID=" + cafeID + "]";
	}



}
