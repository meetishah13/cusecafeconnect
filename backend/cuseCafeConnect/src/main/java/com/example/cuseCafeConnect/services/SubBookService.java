package com.example.cuseCafeConnect.services;


import com.example.cuseCafeConnect.models.SubBook;

import java.util.List;

public interface SubBookService {
    SubBook createSubBook(SubBook subBook);
    SubBook getSubBookById(int subID);
    List<SubBook> getAllSubBooks();
    SubBook updateSubBook(SubBook subBook);
    void deleteSubBook(int subID);
}
