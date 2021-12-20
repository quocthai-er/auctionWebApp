<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="products1" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="products2" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="products3" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<t:main>
    <jsp:attribute name="js">
        <script>
            window.onload=()=>{
                if(!${auth})
                    $('.heart').attr("onclick","location.href='${pageContext.request.contextPath}/Account/Login'")

            }
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
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="right col-sm-10 mt-1">
            <section class="on-sale">
                <div class="container-fluid">
                    <div class="title-box bg-danger mt-1 w-100 justify-content-center" style="border-radius: 5px;">
                        <h2 style="cursor: pointer; font-family: 'Bauhaus 93'">Top Expired</h2>
                    </div>
                    <div class="row">
                            <c:forEach items="${products1}" var="p1">
                                <div class="col-md-3 shadow" style="border-radius: 10%;">
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
                                            <h3 class="mx-auto mt-4" style="width: 250px;height: 75px; object-fit: contain;">${p1.proname}</h3>
                                            <h5 class="text-primary"><b>Price Current:</b> $
                                                <fmt:formatNumber value="${p1.price_current}" type="number" />
                                            </h5>
                                            <c:if test="${p1.price_now!=0}">
                                                <h5 class="text-danger"> <b>Price Buy Now:</b> $
                                                    <fmt:formatNumber value="${p1.price_now}" type="number" />
                                                </h5>
                                            </c:if>
                                            <h5><b>Start Date</b> :
                                                <fmt:parseDate value="${p1.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                                <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                            </h5>
                                            <h5><b>  End Date:</b>
                                                <fmt:parseDate value="${p1.end_day}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="end" type="both" />
                                                <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${end }" />
                                            </h5>
                                            <h5><b>Sum of bids:</b> ${p1.bid_count}</h5>
                                            <h5 class="text-danger"><b>Highest bidder: </b>${p1.name}</h5>
                                        </div>
                                    </div>
                                </c:forEach>
                    </div>
                    <div class="title-box bg-danger mt-3 w-100 justify-content-center" style="border-radius: 5px;">
                        <h2 style="cursor: pointer; font-family: 'Bauhaus 93'">Top Price</h2>
                    </div>
                    <div class="row">
                        <c:forEach items="${products2}" var="p2">
                            <div class="col-md-3 shadow" style="border-radius: 10%">
                                <div class="product-top mt-3 text-center">
                                    <a href="${pageContext.request.contextPath}/Product/Detail?id=${p2.proid}&catid=${p2.catid}"><img src="${pageContext.request.contextPath}/public/imgs/products/${p2.proid}/main.jpg" style="width: 232px;height: 232px; object-fit: contain;"></a>
                                    <div class="overlay-right">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${p2.proid}&catid=${p2.catid}" type="button" class="btn btn-secondary" title="Detail">
                                            <i class="fa fa-eye" aria-hidden="true" style="border-radius: 50%"></i>
                                        </a>
                                        <button  type="button" onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p2.proid}&proname=${p2.proname}&price_start=${p2.price_start}&uid=${authUser.id}&catid=${p2.catid}')" class=" heart btn btn-secondary" title="Add to WatchList">
                                            <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                        </button>
<%--                                        <a type="button" class="btn btn-secondary" title="Add to Cart">--%>
<%--                                            <i class="fa fa-shopping-cart" style="border-radius: 50%"></i>--%>
<%--                                        </a>--%>
                                    </div>
                                </div>
                                <div class="product-bottom text-center">
                                    <h3 class="mx-auto" style="width: 250px;height: 75px; object-fit: contain">${p2.proname}</h3>
                                    <h5 class="text-primary"><b>Price Current:</b> $
                                        <fmt:formatNumber value="${p2.price_current}" type="number" />
                                    </h5>
                                    <c:if test="${p2.price_now!=0}">
                                        <h5 class="text-danger"><b>Price Buy Now:</b> $
                                            <fmt:formatNumber value="${p2.price_now}" type="number" />
                                        </h5>
                                    </c:if>
                                    <h5><b>Start Date:</b>
                                        <fmt:parseDate value="${p2.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                        <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                    </h5>
                                    <h5><b>End Date:</b>>
                                        <fmt:parseDate value="${p2.end_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                        <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${parsedDateTime }" />
                                    </h5>
                                    <h5><b>Sum of bids:</b> ${p2.bid_count}</h5>
                                    <h5 class="text-danger"><b>Highest bidder:</b> ${p2.name}</h5>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="title-box bg-danger mt-3 w-100 justify-content-center" style="border-radius: 5px;">
                        <a name="hot"></a>
                        <h2 style="cursor: pointer;font-family: 'Bauhaus 93'">Top Bidding</h2>
                    </div>
                    <div class="row">
                        <c:forEach items="${products3}" var="p3">
                            <div class="col-md-3 shadow" style="border-radius: 10%">
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
                                    <h3 class="mx-auto" style="width: 250px;height: 75px; object-fit: contain">${p3.proname}</h3>
                                    <h5 class="text-primary"><b>Price Current:</b> $
                                        <fmt:formatNumber value="${p3.price_current}" type="number" />
                                    </h5>
                                    <c:if test="${p3.price_now!=0}">
                                        <h5 class="text-danger"><b>Price Buy Now:</b> $
                                            <fmt:formatNumber value="${p3.price_now}" type="number" />
                                        </h5>
                                    </c:if>
                                    <h5><b>Start Date:</b>
                                        <fmt:parseDate value="${p3.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                        <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                    </h5>
                                    <h5><b>End Date:</b>
                                        <fmt:parseDate value="${p3.end_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                        <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${parsedDateTime }" />
                                    </h5>
                                    <h5><b>Sum of bids:</b> ${p3.count}</h5>
                                    <h5 class="text-danger"><b>Highest bidder: </b> ${p3.name}</h5>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </div>
    </jsp:body>
</t:main>
