package com.example.cuseCafeConnect.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.example.cuseCafeConnect.models.StuCafeGroup;
import com.example.cuseCafeConnect.services.StuCafeGroupService;

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
}
