// TotalShiftsInSchedule.java
package com.example.cuseCafeConnect.models;

import java.util.List;

public class TotalShiftsInSchedule {
    private List<UserSchedulePojo> schedule;
    private List<SubBookDetailsPOJO> pickupUser;
    private List<SubBookDetailsPOJO> dropUser;
	public TotalShiftsInSchedule(List<UserSchedulePojo> schedule, List<SubBookDetailsPOJO> pickupUser,
			List<SubBookDetailsPOJO> dropUser) {
		super();
		this.schedule = schedule;
		this.pickupUser = pickupUser;
		this.dropUser = dropUser;
	}
	public List<UserSchedulePojo> getSchedule() {
		return schedule;
	}
	public void setSchedule(List<UserSchedulePojo> schedule) {
		this.schedule = schedule;
	}
	public List<SubBookDetailsPOJO> getPickupUser() {
		return pickupUser;
	}
	public void setPickupUser(List<SubBookDetailsPOJO> pickupUser) {
		this.pickupUser = pickupUser;
	}
	public List<SubBookDetailsPOJO> getDropUser() {
		return dropUser;
	}
	public void setDropUser(List<SubBookDetailsPOJO> dropUser) {
		this.dropUser = dropUser;
	}
    
    

    
}
