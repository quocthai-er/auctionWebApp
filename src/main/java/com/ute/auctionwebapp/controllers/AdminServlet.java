package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.CategoryModel;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.UserModel;
import com.ute.auctionwebapp.utills.ServletUtills;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminServlet", value = "/Admin/*")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/Admin";
        }

        switch (path) {
            case "/Admin":
                ServletUtills.forward("/views/vwAdministrator/AdminManager.jsp", request, response);
                break;
            case "/Product":
                List<Product> productList = ProductModel.findAll();
                request.setAttribute("products", productList);
                ServletUtills.forward("/views/vwAdministrator/AdminProduct.jsp", request, response);
                break;
            case "/User":
                List<User> userList = UserModel.findAll();
                request.setAttribute("users", userList);
                ServletUtills.forward("/views/vwAdministrator/AdminUser.jsp", request, response);
                break;
            case "/Category":
                List<Category> categoryList = CategoryModel.findAll();
                request.setAttribute("categories", categoryList);
                ServletUtills.forward("/views/vwAdministrator/AdminCategory.jsp", request, response);
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
