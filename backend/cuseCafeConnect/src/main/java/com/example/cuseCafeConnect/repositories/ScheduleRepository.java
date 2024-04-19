
package com.example.cuseCafeConnect.repositories;

import com.example.cuseCafeConnect.models.Schedule;
import com.example.cuseCafeConnect.models.SubBook;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.cuseCafeConnect.models.Roles;

@Repository
public interface ScheduleRepository extends JpaRepository<Schedule, Integer> {
	@Query(value= "SELECT s.* FROM SCHEDULE s where userID = ?1 and isAccepted = 1 Order by s.scheduleID",nativeQuery= true)
	List<Schedule> findScheduleById(int userId);
	
	@Query("SELECT sb FROM SubBook sb WHERE sb.pickUpUser.id = :userId AND sb.acceptSub = 1")
	List<SubBook> findPickedUpSubById(@Param("userId") int userId);
	
	@Query("SELECT sb FROM SubBook sb WHERE sb.dropUser.id = :userId AND sb.acceptSub = 1")
	List<SubBook> findDropUserSubById(@Param("userId") int userId);

	
	
}
