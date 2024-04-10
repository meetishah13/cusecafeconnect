package com.example.cuseCafeConnect.repositories;

import com.example.cuseCafeConnect.models.TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TimeSlotRepository extends JpaRepository<TimeSlot, Integer> {
    // You can add custom query methods here if needed
}
