package com.example.cuseCafeConnect.services;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

import com.example.cuseCafeConnect.models.User;
import com.example.cuseCafeConnect.models.LoginResult;

public interface UserService {
    ResponseEntity<Object> addUser(User user);
    ResponseEntity<Object> getUserDetailsByUserId(int userId);
    ResponseEntity<Object> updateUserDetails(User user);
    LoginResult verifyLogin(String emailId,String password);
    List<User> findByCafeIdAndRoleId(int cafeID, int roleID);
    List<String> getSupervisorListByCafeId(int cafeId);
}