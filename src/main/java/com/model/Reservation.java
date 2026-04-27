package com.model;

import java.sql.Date;

public class Reservation {
    private int    id;
    private String guestName;
    private String guestEmail;
    private String guestPhone;
    private String roomType;
    private int    roomNumber;
    private Date   checkInDate;
    private Date   checkOutDate;
    private int    numGuests;
    private double totalPrice;
    private String status;

    public Reservation() {}

    public int    getId()                             { return id; }
    public void   setId(int id)                       { this.id = id; }

    public String getGuestName()                      { return guestName; }
    public void   setGuestName(String guestName)      { this.guestName = guestName; }

    public String getGuestEmail()                     { return guestEmail; }
    public void   setGuestEmail(String guestEmail)    { this.guestEmail = guestEmail; }

    public String getGuestPhone()                     { return guestPhone; }
    public void   setGuestPhone(String guestPhone)    { this.guestPhone = guestPhone; }

    public String getRoomType()                       { return roomType; }
    public void   setRoomType(String roomType)        { this.roomType = roomType; }

    public int    getRoomNumber()                     { return roomNumber; }
    public void   setRoomNumber(int roomNumber)       { this.roomNumber = roomNumber; }

    public Date   getCheckInDate()                    { return checkInDate; }
    public void   setCheckInDate(Date checkInDate)    { this.checkInDate = checkInDate; }

    public Date   getCheckOutDate()                   { return checkOutDate; }
    public void   setCheckOutDate(Date checkOutDate)  { this.checkOutDate = checkOutDate; }

    public int    getNumGuests()                      { return numGuests; }
    public void   setNumGuests(int numGuests)         { this.numGuests = numGuests; }

    public double getTotalPrice()                     { return totalPrice; }
    public void   setTotalPrice(double totalPrice)    { this.totalPrice = totalPrice; }

    public String getStatus()                         { return status; }
    public void   setStatus(String status)            { this.status = status; }
}