package com.example.cuseCafeConnect.models;

import javax.persistence.*;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.time.LocalDateTime;
@Entity
@Table(name = "subBook")
public class SubBook {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int subID;

	private int subTypeID;


	private LocalDateTime dropDate;

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "dropUser", nullable = false)
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private User dropUser;


	@ManyToOne(fetch = FetchType.LAZY, optional = true)
	@JoinColumn(name = "pickUpUser", nullable = true)
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private User pickUpUser;


	private int acceptSub;


	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "cafeID", nullable = false)
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private Cafe cafe;


	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "scheduleID", nullable = false)
	@OnDelete(action = OnDeleteAction.CASCADE)
	@JsonIgnore
	private Schedule schedule;
	//private int timeSlotID;
	//private String timeSlotDay;


	@Override
	public String toString() {
		return "SubBook [subID=" + subID + ", subTypeID=" + subTypeID + ", dropDate=" + dropDate + ", dropUser="
				+ dropUser + ", pickUpUser=" + pickUpUser + ", acceptSub=" + acceptSub + ", cafe=" + cafe
				+ ", scheduleID=" + schedule + ", comments=" + comments + "]";
	}


	public SubBook(){
	}



	public SubBook(int subID, int subTypeID, LocalDateTime dropDate, User dropUser, User pickUpUser, int acceptSub,
				   Cafe cafe, Schedule schedule, String comments) {
		super();
		this.subID = subID;
		this.subTypeID = subTypeID;
		this.dropDate = dropDate;
		this.dropUser = dropUser;
		this.pickUpUser = pickUpUser;
		this.acceptSub = acceptSub;
		this.cafe = cafe;
		this.schedule = schedule;
		this.comments = comments;
	}


	public int getSubID() {
		return subID;
	}


	public void setSubID(int subID) {
		this.subID = subID;
	}


	public int getSubTypeID() {
		return subTypeID;
	}


	public void setSubTypeID(int subTypeID) {
		this.subTypeID = subTypeID;
	}


	public LocalDateTime getDropDate() {
		return dropDate;
	}


	public void setDropDate(LocalDateTime dropDate) {
		this.dropDate = dropDate;
	}


	public User getDropUser() {
		return dropUser;
	}


	public void setDropUser(User dropUser) {
		this.dropUser = dropUser;
	}


	public User getPickUpUser() {
		return pickUpUser;
	}


	public void setPickUpUser(User pickUpUser) {
		this.pickUpUser = pickUpUser;
	}


	public int getAcceptSub() {
		return acceptSub;
	}


	public void setAcceptSub(int acceptSub) {
		this.acceptSub = acceptSub;
	}


	public Cafe getCafe() {
		return cafe;
	}


	public void setCafe(Cafe cafe) {
		this.cafe = cafe;
	}


	public Schedule getSchedule() {
		return schedule;
	}


	public void setScheduleID(Schedule schedule) {
		this.schedule = schedule;
	}


	public String getComments() {
		return comments;
	}


	public void setComments(String comments) {
		this.comments = comments;
	}


	private String comments;





}