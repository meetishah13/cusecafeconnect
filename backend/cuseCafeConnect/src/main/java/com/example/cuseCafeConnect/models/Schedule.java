package com.example.cuseCafeConnect.models;

import javax.persistence.*;

import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "schedule")
public class Schedule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int scheduleID;
    
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "timeSlotID", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
    private TimeSlot timeslot;
    
    
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "userID", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
    private User user;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "cafeID", nullable = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JsonIgnore
    private Cafe cafe;
    
    
    public Schedule() {
    	
    }



    public Schedule(int scheduleID, TimeSlot timeslot, User user, Cafe cafe, int isAccepted, String requestComments) {
		this.scheduleID = scheduleID;
		this.timeslot = timeslot;
		this.user = user;
		this.cafe = cafe;
		this.isAccepted = isAccepted;
		this.requestComments = requestComments;
	}
    
    
	


	public int getScheduleID() {
		return scheduleID;
	}
	public void setScheduleID(int scheduleID) {
		this.scheduleID = scheduleID;
	}
	public TimeSlot getTimeslot() {
		return timeslot;
	}
	public void setTimeslot(TimeSlot timeslot) {
		this.timeslot = timeslot;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Cafe getCafe() {
		return cafe;
	}
	public void setCafe(Cafe cafe) {
		this.cafe = cafe;
	}
	public int getIsAccepted() {
		return isAccepted;
	}
	public void setIsAccepted(int isAccepted) {
		this.isAccepted = isAccepted;
	}
	public String getRequestComments() {
		return requestComments;
	}
	public void setRequestComments(String requestComments) {
		this.requestComments = requestComments;
	}
	private int isAccepted;
    private String requestComments;
    
    @Override
	public String toString() {
		return "Schedule [scheduleID=" + scheduleID + ", timeslot=" + timeslot + ", user=" + user + ", cafe=" + cafe
				+ ", isAccepted=" + isAccepted + ", requestComments=" + requestComments + "]";
	}
}





