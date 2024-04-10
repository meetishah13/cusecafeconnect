package com.example.cuseCafeConnect.services.impl;

import com.example.cuseCafeConnect.models.Schedule;
import com.example.cuseCafeConnect.repositories.ScheduleRepository;
import com.example.cuseCafeConnect.services.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;

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
        // Check if schedule exists before update
        Schedule existingSchedule = scheduleRepository.findById(schedule.getScheduleID()).orElse(null);
        if (existingSchedule == null) {
            throw new EntityNotFoundException("Schedule with ID " + schedule.getScheduleID() + " not found");
        }

        existingSchedule.setTimeSlotID(schedule.getTimeSlotID());
        existingSchedule.setUserID(schedule.getUserID());
        existingSchedule.setCafeID(schedule.getCafeID());
        existingSchedule.setIsAccepted(schedule.getIsAccepted());
        existingSchedule.setRequestComments(schedule.getRequestComments());

        return scheduleRepository.save(existingSchedule);
    }

    @Override
    public void deleteSchedule(int scheduleID) {
        scheduleRepository.deleteById(scheduleID);
    }
}

