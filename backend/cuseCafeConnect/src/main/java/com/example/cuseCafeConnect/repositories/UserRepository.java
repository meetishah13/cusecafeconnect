package com.example.cuseCafeConnect.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.cuseCafeConnect.models.*;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByUserEmail(String userEmail);
}