package com.example.cuseCafeConnect.services.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.example.cuseCafeConnect.models.User;
import com.example.cuseCafeConnect.models.LoginResult;
import com.example.cuseCafeConnect.repositories.UserRepository;
import com.example.cuseCafeConnect.services.UserService;
import java.util.Base64;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public ResponseEntity<Object> addUser(User user) {
        System.out.println("User name while inserting " + user.getfName());
        try {
            if (userRepository.existsById(user.getUserID())) {
                return new ResponseEntity<>("User with the same userID already exists", HttpStatus.CONFLICT);
            } else {
                User u = userRepository.save(user);
                return new ResponseEntity<>(u, HttpStatus.CREATED);
            }
        } catch (DataIntegrityViolationException ex) {
            return new ResponseEntity<>("Error occurred while adding user: " + ex.getMessage(),
                    HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public List<User> findByCafeIdAndRoleId(int cafeID, int roleID) {
        return userRepository.findByCafeIDAndRoleID(cafeID, roleID);
    }

    @Override
    public ResponseEntity<Object> getUserDetailsByUserId(int userId) {
        Optional<User> user = userRepository.findById(userId);
        if (user.isPresent()) {
            User u = user.get();
            return new ResponseEntity<>(u, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("User Id not found", HttpStatus.BAD_REQUEST);
        }

    }

    public ResponseEntity<Object> updateUserDetails(User user) {
        Optional<User> existingUserOptional = userRepository.findById(user.getUserID());
        if (existingUserOptional.isPresent()) {
            User existingUser = existingUserOptional.get();
            existingUser.setUserEmail(user.getUserEmail());
            existingUser.setfName(user.getfName());
            existingUser.setlName(user.getlName());
            existingUser.setPhoneNo(user.getPhoneNo());
            System.out.println("Base64 image at server side " + user.getPhotoPath());
            if (user.getPhotoPath() != null && user.getPhotoPath().length > 0) {
                existingUser.setPhotoPath(user.getPhotoPath());
            }
            User updatedUser = userRepository.save(existingUser);
            return new ResponseEntity<>(updatedUser, HttpStatus.OK);
        } else {
            return new ResponseEntity<>("User with the given userID not found", HttpStatus.NOT_FOUND);
        }
    }



    @Override
    public LoginResult verifyLogin(String emailId, String password) {
        User user = userRepository.findByUserEmail(emailId);
        if (user == null) {
            return new LoginResult(false, null);
        }
        if (password.equals(user.getPassword())) {
            return new LoginResult(true, user);
        }
        return new LoginResult(false, null);
    }

    @Override
    public User getUserById(int userId) {
        return userRepository.findById(userId).orElse(null);
    }

    @Override
    public List<String> getSupervisorListByCafeId(int cafeID) {
        List<User> supervisors = userRepository.findByCafeIDAndRoleID(cafeID, 2); // Assuming roleId 2 represents
        // supervisors
        List<String> supervisorNames = new ArrayList<>();
        for (User supervisor : supervisors) {
            String supervisorName = supervisor.getfName() + " " + supervisor.getlName();
            supervisorNames.add(supervisorName);
        }
        return supervisorNames;
    }
}