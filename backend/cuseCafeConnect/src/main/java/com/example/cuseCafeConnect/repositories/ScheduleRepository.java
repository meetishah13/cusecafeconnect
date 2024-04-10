
package com.example.cuseCafeConnect.repositories;

import com.example.cuseCafeConnect.models.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.example.cuseCafeConnect.models.Roles;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
}
