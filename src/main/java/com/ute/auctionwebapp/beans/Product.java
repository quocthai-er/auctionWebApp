package com.ute.auctionwebapp.beans;

import java.time.LocalDateTime;
import java.util.Date;

public class Product {
    private int proid;
    private int id;
    private String proname,tinydes,fulldes;
    private int quantity,price_start,price_payment,price_step,price_now,price_current;
    private LocalDateTime start_day,end_day;
    private int catid,bid_id;
    private String status;
    private String renew;

    private String allow_bid;
    private int price_max;
    private int sell_id;
    private String sell_name, bid_name,sell_mail,bid_mail;
    private int count;
    private int bid_count;
    private String name;

    private String reject_bid_id;

    public Product() {}

    public String getName() {
        return name;
    }

    public int getBid_count() {
        return bid_count;
    }

    public String getSell_name() {
        return sell_name;
    }

    public int getCount() {
        return count;
    }

    public String getBid_name() {
        return bid_name;
    }

    public String getSell_mail() {
        return sell_mail;
    }

    public String getBid_mail() {
        return bid_mail;
    }

    public int getProid() {
        return proid;
    }

    public String getProname() {
        return proname;
    }

    public String getTinydes() {
        return tinydes;
    }

    public String getFulldes() {
        return fulldes;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getPrice_start() {
        return price_start;
    }

    public int getPrice_payment() {
        return price_payment;
    }

    public int getPrice_step() {
        return price_step;
    }

    public int getPrice_now() {
        return price_now;
    }

    public int getPrice_current() {
        return price_current;
    }

    public LocalDateTime getStart_day() {
        return start_day;
    }

    public int getSell_id() {
        return sell_id;
    }

    public String getRenew() {
        return renew;
    }

    public LocalDateTime getEnd_day() {
        return end_day;
    }

    public int getCatid() {
        return catid;
    }

    public int getBid_id() {
        return bid_id;
    }

    public String getStatus() {
        return status;
    }
    public int getPrice_max() {
        return price_max;
    }
    public String getAllow_bid() {
        return allow_bid;
    }
    public String getReject_bid_id() {
        return reject_bid_id;
    }

    public Product(String proname, String tinydes, String fulldes, int quantity, int price_start, int price_payment, int price_step, int price_now, int price_current, LocalDateTime start_day, LocalDateTime end_day, int catid, String status, int price_max, int sell_id, String renew, String allow_bid) {
        this.proname = proname;
        this.tinydes = tinydes;
        this.fulldes = fulldes;
        this.quantity = quantity;
        this.price_start = price_start;
        this.price_payment = price_payment;
        this.price_step = price_step;
        this.price_now = price_now;
        this.price_current = price_current;
        this.start_day = start_day;
        this.end_day = end_day;
        this.catid = catid;
        this.status = status;
        this.price_max = price_max;
        this.sell_id = sell_id;
        this.renew = renew;
        this.allow_bid = allow_bid;
    }

    public Product(int proid, String proname, String tinydes, String fulldes, int quantity, int price_start, int price_payment, int price_step, int price_now, int price_current, LocalDateTime start_day, LocalDateTime end_day, int catid, int bid_id, String status, int price_max) {
        this.proid = proid;
        this.proname = proname;
        this.tinydes = tinydes;
        this.fulldes = fulldes;
        this.quantity = quantity;
        this.price_start = price_start;
        this.price_payment = price_payment;
        this.price_step = price_step;
        this.price_now = price_now;
        this.price_current = price_current;
        this.start_day = start_day;
        this.end_day = end_day;
        this.catid = catid;
        this.bid_id = bid_id;
        this.status = status;
        this.price_max = price_max;
    }
}
