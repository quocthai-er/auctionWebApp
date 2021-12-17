package com.ute.auctionwebapp.controllers;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.ProductModel;
import com.ute.auctionwebapp.models.UserModel;
import com.ute.auctionwebapp.utills.MailUtills;
import com.ute.auctionwebapp.utills.ServletUtills;
import com.ute.auctionwebapp.utills.VerifyUtills;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet(name = "AccountServlet", value = "/Account/*")
public class AccountServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        switch (path) {
            case "/Register":
                ServletUtills.forward("/views/vwAccount/Register.jsp", request, response);
                break;

            case "/Login":
                HttpSession session = request.getSession();
                if ((boolean) session.getAttribute("auth")) {
                    ServletUtills.redirect("/Home",request,response);
                } else ServletUtills.forward("/views/vwAccount/Login.jsp", request, response);
                break;

            case "/ForgotPassword":
                ServletUtills.forward("/views/vwAccount/ForgotPassword.jsp", request, response);
                break;

            case "/Profile":
                ServletUtills.forward("/views/vwAccount/Profile.jsp", request, response);
                break;

            case "/SellerProfile":
                ServletUtills.forward("/views/vwAccount/SellerProfile.jsp",request,response);
                break;

            case "/BidderProfile":
                ServletUtills.forward("/views/vwAccount/BidderProfile.jsp",request,response);
                break;

            case "/EditProfile":
                ServletUtills.forward("/views/vwAccount/EditProfile.jsp", request, response);
                break;

            case "/ChangePwd":
                ServletUtills.forward("/views/vwAccount/ChangePwd.jsp",request,response);
                break;

            case "/IsAvailable":
                String username = request.getParameter("email");
                User user = UserModel.findByUsername(username);
                boolean isAvailable = (user == null);

                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                out.print(isAvailable);
                out.flush();
                break;

            case "/IsVerifyCaptcha":
                String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
                boolean verify = VerifyUtills.verifyCaptcha(gRecaptchaResponse);

                out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                out.print(verify);
                out.flush();
                break;

            case "/SendOTP":
                username = request.getParameter("email");
                String otp = request.getParameter("otp");
                boolean sendOTP =  MailUtills.sendOTP(username,otp);
                out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                out.print(sendOTP);
                out.flush();
                break;

            case "/YourProduct":
                int uid =Integer.parseInt(request.getParameter("uid"),10);
                List<Product> sellingProductList = ProductModel.findSellingProduct(uid);
                request.setAttribute("sellingProducts",sellingProductList);
                List<Product> soldProductList = ProductModel.findSoldProduct(uid);
                request.setAttribute("soldProducts",soldProductList);
                List<Product> biddingProductList = ProductModel.findBiddingProduct(uid);
                request.setAttribute("biddingProducts",biddingProductList);
                List<Product> winningProductList = ProductModel.findWinningProduct(uid);
                request.setAttribute("winningProducts",winningProductList);
                ServletUtills.forward("/views/vwAccount/YourProduct.jsp", request, response);
                break;

            default:
                ServletUtills.forward("/views/404.jsp", request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getPathInfo();
        request.setCharacterEncoding("UTF-8");
        switch (path) {
            case "/Register":
                registerUser(request, response);
                break;

            case "/Login":
                login(request, response);
                break;

            case "/ForgotPassword":
                forgot(request, response);
                break;

            case "/EditProfile":
                updateUser(request,response);
                break;

            case "/ChangePwd":
                changepassword(request,response);
                break;

            case "/Logout":
                logout(request, response);
                break;
            case "/EditDes":
                editDes(request, response);
                break;

            default:
                ServletUtills.forward("/views/404.jsp", request, response);
                break;
        }
    }
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String rawpwd = request.getParameter("rawpwd");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawpwd.toCharArray());

        String strDob = request.getParameter("dob") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(strDob, df);

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        int role = 1;
        int reQuest = 0;

        User c = new User(name, email, address,  bcryptHashString, dob, role, reQuest);
        UserModel.add(c);
        ServletUtills.redirect("/Home", request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("uid"));
        String strDob = request.getParameter("dob") + " 00:00";
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse(strDob, df);
        String name = request.getParameter("name");
        String address = request.getParameter("address");

        User c = new User(name,address,dob,id);
        UserModel.update(c);

       User user = UserModel.findById(id);
        HttpSession session = request.getSession();
        session.setAttribute("auth", true);
        session.setAttribute("authUser", user);
        String url = (String) (session.getAttribute("retUrl"));
        if(url == null) url = "/Account/Profile";
        ServletUtills.redirect(url,request,response);

    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = UserModel.findByUsername(email);
        if (user != null) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
            if (result.verified) {
                HttpSession session = request.getSession();
                session.setAttribute("auth", true);
                session.setAttribute("authUser", user);

                String url = (String) (session.getAttribute("retUrl"));
                if (url == null )
                    url = "/Home";

                if (url.equals("/auctionWebApp/Account/YourProduct") || url.equals("/auctionWebApp/WatchList") || url.equals("/auctionWebApp/History"))
                    url = url + "?uid=" + user.getId();
                ServletUtills.redirect(url, request, response);
           /*     ServletUtills.redirect("/Home",request,response);*/
            } else {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Invalid login.");
                ServletUtills.forward("/views/vwAccount/Login.jsp", request, response);
            }
        } else {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Invalid login.");
            ServletUtills.forward("/views/vwAccount/Login.jsp", request, response);
        }
    }

    private void changepassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        String newpassword = request.getParameter("newpassword");
        int id = Integer.parseInt(request.getParameter("uid"));
        User user = UserModel.findById(id);
        if (user != null) {
            BCrypt.Result result = BCrypt.verifyer().verify(password.toCharArray(), user.getPassword());
            if (result.verified) {
                String bcryptHashString = BCrypt.withDefaults().hashToString(12, newpassword.toCharArray());
                User c = new User(bcryptHashString,id);
                UserModel.changepassword(c);
                request.setAttribute("success",true);
                ServletUtills.forward("/views/vwAccount/ChangePwd.jsp", request, response);
            } else {
                request.setAttribute("hasError", true);
                request.setAttribute("errorMessage", "Wrong password.");
                ServletUtills.forward("/views/vwAccount/ChangePwd.jsp", request, response);
            }
        } else {
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "Wrong Password.");
            ServletUtills.forward("/views/vwAccount/ChangePwd.jsp", request, response);
        }
    }
    private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("auth", false);
        session.setAttribute("authUser", new User());

        String url = request.getHeader("referer");
        if (url == null)
            url = "/Home";
        ServletUtills.redirect(url, request, response);
    }

    private void forgot(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, email.toCharArray());
        UserModel.resetPassword(email,bcryptHashString);

        MailUtills.sendResetPassword(email);
        ServletUtills.forward("/views/vwAccount/ForgotPassword.jsp", request, response);
    }

    private void editDes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int proid = Integer.parseInt(request.getParameter("proid"),10);
        int uid = Integer.parseInt(request.getParameter("uid"),10);
        String date = "<i class=\"fa fa-pencil\" aria-hidden=\"true\" ></i>Date modified: " + request.getParameter("date");
        String fullDes = request.getParameter("fulldes");

        ProductModel.EditDes(proid,date,fullDes);
        ServletUtills.redirect("/Account/YourProduct?uid="+uid,request,response);
    }

}
