<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User" />
<jsp:useBean id="catChild" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Category>"/>
<t:watchlist>
    <jsp:attribute name="css">
        <link href="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/css/fileinput.min.css" media="all" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <style>
            .bo-0{
                border-top-left-radius: 0px !important;
                border-bottom-left-radius: 0px !important;
                border-top-right-radius: 0px !important;
                border-bottom-right-radius: 0px !important;
            }

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
        <script src="https://cdn.tiny.cloud/1/v0ozcj27hfm49t3m4umzfpgom0bhbjjl5xxgin0phrhz3385/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.2.5/js/fileinput.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/themes/fa/theme.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.2.5/js/locales/uk.min.js"></script>
        <script src="${pageContext.request.contextPath}/public/js/validator.js"></script>

        <script>
            //validate when add prodct
            $('#frmAddProduct').on('submit', function (e) {
                e.preventDefault();
                tinymce.triggerSave();
                Validator({
                    form: '#frmAddProduct',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#txtProName', 'Please fill your product name'),
                        Validator.isRequired('#txtStartPrice', 'Please fill your starting bid'),
                        Validator.isRequired('#txtStepPrice', 'Please fill your bid increment'),
                        Validator.isRequired('#txtEndDay', 'Please fill your ending date'),
                        Validator.isRequired('#txtTinyDes', 'Please fill your tiny description'),
                        Validator.isRequired('#txtFullDes', 'Please fill your full description'),
                        Validator.isRequired('#txtCat', 'Please fill your category'),
                        Validator.isRequired('#pics', 'Please upload picture products')
                    ],
                });
                check = $('#txtEndDay').val();
                let parts = check.split('/');
                let d = new Date()
                x = new Date(parts[2],parts[1]-1,parts[0]);

                if ((d-x)>=0) {
                    swal({
                        title: "Warning!",
                        text: "Please check Ending date!",
                        icon: "warning",
                        button: "OK!",
                        closeOnClickOutside: false,
                    });
                } else {
                    $('#frmAddProduct').off('submit').submit();
                }
            })

            tinymce.init({
                selector: '#txtFullDes',
                height: 250,
                plugins: 'paste image link autolink lists table media',
                menubar: false,
                toolbar: [
                    'undo redo | bold italic underline strikethrough | numlist bullist | alignleft aligncenter alignright | forecolor backcolor | table link image media'
                ],
            });
            tinymce.init({
                selector: '#txtTinyDes',
                height: 150,
                plugins: 'paste image link autolink lists table media',
                menubar: false,
                toolbar: [
                    'undo redo | bold italic underline strikethrough | numlist bullist | alignleft aligncenter alignright | forecolor backcolor | table link image media'
                ],
            });

            $('#txtEndDay').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
            })
            $('#pics').fileinput({
                msgPlaceholder: 'Please choose main image first...And at least 3 more images',
                theme: 'fa',
                minFileCount: 4,
                maxFileCount: 5,
                dropZoneEnabled: false,
                allowedFileExtensions: ['jpg'],
                captionClass: 'bo-0'
            });

            $('#txtProName').focus();

            //show alert when add product
            if (${success}) {
                swal({
                    title: "Successfully!",
                    text: "Successfully added product!",
                    icon: "success",
                    button: "OK!",
                    closeOnClickOutside: false,
                });
            } else {

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

        <h3 class="text-center mt-3 bg-info text-light w-75 mx-auto" style="font-family: 'Russo One'; background-image: url('https://t3.ftcdn.net/jpg/03/05/08/54/360_F_305085456_qVPV5YYXv9kQoIndzZebtyR4ITmuX9dE.jpg'); background-size: contain">Add Product</h3>

        <div class="card-body w-75 mx-auto" style="background-color: white">
            <form method="post" id="frmAddProduct" enctype="multipart/form-data">
                <input type="hidden" name="uid" value="${authUser.id}">
                <div class="form-group">
                    <label for="txtProName" style="font-weight: bold">Product name:</label>
                    <input type="text" class="form-control" name="proname" id="txtProName">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtCat" style="font-weight: bold">Product name:</label>
                    <select name="catid" id="txtCat" class="w-100" style="border-radius: 25px; border-color: orange; height: 40px">
                        <option value="">Select a Category</option>
                        <c:forEach items="${catChild}" var="catChild">
                            <option value="${catChild.catid}">${catChild.catname}</option>
                        </c:forEach>
                    </select>
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtStartPrice" style="font-weight: bold">Starting bid:</label>
                    <input type="number" class="form-control " name="start_price" id="txtStartPrice">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtStepPrice" style="font-weight: bold">Bid Increment: </label>
                    <input type="number" class="form-control" name="step_price" id="txtStepPrice">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtBuyPrice" style="font-weight: bold">Buy now price:</label>
                    <input type="number" class="form-control" name="buy_price" id="txtBuyPrice">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtEndDay" style="font-weight: bold">Ending Date:</label>
                    <input type="text" class="form-control" name="end_day" id="txtEndDay">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtTinyDes" style="font-weight: bold">Tiny Description:</label> <br>
                    <input type="text" class="form-control" name="tinydes" id="txtTinyDes">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtFullDes" style="font-weight: bold">Full Description:</label>
                    <input type="text" class="form-control" name="fulldes" id="txtFullDes">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <input type="file" name="pics[]" id="pics" multiple>
                    <span class="form-message" ></span>
                </div>
                <div class="form-group form-check">
                    <input type="checkbox" name="auto" class="form-check-input" id="chkAutoRenew">
                    <input type="hidden" name="auto" value="off" >
                    <label class="form-check-label" for="chkAutoRenew">Auto-renew? </label>
                    <span class="d-inline-block " tabindex="0" data-toggle="tooltip" title="When there is a new auction before the end of 5 minutes, the product will automatically renew for another 10 minutes. Default is off!">
                <i class="fa fa-question-circle text-secondary" aria-hidden="true"></i>
                </span>
                </div>
                <div class="form-group form-check">
                    <input type="checkbox" name="allow_bid" class="form-check-input" id="chkAllowBid">
                    <input type="hidden" name="allow_bid" value="off" >
                    <label class="form-check-label" for="chkAllowBid">Only bidders with ratings above 80% are allowed to bid ? </label>
                    <span class="d-inline-block " tabindex="0" data-toggle="tooltip" title="Default is off!">
                <i class="fa fa-question-circle text-primary" aria-hidden="true"></i>
                </span>
                </div>
                <button type="submit" class="btn w-100 text-light" style="background-color: darkblue">Add Product</button>
            </form>
        </div>

    </jsp:body>
</t:watchlist>