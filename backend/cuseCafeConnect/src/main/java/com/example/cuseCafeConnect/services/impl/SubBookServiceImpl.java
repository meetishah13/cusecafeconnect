package com.example.cuseCafeConnect.services.impl;

import com.example.cuseCafeConnect.models.SubBook;
import com.example.cuseCafeConnect.repositories.SubBookRepository;
import com.example.cuseCafeConnect.services.SubBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.util.List;

@Service
public class SubBookServiceImpl implements SubBookService {

    @Autowired
    private SubBookRepository subBookRepository;

    @Override
    public SubBook createSubBook(SubBook subBook) {
        return subBookRepository.save(subBook);
    }

    @Override
    public SubBook getSubBookById(int subID) {
        return subBookRepository.findById(subID).orElse(null);
    }

    @Override
    public List<SubBook> getAllSubBooks() {
        return subBookRepository.findAll();
    }

    @Override
    public SubBook updateSubBook(SubBook subBook) {
        // Check if subBook exists before update
        SubBook existingSubBook = subBookRepository.findById(subBook.getSubID()).orElse(null);
        if (existingSubBook == null) {
            throw new EntityNotFoundException("SubBook with ID " + subBook.getSubID() + " not found");
        }

        // Update relevant fields (replace with specific fields from your SubBook class)
        existingSubBook.setSubTypeID(subBook.getSubTypeID());
        existingSubBook.setDropDate(subBook.getDropDate());
        existingSubBook.setDropUser(subBook.getDropUser());
        existingSubBook.setPickUpUser(subBook.getPickUpUser());
        existingSubBook.setAcceptSub(subBook.getAcceptSub());
        existingSubBook.setCafe(subBook.getCafe());
        existingSubBook.setScheduleID(subBook.getSchedule());
        existingSubBook.setComments(subBook.getComments());

        return subBookRepository.save(existingSubBook);
    }

    @Override
    public void deleteSubBook(int subID) {
        subBookRepository.deleteById(subID);
    }
}

