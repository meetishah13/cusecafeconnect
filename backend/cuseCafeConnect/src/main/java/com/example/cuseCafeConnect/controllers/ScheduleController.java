package com.example.cuseCafeConnect.controllers;


import com.example.cuseCafeConnect.models.*;
//import com.example.cuseCafeConnect.models.TotalShiftsInSchedule;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.example.cuseCafeConnect.services.impl.ScheduleServiceImpl.DropShiftService;

import java.util.List;
import com.example.cuseCafeConnect.services.ScheduleService;

@RestController
@RequestMapping("/api/schedules")
public class ScheduleController {

    @Autowired
    private ScheduleService scheduleService;// If using service layer
    @Autowired
    private DropShiftService dropShiftService;

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

    //new methods

   @GetMapping("/user/{userId}/shifts")
    public ResponseEntity<Object> getUserShifts(@PathVariable int userId) {


        return scheduleService.getUserScheduleById(userId);
    }

   @GetMapping("/user/{cafeId}/schedule")
   public ResponseEntity<Object> getScheduleByCafeId(@PathVariable int cafeId) {


       return scheduleService.getScheduleByCafeId(cafeId);
   }
    @PostMapping("/dropshift")
    public ResponseEntity<String> dropShift(@RequestBody DropShiftRequest request) {
        try {
            dropShiftService.dropShift(request);
            return ResponseEntity.ok("Drop shift successful");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error dropping shift: " + e.getMessage());
        }
    }




}
