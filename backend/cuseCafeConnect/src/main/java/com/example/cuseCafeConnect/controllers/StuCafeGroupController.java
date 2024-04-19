package com.example.cuseCafeConnect.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.cuseCafeConnect.models.StuCafeGroup;
import com.example.cuseCafeConnect.services.StuCafeGroupService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/stucafegroup")
public class StuCafeGroupController {

    @Autowired
    StuCafeGroupService stuCafeGroupService;

    @PostMapping("/add")
    public ResponseEntity<StuCafeGroup> addStuCafeGroup(@RequestBody StuCafeGroup stuCafeGroup) {
        StuCafeGroup newStuCafeGroup = stuCafeGroupService.addStuCafeGroup(stuCafeGroup);
        return new ResponseEntity<>(newStuCafeGroup, HttpStatus.CREATED);
    }

    @GetMapping("/{stuCafeGrpID}")
    public ResponseEntity<StuCafeGroup> getStuCafeGroupById(@PathVariable int stuCafeGrpID) {
        StuCafeGroup stuCafeGroup = stuCafeGroupService.getStuCafeGroupById(stuCafeGrpID);
        if (stuCafeGroup != null) {
            return new ResponseEntity<>(stuCafeGroup, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/update")
    public ResponseEntity<StuCafeGroup> updateStuCafeGroup(@RequestBody StuCafeGroup stuCafeGroup) {
        StuCafeGroup updatedStuCafeGroup = stuCafeGroupService.updateStuCafeGroup(stuCafeGroup);
        if (updatedStuCafeGroup != null) {
            return new ResponseEntity<>(updatedStuCafeGroup, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{stuCafeGrpID}")
    public ResponseEntity<Void> deleteStuCafeGroup(@PathVariable int stuCafeGrpID) {
        boolean deleted = stuCafeGroupService.deleteStuCafeGroup(stuCafeGrpID);
        if (deleted) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @GetMapping("/cafes/{userId}")
    public ResponseEntity<List<Map<String, Object>>> getCafesByUserId(@PathVariable int userId) {
        List<Object[]> cafesData = stuCafeGroupService.getCafeIdsAndNamesForUser(userId);
        List<Map<String, Object>> cafes = new ArrayList<>();

        for (Object[] cafeData : cafesData) {
            Map<String, Object> cafeMap = new HashMap<>();
            cafeMap.put("cafeId", cafeData[0]);
            cafeMap.put("cafeName", cafeData[1]);
            cafes.add(cafeMap);
        }

        return new ResponseEntity<>(cafes, HttpStatus.OK);
    }


}
