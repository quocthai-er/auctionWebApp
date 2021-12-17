package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.utills.ServletUtills;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", value = "/Home/*")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/"))
        {
            path = "/Index";
        }

        switch (path) {
            case "/Index":
                List<Product> list1 = ProductModel.findTop8End();
                request.setAttribute("products1",list1);
                List<Product> list2 = ProductModel.findTop8Price();
                request.setAttribute("products2",list2);
                List<Product> list3 = ProductModel.findTop8Bid();
                request.setAttribute("products3",list3);
                ServletUtills.forward("/views/vwHome/Index.jsp", request, response);
                break;
            default:
                ServletUtills.forward("/views/404.jsp", request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
