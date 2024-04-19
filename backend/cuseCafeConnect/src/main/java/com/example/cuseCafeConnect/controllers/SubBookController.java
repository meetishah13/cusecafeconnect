package com.example.cuseCafeConnect.controllers;

import com.example.cuseCafeConnect.models.SubBook;
import com.example.cuseCafeConnect.services.SubBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/subBooks")
public class SubBookController {

    @Autowired
    private SubBookService subBookService;  // If using service layer

    @PostMapping
    public SubBook createSubBook(@RequestBody SubBook subBook) {
        return subBookService.createSubBook(subBook);  // Or subBookRepository.save(subBook)
    }

    @GetMapping("/{subID}")
    public SubBook getSubBookById(@PathVariable int subID) {
        return subBookService.getSubBookById(subID);  // Or subBookRepository.findById(subID).get()
    }

    @GetMapping
    public List<SubBook> getAllSubBooks() {
        return subBookService.getAllSubBooks();  // Or subBookRepository.findAll()
    }

    @PutMapping("/{subID}")
    public SubBook updateSubBook(@PathVariable int subID, @RequestBody SubBook subBook) {
        subBook.setSubID(subID);  // Ensure ID is set for update
        return subBookService.updateSubBook(subBook);  // Or subBookRepository.save(subBook)
    }

    @DeleteMapping("/{subID}")
    public void deleteSubBook(@PathVariable int subID) {
        subBookService.deleteSubBook(subID);  // Or subBookRepository.deleteById(subID)
    }
    
    
    
    
    //new methods

    
    
    
    
    
    
    
}

