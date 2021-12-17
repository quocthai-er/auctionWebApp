package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.utills.ServletUtills;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchServlet", value = "/Search/*")
public class SearchServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if(path == null || path=="/")
        {
            path="/Search";
        }
        switch (path){
            case "/Search":
                String search = request.getParameter("search");
                List<Product> list1 = ProductModel.Search(search);
                    request.setAttribute("products",list1);
                    ServletUtills.forward("/views/vwSearch/Search.jsp", request, response);
                break;
            case "/SortInc":
                search = request.getParameter("search");
                List<Product> list2 = ProductModel.SortInc(search);
                request.setAttribute("products",list2);
                ServletUtills.forward("/views/vwSearch/Search.jsp", request, response);
                break;
            case "/SortDec":
                search = request.getParameter("search");
                List<Product> list3 = ProductModel.SortDec(search);
                request.setAttribute("products",list3);
                ServletUtills.forward("/views/vwSearch/Search.jsp", request, response);
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
