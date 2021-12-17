package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.beans.WatchList;
import com.ute.auctionwebapp.utills.DbUtills;
import org.sql2o.Connection;

import java.util.List;

public class WatchListModel {
    public static boolean addWatchList(int proid, String proname, int price_start, int uid,int catid) {
        String insertSql = "INSERT INTO watch_list (proid, proname,price_start,uid,catid) VALUES (:proid,:proname,:priceStart,:uid,:catid)";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("proid", proid)
                    .addParameter("proname", proname)
                    .addParameter("priceStart", price_start)
                    .addParameter("uid", uid)
                    .addParameter("catid",catid)
                    .executeUpdate();
            return true;
        }
        catch (Exception e){
            return false;
        }
    }
    public static List<WatchList> findAll(){
        final String query = "select * from watch_list";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(WatchList.class);
        }
    }
    public static boolean findByProduct(int proid, int uid) {
        final String query = "select * from watch_list where proid = :proid and uid=:uid";
        try (Connection con = DbUtills.getConnection()) {
            List<WatchList> list = con.createQuery(query)
                    .addParameter("proid", proid)
                    .addParameter("uid", uid)
                    .executeAndFetch(WatchList.class);

            if (list.size() == 0) {
                return true;
            }
            return false;
        }
    }
    public static boolean deleteWatchList(int id) {
        String Sql = "delete from watch_list where id=:id";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(Sql)
                    .addParameter("id", id)
                    .executeUpdate();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
    public static List<WatchList> findByUID(int uid){
        final String query = "select * from watch_list where uid=:uid";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("uid",uid)
                    .executeAndFetch(WatchList.class);
        }
    }

}
