package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.*;
import com.ute.auctionwebapp.utills.DbUtills;
import org.sql2o.Connection;
import com.ute.auctionwebapp.beans.User;
import org.sql2o.data.Table;

import java.time.LocalDateTime;
import java.util.List;

public class HistoryModel {
    public static void addHistory(int proid, String proname, int sell_id, int bid_id, LocalDateTime buy_day,int price) {
        String insertSql = "INSERT INTO histories (proid, proname, sell_id, bid_id, buy_day,price) VALUES (:proid, :proname, :sell_id, :bid_id, :buy_day,:price)";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("proid", proid)
                    .addParameter("proname", proname)
                    .addParameter("sell_id", sell_id)
                    .addParameter("bid_id", bid_id)
                    .addParameter("buy_day", buy_day)
                    .addParameter("price",price)
                    .executeUpdate();
        }
    }
    public static List<History> findAll(){
        final String query = "select * from histories";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(History.class);
        }
    }
    public static List<History> findByUID(int uid){
        final String query = "select * from histories where bid_id=:uid";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("uid",uid)
                    .executeAndFetch(History.class);
        }
    }
    public static List<History> findByProduct(int proid) {
        final String query = "select users.name, histories.buy_day, histories.price,histories.bid_id,histories.proid\n" +
                "from auction.histories,auction.users\n" +
                "where histories.proid = :proid and histories.bid_id = users.id";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("proid", proid)
                    .executeAndFetch(History.class);
        }
    }
    public static boolean deleteHistory(int proid, int bid_id) {
        String Sql = "delete from histories where proid=:proid and bid_id=:bid_id";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(Sql)
                    .addParameter("proid", proid)
                    .addParameter("bid_id", bid_id)
                    .executeUpdate();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    public static History findHighestBidder(int proid){
        final String query = "select *\n" +
                "from histories\n" +
                "where proid=:proid\n" +
                "order by price desc";
        try (Connection con = DbUtills.getConnection()) {
            List<History> list =  con.createQuery(query)
                    .addParameter("proid",proid)
                    .executeAndFetch(History.class);
            if(list.size()==0)
            {
                return null;
            }
            return list.get(0);
        }
    }
}
