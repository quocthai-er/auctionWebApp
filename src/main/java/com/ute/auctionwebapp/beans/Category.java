package com.ute.auctionwebapp.beans;

public class Category {
    private int catid;
    private String catname;
    private int pid;
    private int level;

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

    public Category(String catname, int level,int pid) {
        this.catname = catname;
        this.pid = pid;
        this.level = level;
    }

    public Category(int catid, String catname) {
        this.catid = catid;
        this.catname = catname;
    }
    public Category(String catname) {
        this.catid = -1;
        this.catname = catname;
    }
    public int getCatid() {
        return catid;
    }

    public String getCatname() {
        return catname;
    }
}
