package com.example.cuseCafeConnect.controllers;

import com.example.cuseCafeConnect.models.Cafe;
import com.example.cuseCafeConnect.models.SubBook;
import com.example.cuseCafeConnect.models.User;
import com.example.cuseCafeConnect.services.SubBookService;
import com.example.cuseCafeConnect.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/api/subBooks")
public class SubBookController {

    @Autowired
    private SubBookService subBookService; // If using service layer
    @Autowired
    private UserService userService;

    @PostMapping
    public SubBook createSubBook(@RequestBody SubBook subBook) {
        return subBookService.createSubBook(subBook); // Or subBookRepository.save(subBook)
    }

    @GetMapping("/{subID}")
    public SubBook getSubBookById(@PathVariable int subID) {
        return subBookService.getSubBookById(subID); // Or subBookRepository.findById(subID).get()
    }

    @GetMapping
    public List<SubBook> getAllSubBooks() {
        return subBookService.getAllSubBooks(); // Or subBookRepository.findAll()
    }

    @PutMapping("/{subID}")
    public SubBook updateSubBook(@PathVariable int subID, @RequestBody SubBook subBook) {
        subBook.setSubID(subID); // Ensure ID is set for update
        return subBookService.updateSubBook(subBook); // Or subBookRepository.save(subBook)
    }

    @DeleteMapping("/{subID}")
    public void deleteSubBook(@PathVariable int subID) {
        subBookService.deleteSubBook(subID); // Or subBookRepository.deleteById(subID)
    }

    @GetMapping("/filter/{userId}")
    public ResponseEntity<Object> findSubBooksByPickUpUserIsNullOrAcceptSub(@PathVariable int userId) {

        return subBookService.findSubBooksByPickUpUserIsNullOrAcceptSub(userId);
    }

    @PostMapping("/{subId}/requestForSub/{userId}")
    public ResponseEntity<Object> requestForSub(@PathVariable int subId, @PathVariable int userId) {
        return subBookService.requestForSub(subId,userId);
    }

    @GetMapping("/{userId}/getSubBookSchedule")
    public ResponseEntity<Object> getSubBookSchedule(@PathVariable int userId) {
        return subBookService.getSubBookSchedule(userId);
    }

    @GetMapping("/getRequestedSub/{userId}")
    public ResponseEntity<Object> getRequestedSubByUserId(@PathVariable int userId) {
        return subBookService.getRequestedSubByUserId(userId);
    }


    @PostMapping("/{subId}/updateSubStatus/{status}")
    public ResponseEntity<Object> updateSubStatus(@PathVariable int subId, @PathVariable int status,@RequestBody String message) {
        return subBookService.updateSubStatus(subId,status,message);
    }


}