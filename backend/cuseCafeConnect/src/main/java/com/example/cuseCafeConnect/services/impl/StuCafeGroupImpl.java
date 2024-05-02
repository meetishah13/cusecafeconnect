// StuCafeGroupImpl.java
package com.example.cuseCafeConnect.services.impl;

import com.example.cuseCafeConnect.models.Cafe;
import com.example.cuseCafeConnect.models.Schedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import com.example.cuseCafeConnect.models.StuCafeGroup;
import com.example.cuseCafeConnect.repositories.StuCafeGroupRepository;
import com.example.cuseCafeConnect.services.StuCafeGroupService;

import java.util.List;

@Service
public class StuCafeGroupImpl implements StuCafeGroupService {

    @Autowired
    StuCafeGroupRepository stuCafeGroupRepository;

    @Override
    public StuCafeGroup addStuCafeGroup(StuCafeGroup stuCafeGroup) {
        return stuCafeGroupRepository.save(stuCafeGroup);
    }

    @Override
    public StuCafeGroup getStuCafeGroupById(int stuCafeGrpID) {
        return stuCafeGroupRepository.findById(stuCafeGrpID).orElse(null);
    }

    @Override
    public StuCafeGroup updateStuCafeGroup(StuCafeGroup stuCafeGroup) {
        if (stuCafeGroupRepository.existsById(stuCafeGroup.getStuCafeGrpID())) {
            return stuCafeGroupRepository.save(stuCafeGroup);
        } else {
            return null;
        }
    }

    @Override
    public boolean deleteStuCafeGroup(int stuCafeGrpID) {
        if (stuCafeGroupRepository.existsById(stuCafeGrpID)) {
            stuCafeGroupRepository.deleteById(stuCafeGrpID);
            return true;
        } else {
            return false;
        }
    }
    @Override
    public List<Object[]> getCafeIdsAndNamesForUser(int userId) {
        return stuCafeGroupRepository.findCafeIdAndNameByUserId(userId);
    }
    @Override
    public List<Object[]> findCafesUserIsNotPartOf(int userId) {
        return stuCafeGroupRepository.findCafesUserIsNotPartOf(userId);
    }

    @Override
    public boolean requestForShift(int userId, int cafeId) {
        StuCafeGroup newStuCafeGroup = new StuCafeGroup(userId,cafeId,0);
        try {
            stuCafeGroupRepository.save(newStuCafeGroup);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public List<Object[]> getRequestedCafeIdsAndNamesForUser(int userId) {
        return stuCafeGroupRepository.findRequestedCafeIdAndNameByUserId(userId);
    }

    @Override
    public List<Object[]> getPendingGroupRequests() {
        return stuCafeGroupRepository.getPendingGroupRequests();
    }

    @Override
    public boolean acceptGroup(int groupId) {
        // Retrieve the entity by ID
        StuCafeGroup group = stuCafeGroupRepository.findById(groupId).orElse(null);
        // Update the isAccepted field and save the entity
        if (group != null) {
            group.setIsAccepted(1); // Assuming you have a field named isAccepted in your entity
            stuCafeGroupRepository.save(group);
            return true;
        }
        return false;
    }

    @Override
    public boolean rejectGroup(int groupId) {
        // Retrieve the entity by ID
        StuCafeGroup group = stuCafeGroupRepository.findById(groupId).orElse(null);

        // Update the isAccepted field and save the entity
        if (group != null) {
            group.setIsAccepted(2); // Assuming you have a field named isAccepted in your entity
            stuCafeGroupRepository.save(group);
            return true;
        }
        return false;
    }

}
