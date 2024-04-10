package com.example.cuseCafeConnect.repositories;

import com.example.cuseCafeConnect.models.Cafe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CafeRepository extends JpaRepository<Cafe, Integer> {
}