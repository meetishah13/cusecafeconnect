package com.example.cuseCafeConnect.controllers;

import com.example.cuseCafeConnect.services.UserService;
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
    @Autowired
    UserService userService;
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
            int cafeId = (int) cafeData[0];
            String cafeName = (String) cafeData[1];
            List<String> supervisorList = userService.getSupervisorListByCafeId(cafeId);

            cafeMap.put("cafeID", cafeId);
            cafeMap.put("cafeName", cafeName);
            cafeMap.put("supervisorList", supervisorList);

            cafes.add(cafeMap);
        }

        return new ResponseEntity<>(cafes, HttpStatus.OK);
    }
//    @GetMapping("/cafes/notmember/{userId}")
    private ResponseEntity<List<Map<String, Object>>> getCafesUserIsNotPartOf(@PathVariable int userId) {
        List<Object[]> cafesData = stuCafeGroupService.findCafesUserIsNotPartOf(userId);
        List<Map<String, Object>> cafes = new ArrayList<>();

        for (Object[] cafeData : cafesData) {
            Map<String, Object> cafeMap = new HashMap<>();
            int cafeId = (int) cafeData[0];
            String cafeName = (String) cafeData[1];
            List<String> supervisorList = userService.getSupervisorListByCafeId(cafeId);

            cafeMap.put("cafeID", cafeId);
            cafeMap.put("cafeName", cafeName);
            cafeMap.put("supervisorList", supervisorList);

            cafes.add(cafeMap);
        }

        return new ResponseEntity<>(cafes, HttpStatus.OK);
    }
    @GetMapping("/cafes/notmember/{userId}")
    public ResponseEntity<Map<String, List<Map<String, Object>>>> getCafes(@PathVariable int userId) {
        Map<String, List<Map<String, Object>>> response = new HashMap<>();
        List<Map<String, Object>> cafesByUser = getCafesByUserId(userId).getBody();
        List<Map<String, Object>> cafesNotMember = getCafesUserIsNotPartOf(userId).getBody();
        response.put("cafesByUser", cafesByUser);
        response.put("cafesNotMember", cafesNotMember);
        return ResponseEntity.ok(response);
    }



}
