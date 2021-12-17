package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.beans.WatchList;
import com.ute.auctionwebapp.models.WatchListModel;
import com.ute.auctionwebapp.utills.ServletUtills;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "WatchListServlet", value = "/WatchList/*")
public class WatchListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/"))
        {
            path = "/WatchList";
        }

        switch (path) {
            case "/WatchList":
                int uid = Integer.parseInt(request.getParameter("uid"),10);
                List<WatchList> list2 = WatchListModel.findByUID(uid);
                request.setAttribute("watchlists",list2);
                ServletUtills.forward("/views/vwWatchList/WatchList.jsp", request, response);
                break;
            case"/deleteWatchList":
                int id = Integer.parseInt(request.getParameter("id"));
                boolean isAvailable = (WatchListModel.deleteWatchList(id));

                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                out.print(isAvailable);
                out.flush();
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
