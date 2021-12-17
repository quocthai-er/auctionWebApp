package com.ute.auctionwebapp.beans;

public class WatchList {
    private int id;
    private int proid;
    private String proname;
    private int price_start;
    private int uid;
    private int catid;

    public WatchList() {
    }


    public WatchList(int id, int proid, String proname, int price_start, int uid,int catid) {
        this.id = id;
        this.proid = proid;
        this.proname = proname;
        this.price_start = price_start;
        this.uid=uid;
        this.catid=catid;
    }
    public int getUid() {
        return uid;
    }
    public int getId() {
        return id;
    }

    public int getCatid() {
        return catid;
    }

    public int getProid() {
        return proid;
    }

    public String getProname() {
        return proname;
    }

    public int getPrice_start() {
        return price_start;
    }
}
