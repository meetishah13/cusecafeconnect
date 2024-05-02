package com.example.cuseCafeConnect.repositories;

import com.example.cuseCafeConnect.models.StuCafeGroup;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StuCafeGroupRepository extends JpaRepository<StuCafeGroup, Integer> {
    @Query("SELECT s.cafeID, c.cafeName, c.cafeLat, c.cafeLong FROM StuCafeGroup s JOIN Cafe c ON s.cafeID = c.cafeID WHERE s.userID = :userId AND s.isAccepted = 1")
    List<Object[]> findCafeIdAndNameByUserId(int userId);
    @Query("SELECT cafe.cafeID, cafe.cafeName, cafe.cafeLat, cafe.cafeLong FROM Cafe cafe WHERE cafe.cafeName!= 'Student' AND cafe.cafeID NOT IN " +
            "(SELECT stuCafe.cafeID FROM StuCafeGroup stuCafe WHERE stuCafe.userID = :userId)")
    List<Object[]> findCafesUserIsNotPartOf(int userId);
    List<StuCafeGroup> findByCafeIDAndUserID(int cafeID, int roleID);
    @Query("SELECT s.cafeID, c.cafeName, c.cafeLat, c.cafeLong, s.isAccepted FROM StuCafeGroup s JOIN Cafe c ON s.cafeID = c.cafeID WHERE s.userID = :userId AND s.isAccepted = 0 OR s.isAccepted = 2")
    List<Object[]> findRequestedCafeIdAndNameByUserId(int userId);
    //Deena APIS
    @Query("SELECT CONCAT(u.fName, ' ', u.lName) AS UserName,  c.cafeName AS CafeName FROM StuCafeGroup scg JOIN User u ON scg.userID = u.userID JOIN Cafe c ON scg.cafeID = c.cafeID WHERE scg.isAccepted = 0")
    List<Object[]> getPendingGroupRequests();

}
