package com.example.cuseCafeConnect.services;

import com.example.cuseCafeConnect.models.Schedule;

import java.util.List;

public interface ScheduleService {
    Schedule createSchedule(Schedule schedule);
    Schedule getScheduleById(int scheduleID);
    List<Schedule> getAllSchedules();
    Schedule updateSchedule(Schedule schedule);
    void deleteSchedule(int scheduleID);
}
