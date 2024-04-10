package com.example.cuseCafeConnect.models;

public class Cafe {
	private int cafeID;
    private String cafeName;
    private String cafeLat;
    private String cafeLong;

    // Constructors
    public Cafe() {}

    public Cafe(int cafeID, String cafeName, String cafeLat, String cafeLong) {
        this.cafeID = cafeID;
        this.cafeName = cafeName;
        this.cafeLat = cafeLat;
        this.cafeLong = cafeLong;
    }

    // Getters and setters
    public int getCafeID() {
        return cafeID;
    }

    public void setCafeID(int cafeID) {
        this.cafeID = cafeID;
    }

    public String getCafeName() {
        return cafeName;
    }

    public void setCafeName(String cafeName) {
        this.cafeName = cafeName;
    }

    public String getCafeLat() {
        return cafeLat;
    }

    public void setCafeLat(String cafeLat) {
        this.cafeLat = cafeLat;
    }

    public String getCafeLong() {
        return cafeLong;
    }

    public void setCafeLong(String cafeLong) {
        this.cafeLong = cafeLong;
    }
}

