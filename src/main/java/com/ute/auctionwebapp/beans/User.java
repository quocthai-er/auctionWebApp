package com.ute.auctionwebapp.beans;

import java.time.LocalDateTime;

public class User {
    private String name, email, password,address;
    LocalDateTime dob;
    private int role, reQuest, id;
    LocalDateTime request_date;

    public int getId() {
        return id;
    }

    public User(String name, String email, String password, String address, LocalDateTime dob, int role, int reQuest, int id, LocalDateTime request_date) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.address = address;
        this.dob = dob;
        this.role = role;
        this.reQuest = reQuest;
        this.id = id;
        this.request_date = request_date;
    }

    public User(String name, String email, String address, String password, LocalDateTime dob, int role, int reQuest) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.address = address;
        this.dob = dob;
        this.role = role;
        this.reQuest = reQuest;
    }

    public User(String name, String address, LocalDateTime dob, int id) {
        this.name = name;
        this.address = address;
        this.dob = dob;
        this.id= id;
    }

    public User(String password, int id) {
        this.password = password;
        this.id= id;
    }
    public User() {
    }

    public User(String name, String email, String address, String password, LocalDateTime dob, int role, int reQuest, LocalDateTime request_date) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.dob = dob;
        this.role = role;
        this.reQuest = reQuest;
        this.address = address;
        this.request_date=request_date;
    }

    public LocalDateTime getRequest_date() {
        return request_date;
    }

    public String getAddress() {
        return address;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public LocalDateTime getDob() {
        return dob;
    }

    public int getRole() { return role;}

    public int getReQuest() {
        return reQuest;
    }
}
