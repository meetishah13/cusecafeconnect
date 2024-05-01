// StuCafeGroupService.java
package com.example.cuseCafeConnect.services;

import com.example.cuseCafeConnect.models.Cafe;
import com.example.cuseCafeConnect.models.StuCafeGroup;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface StuCafeGroupService {
    StuCafeGroup addStuCafeGroup(StuCafeGroup stuCafeGroup);
    StuCafeGroup getStuCafeGroupById(int stuCafeGrpID);
    StuCafeGroup updateStuCafeGroup(StuCafeGroup stuCafeGroup);
    boolean deleteStuCafeGroup(int stuCafeGrpID);
    List<Object[]> getCafeIdsAndNamesForUser(int userId);
     List<Object[]> findCafesUserIsNotPartOf(int userId);
    boolean requestForShift(int userId, int cafeId);
    List<Object[]> getRequestedCafeIdsAndNamesForUser(int userId);

}
