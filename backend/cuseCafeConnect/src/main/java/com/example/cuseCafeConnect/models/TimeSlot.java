package com.example.cuseCafeConnect.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "timeslot")
public class TimeSlot {
	
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int timeSlotID;
	    private String timeSlot;
	    private String timeSlotDay;

	    // Constructors
	    public TimeSlot() {}

		public int getTimeSlotID() {
			return timeSlotID;
		}

		public void setTimeSlotID(int timeSlotID) {
			this.timeSlotID = timeSlotID;
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
	    
	    
	    
}
