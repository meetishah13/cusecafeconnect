package com.example.cuseCafeConnect.controllers;

import com.example.cuseCafeConnect.models.Cafe;
import com.example.cuseCafeConnect.services.CafeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/cafes")
public class CafeController {
    private final CafeService cafeService;

    @Autowired
    public CafeController(CafeService cafeService) {
        this.cafeService = cafeService;
    }

    @GetMapping
    public ResponseEntity<List<Cafe>> getAllCafes() {
        List<Cafe> cafes = cafeService.getAllCafes();
        return ResponseEntity.ok(cafes);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Cafe> getCafeById(@PathVariable("id") int cafeId) {
        Optional<Cafe> cafe = cafeService.getCafeById(cafeId);
        return cafe.map(ResponseEntity::ok).orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Cafe> createCafe(@RequestBody Cafe cafe) {
        Cafe createdCafe = cafeService.createCafe(cafe);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdCafe);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Cafe> updateCafe(@PathVariable("id") int cafeId, @RequestBody Cafe cafe) {
        Optional<Cafe> existingCafe = cafeService.getCafeById(cafeId);
        if (existingCafe.isPresent()) {
            cafe.setCafeID(cafeId);
            Cafe updatedCafe = cafeService.updateCafe(cafe);
            return ResponseEntity.ok(updatedCafe);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteCafe(@PathVariable("id") int cafeId) {
        cafeService.deleteCafe(cafeId);
        return ResponseEntity.noContent().build();
    }
}