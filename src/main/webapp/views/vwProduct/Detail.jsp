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
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />
<t:main>
    <jsp:attribute name="js">
        <script>
            window.onload=()=>{
                if(!${auth})
                {
                    $('.heart').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")
                    $('#btn-auction').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")
                    $('#btnConfirmBid').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")
                }
            }
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
                                // swal({
                                //     title: "Warning!",
                                //     text: "Your rating must have more than 80% to bid on this product!",
                                //     icon: "warning",
                                //     button: "OK!",
                                // });
                                $('#staticBackdrop').modal('toggle')
                                $('.modalConfirm').append('<b style="color: #f33a58"> $' + price + '</b>')
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
        <div class="right col-sm-9 ml-3 ">
            <div class="card mt-2">
                <div class="card-header" style="background-image: linear-gradient(#ea8215, #eca45d)">
                    <h4 style="cursor:pointer; font-family: 'Arial';font-weight: bold" class="text-center">${product.proname}</h4>
                </div>
                <div class="card-body">
                    <div class="all" style="margin-left: 150px">
                        <div>
                            <ul class="list-img mt-2">
                                <li class="img mb-3">
                                    <img id="one" class="border border-success rounded" onclick="changeImage('one')" style="width:80px ;" src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/main.jpg" alt="">
                                </li>
                                <li class="img mb-3">
                                    <img id="two" class="border border-success rounded" onclick="changeImage('two')" style="width:80px ;" src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub1.jpg" alt="">
                                </li>
                                <li class="img mb-3">
                                    <img id="three" class="border border-success rounded" onclick="changeImage('three')" style="width:80px ;"  src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub2.jpg" alt="">
                                </li>
                                <li class="img">
                                    <img id="four" class="border border-success rounded" onclick="changeImage('four')" style="width:80px ;"  src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/sub3.jpg" alt="">
                                </li>
                            </ul>
                        </div>
                        <div id="main_img" style="margin-left: 10px">
                            <img id="img_main" src="${pageContext.request.contextPath}/public/imgs/products/${product.proid}/main.jpg" style="width: 400px;height: 400px; object-fit: contain;" alt="">
                        </div>
                    </div>
                    <h4 style="cursor:pointer;" class="text-primary text-center mt-3">
                        Starting price:$
                        <fmt:formatNumber value="${product.price_start}" type="number" />
                    </h4>
                    <h4 style="cursor:pointer;" class="text-primary text-center mt-3">Current price:$
                        <fmt:formatNumber value="${product.price_current}" type="number" />
                    </h4>
                    <c:if test="${product.price_now!=0}">
                        <h4 style="cursor:pointer;" class="text-danger text-center mt-3">Buy Now Price:$
                            <fmt:formatNumber value="${product.price_now}" type="number" />
                        </h4>
                    </c:if>

                    <input id="price_start" name="price_start" type="hidden" value="${product.price_start}">
                    <input id="step" name="step" type="hidden" value="${product.price_step}">
                    <input id="email" name="email" type="hidden" value="${authUser.email}">
                    <input id="price_cur" name="price_cur" type="hidden" value="${product.price_current}">
                    <div class="border border-info rounded" >
                        <div class="content mt-3 " style="margin-left: 50px">
                            <h4 class="mr-2"><span class="text-info"> <b>Seller:</b></span> ${product.sell_name}</h4>
                            <h4 class="mr-2"><span class="text-info"><b>Highest Bidder:</b></span>
                                ${product.bid_name}
                            </h4>
                            <h4 class="mr-2"><span class="text-info"><b>Date Start:</b> </span><fmt:parseDate value="${product.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
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
                        Recommended price: $ <fmt:formatNumber value="${hint}" type="number" /> </div>
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
                    <h4 class="mt-2">
                        Auction History</h4>
                    <div class="tableFixHead" style="cursor: pointer">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th scope="col">Time</th>
                                <th scope="col">Bidder</th>
                                <th scope="col">Price</th>
                                <th scope="col">Reject</th>
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
                                                <c:set var="nameParts" value="${fn:split(h.name, ' ')}"/>
                                                *****${nameParts[0]}
                                            </td>
                                            <td>$ <fmt:formatNumber value="${h.price}" type="number" /></td>
                                            <c:if test="${auth && authUser.id==product.sell_id}">
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
                </div>
            </div>
            <hr>
            <h3 class="text-primary" style="cursor: pointer">Similar products</h3>
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
                                    <div class="col-lg-3 mb-4 shadow text-center" style="border-radius: 10%" >
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
                                            <h3 name="proname" class="mx-auto" style="width: 205px;height: 75px; object-fit: contain">${p.proname}</h3>
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

