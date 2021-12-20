package com.ute.auctionwebapp.beans;

import java.time.LocalDateTime;

public class User {
    private String name, email, password,address;
    LocalDateTime dob;
    private int role, reQuest, id;
    LocalDateTime request_date;
    boolean gg_acc;

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

    public User(String name, String email, String address, String password, LocalDateTime dob, int role, int reQuest, boolean gg_acc) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.address = address;
        this.dob = dob;
        this.role = role;
        this.reQuest = reQuest;
        this.gg_acc = gg_acc;
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

    public User(int id, int reQuest) {
        this.id= id;
        this.reQuest = reQuest;
    }

    public User(int id, int role, int reQuest) {
        this.id= id;
        this.role = role;
        this.reQuest = reQuest;
    }

    public User() {
    }

    public boolean isGg_acc() {
        return gg_acc;
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
