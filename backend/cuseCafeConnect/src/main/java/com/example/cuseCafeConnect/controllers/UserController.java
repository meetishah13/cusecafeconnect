package com.example.cuseCafeConnect.controllers;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.cuseCafeConnect.models.User;
import com.example.cuseCafeConnect.models.LoginResult;
import com.example.cuseCafeConnect.services.UserService;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    UserService userService;

    @GetMapping(value = "/")
    public ResponseEntity<String> test() {
        return new ResponseEntity<>("Hello World", HttpStatus.OK);
    }

    @PostMapping(value = "/addUser")
    public ResponseEntity<Object> addUser(@RequestBody User user) {
        System.out.println("--------------------\n" + user.toString());
        return userService.addUser(user);
    }

    @GetMapping(value = "/{userId}/getUserDetails")
    public ResponseEntity<Object> getUserDetailsByUserId(@PathVariable("userId") int userId) {
        return userService.getUserDetailsByUserId(userId);
    }

    @PutMapping("/editUser")
    public ResponseEntity<Object> updateUserDetails(@RequestParam("userID") int userID,
                                                    @RequestParam("userEmail") String userEmail,
                                                    @RequestParam("fName") String fName,
                                                    @RequestParam("lName") String lName,
                                                    @RequestParam("phoneNo") String phoneNo,
                                                    @RequestParam(value = "photoPath", required = false) MultipartFile photoPath) {
        User user = new User();
        user.setUserID(userID);
        user.setUserEmail(userEmail);
        user.setfName(fName);
        user.setlName(lName);
        user.setPhoneNo(phoneNo);

        if (photoPath != null && !photoPath.isEmpty()) {
            try {
                user.setPhotoPath(photoPath.getBytes());
            } catch (IOException e) {
                e.printStackTrace();
                return new ResponseEntity<>("Failed to process photoPath: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        return userService.updateUserDetails(user);

    }

    @GetMapping(value = "/login")
    public LoginResult verifyLogin(@RequestParam String emailId, @RequestParam String password) {
        return userService.verifyLogin(emailId, password);
    }

}