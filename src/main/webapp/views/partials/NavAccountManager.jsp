<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />
<div class="header">
    <!-- Top Nav -->
    <nav class="navbar navbar-expand-lg navbar-light bg-info">
        <div class="collapse navbar-collapse justify-content-lg-between" id="navbarSupportedContent">
            <a href="${pageContext.request.contextPath}/Home">
                <img src="${pageContext.request.contextPath}/public/imgs/logo.png" class="img-fluid rounded-top" alt="No Loading" style=" width:140px ;height: 70px">
            </a>
        </div>
    </nav>

    <nav class="navbar navbar-expand-lg navbar-light bg-light mt-1 ">
        <div class="collapse navbar-collapse justify-content-around" id="navbarNavDropdown">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link mr-5 ml-5 text-success" href="${pageContext.request.contextPath}/Admin/Product">
                        <i class="fa fa-product-hunt" aria-hidden="true"></i>
                        Product <span class="sr-only">(current)</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link mr-5 ml-5 text-danger" href="${pageContext.request.contextPath}/Admin/User">
                        <i class="fa fa-id-card-o" aria-hidden="true"></i>
                        User
                    </a>
                </li>
                <li class="nav-item mr-5 ml-5">
                    <a class="nav-link text-warning" href="${pageContext.request.contextPath}/Admin/Category">
                        <i class="fa fa-list-ol" aria-hidden="true"></i>
                        Category</a>
                </li>
            </ul>
        </div>
    </nav>
</div>

