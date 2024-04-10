package com.example.cuseCafeConnect.controllers;

import com.example.cuseCafeConnect.models.Schedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import com.example.cuseCafeConnect.services.ScheduleService;

@RestController
@RequestMapping("/api/schedules")
public class ScheduleController {

    @Autowired
    private ScheduleService scheduleService;  // If using service layer

    @PostMapping
    public Schedule createSchedule(@RequestBody Schedule schedule) {
        return scheduleService.createSchedule(schedule);  // Or scheduleRepository.save(schedule)
    }

    @GetMapping("/{scheduleID}")
    public Schedule getScheduleById(@PathVariable int scheduleID) {
        return scheduleService.getScheduleById(scheduleID);  // Or scheduleRepository.findById(scheduleID).get()
    }

    @GetMapping
    public List<Schedule> getAllSchedules() {
        return scheduleService.getAllSchedules();  // Or scheduleRepository.findAll()
    }

    @PutMapping("/{scheduleID}")
    public Schedule updateSchedule(@PathVariable int scheduleID, @RequestBody Schedule schedule) {
        schedule.setScheduleID(scheduleID);  // Ensure ID is set for update
        return scheduleService.updateSchedule(schedule);  // Or scheduleRepository.save(schedule)
    }

    @DeleteMapping("/{scheduleID}")
    public void deleteSchedule(@PathVariable int scheduleID) {
        scheduleService.deleteSchedule(scheduleID);  // Or scheduleRepository.deleteById(scheduleID)
    }
}
