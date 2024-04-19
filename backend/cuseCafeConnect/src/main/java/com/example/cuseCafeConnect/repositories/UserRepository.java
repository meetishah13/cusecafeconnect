package com.example.cuseCafeConnect.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.cuseCafeConnect.models.*;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUserEmail(String userEmail);

    List<User> findByCafeIDAndRoleID(int cafeID, int roleID);


}