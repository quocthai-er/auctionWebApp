
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="products" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>

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
     <jsp:attribute name="js">
        <script>
            //Add paging
            $(document).ready(function() {
                $('.t1').after('<div id="nav" class="text-center"></div>');
                let itemsShown = 8;
                let itemsTotal = $('.t1 .col-md-3').length;
                let numPages = itemsTotal / itemsShown;
                for (let i = 0; i < numPages; i++) {
                    let pageNum = i + 1;
                    $('#nav').append('<a href="#" class="btn-outline-warning btn-sm text-decoration-none rounded-lg border border-warning" rel="' + i + '">&emsp;' + pageNum + '&emsp;</a> ');
                }
                $('.t1 .col-md-3').hide();
                $('.t1 .col-md-3').slice(0, itemsShown).show();
                $('#nav a:first').addClass('active');
                $('#nav a').bind('click', function(e) {
                    e.preventDefault();
                    $('#nav a').removeClass('active');
                    $(this).addClass('active');
                    let currPage = $(this).attr('rel');
                    let startItem = currPage * itemsShown;
                    let endItem = startItem + itemsShown;
                    $('.t1 .col-md-3').css('opacity', '0').hide().slice(startItem, endItem).
                    css('display', 'block').animate({
                        opacity: 1
                    }, 300);
                });
            });
            window.onload=()=>{
                if(!${auth})
                    $('.heart').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")
            }
            function remove (otp){
                $.getJSON(otp, function (data) {
                    if (data == false) {
                        swal({
                            title: "Failed!",
                            text: "Failed deleted to this product!",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else
                    {
                        swal({
                            title: "Successfully!",
                            text: "Successfully deleted to this product!",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        })
                            .then(function(){
                                    location.reload();
                                }
                            );
                    }
                });
            }
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

        <div class="title-box bg-warning mt-3 mx-auto justify-content-center " style="border-radius: 5px; width: 84% ;background-image: url('https://images.squarespace-cdn.com/content/v1/5be4abdf0dbda37a57d6b5cd/1542130803615-0392V5SC5CWYPEEA1FTH/Header-bgr-V1.jpg?format=1500w'); background-size: cover">
            <h2 style="font-family: 'Russo One'">Product Manager</h2>
        </div>
        <div class="right col-sm-10 mx-auto" style="background-color: white">
            <section class="on-sale">
                <div class="container-fluid t1">
                    <div class="row mt-2">
                        <c:choose>
                            <c:when test="${products.size()==0}">
                                <div class="card-body">
                                    <p class="card-text">No data</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${products}" var="p">
                                    <div class="col-md-3 mb-2 mt-3" >
                                        <div class="product-top mt-3 text-center">
                                            <a href="${pageContext.request.contextPath}/Product/Detail?id=${p.proid}&catid=${p.catid}"><img style="width: 232px;height: 232px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${p.proid}/main.jpg"></a>
                                            <div class="overlay-right">
                                                <a href="${pageContext.request.contextPath}/Product/Detail?id=${p.proid}&catid=${p.catid}" class="btn btn-secondary" title="Detail">
                                                    <i class="fa fa-eye" style="border-radius: 50%" aria-hidden="true"></i>
                                                </a>
<%--                                                <button type="button"  href="${pageContext.request.contextPath}/Product/AddWatchList?proid=${p.proid}&proname=${p.proname}&price_start=${p.price_start}&uid=${authUser.id}" onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p.proid}&proname=${p.proname}&price_start=${p.price_start}&uid=${authUser.id}&catid=${p.catid}')" class="heart btn btn-secondary " title="Add to WatchList">--%>
<%--                                                    <i class="fa fa-heart-o" style="border-radius: 50%"></i>--%>
<%--                                                </button>--%>
                                                <button type="button"  onclick="remove('${pageContext.request.contextPath}/Admin/DeleteProduct?id=${p.proid}')"href="${pageContext.request.contextPath}/WatchList/deleteWatchList?id=${w.id}" onclick="remove('${pageContext.request.contextPath}/WatchList/deleteWatchList?id=${w.id}')" class=" btn btn-secondary" title="Remove Product">
                                                    <i class="fa fa-trash" aria-hidden="true" style="border-radius: 50%"></i>
                                                </button>
                                               <%-- <button  onclick="remove('${pageContext.request.contextPath}/Admin/DeleteProduct?id=${p.proid}')">
                                                    <i class="fa fa-trash-o" style="border-radius: 50%" aria-hidden="true"></i>
                                                </button>--%>
                                            </div>
                                        </div>
                                        <div class="product-bottom text-center" >
                                            <h3 class="mx-auto mt-4" style="width: 230px;height: 75px; object-fit: contain; font-family: Arial">${p.proname}</h3>
                                            <h5><b>Price Current:</b>
                                                <span class="text-danger font-weight-bold" style="font-size: 30px">$<fmt:formatNumber value="${p.price_current}" type="number" /></span>
                                            </h5>
                                            <c:if test="${p.price_now!=0}">
                                                <h5> <b>Price Buy Now:</b>
                                                    <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${p.price_now}" type="number"/></span>
                                                </h5>
                                            </c:if>
                                            <h5><b>Start Date</b> :
                                                <fmt:parseDate value="${p.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                                <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                            </h5>
                                            <h5><b>  End Date:</b>
                                                <fmt:parseDate value="${p.end_day}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="end" type="both" />
                                                <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ end }" />
                                            </h5>
                                            <%--<h5><b>Sum of bids:</b> ${p.bid_count}</h5>--%>
                                            <%--<h5><b>Highest bidder: </b>--%>
                                            <%--    <c:choose>--%>
                                            <%--    <c:when test="${empty p.name}">--%>
                                            <%--        Nobody bidding.--%>
                                            <%--    </c:when>--%>
                                            <%--    <c:otherwise>--%>
                                            <%--    <span class="text-danger">${p.name}</span></h5>--%>
                                            <%--</c:otherwise>--%>
                                            <%--</c:choose>--%>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </section>
        </div>
    </jsp:body>
</t:manager>
