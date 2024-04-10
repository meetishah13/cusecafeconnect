// StuCafeGroupImpl.java
package com.example.cuseCafeConnect.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.cuseCafeConnect.models.StuCafeGroup;
import com.example.cuseCafeConnect.repositories.StuCafeGroupRepository;
import com.example.cuseCafeConnect.services.StuCafeGroupService;

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
}
