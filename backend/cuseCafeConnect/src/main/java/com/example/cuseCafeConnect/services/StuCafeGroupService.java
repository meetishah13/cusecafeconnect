// StuCafeGroupService.java
package com.example.cuseCafeConnect.services;

import com.example.cuseCafeConnect.models.StuCafeGroup;

public interface StuCafeGroupService {
    StuCafeGroup addStuCafeGroup(StuCafeGroup stuCafeGroup);
    StuCafeGroup getStuCafeGroupById(int stuCafeGrpID);
    StuCafeGroup updateStuCafeGroup(StuCafeGroup stuCafeGroup);
    boolean deleteStuCafeGroup(int stuCafeGrpID);
}
