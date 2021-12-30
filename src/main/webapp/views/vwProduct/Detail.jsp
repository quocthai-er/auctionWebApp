<%--
  Created by IntelliJ IDEA.
  User: Tri
  Date: 11/22/2021
  Time: 3:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="product" scope="request" type="com.ute.auctionwebapp.beans.Product"/>
<jsp:useBean id="products" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="histories" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.History>"/>
<jsp:useBean id="usersRate" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Feedback>"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />

<t:main>
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
    <jsp:attribute name="js">
        <script>
            //Return to login if guest click add to watchlist and bidding
            window.onload=()=>{
                if(!${auth})
                {
                    $('.heart').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")
                    $('#btn-auction').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")
                    $('#btnConfirmBid').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")
                }
            }

            // Scroll to top of page
            window.addEventListener("scroll", function () {
                let scroll = document.querySelector('.scrollTop');
                scroll.classList.toggle('active',window.scrollY > 300);
            });

            //Bidding
            if(${auth})
            {
                $('#btnConfirmBid').on('click',function (){
                    $('.modalConfirm').html($('.modalConfirm').html().replace(/<b style="color: #f33a58">[^<]*/,''))
                    let step = parseInt($('#step').val());
                    let price = parseInt($('#price').val()) ;
                    let price_start= parseInt($('#price_start').val()) ;
                    let price_cur= parseInt($('#price_cur').val()) ;
                    if(Number.isNaN(price)|| price<price_start || price < price_cur || price % step !==0)
                    {
                        swal({
                            title: "Warning!",
                            text: "Please enter your valid price again! Bid increment is $"+step,
                            icon: "warning",
                            button: "OK!",
                        });
                    }
                    else {
                        let rejectFlag = 0;
                        <c:forEach var="rejectBidID" items="${fn:split(product.reject_bid_id, ',')}">
                            <c:if  test="${authUser.id == rejectBidID}" >
                                rejectFlag = 1;
                            </c:if>
                        </c:forEach>
                        if (rejectFlag === 0) {
                            if (${product.allow_bid.equals("off")}){
                                //Case all bidder can bid this product
                                $('#staticBackdrop').modal('toggle')
                                $('.modalConfirm').append('<b style="color: #f33a58"> $'+price+'</b>')
                            } else {
                                //Case check if bidder have rating above 80%
                                $.getJSON('${pageContext.request.contextPath}/Feedback/GetUserRate?uid=${authUser.id}', function (data) {
                                    if (data >=80) {
                                        $('#staticBackdrop').modal('toggle')
                                        $('.modalConfirm').append('<b style="color: #f33a58"> $' + price + '</b>')
                                    } else {
                                        swal({
                                            title: "Warning!",
                                            text: "Your rating must have more than 80% to bid on this product!",
                                            icon: "warning",
                                            button: "OK!",
                                        });
                                    }
                                });
                            }
                        } else  swal({
                                title: "Rejected!",
                                text: "You have been rejected by seller in this product!",
                                icon: "error",
                                dangerMode: true,
                                button: "OK!",
                            });
                    }
                });

                $('#btn-auction').on('click',function (){
                    let step = parseInt($('#step').val());
                    let price = parseInt($('#price').val()) ;
                    let price_start= parseInt($('#price_start').val()) ;
                    let price_cur= parseInt($('#price_cur').val()) ;
                    let email = $('#email').val();
                    if(Number.isNaN(price)|| price<price_start || price < price_cur || price % step !==0)
                    {
                        alert("Please enter your valid price again")
                    }
                    else{
                        $('#btn-auction').empty();
                        $('#btn-auction').html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> &nbsp; Loading...')
                        $.getJSON('${pageContext.request.contextPath}/Product/Bidding?proid=${product.proid}&proname=${product.proname}&step='+step+'&price='+price+'&uid=${authUser.id}&email='+email+'&sell_mail=${product.sell_mail}&bid_mail=${product.bid_mail}', function (data) {
                            if (data === false) {
                                swal({
                                    title: "Failed!",
                                    text: "Bidding failed. Please try again!",
                                    icon: "error",
                                    button: "OK!",
                                    dangerMode: true,
                                    closeOnClickOutside: false,
                                })
                                .then(function(){
                                        location.reload();
                                    }
                                );
                            } else{
                                $('#btn-auction').html('Done')
                                swal({
                                    title: "Successfully!",
                                    text: "Bidding successful!",
                                    icon: "success",
                                    button: "Done!",
                                    closeOnClickOutside: false,
                                })
                                .then(function(){
                                        location.reload();
                                    }
                                );
                            }

                        });
                    }
                });
            }

            //Show modal reject
            $('#modalReject').on('show.bs.modal', function (event) {
                let button = $(event.relatedTarget);
                let proid = button.data('proid');
                let bidid = button.data('bidid');
                $('#btnReject').attr('href','${pageContext.request.contextPath}/Product/Reject?proid='+proid+'&bidid='+bidid);
            });

            $('#btnReject').on('click', function () {
                $('#btnReject').empty();
                $('#btnReject').html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> &nbsp; Loading...')
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
            function countdownTimer (day) {
                // Set the date we're counting down to
                a = new Date(day)
                // Update the count down every 1 second
                let x = setInterval(function() {

                    // Get today's date and time
                    let now = new Date().getTime();

                    // Find the distance between now and the count down date
                    let distance = a - now;

                    // Time calculations for days, hours, minutes and seconds
                    let days = Math.floor(distance / (1000 * 60 * 60 * 24));
                    let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    let seconds = Math.floor((distance % (1000 * 60)) / 1000);
                    //Output the result in an element with day < 3
                    if (days < 3)
                        if (days === 0)
                            if (hours === 0) document.querySelector("#item").innerHTML = minutes + " more minutes";
                            else document.querySelector("#item").innerHTML = hours + " more hours";
                        else document.querySelector("#item").innerHTML = days + " more days";
                    else
                        document.querySelector("#item").innerHTML = days + "day " + hours + "hour "
                            + minutes + "min " + seconds + "second ";
                    if (distance < 0) {
                        clearInterval(x);
                        document.querySelector("#item").innerHTML = "EXPIRED";
                        $('#btnConfirmBid').hide();
                        $('#price').attr('readonly',true);
                    }
                }, 1000);
            }
            countdownTimer("'<fmt:parseDate value="${product.end_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="end" type="both" />"+
            '<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${end}" />')
        </script>
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

        <div class="right col-sm-9 ml-3 ">
            <a name ="top" ></a>
            <a href="#top"><i class="fa fa-arrow-up fa-2x scrollTop" aria-hidden="true"></i></a>
            <div class="card mt-2">
                <div class="card-header" style="background-image: linear-gradient(#ea8215, #eca45d)">
                    <h4 style="cursor:pointer; font-family: 'Arial';font-weight: bold; color: white" class="text-center">${product.proname}</h4>
                </div>
                <div class="card-body">
                    <div class="all" style="margin-left: 150px">
                        <div>
                            <ul class="list-img mt-2">
                                <li class="img mb-3">
                                    <img  data-target="#carouselExampleIndicators" data-slide-to="0" id="one" class="border border-success rounded" style="width: 80px;height: 80px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/main.jpg" alt="">
                                </li>
                                <li class="img mb-3">
                                    <img  data-target="#carouselExampleIndicators" data-slide-to="1" id="two" class="border border-success rounded"  style="width: 80px;height: 80px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub1.jpg" alt="">
                                </li>
                                <li class="img mb-3">
                                    <img  data-target="#carouselExampleIndicators" data-slide-to="2" id="three" class="border border-success rounded" style="width: 80px;height: 80px; object-fit: contain;"  src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub2.jpg" alt="">
                                </li>
                                <li class="img">
                                    <img  data-target="#carouselExampleIndicators" data-slide-to="3" id="four" class="border border-success rounded"  style="width: 80px;height: 80px; object-fit: contain;"  src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub3.jpg" alt="">
                                </li>
                            </ul>
                        </div>
                        <div id="main_img" style="margin-left: 20px" >
                            <div id="carouselExampleIndicators" class="carousel slide" data-interval="2000" data-ride="carousel" style="width: 400px;height: 400px; object-fit: contain; box-shadow: none">
                                <ol class="carousel-indicators">
                                    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active bg-secondary"></li>
                                    <li data-target="#carouselExampleIndicators" data-slide-to="1" class="bg-secondary"></li>
                                    <li data-target="#carouselExampleIndicators" data-slide-to="2" class="bg-secondary"></li>
                                    <li data-target="#carouselExampleIndicators" data-slide-to="3" class="bg-secondary"></li>
                                </ol>
                                <div class="carousel-inner">
                                    <div class="carousel-item active">
                                        <img src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/main.jpg" class="d-block w-100" alt="...">
                                    </div>
                                    <div class="carousel-item">
                                        <img src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub1.jpg" class="d-block w-100" alt="...">
                                    </div>
                                    <div class="carousel-item">
                                        <img src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub2.jpg" class="d-block w-100" alt="...">
                                    </div>
                                    <div class="carousel-item">
                                        <img src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub3.jpg" class="d-block w-100" alt="...">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <h4 style="cursor:pointer;" class="text-center mt-3"><b>Current price:</b>
                        <span class="text-danger font-weight-bold" style="font-size: 43px">$<fmt:formatNumber value="${product.price_current}" type="number" /></span>
                    </h4>
                    <h4 style="cursor:pointer;" class="text-center mt-3 mr-5">
                        <b>Starting price:</b>
                        <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${product.price_start}" type="number" /></span>
                    </h4>
                    <c:if test="${product.price_now!=0}">
                        <h4 style="cursor:pointer;" class="text-center mt-3 mr-5"><b>Buy now price:</b>
                            <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${product.price_now}" type="number" /></span>
                        </h4>
                    </c:if>

                    <input id="price_start" name="price_start" type="hidden" value="${product.price_start}">
                    <input id="step" name="step" type="hidden" value="${product.price_step}">
                    <input id="email" name="email" type="hidden" value="${authUser.email}">
                    <input id="price_cur" name="price_cur" type="hidden" value="${product.price_current}">
                    <div class="border border-info rounded" >
                        <div class="content mt-3 " style="margin-left: 50px">
                            <h4 class="mr-2"><span class="text-info"> <b>Seller:</b></span>
                                <c:choose>
                                    <c:when test="${auth}">
                                        ${product.sell_name}
                                        <c:set var="rate" value="0"/>
                                        <c:forEach items="${usersRate}" var="r">
                                            <c:if test="${product.sell_id == r.uid}">
                                                <c:set var="rate" value="${r.rate}"/>
                                            </c:if>
                                        </c:forEach>
                                        (<a title="Click to view user feedback" href="${pageContext.request.contextPath}/Feedback/ViewComment?uid=${product.sell_id}">
                                                ${rate}%
                                        </a><i class="fa fa-thumbs-o-up text-primary" aria-hidden="true"></i> )
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="nameParts" value="${fn:split(product.sell_name, ' ')}"/>
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
                                    </c:otherwise>
                                </c:choose>
                            </h4>
                            <h4 class="mr-2"><span class="text-info"><b>Highest Bidder:</b></span>
                                <c:choose>
                                    <c:when test="${empty product.bid_name}">
                                        None.
                                    </c:when>
                                    <c:when test="${authUser.id == product.sell_id}">
                                        ${product.bid_name}
                                        <c:set var="rate" value="0"/>
                                        <c:forEach items="${usersRate}" var="r">
                                            <c:if test="${product.bid_id == r.uid}">
                                                <c:set var="rate" value="${r.rate}"/>
                                            </c:if>
                                        </c:forEach>
                                        (<a title="Click to view user feedback" href="${pageContext.request.contextPath}/Feedback/ViewComment?uid=${product.bid_id}">
                                        ${rate}%
                                        </a><i class="fa fa-thumbs-o-up text-primary" aria-hidden="true"></i> )
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="nameParts" value="${fn:split(product.bid_name, ' ')}"/>
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
                                    </c:otherwise>
                                </c:choose>
                            </h4>
                            <h4 class="mr-2"><span class="text-info"><b>Date Start:</b> </span><fmt:parseDate value="${product.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" /></h4>
                            <h4 class="mr-2"><span class="text-info"><b>Date End:</b> </span><fmt:parseDate value="${product.end_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" /></h4>
                            <h4>
                                <span class="text-info"><b>Time remaining:</b></span>
                                <span id="item" style="display: inline-block"></span>
                            </h4>
                            <h4>
                                <span class="text-info"><b>Product details:</b></span></h4>
                            <div style="margin-left: 75px;!important;">${product.fulldes}</div>

                        </div>
                    </div>

                    <h4 class="ml-5 mt-3 text-danger">
                        Please bid:</h4>
                    <c:if test="${product.price_current==0}">
                        <c:set var="hint" value="${product.price_start+product.price_step}"></c:set>
                    </c:if>
                    <c:if test="${product.price_current>0}">
                        <c:set var="hint" value="${product.price_current+product.price_step}"></c:set>
                    </c:if>
                    <div id="hint" class="ml-5 mb-2 text-info" >
                        Recommended price: $<fmt:formatNumber value="${hint}" type="number" /> </div>
                    <form action="" method="post" class="mb-3">
                        <div class="input-group flex-nowrap mb-3">
                            <div class="input-group-prepend">
                            <span class="input-group-text" id="addon-wrapping">
                                <i class="fa fa-hand-o-right" aria-hidden="true"></i>
                            </span>
                            </div>
                            <input id="price" type="number" name="price" class="form-control min-vh-75" placeholder="$ <fmt:formatNumber value="${hint}" type="number" />" aria-label="price" aria-describedby="addon-wrapping">
                        </div>


                        <div class="card-footer text-muted bg-warning d-flex justify-content-center">

                            <button type="button" id="btnConfirmBid" class="btn btn-primary mr-5" role="button" data-target="#staticBackdrop">
                                <i class="fa fa-gavel" aria-hidden="true"></i>
                                Bid now
                            </button>

                            <!-- Modal Confirm -->
                            <div class="modal fade" id="staticBackdrop" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="staticBackdropLabel">Bid Confirmation</h5>
                                        </div>
                                        <div class="modal-body modalConfirm">
                                            I bid for <b> ${product.proname}</b> <br>
                                            Confirm Bidding Price
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                <i class="fa fa-times" aria-hidden="true"></i> Close</button>
                                            <button type="button" id="btn-auction" class="btn btn-primary">
                                                <i class="fa fa-check" aria-hidden="true"></i> Confirm Bid</button>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <button class="heart btn btn-danger mr-5" onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${product.proid}&proname=${product.proname}&price_start=${product.price_start}&uid=${authUser.id}&catid=${product.catid}')" type="button">
                                <i class="fa fa-heart" aria-hidden="true"></i>
                                Love
                            </button>
                        </div>
                    </form>
                    <c:if test="${auth}">
                        <h4 class="mt-2">
                            Auction History</h4>
                        <div class="tableFixHead" style="cursor: pointer">
                            <table class="table table-hover">
                                <thead>
                                <tr>
                                    <th scope="col">Time</th>
                                    <th scope="col">Bidder</th>
                                    <th scope="col">Price</th>
                                    <c:if test="${authUser.id==product.sell_id}">
                                        <th scope="col">Bidder rate</th>
                                        <th scope="col">Reject</th>
                                    </c:if>
                                </tr>
                                </thead>
                                <tbody>
                                <c:choose>
                                    <c:when test="${histories.size()==0}">
                                        <div class="card-body">
                                            <p class="card-text">No data</p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach items="${histories}" var="h">
                                            <tr>
                                                <td>
                                                    <fmt:parseDate value="${h.buy_day}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                                    <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${authUser.id == product.sell_id}">
                                                            ${h.name}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="nameParts" value="${fn:split(h.name, ' ')}"/>
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
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>$ <fmt:formatNumber value="${h.price}" type="number" /></td>
                                                <c:if test="${authUser.id == product.sell_id}">
                                                    <td>
                                                        <c:set var="rate" value="0"/>
                                                        <c:forEach items="${usersRate}" var="r">
                                                            <c:if test="${h.bid_id == r.uid}">
                                                                <c:set var="rate" value="${r.rate}"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        <a title="Click to view user feedback" class="ml-3" href="${pageContext.request.contextPath}/Feedback/ViewComment?uid=${h.bid_id}">
                                                            ${rate}%
                                                    </a><i class="fa fa-thumbs-o-up text-primary" aria-hidden="true"></i>
                                                    </td>

                                                    <td>
                                                        <button type="button" data-toggle="modal" data-target="#modalReject" data-proid="${h.proid}" data-bidid="${h.bid_id}" class="btn btn-outline-danger btn-sm btn-block w-50" title="Reject Bidder">
                                                            <i class="fa fa-times" aria-hidden="true"></i>
                                                        </button>
                                                    </td>
                                                </c:if>
                                            </tr>
                                        </c:forEach>
                                        <%--Modal Reject--%>
                                        <div class="modal fade" id="modalReject" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="rejectLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="rejectLabel">Reject Confirmation</h5>
                                                    </div>
                                                    <div class="modal-body">
                                                        Are you sure to reject bidder to bid on this product?
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                            <i class="fa fa-times" aria-hidden="true"></i> Close</button>
                                                        <a type="button" id="btnReject" class="btn btn-outline-danger">
                                                            <i class="fa fa-check" aria-hidden="true"></i> Confirm Reject</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </c:if>

                </div>
            </div>
            <hr>
            <h3 class="text-danger" style="cursor: pointer; font-family: 'Russo One'">Similar products</h3>
                <div class="container-fluid">
                    <div class="row mt-2">
                        <c:choose>
                            <c:when test="${products.size()==0}">
                                <div class="card-body">
                                    <p class="card-text">No data</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${products}" var="p">
                                    <div class="col-md-3 mb-4 shadow text-center mt-3" style="background-color: white">
                                        <div class="product-top mt-3 text-center">
                                            <a href="${pageContext.request.contextPath}/Product/Detail?id=${p.proid}&catid=${p.catid}"><img style="width: 205px;height: 232px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${p.proid}/main.jpg"></a>
                                            <div class="overlay-right">
                                                    <a href="${pageContext.request.contextPath}/Product/Detail?id=${p.proid}&catid=${p.catid}" class="btn btn-secondary" title="Detail">
                                                        <i class="fa fa-eye" style="border-radius: 50%" aria-hidden="true"></i>
                                                    </a>
                                                    <button type="button"   href="${pageContext.request.contextPath}/Product/AddWatchList?proid=${p.proid}&proname=${p.proname}&price_start=${p.price_start}&uid=${authUser.id}&catid=${p.catid}" onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p.proid}&proname=${p.proname}&price_start=${p.price_start}&uid=${authUser.id}')" class="heart btn btn-secondary " title="Add to WatchList">
                                                        <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                                    </button>

                                            </div>
                                        </div>
                                        <div class="product-bottom text-center">
                                            <h3 name="proname" class="mx-auto" style="width: 205px;height: 75px; object-fit: contain; font-family: Arial">${p.proname}</h3>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
        </div>
    </jsp:body>
</t:main>

