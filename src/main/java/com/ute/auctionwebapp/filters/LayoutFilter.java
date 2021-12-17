package com.ute.auctionwebapp.filters;

import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.models.CategoryModel;

import javax.servlet.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "LayoutFilter")
public class LayoutFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        List<Category> list1 = CategoryModel.findParent();
        request.setAttribute("categoriesWithDetails1",list1);
        List<Category> list2 = CategoryModel.findChild();
        request.setAttribute("categoriesWithDetails2",list2);
        chain.doFilter(request, response);
    }
}
