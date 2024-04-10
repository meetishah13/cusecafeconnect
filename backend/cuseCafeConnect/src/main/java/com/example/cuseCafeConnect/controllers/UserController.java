package com.example.cuseCafeConnect.controllers;

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

import com.example.cuseCafeConnect.models.User;
import com.example.cuseCafeConnect.services.UserService;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    UserService userService;

    @GetMapping(value = "/")
    public ResponseEntity<String> test(){
        return new ResponseEntity<>("Hello World",HttpStatus.OK);
    }

    @PostMapping(value = "/addUser")
    public ResponseEntity<Object> addUser( @RequestBody User user){
        System.out.println("--------------------\n"+user.toString());
        return userService.addUser(user);
    }

    @GetMapping(value = "/{userId}/getUserDetails")
    public ResponseEntity<Object> getUserDetailsByUserId(@PathVariable("userId") int userId) {
        return userService.getUserDetailsByUserId(userId);
    }

    @PutMapping("/editUser")
    public ResponseEntity<Object> updateUserDetails(@RequestBody User user) {
        return userService.updateUserDetails(user);
    }

    @GetMapping(value = "/login")
    public boolean verifyLogin(@RequestParam String emailId,@RequestParam String password) {
        return userService.verifyLogin(emailId,password);
    }
    
    



    
}
