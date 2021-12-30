<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<jsp:useBean id="sellingProducts" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="soldProducts" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="biddingProducts" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="winningProducts" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Product>"/>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />

<t:watchlist>
    <jsp:attribute name="css">
        <style>
            .header-pro {
                background-image: url("https://cdn.tgdd.vn/mwgcart/mwg-site/ContentMwg/images/noel/Tagline/TGDD/tagline_desktop.png?v=1");
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
        <script src="https://cdn.tiny.cloud/1/v0ozcj27hfm49t3m4umzfpgom0bhbjjl5xxgin0phrhz3385/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script>
            // Scroll to top of page
            window.addEventListener("scroll", function () {
                let scroll = document.querySelector('.scrollTop');
                scroll.classList.toggle('active',window.scrollY > 250);
            });


            function pagination (tableSelection, quantityItem, rowSelection,navName ) {
                $(document).ready(function() {
                    $(tableSelection).after('<div id='+navName+' class="text-center"></div>');
                    let itemsShown = quantityItem;
                    let itemsTotal = $(rowSelection).length;
                    let numPages = itemsTotal / itemsShown;
                    for (let i = 0; i < numPages; i++) {
                        let pageNum = i + 1;
                        $('#'+navName+'').append('<a href="#" class="btn-outline-warning btn-sm text-decoration-none rounded-lg border border-warning" rel="' + i + '">&emsp;' + pageNum + '&emsp;</a> ');
                    }
                    $(rowSelection).hide();
                    $(rowSelection).slice(0, itemsShown).show();
                    $('#'+navName+' a:first').addClass('active');
                    $('#'+navName+' a').bind('click', function(e) {
                        e.preventDefault();
                        $('#'+navName+' a').removeClass('active');
                        $(this).addClass('active');
                        let currPage = $(this).attr('rel');
                        let startItem = currPage * itemsShown;
                        let endItem = startItem + itemsShown;
                        $(rowSelection).css('opacity', '0').hide().slice(startItem, endItem).
                        css('display', 'block').animate({
                            opacity: 1
                        }, 300);
                    });
                });
            }

            pagination ('.t1', 4, '.t1 .col-md-3','nav1' )
            pagination ('.t2', 4, '.t2 .col-md-3','nav2' )
            pagination ('.t3', 4, '.t3 .col-md-3','nav3' )

            tinymce.init({
                selector: '#txtFullDes',
                height: 250,
                plugins: 'paste image link autolink lists table media',
                menubar: false,
                toolbar: [
                    'undo redo | bold italic underline strikethrough | numlist bullist | alignleft aligncenter alignright | forecolor backcolor | table link image media'
                ],
            });

            $('#addDes').on('show.bs.modal', function (event) {
                let button = $(event.relatedTarget)
                let id = button.data('id')
                let name = button.data('name')
                let des = button.data('des')
                let modal = $(this)
                modal.find('#proID').val(id)
                modal.find('#txtProname').text('Product: '+name)
            })

            $('#commentSold').on('show.bs.modal', function (event) {
                let button = $(event.relatedTarget)
                let id = button.data('id')
                let name = button.data('name')
                let uid = button.data('uid')
                let uname = button.data('uname')
                let modal = $(this)
                modal.find('#soldproid').val(id)
                modal.find('#soldproname').val(name)
                modal.find('#uid').val(uid)
                modal.find('#uname').val(uname)
                modal.find('#txtsoldProname').text('Product: '+name)
                modal.find('#txtsoldbidname').text('Winner: '+ uname)
            })

            $('#commentWin').on('show.bs.modal', function (event) {
                let button = $(event.relatedTarget)
                let id = button.data('id')
                let name = button.data('name')
                let uid = button.data('uid')
                let uname = button.data('uname')
                let modal = $(this)
                modal.find('#winproid').val(id)
                modal.find('#winproname').val(name)
                modal.find('#winuid').val(uid)
                modal.find('#winuname').val(uname)
                modal.find('#txtWinProname').text('Product: '+name)
                modal.find('#txtWinSeller').text('Seller: '+uname)
            })

            //Add to watchlist
            function add (otp){
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

            //Cancel Transaction
            function cancelTrans (query){
                swal({
                    title: "Are you sure?",
                    text: "Delete this product transaction?",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) => {
                    if (willDelete) {
                        $.getJSON(query, function (data) {
                            if (data === false) {
                                swal({
                                    title: "Failed!",
                                    text: "Failed cancel this product transaction!",
                                    icon: "error",
                                    button: "OK!",
                                    dangerMode: true,
                                    closeOnClickOutside: false,
                                });
                            } else swal({
                                title: "Successfully!",
                                text: "Successfully cancel this product transaction!",
                                icon: "success",
                                button: "OK!",
                                closeOnClickOutside: false,
                            }).then(function(){
                                    location.reload();
                                }
                            );
                        });
                    }
                });
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
            $('#feedback').on('submit', function (e){
                e.preventDefault();
                let proid= $('#soldproid').val();
                $.getJSON('${pageContext.request.contextPath}/Feedback/CheckFeedBack?review_id=${authUser.id}&proid='+proid, function (data) {
                    if (data === false){
                        swal({
                            title: "Successfully!",
                            text: "Successfully added to your feedback",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        }).then(function (){
                            $('#feedback').off('submit').submit();
                        })
                    } else {
                        swal({
                            title: "Failed!",
                            text: "You already added a feedback on this product!",
                            icon: "error",
                            button: "OK!",
                            dangerMode: "true",
                            closeOnClickOutside: false,
                        })
                    }
                })
            })

            $('#feedbackWin').on('submit', function (e){
                e.preventDefault();
                let proid= $('#winproid').val();
                $.getJSON('${pageContext.request.contextPath}/Feedback/CheckFeedBack?review_id=${authUser.id}&proid='+proid, function (data) {
                    if (data === false){
                        swal({
                            title: "Successfully!",
                            text: "Successfully added to your feedback",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,

                        }).then(function (){
                            $('#feedbackWin').off('submit').submit();
                        })
                    } else {
                        swal({
                            title: "Failed!",
                            text: "You already added a feedback on this product!",
                            icon: "error",
                            button: "OK!",
                            dangerMode: "true",
                            closeOnClickOutside: false,
                        })
                    }
                })
            })

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
        <a name ="top"></a>
        <section class="selling">
            <div class="title-box d-flex justify-content-between mt-1 h-100 mb-3 w-100 header-pro" style="border-radius: 5px; position: sticky; top: 0px;z-index: 100">
                <h2 class="font-weight-bold">YOUR PRODUCTS</h2>
                <div class="btn-group-sm" >
                <a class="btn btn-outline-light rounded-pill" href="#selling" role="button">Selling List</a>
                <a class="btn btn-outline-light rounded-pill" href="#sold" role="button">Sold List</a>
                <a class="btn btn-outline-light rounded-pill" href="#bidding" role="button">Bidding List</a>
                <a class="btn btn-outline-light rounded-pill" href="#winning" role="button">Won List</a>
                </div>
            </div>
            <%--Scroll to top--%>
            <a href="#top"><i class="fa fa-arrow-up fa-2x scrollTop" aria-hidden="true"></i></a>

            <%--Selling Product--%>
            <a name="selling" class="p-4"></a>
            <div class="container-fluid t1" >
                <div class="w-100 mb-1 justify-content-between d-flex border-bottom">
                    <div class="title-pro">
                        <h2>Selling Products</h2>
                    </div>
                    <c:choose>
                        <c:when test="${authUser.role != 1}">
                            <a id="btnAddPro" class="btn btn-success btn-lg mb-3" href="${pageContext.request.contextPath}/Product/Add" role="button">Add Product</a>
                        </c:when>
                    </c:choose>
                </div>
                <div class="row mt-2 ml-1">
                    <c:choose>
                        <c:when test="${sellingProducts.size()==0}">
                            <div class="card-body">
                                <p class="card-text">You are not selling any products</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${sellingProducts}" var="p">
                                <div class="col-md-3 mb-4 mt-3">
                                    <div class="product-top mt-3 text-center">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${p.proid}&catid=${p.catid}"><img style="width: 232px;height: 232px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${p.proid}/main.jpg"></a>
                                        <div class="overlay-right">
                                            <a href="${pageContext.request.contextPath}/Product/Detail?id=${p.proid}&catid=${p.catid}" class="btn btn-secondary" title="Detail">
                                                <i class="fa fa-eye" style="border-radius: 50%" aria-hidden="true"></i>
                                            </a>
                                            <button type="button"  onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p.proid}&proname=${p.proname}&price_start=${p.price_start}&uid=${authUser.id}&catid=${p.catid}')" class="heart btn btn-secondary " title="Add to WatchList">
                                                <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                            </button>
                                            <button type="button" class="btn btn-secondary" title="Add Description" data-toggle="modal" data-target="#addDes" data-id="${p.proid}" data-name = "${p.proname}">
                                                <i class="fa fa-pencil" aria-hidden="true" style="border-radius: 50%"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="product-bottom text-center">
                                        <h3 class="mx-auto mt-4" style="width: 250px;height: 75px; object-fit: contain; font-family: Arial">${p.proname}</h3>
                                        <h5><b>Price Current:</b>
                                            <span class="text-danger font-weight-bold" style="font-size: 30px">$<fmt:formatNumber value="${p.price_current}" type="number" /></span>
                                        </h5>
                                        <c:if test="${p.price_now!=0}">
                                            <h5> <b>Price Buy Now:</b>
                                                <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${p.price_now}" type="number"/></span>
                                            </h5>
                                        </c:if>
                                        <h5><b>Start Date:</b>
                                            <fmt:parseDate value="${p.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                            <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                        </h5>
                                        <h5><b>End Date:</b>
                                            <fmt:parseDate value="${p.end_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                            <span class="text-success" data-countdown="<fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${parsedDateTime}" />"></span>
                                        </h5>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="modal fade" id="addDes" tabindex="-1" aria-labelledby="addDesLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addDesLabel" style="font-family: 'Russo One'">Add Description</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <form method="post" action="${pageContext.request.contextPath}/Account/EditDes">
                                        <div class="modal-body">
                                                <input type="hidden" name="uid" value="${authUser.id}">
                                                <input type="hidden" id="proID" name="proid">
                                                <div class="form-group">
                                                    <b class="text-info"><label id="txtProname" class="col-form-label"></label></b>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txtModifyDate" class="col-form-label">Modify Date:</label>
                                                    <input type="text" readonly value="<fmt:formatDate value="${now}" pattern="dd/MM/yyyy hh:mm:ss"/>" name="date" class="form-control" id="txtModifyDate">
                                                </div>
                                                <div class="form-group">
                                                    <label for="txtFullDes" class="col-form-label">Full Description:</label>
                                                    <textarea class="form-control" name="fulldes" id="txtFullDes"></textarea>
                                                </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                <i class="fa fa-times" aria-hidden="true"></i> Close</button>
                                            <button type="submit" class="btn btn-info">
                                                <i class="fa fa-check" aria-hidden="true"></i> Save</button>
                                        </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <%--Sold Product--%>
            <a name="sold" class="p-4"></a>
            <div class="container-fluid t2">
                <div class="w-100 mb-1 border-bottom">
                    <div class="title-pro">
                        <h2>Sold Products</h2>
                    </div>
                </div>
                <div class="row mt-2 ml-1">
                    <c:choose>
                        <c:when test="${soldProducts.size()==0}">
                            <div class="card-body">
                                <p class="card-text">You have not sold on any products yet </p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${soldProducts}" var="p2">
                                <div class="col-md-3 mb-4 mt-3">
                                    <div class="product-top mt-3 text-center">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${p2.proid}&catid=${p2.catid}"><img style="width: 232px;height: 232px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${p2.proid}/main.jpg"></a>
                                        <div class="overlay-right">
                                            <a href="${pageContext.request.contextPath}/Product/Detail?id=${p2.proid}&catid=${p2.catid}" class="btn btn-secondary" title="Detail">
                                                <i class="fa fa-eye" style="border-radius: 50%" aria-hidden="true"></i>
                                            </a>
                                            <button type="button"  onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p2.proid}&proname=${p2.proname}&price_start=${p2.price_start}&uid=${authUser.id}&catid=${p2.catid}')" class="heart btn btn-secondary " title="Add to WatchList">
                                                <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                            </button>
                                            <button type="button" data-toggle="modal" data-target="#commentSold" data-id="${p2.proid}" data-name = "${p2.proname}" data-uid="${p2.bid_id}" data-uname="${p2.bid_name}"  class="heart btn btn-secondary" title="Comment">
                                                <i class="fa fa-comment" style="border-radius: 50%"></i>
                                            </button>
                                            <button type="button" onclick="cancelTrans('${pageContext.request.contextPath}/Feedback/CancelTrans?uid=${p2.bid_id}&uname=${p2.bid_name}&review_id=${authUser.id}&review_name=${authUser.name}&proid=${p2.proid}&proname=${p2.proname}')" class="heart btn btn-secondary" title="Cancel this product transaction">
                                                <i class="fa fa-times-circle text-danger" aria-hidden="true" style="border-radius: 50%"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="product-bottom text-center">
                                        <h3 class="mx-auto mt-4" style="width: 250px;height: 75px; object-fit: contain; font-family: Arial">${p2.proname}</h3>
                                        <h5><b>Price Current:</b>
                                            <span class="text-danger font-weight-bold" style="font-size: 30px">$<fmt:formatNumber value="${p2.price_current}" type="number" /></span>
                                        </h5>
                                        <c:if test="${p2.price_now!=0}">
                                            <h5> <b>Price Buy Now:</b>
                                                <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${p2.price_now}" type="number"/></span>
                                            </h5>
                                        </c:if>
                                        <h5><b>Start Date:</b>
                                            <fmt:parseDate value="${p2.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                            <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                        </h5>
                                        <h5><b>End Date:</b>
                                            <fmt:parseDate value="${p2.end_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                            <span class="text-success" data-countdown="<fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${parsedDateTime}" />"></span>
                                        </h5>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="modal fade" id="commentSold" tabindex="-1" aria-labelledby="addCommentSoldLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addCommentSoldLabel" style="font-weight: bold; font-family: 'Russo One'">Feedback</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <form method="post" id="feedback" action="${pageContext.request.contextPath}/Feedback/AddSoldFeedback" >
                                            <div class="modal-body">
                                                <input type="hidden" name="review_id" value="${authUser.id}">
                                                <input type="hidden" name="review_name" value="${authUser.name}">
                                                <input type="hidden" name="soldproname" id="soldproname">
                                                <input type="hidden" id="soldproid" name="soldproid">
                                                <input type="hidden" id="uid" name="uid">
                                                <input type="hidden" id="uname" name="uname">

                                                <div class="form-group">
                                                    <b class="text-info"><label id="txtsoldProname" class="col-form-label"></label></b>
                                                </div>
                                                <div class="form-group">
                                                    <b class="text-secondary"><label id="txtsoldbidname" class="col-form-label"></label></b>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txtsoldcomment" class="col-form-label">Comment:</label>
                                                    <textarea class="form-control" name="soldcomment" id="txtsoldcomment"></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <label><input type="radio" name="soldlike" checked value="1"> <i class="fa fa-thumbs-up text-primary fa-2x"></i></label>
                                                    <label><input type="radio" name="soldlike" value="0"> <i class="fa fa-thumbs-down text-danger fa-2x"></i></label>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                    <i class="fa fa-times" aria-hidden="true"></i> Close</button>
                                                <button type="submit" class="btn btn-info" >
                                                    <i class="fa fa-check" aria-hidden="true"></i> Save</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <%--Bidding Product--%>
            <a name="bidding" class="p-4"></a>
            <div class="container-fluid t3">
                <div class="w-100 mb-1 border-bottom">
                    <div class="title-pro">
                        <h2>Bidding Products</h2>
                    </div>
                </div>
                <div class="row mt-2 ml-1">
                    <c:choose>
                        <c:when test="${biddingProducts.size()==0}">
                            <div class="card-body">
                                <p class="card-text">You are not bidding any products </p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${biddingProducts}" var="p3">
                                <div class="col-md-3 mb-4 mt-3">
                                    <div class="product-top mt-3 text-center">
                                        <c:if test="${p3.bid_id == authUser.id}">
                                            <span class="top-bid"></span>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${p3.proid}&catid=${p3.catid}"><img style="width: 232px;height: 232px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${p3.proid}/main.jpg"></a>
                                        <div class="overlay-right">
                                            <a href="${pageContext.request.contextPath}/Product/Detail?id=${p3.proid}&catid=${p3.catid}" class="btn btn-secondary" title="Detail">
                                                <i class="fa fa-eye" style="border-radius: 50%" aria-hidden="true"></i>
                                            </a>
                                            <button type="button"  onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p3.proid}&proname=${p3.proname}&price_start=${p3.price_start}&uid=${authUser.id}&catid=${p3.catid}')" class="heart btn btn-secondary " title="Add to WatchList">
                                                <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="product-bottom text-center">
                                        <h3 class="mx-auto mt-4" style="width: 250px;height: 75px; object-fit: contain; font-family: Arial">${p3.proname}</h3>
                                        <h5><b>Price Current:</b>
                                            <span class="text-danger font-weight-bold" style="font-size: 30px">$<fmt:formatNumber value="${p3.price_current}" type="number" /></span>
                                        </h5>
                                        <c:if test="${p3.price_now!=0}">
                                            <h5> <b>Price Buy Now:</b>
                                                <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${p3.price_now}" type="number"/></span>
                                            </h5>
                                        </c:if>
                                        <h5><b>Start Date:</b>
                                            <fmt:parseDate value="${p3.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                            <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                        </h5>
                                        <h5><b>End Date:</b>
                                            <fmt:parseDate value="${p3.end_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                            <span class="text-success" data-countdown="<fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${parsedDateTime}" />"></span>
                                        </h5>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <%--Winning Product--%>
            <a name="winning" class="p-4"></a>
            <div class="container-fluid t4">
                <div class="w-100 mb-1 border-bottom">
                    <div class="title-pro">
                        <h2>Won Products</h2>
                    </div>
                </div>
                <div class="row mt-2 ml-1">
                    <c:choose>
                        <c:when test="${winningProducts.size()==0}">
                            <div class="card-body">
                                <p class="card-text">You have not winning on any products yet </p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${winningProducts}" var="p4">
                                <div class="col-md-3 mb-4 mt-3 mt-3">
                                    <div class="product-top mt-3 text-center">
                                        <a href="${pageContext.request.contextPath}/Product/Detail?id=${p4.proid}&catid=${p4.catid}"><img style="width: 232px;height: 232px; object-fit: contain;" src="${pageContext.request.contextPath}/public/imgs/products/${p4.proid}/main.jpg"></a>
                                        <div class="overlay-right">
                                            <a href="${pageContext.request.contextPath}/Product/Detail?id=${p4.proid}&catid=${p4.catid}" class="btn btn-secondary" title="Detail">
                                                <i class="fa fa-eye" style="border-radius: 50%" aria-hidden="true"></i>
                                            </a>
                                            <button type="button"  onclick="add('${pageContext.request.contextPath}/Product/AddWatchList?proid=${p4.proid}&proname=${p4.proname}&price_start=${p4.price_start}&uid=${authUser.id}&catid=${p4.catid}')" class="heart btn btn-secondary " title="Add to WatchList">
                                                <i class="fa fa-heart-o" style="border-radius: 50%"></i>
                                            </button>
                                            <button type="button" data-toggle="modal" data-target="#commentWin" data-id="${p4.proid}" data-name = "${p4.proname}" data-uid="${p4.sell_id}" data-uname="${p4.sell_name}"  class="heart btn btn-secondary" title="Comment">
                                                <i class="fa fa-comment" style="border-radius: 50%"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="product-bottom text-center">
                                        <h3 class="mx-auto mt-4" style="width: 250px;height: 75px; object-fit: contain; font-family: Arial">${p4.proname}</h3>
                                        <h5><b>Price Current:</b>
                                            <span class="text-danger font-weight-bold" style="font-size: 30px">$<fmt:formatNumber value="${p4.price_current}" type="number" /></span>
                                        </h5>
                                        <c:if test="${p4.price_now!=0}">
                                            <h5> <b>Price Buy Now:</b>
                                                <span class="text-primary" style="font-size: larger">$<fmt:formatNumber value="${p4.price_now}" type="number"/></span>
                                            </h5>
                                        </c:if>
                                        <h5><b>Start Date:</b>
                                            <fmt:parseDate value="${p4.start_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                            <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                        </h5>
                                        <h5><b>End Date:</b>
                                            <fmt:parseDate value="${p4.end_day }" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                            <span class="text-success" data-countdown="<fmt:formatDate pattern="MM/dd/yyyy HH:mm:ss" value="${parsedDateTime}" />"></span>
                                        </h5>
                                    </div>
                                </div>
                            </c:forEach>
                            <div class="modal fade" id="commentWin" tabindex="-1" aria-labelledby="addCommentWinLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="addCommentWinLabel" style="font-weight: bold; font-family: 'Russo One'">Feedback</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <form method="post" id="feedbackWin" action="${pageContext.request.contextPath}/Feedback/AddWinFeedback" >
                                            <div class="modal-body">
                                                <input type="hidden" name="review_id" value="${authUser.id}">
                                                <input type="hidden" name="review_name" value="${authUser.name}">
                                                <input type="hidden" name="winproname" id="winproname">
                                                <input type="hidden" id="winproid" name="winproid">
                                                <input type="hidden" id="winuid" name="winuid">
                                                <input type="hidden" id="winuname" name="winuname">

                                                <div class="form-group">
                                                    <b class="text-primary"><label id="txtWinProname" class="col-form-label"></label></b>
                                                </div>
                                                <div class="form-group">
                                                    <b class="text-secondary"><label id="txtWinSeller" class="col-form-label"></label></b>
                                                </div>
                                                <div class="form-group">
                                                    <label for="txtwincomment" class="col-form-label">Comment:</label>
                                                    <textarea class="form-control" name="wincomment" id="txtwincomment"></textarea>
                                                </div>
                                                <div class="form-group ">
                                                         <label><input type="radio" name="winlike" checked value="1" > <i class="fa fa-thumbs-up text-primary fa-2x"></i> </label>
                                                        <label><input type="radio" name="winlike" value="0" > <i class="fa fa-thumbs-down text-danger fa-2x"></i></label>

                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                                    <i class="fa fa-times" aria-hidden="true"></i> Close</button>
                                                <button type="submit" class="btn btn-info" >
                                                    <i class="fa fa-check" aria-hidden="true"></i> Save</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>
    </jsp:body>
</t:watchlist>