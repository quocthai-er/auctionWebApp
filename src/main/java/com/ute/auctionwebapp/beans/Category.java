package com.ute.auctionwebapp.beans;

public class Category {
    private int catid;
    private String catname;
    private int pid;
    private int level;
    public Category(int id, String name) {
    }

    public Category(String name) {
    }

    public int getPid() {
        return pid;
    }

    public int getLevel() {
        return level;
    }

    public Category(int catid, String catname, int pid, int level) {
        this.catid = catid;
        this.catname = catname;
        this.pid=pid;
        this.level = level;
    }

    public int getCatid() {
        return catid;
    }

    public String getCatname() {
        return catname;
    }
}
