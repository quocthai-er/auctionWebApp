package com.ute.auctionwebapp.utills;

import org.sql2o.Connection;
import org.sql2o.Sql2o;

public class DbUtills {
//    static Sql2o sql2o = new Sql2o("jdbc:mysql://SLWYkE9L5R@remotemysql.com/auction", "SLWYkE9L5R", "fNwl1ExBQF");
//    http://node2058-auction.user.edgecloudph.com/index.php?route=/&route=%2F&db=auction
//    static Sql2o sql2o = new Sql2o("jdbc:mysql://node2058-auction.user.edgecloudph.com/auction", "root", "ONXght68127");
    static Sql2o sql2o = new Sql2o("jdbc:mysql://localhost:3306/auction", "root", "");
    public static Connection getConnection () {
        return sql2o.open();
    }
}
