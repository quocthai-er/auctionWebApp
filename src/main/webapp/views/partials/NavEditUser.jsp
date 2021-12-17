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

            <ul class="navbar-nav">
                <li class="nav-item active mr-4 dropdown">
                    <c:choose>
                        <c:when test="${auth}">
                            <form id="frmLogout" method="post" action="${pageContext.request.contextPath}/Account/Logout"></form>
                            <a href="${pageContext.request.contextPath}/Account/Login" class="text-light">
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
                                    </a></li></c:when>
                                    <%-- <c:otherwise>${"(Seller)"}</c:otherwise>--%>
                                </c:choose>
                                <li><a class="dropdown-item" href="javascript: $('#frmLogout').submit()">
                                    <i class="fa fa-sign-out" aria-hidden="true"></i> Sign out
                                </a></li>
                            </ul>
                        </c:when>
                        <%--<c:otherwise>
                            <a href="${pageContext.request.contextPath}/Account/Login" class="text-light">
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
                        </c:otherwise>--%>
                    </c:choose>
                </li>
            </ul>
        </div>
    </nav>


</div>