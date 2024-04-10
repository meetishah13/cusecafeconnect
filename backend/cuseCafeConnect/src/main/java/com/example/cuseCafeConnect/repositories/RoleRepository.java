package com.example.cuseCafeConnect.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.cuseCafeConnect.models.Roles;

@Repository
public interface RoleRepository extends JpaRepository<Roles, Integer> {
}