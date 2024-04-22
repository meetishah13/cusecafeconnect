package com.example.cuseCafeConnect.services.impl;

import com.example.cuseCafeConnect.models.Schedule;
import com.example.cuseCafeConnect.models.ScheduleCafeDTO;
import com.example.cuseCafeConnect.models.SubBook;
import com.example.cuseCafeConnect.models.SubBookDetailsPOJO;
import com.example.cuseCafeConnect.models.TotalShiftsInSchedule;
import com.example.cuseCafeConnect.models.UserSchedulePojo;
import com.example.cuseCafeConnect.repositories.ScheduleRepository;
import com.example.cuseCafeConnect.services.ScheduleService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;


import javax.persistence.EntityNotFoundException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ScheduleServiceImpl implements ScheduleService {

    @Autowired
    private ScheduleRepository scheduleRepository;

    @Override
    public Schedule createSchedule(Schedule schedule) {
        return scheduleRepository.save(schedule);
    }

    @Override
    public Schedule getScheduleById(int scheduleID) {
        return scheduleRepository.findById(scheduleID).orElse(null);
    }

    @Override
    public List<Schedule> getAllSchedules() {
        return scheduleRepository.findAll();
    }

	@Override
	public Schedule updateSchedule(Schedule schedule) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteSchedule(int scheduleID) {
		// TODO Auto-generated method stub
		
	}
	
	private UserSchedulePojo convertScheduleToPojo(Schedule s) {
		UserSchedulePojo temp=new UserSchedulePojo(s.getScheduleID(),s.getTimeslot().getTimeSlotID(),s.getCafe().getCafeID(),s.getTimeslot().getTimeSlot(),s.getTimeslot().getTimeSlotDay(),s.getCafe().getCafeName());
		return temp; 
	}
	
	private SubBookDetailsPOJO convertSubBookToPOJO(SubBook sb) {
		SubBookDetailsPOJO temp = new SubBookDetailsPOJO(sb.getSubID(),sb.getDropDate(),sb.getSchedule().getScheduleID(),sb.getSchedule().getTimeslot().getTimeSlotID(),sb.getSchedule().getTimeslot().getTimeSlot(),sb.getCafe().getCafeID(),sb.getCafe().getCafeName()); 
		return temp;
	}

	@Override
	public ResponseEntity<Object> getUserScheduleById(int userId) {
		try{
			List<Schedule> sc = scheduleRepository.findScheduleById(userId);
			List<SubBook> pickUpShift = scheduleRepository.findPickedUpSubById(userId);
			for(SubBook p: pickUpShift) {
				System.out.println("In pick up ");
				System.out.println("In pick up sb.id " + p.getSubID());
				System.out.println("In pick up sb.fname " + p.getPickUpUser().getfName());
			}
			List<SubBook> dropUserShift = scheduleRepository.findDropUserSubById(userId);
			List<UserSchedulePojo> temp=new ArrayList<>();
			List<SubBookDetailsPOJO> pickUpPOJOList=new ArrayList<>();
			List<SubBookDetailsPOJO> dropUserPOJOList=new ArrayList<>();
			
			for(Schedule s:sc) {
				temp.add(convertScheduleToPojo(s));
			}
			for(SubBook sb : pickUpShift) {
				pickUpPOJOList.add(convertSubBookToPOJO(sb));
			}
			for(SubBook sb : dropUserShift) {
				dropUserPOJOList.add(convertSubBookToPOJO(sb));
			}
			
			TotalShiftsInSchedule ts = new TotalShiftsInSchedule(temp,pickUpPOJOList,dropUserPOJOList);
			
			return new ResponseEntity<>(ts,HttpStatus.OK);
		}catch(Exception e) {
			System.out.println("Error msg: " + e.getLocalizedMessage());
			return new ResponseEntity<>(e.getStackTrace(),HttpStatus.BAD_GATEWAY);
		}
		
		
	

   
}

	@Override
	public ResponseEntity<Object> getScheduleByCafeId(int cafeId) {
		List<Object[]> sc = scheduleRepository.findScheduleByCafeId(cafeId); 
		List<ScheduleCafeDTO> schedules = new ArrayList<>();
		System.out.println("Length " + sc.size());
		for(Object[] s : sc) {
			//Map<String, Object> scheduleMap = new HashMap<>();
			System.out.println("timeSlot " +  s[0]);
			System.out.println("timeSlotDay " +  s[1]);
			System.out.println("userName " +  s[2]);
			ScheduleCafeDTO scdto = new ScheduleCafeDTO((String) s[0],(String)s[1],(String)s[2]);
			schedules.add(scdto);
			
		}
		return new ResponseEntity<>(schedules,HttpStatus.OK);
	}
}

