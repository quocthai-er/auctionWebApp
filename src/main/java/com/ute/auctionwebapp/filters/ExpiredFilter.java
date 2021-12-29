package com.ute.auctionwebapp.filters;

import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.UserModel;
import com.ute.auctionwebapp.utills.MailUtills;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebFilter(filterName = "ExpiredFilter")
public class ExpiredFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws ServletException, IOException {
        // Update status of product to expired and send mail to seller and winning bidder
        List<Product> productList = ProductModel.findAll();
        for (Product p : productList) {
            if (p.getStatus().equals("Now") && p.getEnd_day().isBefore(LocalDateTime.now())) {
                ProductModel.UpdateExpiredProduct(p.getProid());
                if (p.getBid_id() == 0) {
                    Product p1 = ProductModel.findByNoBIdid(p.getProid());
                    MailUtills.sendExpiredNoBid(p1.getSell_mail(),p.getProname());
                } else {
                    Product p1 = ProductModel.findByBidid(p.getProid());
                    MailUtills.sendExpiredBid(p1.getSell_mail(),p1.getBid_mail(),p.getPrice_current(),p.getProname(),p1.getBid_name(),p1.getSell_name());
                }
            }
        }

        //Downgrade from seller to bidder when expired
        List<User> userList = UserModel.findAll();
        for (User u : userList) {
            if (u.getRequest_date() != null && u.getRequest_date().isBefore(LocalDateTime.now())) {
                UserModel.updateExpiredSeller(u.getId());
            }
        }
        chain.doFilter(req, res);
    }
}
