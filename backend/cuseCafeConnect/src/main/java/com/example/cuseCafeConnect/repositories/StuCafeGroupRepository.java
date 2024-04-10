package com.example.cuseCafeConnect.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.cuseCafeConnect.models.StuCafeGroup;

public interface StuCafeGroupRepository extends JpaRepository<StuCafeGroup, Integer> {
    // You can define custom query methods here if needed
}
