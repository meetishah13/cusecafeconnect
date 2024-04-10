package com.example.cuseCafeConnect.services;

import com.example.cuseCafeConnect.models.Cafe;
import com.example.cuseCafeConnect.repositories.CafeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CafeService {
    private final CafeRepository cafeRepository;

    @Autowired
    public CafeService(CafeRepository cafeRepository) {
        this.cafeRepository = cafeRepository;
    }

    public List<Cafe> getAllCafes() {
        return cafeRepository.findAll();
    }

    public Optional<Cafe> getCafeById(int cafeId) {
        return cafeRepository.findById(cafeId);
    }

    public Cafe createCafe(Cafe cafe) {
        return cafeRepository.save(cafe);
    }

    public Cafe updateCafe(Cafe cafe) {
        return cafeRepository.save(cafe);
    }

    public void deleteCafe(int cafeId) {
        cafeRepository.deleteById(cafeId);
    }
}