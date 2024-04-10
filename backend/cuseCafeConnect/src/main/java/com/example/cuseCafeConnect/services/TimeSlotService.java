package com.example.cuseCafeConnect.services;

import com.example.cuseCafeConnect.models.TimeSlot;
import java.util.List;

public interface TimeSlotService {
    TimeSlot getTimeSlotById(int id);
    List<TimeSlot> getAllTimeSlots();
    TimeSlot saveTimeSlot(TimeSlot timeSlot);
    TimeSlot updateTimeSlot(int id, TimeSlot timeSlot);
    void deleteTimeSlot(int id);
}
