<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />
<div class="header">
    <!-- Top Nav -->
    <nav class="navbar navbar-expand-lg navbar-light " style="background-image: linear-gradient(#ea8215, #eca45d)">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-lg-between"  id="navbarSupportedContent">
            <a href="${pageContext.request.contextPath}/Home"><img src="${pageContext.request.contextPath}/public/imgs/logo.png" class="img-fluid rounded-top"
                                                                   alt="No Loading" style=" width:140px ;height: 70px"></a>
            <nav class="navbar navbar-light d-inline" style="background-image: linear-gradient(#ea8215, #eca45d)">
                <div class="form-inline">
                    <input id="search" class="form-control mr-sm-3" name="search"  type="search" placeholder="Search" aria-label="Search" style="width: 500px">
                    <button id="btnSearch" class="btn btn-outline-success text-light bg-success my-2 my-sm-0 " type="button" onclick="Found('${pageContext.request.contextPath}')" >
                        <i class="fa fa-search"></i>
                        Search
                    </button>
                </div>
            </nav>
            <ul class="navbar-nav ">
                <li class="nav-item active mr-4 "><a href="${pageContext.request.contextPath}/WatchList?uid=${authUser.id}"  id="watchlist" class="text-light " style="font-weight: bold" >
                    <i class="fa fa-heart text-danger" aria-hidden="true"></i>
                    WatchList
                </a>
                </li>
                <li class="nav-item active mr-4 dropdown">
                    <c:choose>
                        <c:when test="${auth}">
                            <form id="frmLogout" method="post" action="${pageContext.request.contextPath}/Account/Logout"></form>
                            <a href="${pageContext.request.contextPath}/Account/Login" class="text-light " style="font-weight: bold">
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                <c:set var="nameParts" value="${fn:split(authUser.name, ' ')}"/>
                                Hi, <b>${nameParts[0]}!</b>
                                <c:choose>
                                    <c:when test="${authUser.role == 0}">${"(Admin)"}</c:when>
                                    <c:when test="${authUser.role == 1}">${"(Bidder)"}</c:when>
                                    <c:otherwise>${"(Seller)"}</c:otherwise>
                                </c:choose>
                            </a>
                            <ul class="dropdown-menu mt-0 dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                                <c:choose>
                                    <c:when test="${authUser.role == 1}"><li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/BidderProfile">
                                        <i class="fa fa-user" aria-hidden="true"></i> Profile
                                    </a></li></c:when>
                                    <c:when test="${authUser.role == 0}"><li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Profile">
                                        <i class="fa fa-user" aria-hidden="true"></i> Profile
                                    </a></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Admin">
                                            <i class="fa fa-cog" aria-hidden="true"></i>
                                            Manage
                                        </a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/SellerProfile">
                                            <i class="fa fa-user" aria-hidden="true"></i> Profile
                                        </a></li>
                                    </c:otherwise>
                                </c:choose>

                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/YourProduct?uid=${authUser.id}">
                                    <i class="fa fa-product-hunt" aria-hidden="true"></i> Your Products
                                </a></li>
                                <li><a class="dropdown-item" href="javascript: $('#frmLogout').submit()">
                                    <i class="fa fa-sign-out" aria-hidden="true"></i> Sign out
                                </a></li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/Account/Login" class="text-light " style="font-weight: bold">
                                <i class="fa fa-user-circle-o" aria-hidden="true"></i>
                                Login/Register
                            </a>
                            <ul class="dropdown-menu mt-0 dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Login">
                                    <i class="fa fa-sign-in mr-1" aria-hidden="true"></i>Login
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/Account/Register">
                                    <i class="fa fa-user-plus mr-1" aria-hidden="true"></i> Register
                                </a></li>
                            </ul>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </nav>

    <nav class="navbar navbar-expand-lg navbar-light bg-light ">
        <div class="collapse navbar-collapse justify-content-around" id="navbarNavDropdown">
            <ul class="navbar-nav">
                    <li class="nav-item active">
                        <a class="nav-link mr-5 ml-5 text-success" href="${pageContext.request.contextPath}/Admin">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i>
                            Back <span class="sr-only">(current)</span>
                        </a>
                    </li>
                <li class="nav-item active">
                    <a class="nav-link mr-5 ml-5 text-warning" href="${pageContext.request.contextPath}/Admin/Product">
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
                    <a class="nav-link text-info" href="${pageContext.request.contextPath}/Admin/Category">
                        <i class="fa fa-list-ol" aria-hidden="true"></i>
                        Category</a>
                </li>
            </ul>
        </div>
    </nav>
</div>

