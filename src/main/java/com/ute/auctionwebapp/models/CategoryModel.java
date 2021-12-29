package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.utills.DbUtills;
import org.sql2o.Connection;
import org.sql2o.Sql2o;

import java.util.List;

public class CategoryModel {
    public static List<Category> findAll(){
        final String query = "select * from categories";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Category.class);
        }
    }
//    public static Category findByPID(int id){
//        final String query = "select * from categories where catid=:catid";
//        try (Connection con = DbUtills.getConnection()) {
//            List<Category> list = con.createQuery(query)
//                    .addParameter("catid",id)
//                    .executeAndFetch(Category.class);
//            if(list.size()==0)
//            {
//                return null;
//            }
//            return list.get(0);
//        }
//    }
    public static List<Category> findBylevel(){
        final String query = "select * from categories where level=0 ";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Category.class);
        }
    }

    public static List<Category> findParent(){
        final String query = "select * from categories where pid=0";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Category.class);
        }
    }

    public static List<Category> findChildByPid(int id){
        final String query = "select *\n" +
                "from categories\n" +
                "where pid=:pid and level=0";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("pid",id)
                    .executeAndFetch(Category.class);
        }
    }

    public static List<Category> findChild(){
        final String query = "select a.catid, a.catname, a.pid,a.level from auction.categories a, auction.categories b where a.pid = b.catid";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Category.class);
        }
    }

    public static Category findById(int id) {
        final String query = "select * from categories where CatID = :CatID";
        try (Connection con = DbUtills.getConnection()) {
            List<Category> list = con.createQuery(query)
                    .addParameter("CatID", id)
                    .executeAndFetch(Category.class);
            if (list.size() == 0) {
                return null;
            }
            return list.get(0);
        }
    }

    // Chỉnh sửa local port tại đây
    public static void add(Category c) {
//        Sql2o sql2o = new Sql2o("jdbc:mysql://localhost:8082/qlbh", "root", "root");
        String insertSql = " INSERT INTO categories ( catname, level, pid) VALUES (:catname,:level,:pid)";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("catname", c.getCatname())
                    .addParameter("level", c.getLevel())
                    .addParameter("pid", c.getPid())
                    .executeUpdate();
        }
    }


    public static void update(Category c) {
        String sql = "update categories set catname = :CatName where catid = :CatID";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(sql)
                    .addParameter("CatID", c.getCatid())
                    .addParameter("CatName", c.getCatname())
                    .executeUpdate();
        }
    }

    public static void delete(int id) {
        String sql = "delete from categories where CatID = :CatID";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(sql)
                    .addParameter("CatID", id)
                    .executeUpdate();
        }
    }
}


