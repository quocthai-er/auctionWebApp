
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="users" scope="request" type="com.ute.auctionwebapp.beans.User"/>
<jsp:useBean id="Feedback" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Feedback>"/>
<style>
    body{
        background-image: url("https://cdn.tgdd.vn/mwgcart/mwg-site/ContentMwg/images/noel/BG-min.png?v=2&fbclid=IwAR0GDK8iX1hJ5pGL0sqMAr7t8UlbK2XVlOKT73L1wWfkYXqa3vDspcMYBMs");
        background-size: cover;
        background-color: #daf5ff !important;
        background-attachment: fixed;
    }
</style>
<style>
    /* customizable snowflake styling */
    .snowflake {
        color: #fff;
        font-size: 1em;
        font-family: Arial, sans-serif;
        text-shadow: 0 0 5px #000;
    }

    @-webkit-keyframes snowflakes-fall{0%{top:-10%}100%{top:100%}}@-webkit-keyframes snowflakes-shake{0%,100%{-webkit-transform:translateX(0);transform:translateX(0)}50%{-webkit-transform:translateX(80px);transform:translateX(80px)}}@keyframes snowflakes-fall{0%{top:-10%}100%{top:100%}}@keyframes snowflakes-shake{0%,100%{transform:translateX(0)}50%{transform:translateX(80px)}}.snowflake{position:fixed;top:-10%;z-index:9999;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:default;-webkit-animation-name:snowflakes-fall,snowflakes-shake;-webkit-animation-duration:10s,3s;-webkit-animation-timing-function:linear,ease-in-out;-webkit-animation-iteration-count:infinite,infinite;-webkit-animation-play-state:running,running;animation-name:snowflakes-fall,snowflakes-shake;animation-duration:10s,3s;animation-timing-function:linear,ease-in-out;animation-iteration-count:infinite,infinite;animation-play-state:running,running}.snowflake:nth-of-type(0){left:1%;-webkit-animation-delay:0s,0s;animation-delay:0s,0s}.snowflake:nth-of-type(1){left:10%;-webkit-animation-delay:1s,1s;animation-delay:1s,1s}.snowflake:nth-of-type(2){left:20%;-webkit-animation-delay:6s,.5s;animation-delay:6s,.5s}.snowflake:nth-of-type(3){left:30%;-webkit-animation-delay:4s,2s;animation-delay:4s,2s}.snowflake:nth-of-type(4){left:40%;-webkit-animation-delay:2s,2s;animation-delay:2s,2s}.snowflake:nth-of-type(5){left:50%;-webkit-animation-delay:8s,3s;animation-delay:8s,3s}.snowflake:nth-of-type(6){left:60%;-webkit-animation-delay:6s,2s;animation-delay:6s,2s}.snowflake:nth-of-type(7){left:70%;-webkit-animation-delay:2.5s,1s;animation-delay:2.5s,1s}.snowflake:nth-of-type(8){left:80%;-webkit-animation-delay:1s,0s;animation-delay:1s,0s}.snowflake:nth-of-type(9){left:90%;-webkit-animation-delay:3s,1.5s;animation-delay:3s,1.5s}.snowflake:nth-of-type(10){left:25%;-webkit-animation-delay:2s,0s;animation-delay:2s,0s}.snowflake:nth-of-type(11){left:65%;-webkit-animation-delay:4s,2.5s;animation-delay:4s,2.5s}
</style>
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


<t:admin>
     <jsp:attribute name="js">
        <script>

        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="history-image">
            <div class="title-box bg-danger mt-1 mb-3 w-75 mx-auto justify-content-center" style="border-radius: 5px; font-family: 'Russo One';background-image: url('https://www.thebutlerspantry.ie/wp-content/uploads/2020/10/trim-header-christmas.png');background-size: cover">
                <h2>Feedback</h2>
            </div>
            <div class="text-center">
                <div text-center>
                    <b class="text-secondary "style="text-align: center; font-size: larger">Feedback about: ${users.name}</b>
                </div>

                <div class=" text-center">
                    <b style="align-items: center">
                        <script>
                            let countlike = 0;
                            let countdislike = 0;
                            <c:forEach items="${Feedback}" var="f">
                            <c:if test="${f.uid == users.id}">

                            <c:if test="${f.like == 1}">
                            countlike ++ ;
                            </c:if>

                            <c:if test="${f.dislike == 1}">
                            countdislike ++ ;
                            </c:if>

                            </c:if>
                            </c:forEach>
                            document.write("<b> Rate: </b>" + countlike + " <i class='text-primary fa fa-thumbs-up'></i> | "+ countdislike +" <i class='text-danger fa fa-thumbs-down'></i>")
                        </script>
                    </b>
                </div>

            </div>
            <div  class="tableFixHistory w-75 h-50 mx-auto" style="cursor: pointer" id="tableFixHistory2">
                <table class="table  table-hover">
                    <thead>
                    <tr>
                        <th scope="col" style="background-color: black; color: white">From</th>
                        <th scope="col" style="background-color: black; color: white">Product</th>
                        <th scope="col" style="background-color: black; color: white">Comment</th>
                        <th scope="col" style="background-color: black; color: white">Like/Dislike</th>

                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${Feedback.size()== 0}">
                            <div class="card-body">
                                <p class="card-text">No data</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${Feedback}" var="f">
                                <c:if test="${f.uid == users.id}">
                                    <tr>
                                        <th scope="col">${f.review_name}</th>
                                        <th>${f.proname}</th>
                                        <th >${f.des}</th>
                                        <c:if test="${f.like ==1}">
                                            <th >
                                                <i class="fa fa-thumbs-up text-primary" aria-hidden="true"></i>
                                            </th>
                                        </c:if>
                                        <c:if test="${f.dislike ==1}">
                                            <th >
                                                <i class="fa fa-thumbs-down text-danger" aria-hidden="true"></i>
                                            </th>
                                        </c:if>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>

        </div>
    </jsp:body>
</t:admin>