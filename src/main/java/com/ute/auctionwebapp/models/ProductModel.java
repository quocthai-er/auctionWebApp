package com.ute.auctionwebapp.models;

import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.utills.DbUtills;
import org.sql2o.Connection;

import java.time.LocalDateTime;
import java.util.List;

public class ProductModel {
    public static List<Product> findAll(){
        final String query = "select * from products";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Product.class);
        }
    }
    public static List<Product> findTop8End(){
        final String query = "(select  p.proid,p.name, h.bid_count,p.proname,p.tinydes, p.fulldes, p.quantity, p.price_start, p.price_step, p.price_max, p.price_now, p.price_current, p.price_payment, p.start_day, p.end_day, p.catid, p.bid_id, p.sell_id, p.status, p.renew\n" +
                "from\n" +
                "     (select*\n" +
                "      from\n" +
                "          (SELECT proid, proname, tinydes, fulldes, quantity, renew, price_start, price_step, price_max, price_now, price_current, price_payment, start_day, end_day, catid, bid_id, sell_id, status\n" +
                "           from products\n" +
                "           where TIMESTAMPDIFF(SECOND,NOW(),products.end_day)>0\n" +
                "           order by products.end_day asc limit 8) as p\n" +
                "              left join (select users.id, users.name from users) as u on p.bid_id =u.id) as p\n" +
                "         left join (select proid, count(proid) as bid_count from histories group by proid) h\n" +
                "                   on p.proid = h.proid\n" +
                "group by p.proid);";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Product.class);
        }
    }
    public static List<Product> findTop8Price(){
        final String query = "(select  p.proid,p.name, h.bid_count,p.proname,p.tinydes, p.fulldes, p.quantity, p.price_start, p.price_step, p.price_max, p.price_now, p.price_current, p.price_payment, p.start_day, p.end_day, p.catid, p.bid_id, p.sell_id, p.status, p.renew\n" +
                " from\n" +
                "     (select*\n" +
                "      from\n" +
                "          (SELECT proid, proname, tinydes, fulldes, quantity, renew, price_start, price_step, price_max, price_now, price_current, price_payment, start_day, end_day, catid, bid_id, sell_id, status\n" +
                "           from products\n" +
                "           where TIMESTAMPDIFF(SECOND,NOW(),products.end_day)>0 order by products.price_current desc limit 8) as a\n" +
                "              left join (select users.id, users.name from users) as u on a.bid_id =u.id) as p\n" +
                "         left join (select proid, count(proid) as bid_count from histories group by proid) h\n" +
                "                   on p.proid = h.proid\n" +
                " order by p.price_current desc\n" +
                ");";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Product.class);
        }
    }
    public static List<Product> findTop8Bid(){
        final String query = "SELECT count(a.proid) as count,c.name, a.proid, c.proname, c.tinydes, c.fulldes, c.quantity, c.price_start, c.price_step, c.price_max, c.price_now, c.price_current, c.price_payment, c.start_day, c.end_day, c.catid, c.bid_id, c.sell_id, c.status, c.renew\n" +
                "from auction.histories a, (select*\n" +
                "                           from\n" +
                "                               (SELECT proid, proname, tinydes, fulldes, quantity, renew, price_start, price_step, price_max, price_now, price_current, price_payment, start_day, end_day, catid, bid_id, sell_id, status\n" +
                "                                from products\n" +
                "                                where TIMESTAMPDIFF(SECOND,NOW(),products.end_day)>0\n" +
                "                                order by products.end_day asc limit 8) as p\n" +
                "                                   left join (select users.id, users.name from users) as u on p.bid_id =u.id) as c\n" +
                "where c.proid = a.proid\n" +
                "group by a.proid\n" +
                "order by count desc\n" +
                "limit 8;";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Product.class);
        }
    }
    public static List<Product> findByCatId(int catId){
        final String query = "(select  p.proid,p.name, h.bid_count,p.proname,p.tinydes, p.fulldes, p.quantity, p.price_start, p.price_step, p.price_max, p.price_now, p.price_current, p.price_payment, p.start_day, p.end_day, p.catid, p.bid_id, p.sell_id, p.status, p.renew\n" +
                "            from\n" +
                "     (select*\n" +
                "      from\n" +
                "          (select proid, proname, tinydes, fulldes, quantity, renew, price_start, price_step, price_max, price_now, price_current, price_payment, start_day, end_day, catid, bid_id, sell_id, status\n" +
                "           from products\n" +
                "           where catid = :catid and CURDATE()<end_day and CURTIME()<end_day) as a\n" +
                "              left join (select users.id, users.name from users) as u on a.bid_id =u.id) as p\n" +
                "         left join (select proid, count(proid) as bid_count from histories group by proid) h\n" +
                "                   on p.proid = h.proid\n" +
                "     group by p.proid\n" +
                "    );";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("catid",catId)
                    .executeAndFetch(Product.class);
        }
    }
    public static List<Product> findByCatPid(String catname){
        final String query = "(select  p.proid,p.name, h.bid_count,p.proname,p.tinydes, p.fulldes, p.quantity, p.price_start, p.price_step, p.price_max, p.price_now, p.price_current, p.price_payment, p.start_day, p.end_day, p.catid, p.bid_id, p.sell_id, p.status, p.renew\n" +
                "            from\n" +
                "     (select*\n" +
                "      from\n" +
                "          ((select proid, proname, tinydes, fulldes, quantity, renew, price_start, price_step, price_max, price_now, price_current, price_payment, start_day, end_day, products.catid, bid_id, sell_id, status\n" +
                "           from auction.products , auction.categories\n" +
                "           where auction.categories.pid=(select catid from auction.categories where catname=:catname)\n" +
                "             and categories.catid=products.catid and CURDATE() < products.end_day and CURTIME()<products.end_day) as a\n" +
                "              left join (select users.id, users.name from users) as u on a.bid_id =u.id)) as p\n" +
                "                left join (select proid, count(proid) as bid_count from histories group by proid) h\n" +
                "                   on p.proid = h.proid\n" +
                "     group by p.proid\n" +
                "    );";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("catname",catname)
                    .executeAndFetch(Product.class);
        }
    }

    public static Product findByBidid(int id){
        final String query = "select *\n" +
                "from products,\n" +
                "     (select name as sell_name, email as sell_mail\n" +
                "                from users,products where users.id = products.sell_id) as A,\n" +
                "     (select name as bid_name,email as bid_mail\n" +
                "      from users,products where users.id = products.bid_id and proid= :proid) as B\n" +
                "where proid= :proid";
        try (Connection con = DbUtills.getConnection()) {
            List<Product> list = con.createQuery(query)
                    .addParameter("proid",id)
                    .executeAndFetch(Product.class);
            if(list.size()==0)
            {
                return null;
            }
            return list.get(0);
        }
    }
    public static Product findByNoBIdid(int id){
        final String query = "select *\n" +
                "from products,\n" +
                "     (select name as sell_name, email as sell_mail\n" +
                "                from users,products where users.id = products.sell_id) as A\n"+
                "where proid= :proid";
        try (Connection con = DbUtills.getConnection()) {
            List<Product> list = con.createQuery(query)
                    .addParameter("proid",id)
                    .executeAndFetch(Product.class);
            if(list.size()==0)
            {
                return null;
            }
            return list.get(0);
        }
    }
    public static List<Product> findNear(int catid, int proid){
        final String query = "select * from products where catid in (select catid from categories where pid = (\n" +
                "    select pid from categories where categories.catid = :catid\n" +
                ")) and proid not in (select proid from products where proid = :proid)" +
                " and CURDATE()<end_day and CURTIME()<end_day order by field(catid,:catid) desc limit 8";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("catid",catid)
                    .addParameter("proid",proid)
                    .executeAndFetch(Product.class);
        }
    }

    public static List<Product> findBidid(){
        final String query = "select proid,proname\n" +
                "from auction.products, (select id from users) as a\n" +
                "where products.bid_id in(a.id)\n" +
                "group by proid";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Product.class);
        }
    }

    public static boolean updatePriceCur(int proid, int price_current, String renew){
        if (renew.equals("on")) {
            String query = "update auction.products set end_day = date_add(end_day,interval 10 minute) " +
                    "where proid=:proid and timestampdiff(minute, NOW(),end_day) <=5";
            try (Connection con = DbUtills.getConnection()) {
                con.createQuery(query)
                        .addParameter("proid", proid)
                        .executeUpdate();
            }
        }
        String Sql = "update auction.products set price_current=:price_current where proid=:proid";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(Sql)
                    .addParameter("proid",proid )
                    .addParameter("price_current", price_current)
                    .executeUpdate();
            return true;
        }
        catch (Exception e){return false;}
    }
    public static boolean updatePriceMax(int proid, int price_current,int price_max,int uid, String renew){
        if (renew.equals("on")) {
            String query = "update auction.products set end_day = date_add(end_day,interval 10 minute) " +
                    "where proid=:proid and timestampdiff(minute, NOW(),end_day) <=5";
            try (Connection con = DbUtills.getConnection()) {
                con.createQuery(query)
                        .addParameter("proid", proid)
                        .executeUpdate();
            }
        }
        String Sql = "update auction.products set price_current=:price_current, price_max=:price_max," +
                "bid_id=:bid_id where proid=:proid";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(Sql)
                    .addParameter("proid",proid )
                    .addParameter("price_current", price_current)
                    .addParameter("price_max", price_max)
                    .addParameter("bid_id", uid)
                    .executeUpdate();
            return true;
        }
        catch (Exception e){return false;}
    }

    public static List<Product> findSellingProduct(int uid){
        final String query = "select * from products where sell_id =:uid " +
                "and CURDATE()<end_day and CURTIME()<end_day ";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("uid",uid)
                    .executeAndFetch(Product.class);
        }
    }

    public static List<Product> findSoldProduct(int uid){
        final String query = "select * from products where sell_id = :uid\n" +
                "                and CURDATE()>=end_day and CURTIME()>=end_day\n" +
                "                and bid_id is not null and price_current is not null";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("uid",uid)
                    .executeAndFetch(Product.class);
        }
    }

    public static List<Product> findBiddingProduct(int uid){
        final String query = "select * from products where proid in " +
                "(select proid from histories where bid_id = :uid) " +
                "and CURDATE()<end_day and CURTIME()<end_day";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("uid",uid)
                    .executeAndFetch(Product.class);
        }
    }

    public static List<Product> findWinningProduct(int uid){
        final String query = "select * from products where bid_id = :uid\n" +
                "                and CURDATE()>=end_day and CURTIME()>=end_day\n" +
                "                and price_current is not null";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("uid",uid)
                    .executeAndFetch(Product.class);
        }
    }
    public static List<Product> Search(String search){
        final String query = "(select  p.proid,p.name, h.bid_count,p.proname,p.tinydes, p.fulldes, p.quantity, p.price_start, p.price_step, p.price_max, p.price_now, p.price_current, p.price_payment, p.start_day, p.end_day, p.catid, p.bid_id, p.sell_id, p.status, p.renew\n" +
                " from\n" +
                " (select*\n" +
                " from\n" +
                "  (SELECT proid, proname, tinydes, fulldes, quantity, renew, price_start, price_step, price_max, price_now, price_current, price_payment, start_day, end_day,p1.catid, bid_id, sell_id, status\n" +
                "FROM auction.products p1\n" +
                "         LEFT JOIN categories c on p1.catid = c.catid\n" +
                " WHERE\n" +
                "       (MATCH(c.catname) AGAINST(:search)\n" +
                "           OR MATCH(p1.proname,p1.tinydes) AGAINST(:search))and CURDATE() < p1.end_day and CURTIME()<p1.end_day) as a\n" +
                "left join (select users.id, users.name from users) as u on a.bid_id =u.id) as p\n" +
                "left join (select proid, count(proid) as bid_count from histories group by proid) h\n" +
                "  on p.proid = h.proid\n" +
                "  group by p.proid\n" +
                "   );";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("search",search)
                    .executeAndFetch(Product.class);
        }
    }
    public static List<Product> SortInc(String search){
        final String query = "(select  p.proid,p.name, h.bid_count,p.proname,p.tinydes, p.fulldes, p.quantity, p.price_start, p.price_step, p.price_max, p.price_now, p.price_current, p.price_payment, p.start_day, p.end_day, p.catid, p.bid_id, p.sell_id, p.status, p.renew\n" +
                " from\n" +
                " (select*\n" +
                "from\n" +
                "(SELECT p1.proid,p1.proname,p1.tinydes, p1.fulldes, p1.quantity, p1.price_start, p1.price_step, p1.price_max, p1.price_now, p1.price_current, p1.price_payment, p1.start_day, p1.end_day, p1.catid, p1.bid_id, p1.sell_id, p1.status, p1.renew\n" +
                "FROM auction.products p1\n" +
                "         LEFT JOIN categories c on p1.catid = c.catid\n" +
                " WHERE\n" +
                "     (MATCH(c.catname) AGAINST(:search)\n" +
                "         OR MATCH(p1.proname,p1.tinydes) AGAINST(:search))and CURDATE() < p1.end_day and CURTIME()<p1.end_day\n" +
                "order by p1.price_current asc) as a\n" +
                " left join (select users.id, users.name from users) as u on a.bid_id =u.id) as p\n" +
                " left join (select proid, count(proid) as bid_count from histories group by proid) h\n" +
                " on p.proid = h.proid\n" +
                "order by p.price_current asc\n" +
                ");\n";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("search",search)
                    .executeAndFetch(Product.class);
        }
    }
    public static List<Product> SortDec(String search){
        final String query = "(select  p.proid,p.name, h.bid_count,p.proname,p.tinydes, p.fulldes, p.quantity, p.price_start, p.price_step, p.price_max, p.price_now, p.price_current, p.price_payment, p.start_day, p.end_day, p.catid, p.bid_id, p.sell_id, p.status, p.renew\n" +
                "            from\n" +
                "     (select*\n" +
                "      from\n" +
                "          (SELECT p1.proid,p1.proname,p1.tinydes, p1.fulldes, p1.quantity, p1.price_start, p1.price_step, p1.price_max, p1.price_now, p1.price_current, p1.price_payment, p1.start_day, p1.end_day, p1.catid, p1.bid_id, p1.sell_id, p1.status, p1.renew\n" +
                "           FROM auction.products p1\n" +
                "                    LEFT JOIN categories c on p1.catid = c.catid\n" +
                "           WHERE\n" +
                "               (MATCH(c.catname) AGAINST(:search)\n" +
                "                   OR MATCH(p1.proname,p1.tinydes) AGAINST(:search)) and CURDATE() < p1.end_day and CURTIME()<p1.end_day\n" +
                "           order by p1.end_day desc) as a\n" +
                "              left join (select users.id, users.name from users) as u on a.bid_id =u.id) as p\n" +
                "         left join (select proid, count(proid) as bid_count from histories group by proid) h\n" +
                "                   on p.proid = h.proid\n" +
                " order by p.end_day desc\n" +
                "    );";
        try (Connection con = DbUtills.getConnection()) {
            return con.createQuery(query)
                    .addParameter("search",search)
                    .executeAndFetch(Product.class);
        }
    }
    public static void EditDes(int proid, String date, String fulldes){
        final String query = "update products set fulldes= CONCAT_WS(CHAR(10 using utf8),fulldes,:date, :fulldes ) where proid = :proid";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(query)
                    .addParameter("proid",proid)
                    .addParameter("date",date)
                    .addParameter("fulldes",fulldes)
                    .executeUpdate();
        }
    }
    public static int getLastProID(){
        final String query = "SELECT proid FROM products ORDER BY proid DESC LIMIT 1;";
        try (Connection con = DbUtills.getConnection()) {
            List<Product> list = con.createQuery(query)
                    .executeAndFetch(Product.class);
            return list.get(0).getProid();
        }
    }
    public static int add(Product p){
        final String query = "INSERT INTO products ( proname, tinydes, fulldes, quantity, price_start, price_payment, price_step, price_now, price_current, price_max, start_day, end_day, catid, status, sell_id,renew,allow_bid) VALUES (:proname,:tinydes,:fulldes,:quantity,:priceStart,:pricePayment,:priceStep,:priceNow,:priceCurrent,:priceMax,:startDay,:endDay,:catid,:status,:sellId,:renew,:allow_bid)\n";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(query)
                    .addParameter("proname",p.getProname())
                    .addParameter("tinydes",p.getTinydes())
                    .addParameter("fulldes",p.getFulldes())
                    .addParameter("quantity",p.getQuantity())
                    .addParameter("priceStart",p.getPrice_start())
                    .addParameter("pricePayment",p.getPrice_payment())
                    .addParameter("sellId",p.getSell_id())
                    .addParameter("priceStep",p.getPrice_step())
                    .addParameter("priceNow",p.getPrice_now())
                    .addParameter("priceCurrent",p.getPrice_current())
                    .addParameter("startDay",p.getStart_day())
                    .addParameter("endDay",p.getEnd_day())
                    .addParameter("catid",p.getCatid())
                    .addParameter("status",p.getStatus())
                    .addParameter("priceMax",p.getPrice_max())
                    .addParameter("renew",p.getRenew())
                    .addParameter("allow_bid",p.getAllow_bid())
                    .executeUpdate();
            return getLastProID();
        }
    }
    public static void UpdateExpiredProduct(int proid){
        final String query = "update products set status = 'Expired' where proid = :proid";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(query)
                    .addParameter("proid",proid)
                    .executeUpdate();
        }
    }
    public static void UpdateRejectBidId(int proid, int bidid){
        final String query = "update products set reject_bid_id= CONCAT_WS(',',reject_bid_id,:bidid ) where proid = :proid";
        try (Connection con = DbUtills.getConnection()) {
            con.createQuery(query)
                    .addParameter("proid",proid)
                    .addParameter("bidid",bidid)
                    .executeUpdate();
        }
    }
}
