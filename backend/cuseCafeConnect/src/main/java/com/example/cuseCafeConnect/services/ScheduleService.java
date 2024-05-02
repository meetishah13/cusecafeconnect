package com.example.cuseCafeConnect.services;

import com.example.cuseCafeConnect.models.PendingScheduleDTO;
import com.example.cuseCafeConnect.models.Schedule;


import java.util.List;

import org.springframework.http.ResponseEntity;

public interface ScheduleService {
    Schedule createSchedule(Schedule schedule);
    Schedule getScheduleById(int scheduleID);
    List<Schedule> getAllSchedules();
    Schedule updateSchedule(Schedule schedule);
    void deleteSchedule(int scheduleID);
	ResponseEntity<Object> getUserScheduleById(int userId);
	ResponseEntity<Object> getScheduleByCafeId(int cafeId);
    boolean requestForShift(int userId, int cafeId, int timeSlotId,String comments);

    //Deena
    List<PendingScheduleDTO> getPendingSchedules();
     boolean acceptSchedule(int scheduleId,String comment);
     boolean rejectSchedule(int scheduleId, String comment);
}
