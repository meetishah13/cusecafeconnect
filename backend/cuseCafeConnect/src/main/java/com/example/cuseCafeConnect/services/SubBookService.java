package com.example.cuseCafeConnect.services;


import com.example.cuseCafeConnect.models.SubBook;
import com.example.cuseCafeConnect.models.User;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface SubBookService {
    SubBook createSubBook(SubBook subBook);
    SubBook getSubBookById(int subID);
    List<SubBook> getAllSubBooks();
    SubBook updateSubBook(SubBook subBook);
    void deleteSubBook(int subID);
    ResponseEntity<Object> findSubBooksByPickUpUserIsNullOrAcceptSub(int userId);
    ResponseEntity<Object> requestForSub(int subId,int userId);
    ResponseEntity<Object> getRequestedSubByUserId(int userId);
    ResponseEntity<Object> getSubBookSchedule(int userId);
    ResponseEntity<Object> updateSubStatus(int subId,int status,String message);

}