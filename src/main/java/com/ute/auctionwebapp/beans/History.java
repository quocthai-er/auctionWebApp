package com.ute.auctionwebapp.beans;

import java.time.LocalDateTime;

public class History {
    private int proid;
    private String proname;
    private int sell_id;
    private int bid_id;
    private LocalDateTime buy_day;
    private int price;
    private String name;
    public History() {}

    public History(int proid, String proname, int sell_id, int bid_id, LocalDateTime buy_day, int price) {
        this.proid = proid;
        this.proname = proname;
        this.sell_id = sell_id;
        this.bid_id = bid_id;
        this.buy_day = buy_day;
        this.price = price;
    }

    public int getProid() {
        return proid;
    }

    public String getProname() {
        return proname;
    }

    public String getName() {
        return name;
    }

    public int getSell_id() {
        return sell_id;
    }

    public int getBid_id() {
        return bid_id;
    }

    public LocalDateTime getBuy_day() {
        return buy_day;
    }

    public int getPrice() {
        return price;
    }
}
