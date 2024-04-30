package com.example.cuseCafeConnect.repositories;

import com.example.cuseCafeConnect.models.TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface TimeSlotRepository extends JpaRepository<TimeSlot, Integer> {
    @Query(value="SELECT ts.timeSlotID, ts.timeSlot,ts.timeSlotDay FROM timeSlot ts LEFT JOIN schedule s ON ts.timeSlotID = s.timeSlotID AND s.cafeID = ?1 AND s.isAccepted = 1 WHERE s.scheduleID IS NULL;",nativeQuery= true)
    List<Object[]> findAvailableScheduleByCafeId(int cafeId);

}
