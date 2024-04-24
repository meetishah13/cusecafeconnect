package com.example.cuseCafeConnect.repositories;


import com.example.cuseCafeConnect.models.SubBook;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SubBookRepository extends JpaRepository<SubBook, Integer> {
//    @Query("SELECT sb FROM SubBook sb WHERE sb.pickUpUser IS NULL OR sb.acceptSub = 0")
    @Query("SELECT sb.subID, c.cafeName, du.userID AS dropUserId, du.fName AS dropUserName, pu.userID AS pickUpUserId, pu.fName AS pickUpUserName, ts.timeSlotID, ts.timeSlot, ts.timeSlotDay, sb.dropDate " +
            "FROM SubBook sb " +
            "JOIN sb.cafe c " +
            "LEFT JOIN sb.dropUser du " +
            "LEFT JOIN sb.pickUpUser pu " +
            "LEFT JOIN sb.schedule sch " +
            "LEFT JOIN sch.timeslot ts " +
            "WHERE sb.pickUpUser IS NULL OR sb.acceptSub = 0")
    List<Object[]> findSubBooksByPickUpUserIsNullOrAcceptSub();


//    List<SubBook> findSubBooksByPickUpUserIsNullOrAcceptSub();
}