package com.example.cuseCafeConnect.controllers;

import com.example.cuseCafeConnect.models.TimeSlot;
import com.example.cuseCafeConnect.services.TimeSlotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/timeslots")
public class TimeSlotController {

    @Autowired
    private TimeSlotService timeSlotService;

    @GetMapping("/{id}")
    public ResponseEntity<TimeSlot> getTimeSlotById(@PathVariable("id") int id) {
        TimeSlot timeSlot = timeSlotService.getTimeSlotById(id);
        if (timeSlot != null) {
            return new ResponseEntity<>(timeSlot, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping
    public ResponseEntity<List<TimeSlot>> getAllTimeSlots() {
        List<TimeSlot> timeSlots = timeSlotService.getAllTimeSlots();
        return new ResponseEntity<>(timeSlots, HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<TimeSlot> saveTimeSlot(@RequestBody TimeSlot timeSlot) {
        TimeSlot savedTimeSlot = timeSlotService.saveTimeSlot(timeSlot);
        return new ResponseEntity<>(savedTimeSlot, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<TimeSlot> updateTimeSlot(@PathVariable("id") int id, @RequestBody TimeSlot timeSlot) {
        TimeSlot updatedTimeSlot = timeSlotService.updateTimeSlot(id, timeSlot);
        if (updatedTimeSlot != null) {
            return new ResponseEntity<>(updatedTimeSlot, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTimeSlot(@PathVariable("id") int id) {
        timeSlotService.deleteTimeSlot(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }


    @GetMapping("/availableByCafe/{cafeId}")
    public ResponseEntity<List<Object[]>> getAvailableTimeSlotIdsByCafeId(@PathVariable int cafeId) {
        List<Object[]> availableTimeSlotIds = timeSlotService.getAvailableTimeSlotIdsByCafeId(cafeId);
//        System.out.print(availableTimeSlotIds);
        return new ResponseEntity<>(availableTimeSlotIds, HttpStatus.OK);
    }


}
