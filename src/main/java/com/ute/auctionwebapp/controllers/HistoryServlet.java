package com.ute.auctionwebapp.controllers;

import com.ute.auctionwebapp.beans.History;
import com.ute.auctionwebapp.models.HistoryModel;
import com.ute.auctionwebapp.utills.ServletUtills;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "HistoryServlet", value = "/History/*")
public class HistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/History";
        }
        switch (path) {
            case "/History":
                int uid=Integer.parseInt(request.getParameter("uid"),10);
                List<History> list = HistoryModel.findByUID(uid);
                request.setAttribute("histories", list);
                ServletUtills.forward("/views/vwHistory/History.jsp", request, response);
                break;
//            case "/deleteHistory":
//                int id = Integer.parseInt(request.getParameter("id"));
//                boolean isAvailable = (HistoryModel.deleteHistory(id));
//
//                PrintWriter out = response.getWriter();
//                response.setContentType("application/json");
//                response.setCharacterEncoding("utf-8");
//
//                out.print(isAvailable);
//                out.flush();
        }
    }
    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {
    }
}
