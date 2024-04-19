package com.example.cuseCafeConnect.repositories;
//
//import org.springframework.data.jpa.repository.JpaRepository;
//import com.example.cuseCafeConnect.models.StuCafeGroup;
//
//public interface StuCafeGroupRepository extends JpaRepository<StuCafeGroup, Integer> {
//    // You can define custom query methods here if needed
//}

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.cuseCafeConnect.models.StuCafeGroup;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface StuCafeGroupRepository extends JpaRepository<StuCafeGroup, Integer> {
    @Query("SELECT s.cafeID, c.cafeName FROM StuCafeGroup s JOIN Cafe c ON s.cafeID = c.cafeID WHERE s.userID = :userId AND s.isAccepted = 1")
    List<Object[]> findCafeIdAndNameByUserId(int userId);

}
