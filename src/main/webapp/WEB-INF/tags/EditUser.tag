<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag pageEncoding="utf-8" %>
<%@attribute name="css" fragment="true" required="false" %>
<%@attribute name="js" fragment="true" required="false" %>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <c:choose>
        <c:when test="${authUser.role==0}">
            <title>Admin</title>
        </c:when>
        <c:when test="${authUser.role==1}">
            <title>Bidder</title>
        </c:when>
        <c:otherwise>
            <title>Seller</title>
        </c:otherwise>
    </c:choose>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/lib.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/public/css/img.css">
    <script src="https://www.google.com/recaptcha/api.js?hl=en" async defer></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap" rel="stylesheet">
    <style>
        body {
            height: 100vh;
           /* background-image: url(https://upload.wikimedia.org/wikipedia/commons/d/dd/Elegant_Background-18.jpg);*/
            background-color: white;
            background-size: 100%;
        }
        form {
            width: 35%;
            padding: 25px 0;
        }
        /*--------------preloader---------------*/
        #preloader {
            background: #fff url('${pageContext.request.contextPath}/public/imgs/loader.gif') no-repeat center center;
            background-size: 50%;
            height: 100vh;
            width: 100%;
            position: fixed;
            z-index: 100;
        }
    </style>
    <jsp:invoke fragment="css"/>
</head>
<body>
    <div id="preloader"></div>
    <script src="${pageContext.request.contextPath}/public/js/img.js"></script>
    <jsp:include page="../../views/partials/NavEditUser.jsp"/>
    <div class="row">
        <jsp:doBody/>
    </div>
    <jsp:include page="../../views/partials/Footer.jsp"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/public/js/validator.js"></script>
    <script src="${pageContext.request.contextPath}/public/js/main.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <jsp:invoke fragment="js"/>
</body>
</html>