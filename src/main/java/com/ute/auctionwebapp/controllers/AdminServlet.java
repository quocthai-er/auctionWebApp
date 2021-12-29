package com.ute.auctionwebapp.controllers;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.ute.auctionwebapp.beans.Category;
import com.ute.auctionwebapp.beans.History;
import com.ute.auctionwebapp.beans.Product;
import com.ute.auctionwebapp.beans.User;
import com.ute.auctionwebapp.models.*;
import com.ute.auctionwebapp.utills.MailUtills;
import com.ute.auctionwebapp.utills.ServletUtills;
import com.ute.auctionwebapp.utills.VerifyUtills;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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

            case "/Category/AddCategory":
                List<Category> listC = CategoryModel.findParent();
                request.setAttribute("catParent",listC);
                ServletUtills.forward("/views/vwAdministrator/AddCategory.jsp", request, response);
                break;

            case "/Category/EditCategory":
                int id1 = 0;
                try {
                    id1 = Integer.parseInt(request.getParameter("id"));
                }catch (NumberFormatException e){

                }
                Category c1 = CategoryModel.findById(id1);
                if(c1 != null) {
                    request.setAttribute("category", c1);
                    ServletUtills.forward("/views/vwAdministrator/EditCategory.jsp", request, response);
                } else{
                    ServletUtills.forward("/views/204.jsp", request, response);
                }
                break;

            case "/EditUser":
                int id  = Integer.parseInt(request.getParameter("uid"),10);
                User user = UserModel.findById(id);
                request.setAttribute("users",user);
                ServletUtills.forward("/views/vwAdministrator/AdminEditUser.jsp", request, response);
                break;

            /*case "/DeleteUser":
                int useriddel = Integer.parseInt(request.getParameter("id"));
                boolean isUserAvailable1 = (UserModel.deleteUser(useriddel));
                boolean useriddle = false;
                if(isUserAvailable1)
                {
                    readyuser = true;
                }
                PrintWriter outuser = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                outuser.print(readyuser);
                outuser.flush();
                break;*/

            case "/Upgrage":
                int bidderid  = Integer.parseInt(request.getParameter("uid"),10);
                int reQ = 1;
                User upgrage = new User(bidderid,reQ);
                UserModel.upgrage(upgrage);
                PrintWriter up = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                up.print(true);
                up.flush();
                break;

            case "/UpgrageSeller":
                int userid = Integer.parseInt(request.getParameter("uid"),10);
                int role = 2;
                int reQu = 0;
                User upseller = new User(userid,role,reQu);
                UserModel.upgrageSeller(upseller);
                ServletUtills.redirect("/Admin/User",request,response);
                break;

            case "/DownSeller":
                int sellid = Integer.parseInt(request.getParameter("uid"),10);
                int roledown = 1;
                int requ = 0;
                User downseller = new User(sellid,roledown,requ);
                UserModel.downSeller(downseller);
                ServletUtills.redirect("/Admin/User",request,response);
                break;
            case "/DeleteUser":
                int Userid = Integer.parseInt(request.getParameter("uid"),10);
                HistoryModel.deleteHistoryUid(Userid);
                WatchListModel.deleteWatchListUid(Userid);
                List<Product> listP = ProductModel.findProductByUid(Userid);
                boolean del = false;
                if(listP.size()==0)
                {
                    del = UserModel.deleteUser(Userid);
                }
                else{
                   for (Product p:listP)
                   {
                       if(p.getBid_id()==Userid )
                       {
                           History h = HistoryModel.findHighestBidder(p.getProid());
                           if(h==null)
                           {
                               ProductModel.updatePriceMax(p.getProid(),0,0,0,p.getRenew());
                           }
                           else{
                               ProductModel.updatePriceMax(p.getProid(),h.getPrice(),h.getPrice(),h.getBid_id(),p.getRenew());
                           }
                           if(p.getSell_id()==Userid)
                           {
                               ProductModel.deleteProduct(p.getProid());
                           }
                       }
                       else{
                           if(p.getSell_id()==Userid)
                           {
                               ProductModel.deleteProduct(p.getProid());
                           }
                       }
                   }
                    del = UserModel.deleteUser(Userid);
                }
                PrintWriter u = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");
                u.print(del);
                u.flush();
                break;
            case"/DeleteProduct":
                int proid = Integer.parseInt(request.getParameter("id"));
                boolean isAvailable1 = (ProductModel.deleteProduct(proid));
                boolean isAvailable2 = (HistoryModel.deleteHistoryByProduct(proid));
                boolean isAvailable3 = (WatchListModel.deleteWatchListByProduct(proid));
                boolean ready = false;
                if(isAvailable1 && isAvailable2 && isAvailable3)
                {
                    ready = true;
                }
                PrintWriter out = response.getWriter();
                response.setContentType("application/json");
                response.setCharacterEncoding("utf-8");

                out.print(ready);
                out.flush();
                break;

            case "/User/AddUser":
                ServletUtills.forward("/views/vwAdministrator/AddUser.jsp", request, response);
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
            case "/Category/AddCategory":
                addCategory(request,response);
                break;

            case "/Delete":
                deleteCategory(request, response);
                break;

            case "/Update":
                updateCategory(request, response);
                break;

            case "/EditUser":
                updateUser(request,response);
                break;

            case "/User/AddUser":
                addUser(request,response);
                break;
            case "/User/ResetPassword":
                forgot(request,response);
                break;
            default:
                ServletUtills.forward("/views/404.jsp", request, response);
                break;
        }

    }
    private void forgot(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = UserModel.findByUsername(email);
        if (user != null && !user.isGg_acc()) {
            String rawPassword = VerifyUtills.getPasswordRanDom(8);
            String bcryptHashString = BCrypt.withDefaults().hashToString(12, rawPassword.toCharArray());
            UserModel.resetPassword(email, bcryptHashString);
            MailUtills.sendResetPassword(email, rawPassword);
            request.setAttribute("hasSuccess", true);
            request.setAttribute("Message", "Reset Password Successfully !");
        }
        int id  = Integer.parseInt(request.getParameter("uid"),10);
        User user1 = UserModel.findById(id);
        request.setAttribute("users",user1);
        ServletUtills.forward("/views/vwAdministrator/AdminEditUser.jsp", request, response);
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

       /* User user = UserModel.findById(id);
        HttpSession session = request.getSession();
        session.setAttribute("auth", true);
        session.setAttribute("authUser", user);
        String url = (String) (session.getAttribute("retUrl"));
        if(url == null) url = "/Account/Profile";*/
        ServletUtills.redirect("/Admin/User",request,response);

    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("CatName");
        int catPID = Integer.parseInt(request.getParameter("catpid"),10);
        int level =0;
        if(catPID==0)
        {
            level = 1;
        }
        Category c = new Category(name,level,catPID);
        CategoryModel.add(c);
        request.setAttribute("hasSuccess", true);
        request.setAttribute("Message", "Add Successfully !");
        List<Category> listC = CategoryModel.findParent();
        request.setAttribute("catParent",listC);
        ServletUtills.forward("/views/vwAdministrator/AddCategory.jsp", request, response);
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int id = Integer.parseInt(request.getParameter("CatID"));
        String name = request.getParameter("CatName");
        Category c = new Category(id, name);
        System.out.println(c.getCatid());
        System.out.println(c.getCatname());
        CategoryModel.update(c);
        ServletUtills.redirect("/Admin/Category", request, response);
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        int id = Integer.parseInt(request.getParameter("CatID"));
        List<Product> litsP = ProductModel.findByCatIDAdmin(id);
        List<Category> listPidC = CategoryModel.findChildByPid(id);
        if(litsP.size()==0 && listPidC.size()==0)
        {
            CategoryModel.delete(id);
        }
        else{
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "This Category have Child Category or Product. Cannot Delete");
            Category c1 = CategoryModel.findById(id);
            request.setAttribute("category", c1);
            ServletUtills.forward("/views/vwAdministrator/EditCategory.jsp", request, response);
        }
        ServletUtills.redirect("/Admin/Category",request,response);
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String name = request.getParameter("User");
        String email = request.getParameter("Email");
        String password = request.getParameter("Password");
        DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        LocalDateTime dob = LocalDateTime.parse("01/01/2001 00:00", df);
        String bcryptHashString = BCrypt.withDefaults().hashToString(12, password.toCharArray());
        String address = "None";
        int role = Integer.parseInt(request.getParameter("Role"),10);
        boolean gg_acc = false;
        int reQuest = 0;
        User c = new User(name, email, address,  bcryptHashString, dob, role, reQuest,gg_acc);
        User x = UserModel.findByUsername(email);
        boolean isAvailable = (x == null);
        if(isAvailable){
            UserModel.add(c);
            request.setAttribute("hasSuccess", true);
            request.setAttribute("Message", "Add Successfully !");
        } else{
            request.setAttribute("hasError", true);
            request.setAttribute("errorMessage", "This Email has already existed. Cannot create User");
        }
        ServletUtills.forward("/views/vwAdministrator/AddUser.jsp", request, response);
    }
}
