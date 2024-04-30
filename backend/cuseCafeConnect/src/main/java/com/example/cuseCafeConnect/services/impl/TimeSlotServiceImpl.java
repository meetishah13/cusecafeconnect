package com.example.cuseCafeConnect.services.impl;

import com.example.cuseCafeConnect.models.TimeSlot;
import com.example.cuseCafeConnect.repositories.TimeSlotRepository;
import com.example.cuseCafeConnect.services.TimeSlotService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class TimeSlotServiceImpl implements TimeSlotService {

    @Autowired
    private TimeSlotRepository timeSlotRepository;

    @Override
    public TimeSlot getTimeSlotById(int id) {
        Optional<TimeSlot> optionalTimeSlot = timeSlotRepository.findById(id);
        return optionalTimeSlot.orElse(null);
    }

    @Override
    public List<TimeSlot> getAllTimeSlots() {
        return timeSlotRepository.findAll();
    }

    @Override
    public TimeSlot saveTimeSlot(TimeSlot timeSlot) {
        return timeSlotRepository.save(timeSlot);
    }

    @Override
    public TimeSlot updateTimeSlot(int id, TimeSlot updatedTimeSlot) {
        Optional<TimeSlot> optionalTimeSlot = timeSlotRepository.findById(id);
        if (optionalTimeSlot.isPresent()) {
            updatedTimeSlot.setTimeSlotID(id);
            return timeSlotRepository.save(updatedTimeSlot);
        }
        return null;
    }

    @Override
    public void deleteTimeSlot(int id) {
        timeSlotRepository.deleteById(id);
    }


    @Override
    public List<Object[]> getAvailableTimeSlotIdsByCafeId(int cafeId) {
        return timeSlotRepository.findAvailableScheduleByCafeId(cafeId);
    }
}
