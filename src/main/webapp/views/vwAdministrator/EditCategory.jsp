<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="category" scope="request" type="com.ute.auctionwebapp.beans.Category"/>

<t:manager>
    <jsp:attribute name="css">
        <style>

            body{
                background-image: url("https://cdn.tgdd.vn/mwgcart/mwg-site/ContentMwg/images/noel/BG-min.png?v=2&fbclid=IwAR0GDK8iX1hJ5pGL0sqMAr7t8UlbK2XVlOKT73L1wWfkYXqa3vDspcMYBMs");
                background-size: cover;
                background-color: #daf5ff !important;
                background-attachment: fixed;
            }

            /* customizable snowflake styling */
            .snowflake {
                color: #fff;
                font-size: 1em;
                font-family: Arial, sans-serif;
                text-shadow: 0 0 5px #000;
            }

            @-webkit-keyframes snowflakes-fall{0%{top:-10%}100%{top:100%}}@-webkit-keyframes snowflakes-shake{0%,100%{-webkit-transform:translateX(0);transform:translateX(0)}50%{-webkit-transform:translateX(80px);transform:translateX(80px)}}@keyframes snowflakes-fall{0%{top:-10%}100%{top:100%}}@keyframes snowflakes-shake{0%,100%{transform:translateX(0)}50%{transform:translateX(80px)}}.snowflake{position:fixed;top:-10%;z-index:9999;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:default;-webkit-animation-name:snowflakes-fall,snowflakes-shake;-webkit-animation-duration:10s,3s;-webkit-animation-timing-function:linear,ease-in-out;-webkit-animation-iteration-count:infinite,infinite;-webkit-animation-play-state:running,running;animation-name:snowflakes-fall,snowflakes-shake;animation-duration:10s,3s;animation-timing-function:linear,ease-in-out;animation-iteration-count:infinite,infinite;animation-play-state:running,running}.snowflake:nth-of-type(0){left:1%;-webkit-animation-delay:0s,0s;animation-delay:0s,0s}.snowflake:nth-of-type(1){left:10%;-webkit-animation-delay:1s,1s;animation-delay:1s,1s}.snowflake:nth-of-type(2){left:20%;-webkit-animation-delay:6s,.5s;animation-delay:6s,.5s}.snowflake:nth-of-type(3){left:30%;-webkit-animation-delay:4s,2s;animation-delay:4s,2s}.snowflake:nth-of-type(4){left:40%;-webkit-animation-delay:2s,2s;animation-delay:2s,2s}.snowflake:nth-of-type(5){left:50%;-webkit-animation-delay:8s,3s;animation-delay:8s,3s}.snowflake:nth-of-type(6){left:60%;-webkit-animation-delay:6s,2s;animation-delay:6s,2s}.snowflake:nth-of-type(7){left:70%;-webkit-animation-delay:2.5s,1s;animation-delay:2.5s,1s}.snowflake:nth-of-type(8){left:80%;-webkit-animation-delay:1s,0s;animation-delay:1s,0s}.snowflake:nth-of-type(9){left:90%;-webkit-animation-delay:3s,1.5s;animation-delay:3s,1.5s}.snowflake:nth-of-type(10){left:25%;-webkit-animation-delay:2s,0s;animation-delay:2s,0s}.snowflake:nth-of-type(11){left:65%;-webkit-animation-delay:4s,2.5s;animation-delay:4s,2.5s}
        </style>
    </jsp:attribute>
    <jsp:body>
        <div class="snowflakes" aria-hidden="true">
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
        </div>
        <form action="" method="post">
            <div class="card w-50 mx-auto mt-3">
                <h4 class="card-header text-light" style="font-family: 'Russo One',sans-serif ; background-image: url('https://t3.ftcdn.net/jpg/03/05/08/54/360_F_305085456_qVPV5YYXv9kQoIndzZebtyR4ITmuX9dE.jpg');background-size: cover">
                    Category
                </h4>
                <div class="card-body">
                    <div class="form-group">
                        <label for="txtCatID">CategoryID</label>
                        <input type="text" class="form-control" id="txtCatID" name="CatID" readonly value="${category.catid}">
                    </div>
                    <div class="form-group">
                        <label for="txtCatName">CategoryName</label>
                        <input type="text" class="form-control" id="txtCatName" name="CatName" autofocus value="${category.catname}">
                    </div>
                    <c:if test="${hasError}">
                        <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                            <strong>Error!</strong> ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                </div>
                <div class="card-footer">
                    <a class="btn btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category" role="button">
                        <i class="fa fa-backward" aria-hidden="true"></i>
                        List
                    </a>
                    <button type="submit" class="btn btn-danger" formaction="${pageContext.request.contextPath}/Admin/Delete">
                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                        Delete
                    </button>
                    <button type="submit" class="btn" formaction="${pageContext.request.contextPath}/Admin/Update" style="background-color: darkblue; color: white">
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Save
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:manager>