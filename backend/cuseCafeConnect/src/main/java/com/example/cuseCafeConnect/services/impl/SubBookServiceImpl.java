package com.example.cuseCafeConnect.services.impl;

import com.example.cuseCafeConnect.models.SubBook;
import com.example.cuseCafeConnect.models.SubBookSchedule;
import com.example.cuseCafeConnect.models.User;
import com.example.cuseCafeConnect.repositories.SubBookRepository;
import com.example.cuseCafeConnect.repositories.UserRepository;
import com.example.cuseCafeConnect.services.SubBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.time.LocalDateTime;
import java.util.*;

@Service
public class SubBookServiceImpl implements SubBookService {

    @Autowired
    private SubBookRepository subBookRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public SubBook createSubBook(SubBook subBook) {
        return subBookRepository.save(subBook);
    }

    @Override
    public SubBook getSubBookById(int subID) {
        return subBookRepository.findById(subID).orElse(null);
    }

    @Override
    public List<SubBook> getAllSubBooks() {
        return subBookRepository.findAll();
    }

    @Override
    public SubBook updateSubBook(SubBook subBook) {
        SubBook existingSubBook = subBookRepository.findById(subBook.getSubID()).orElse(null);
        if (existingSubBook == null) {
            throw new EntityNotFoundException("SubBook with ID " + subBook.getSubID() + " not found");
        }
        existingSubBook.setSubTypeID(subBook.getSubTypeID());
        existingSubBook.setDropDate(subBook.getDropDate());
        existingSubBook.setDropUser(subBook.getDropUser());
        existingSubBook.setPickUpUser(subBook.getPickUpUser());
        existingSubBook.setAcceptSub(subBook.getAcceptSub());
        existingSubBook.setCafe(subBook.getCafe());
        existingSubBook.setScheduleID(subBook.getSchedule());
        existingSubBook.setComments(subBook.getComments());

        return subBookRepository.save(existingSubBook);
    }

    @Override
    public void deleteSubBook(int subID) {
        subBookRepository.deleteById(subID);
    }

    @Override
    public ResponseEntity<Object> findSubBooksByPickUpUserIsNullOrAcceptSub(int userId) {
        List<Object[]> res = subBookRepository.findSubBooksByPickUpUserIsNullOrAcceptSub();
        List<SubBookSchedule> result = new ArrayList<>();
        for (Object[] r : res) {
            Integer dropUserId = (Integer) r[2];
            Integer pickUserId = (Integer) r[4];
            if (!dropUserId.equals(userId) && (pickUserId == null || !pickUserId.equals(userId))) {
                System.out.println("Id " + r[0]);
                System.out.println("Cafe Name " + r[1]);
                System.out.println("Drop user Name " + r[3]);
                System.out.println("TimeSlot " + r[7]);
                System.out.println("Time slot day " + r[8]);
                System.out.println("Drop Date " + r[9]);
                SubBookSchedule s = new SubBookSchedule((int) r[0], (String) r[1], (String) r[3], (String) r[7],
                        (String) r[8], (LocalDateTime) r[9], "", (r[5] != null) ? (String) r[5] : "","");
                result.add(s);
            }
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @Override
    public ResponseEntity<Object> requestForSub(int subId, int userId) {
        SubBook subBook = subBookRepository.findById(subId).orElse(null);
        if (subBook == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("SubBook with ID " + subId + " not found.");
        }

        if (subBook.getPickUpUser() != null) {
            // PickUpUser already set
            return createNewSubBook(subBook, userId);
        } else {
            // PickUpUser not set
            return setPickUpUser(subBook, userId);
        }
    }

    private ResponseEntity<Object> createNewSubBook(SubBook subBook, int userId) {
        User user = getUserById(userId);
        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }

        SubBook newSubBook = cloneSubBook(subBook);
        newSubBook.setPickUpUser(user);
        newSubBook.setSubID(0);
        newSubBook.setAcceptSub(3);

        try {
            subBookRepository.save(newSubBook);
            return ResponseEntity.ok(true);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(false);
        }
    }

    private ResponseEntity<Object> setPickUpUser(SubBook subBook, int userId) {
        User user = getUserById(userId);
        if (user == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(false);
        }

        subBook.setPickUpUser(user);
        try {
            subBookRepository.save(subBook);
            return ResponseEntity.ok(true);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(false);
        }
    }

    private User getUserById(int userId) {
        return userRepository.findById(userId).orElse(null);
    }

    private SubBook cloneSubBook(SubBook originalSubBook) {
        SubBook newSubBook = new SubBook();
        newSubBook.setSubTypeID(originalSubBook.getSubTypeID());
        newSubBook.setDropDate(originalSubBook.getDropDate());
        newSubBook.setDropUser(originalSubBook.getDropUser());
        newSubBook.setCafe(originalSubBook.getCafe());
        newSubBook.setScheduleID(originalSubBook.getSchedule());
        newSubBook.setComments(originalSubBook.getComments());
        return newSubBook;
    }

    @Override
    public ResponseEntity<Object> getSubBookSchedule(int userId) {
        User u = getUserById(userId);
        List<Object[]> res = subBookRepository.findSubBooksByCafeId(u.getCafeID());
        List<SubBookSchedule> result = new ArrayList<>();
        for (Object[] r : res) {
            int statusCode = (int) r[10];
            String status = "";
            System.out.println(statusCode);
            if (statusCode == 1) {
                status = "Accepted";
            } else if (statusCode == 2) {
                status = "Rejected";
            } else {
                status = "In Review";
            }
            SubBookSchedule s = new SubBookSchedule((int) r[0], (String) r[1], (String) r[3], (String) r[7],
                    (String) r[8], (LocalDateTime) r[9], status, (String) r[5],"");
            result.add(s);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @Override
    public ResponseEntity<Object> getRequestedSubByUserId(int userId) {
        List<Object[]> res = subBookRepository.findSubBooksByPickUpUser(userId);
        List<SubBookSchedule> result = new ArrayList<>();
        for (Object[] r : res) {
            int statusCode = (int) r[10];
            String status = "";
            System.out.println(statusCode);
            if (statusCode == 1) {
                status = "Accepted";
            } else if (statusCode == 2) {
                status = "Rejected";
            } else {
                status = "In Review";
            }
            SubBookSchedule s = new SubBookSchedule((int) r[0], (String) r[1], (String) r[3], (String) r[7], (String) r[8], (LocalDateTime) r[9], status, (String) r[5],r[11] != null ? ((String) r[11]).replaceAll("\"", "") : "");
            result.add(s);
        }
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @Override
    public ResponseEntity<Object> updateSubStatus(int subId, int status, String message) {
        SubBook subBook = subBookRepository.findById(subId).orElse(null);
        if (subBook == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("SubBook with ID " + subId + " not found.");
        }
        subBook.setAcceptSub(status);
        subBook.setComments(message);
        try {
            subBookRepository.save(subBook);
            return ResponseEntity.ok(true);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(false);
        }

    }

}