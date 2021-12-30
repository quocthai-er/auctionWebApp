<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="products1" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="products2" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="products3" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="now" class="java.util.Date" />
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

<t:main>
    <jsp:attribute name="js">
        <script>
            //Return to login if guest click add to watchlist
            window.onload=()=>{
                if(!${auth})
                    $('.heart').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")
            }

            // Scroll to top of page
            window.addEventListener("scroll", function () {
                let scroll = document.querySelector('.scrollTop');
                scroll.classList.toggle('active',window.scrollY > 250);
                // let nav = document.querySelector('.nav-fix');
                // nav.classList.toggle('active',window.scrollY > 80);
            });

            //Add to watchlist
            function add (otp){
                {
                    $.getJSON(otp, function (data) {
                        if (data === false) {
                            swal({
                                title: "Failed!",
                                text: "Failed added to your watchlist!",
                                icon: "error",
                                button: "OK!",
                                dangerMode: true,
                                closeOnClickOutside: false,
                            });
                        } else swal({
                            title: "Successfully!",
                            text: "Successfully added to your watchlist!",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        });
                    });
                }
            }
            //Countdown timer in product
            $(function(){
                $('[data-countdown]').each(function() {
                    let $this = $(this), finalDate = $(this).data('countdown');
                    $this.countdown(finalDate, function(event) {
                        $this.html(event.strftime('%D days %H:%M:%S'))}).on('finish.countdown', function() {
                        $this.text('EXPIRED');
                    });
                });
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="right col-sm-10 mt-1 bg-white">
            <a name ="top" ></a>
            <a href="#top"><i class="fa fa-arrow-up fa-2x scrollTop" aria-hidden="true"></i></a>
            <section class="on-sale">
                <div class="container-fluid">
                    <div class="row">
                        <div class="title-box bg-danger mt-1 w-100 justify-content-center" style="border-radius: 5px;background-image: url('https://www.thebutlerspantry.ie/wp-content/uploads/2020/10/trim-header-christmas.png');background-size: cover">
                            <h2 style="cursor: pointer; font-family: 'Russo One'">Top Expired</h2>
                        </div>
                        <c:forEach items="${products1}" var="p1">
                                <div class="col-md-3 mt-3" data-aos="zoom-in" data-aos-duration="1000" >
                                    <div class="product-top mt-3 text-center">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${p1.proid}&catid=${p1.catid}"><img src="${pageContext.request.contextPath}/public/imgs/products/${p1.proid}/main.jpg" style="width: 232px;height: 232px; object-fit: contain;"></a>
                                        <div class="overlay-right">
                                                <a href="${pageContext.request.contextPath}/Product/Detail?id=${p1.proid}&catid=${p1.catid}" type="button" class="btn btn-secondary" title="Detail">
                                                    <i class="fa fa-eye" aria-hidden="true" style="border-radius: 50%"></i>
                                                </a>
                                                    <button type="button" onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p1.proid}&proname=${p1.proname}&price_start=${p1.price_start}&uid=${authUser.id}&catid=${p1.catid}')" class="heart btn btn-secondary" title="Add to WatchList">
                                                        <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                                    </button>
                                        </div>
                                    </div>
                                        <div class="product-bottom text-center" >
                                            <h3 class="mx-auto mt-4" style="width: 240px;height: 75px; object-fit: contain; font-family: Arial">${p1.proname}</h3>
                                            <h5><b>Price Current:</b>
                                                <span class="text-danger font-weight-bold" style="font-size: 30px">$<fmt:formatNumber value="${p1.price_current}" type="number" /></span>
                                            </h5>
                                            <c:if test="${p1.price_now!=0}">
                                                <h5> <b>Price Buy Now:</b>
                                                    <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${p1.price_now}" type="number"/></span>
                                                </h5>
                                            </c:if>
                                            <h5><b>Start Date</b> :
                                                <fmt:parseDate value="${p1.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                                <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                            </h5>
                                            <h5><b>  End Date:</b>
                                                <fmt:parseDate value="${p1.end_day}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="end" type="both" />
                                                <span class="text-success" data-countdown="<fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${end }" />"></span>
                                            </h5>
                                            <h5><b>Sum of bids:</b> ${p1.bid_count}</h5>
                                            <h5><b>Highest bidder: </b>
                                                <c:choose>
                                                    <c:when test="${empty p1.name}">
                                                        Nobody bidding.
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-danger">
                                                            <c:set var="nameParts" value="${fn:split(p1.name, ' ')}"/>
                                                            <c:choose>
                                                                <c:when test="${nameParts[0].length() <=3}">
                                                                    *****${nameParts[0].substring(1)}***
                                                                </c:when>
                                                                <c:when test="${nameParts[0].length() >5}">
                                                                    ***${nameParts[0].substring(0,1)}*${nameParts[0].substring(3,4)}x${nameParts[0].substring(5)}*
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ***${nameParts[0].substring(0,2)}*${nameParts[0].substring(3,4)}***
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span></h5>
                                                    </c:otherwise>
                                                </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                    </div>

                    <div class="row">
                        <div class="title-box bg-danger mt-3 w-100 justify-content-center" style="border-radius: 5px;background-image: url('https://www.thebutlerspantry.ie/wp-content/uploads/2020/10/trim-header-christmas.png');background-size: cover">
                            <h2 style="cursor: pointer; font-family: 'Russo One'">Top Price</h2>
                        </div>
                        <c:forEach items="${products2}" var="p2">
                            <div class="col-md-3 mt-3" data-aos="fade-up" data-aos-duration="1000" >
                                <div class="product-top mt-3 text-center">
                                    <a href="${pageContext.request.contextPath}/Product/Detail?id=${p2.proid}&catid=${p2.catid}"><img src="${pageContext.request.contextPath}/public/imgs/products/${p2.proid}/main.jpg" style="width: 232px;height: 232px; object-fit: contain;"></a>
                                    <div class="overlay-right">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${p2.proid}&catid=${p2.catid}" type="button" class="btn btn-secondary" title="Detail">
                                            <i class="fa fa-eye" aria-hidden="true" style="border-radius: 50%"></i>
                                        </a>
                                        <button  type="button" onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p2.proid}&proname=${p2.proname}&price_start=${p2.price_start}&uid=${authUser.id}&catid=${p2.catid}')" class=" heart btn btn-secondary" title="Add to WatchList">
                                            <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="product-bottom text-center">
                                    <h3 class="mx-auto mt-4" style="width: 240px;height: 75px; object-fit: contain; font-family: Arial">${p2.proname}</h3>
                                    <h5><b>Price Current:</b>
                                        <span class="text-danger font-weight-bold" style="font-size: 30px">$<fmt:formatNumber value="${p2.price_current}" type="number" /></span>
                                    </h5>
                                    <c:if test="${p2.price_now!=0}">
                                        <h5> <b>Price Buy Now:</b>
                                            <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${p2.price_now}" type="number"/></span>
                                        </h5>
                                    </c:if>
                                    <h5><b>Start Date</b> :
                                        <fmt:parseDate value="${p2.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                        <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                    </h5>
                                    <h5><b>  End Date:</b>
                                        <fmt:parseDate value="${p2.end_day}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="end" type="both" />
                                        <span class="text-success" data-countdown="<fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${end }" />"></span>
                                    </h5>
                                    <h5><b>Sum of bids:</b> ${p2.bid_count}</h5>
                                    <h5><b>Highest bidder: </b>
                                        <c:choose>
                                        <c:when test="${empty p2.name}">
                                            Nobody bidding.
                                        </c:when>
                                        <c:otherwise>
                                        <span class="text-danger">
                                            <c:set var="nameParts" value="${fn:split(p2.name, ' ')}"/>
                                            <c:choose>
                                                <c:when test="${nameParts[0].length() <=3}">
                                                    *****${nameParts[0].substring(1)}***
                                                </c:when>
                                                <c:when test="${nameParts[0].length() >5}">
                                                    ***${nameParts[0].substring(0,1)}*${nameParts[0].substring(3,4)}x${nameParts[0].substring(5)}*
                                                </c:when>
                                                <c:otherwise>
                                                    ***${nameParts[0].substring(0,2)}*${nameParts[0].substring(3,4)}***
                                                </c:otherwise>
                                            </c:choose>
                                        </span></h5>
                                    </c:otherwise>
                                    </c:choose>
                                    </h5>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="row">
                        <div class="title-box bg-danger mt-3 w-100 justify-content-center" style="border-radius: 5px;background-image: url('https://www.thebutlerspantry.ie/wp-content/uploads/2020/10/trim-header-christmas.png');background-size: cover">
                            <a name="hot"></a>
                            <h2 style="cursor: pointer;font-family: 'Russo One'">Top Bidding</h2>
                        </div>
                        <c:forEach items="${products3}" var="p3">
                            <div class="col-md-3 mt-3" data-aos="fade-left" data-aos-duration="1500" >
                                <div class="product-top mt-3 text-center">
                                    <a href="${pageContext.request.contextPath}/Product/Detail?id=${p3.proid}&catid=${p3.catid}"><img src="${pageContext.request.contextPath}/public/imgs/products/${p3.proid}/main.jpg" style="width: 232px;height: 232px; object-fit: contain;"></a>
                                    <div class="overlay-right">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${p3.proid}&catid=${p3.catid}" type="button" class="btn btn-secondary" title="Detail">
                                            <i class="fa fa-eye" aria-hidden="true" style="border-radius: 50%"></i>
                                        </a>
                                        <button  type="button" onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p3.proid}&proname=${p3.proname}&price_start=${p3.price_start}&uid=${authUser.id}&catid=${p3.catid}')" class=" heart btn btn-secondary" title="Add to WatchList">
                                            <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="product-bottom text-center">
                                    <h3 class="mx-auto mt-4" style="width: 240px;height: 75px; object-fit: contain; font-family: Arial">${p3.proname}</h3>
                                    <h5><b>Price Current:</b>
                                        <span class="text-danger font-weight-bold" style="font-size: 30px">$<fmt:formatNumber value="${p3.price_current}" type="number" /></span>
                                    </h5>
                                    <c:if test="${p3.price_now!=0}">
                                        <h5> <b>Price Buy Now:</b>
                                            <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${p3.price_now}" type="number"/></span>
                                        </h5>
                                    </c:if>
                                    <h5><b>Start Date</b> :
                                        <fmt:parseDate value="${p3.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                        <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                    </h5>
                                    <h5><b>  End Date:</b>
                                        <fmt:parseDate value="${p3.end_day}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="end" type="both" />
                                        <span class="text-success" data-countdown="<fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${end }" />"></span>
                                    </h5>
                                    <h5><b>Sum of bids:</b> ${p3.count}</h5>
                                    <h5><b>Highest bidder: </b>
                                        <c:choose>
                                        <c:when test="${empty p3.name}">
                                            Nobody bidding.
                                        </c:when>
                                        <c:otherwise>
                                        <span class="text-danger">
                                            <c:set var="nameParts" value="${fn:split(p3.name, ' ')}"/>
                                                <c:choose>
                                                    <c:when test="${nameParts[0].length() <=3}">
                                                        *****${nameParts[0].substring(1)}***
                                                    </c:when>
                                                    <c:when test="${nameParts[0].length() >5}">
                                                        ***${nameParts[0].substring(0,1)}*${nameParts[0].substring(3,4)}x${nameParts[0].substring(5)}*
                                                    </c:when>
                                                    <c:otherwise>
                                                        ***${nameParts[0].substring(0,2)}*${nameParts[0].substring(3,4)}***
                                                    </c:otherwise>
                                                </c:choose>
                                        </span></h5>
                                    </c:otherwise>
                                    </c:choose>
                                    </h5>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </div>
    </jsp:body>
</t:main>
