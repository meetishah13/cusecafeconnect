package com.example.cuseCafeConnect.services;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

import com.example.cuseCafeConnect.models.User;

public interface UserService {
    ResponseEntity<Object> addUser(User user);
    ResponseEntity<Object> getUserDetailsByUserId(int userId);
    ResponseEntity<Object> updateUserDetails(User user);
    boolean verifyLogin(String emailId,String password);
}