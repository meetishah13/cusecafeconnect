package com.example.cuseCafeConnect.repositories;

import com.example.cuseCafeConnect.models.StuCafeGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StuCafeGroupRepository extends JpaRepository<StuCafeGroup, Integer> {
    @Query("SELECT s.cafeID, c.cafeName FROM StuCafeGroup s JOIN Cafe c ON s.cafeID = c.cafeID WHERE s.userID = :userId AND s.isAccepted = 1")
    List<Object[]> findCafeIdAndNameByUserId(int userId);
    @Query("SELECT cafe.cafeID, cafe.cafeName FROM Cafe cafe WHERE cafe.cafeName!= 'Student' AND cafe.cafeID NOT IN " +
            "(SELECT stuCafe.cafeID FROM StuCafeGroup stuCafe WHERE stuCafe.userID = :userId)")
    List<Object[]> findCafesUserIsNotPartOf(int userId);
}
