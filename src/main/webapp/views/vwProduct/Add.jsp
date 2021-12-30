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
        <h3 class="text-center mb-3 mt-3 bg-info text-light">Add Product</h3>

        <div class="w-75 mx-auto">
            <form method="post" id="frmAddProduct" enctype="multipart/form-data">
                <input type="hidden" name="uid" value="${authUser.id}">
                <div class="form-group">
                    <label for="txtProName">Product name</label>
                    <input type="text" class="form-control" name="proname" id="txtProName">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtCat">Product name</label>
                    <select name="catid" id="txtCat" class="w-100" style="border-radius: 25px; border-color: orange; height: 40px">
                        <option value="">Select a Category</option>
                        <c:forEach items="${catChild}" var="catChild">
                            <option value="${catChild.catid}">${catChild.catname}</option>
                        </c:forEach>
                    </select>
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtStartPrice">Starting bid</label>
                    <input type="number" class="form-control " name="start_price" id="txtStartPrice">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtStepPrice">Bid Increment </label>
                    <input type="number" class="form-control" name="step_price" id="txtStepPrice">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtBuyPrice">Buy now price</label>
                    <input type="number" class="form-control" name="buy_price" id="txtBuyPrice">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtEndDay">Ending Date</label>
                    <input type="text" class="form-control" name="end_day" id="txtEndDay">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtTinyDes">Tiny Description</label> <br>
                    <input type="text" class="form-control" name="tinydes" id="txtTinyDes">
                    <span class="form-message" ></span>
                </div>
                <div class="form-group">
                    <label for="txtFullDes">Full Description</label>
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
                <i class="fa fa-question-circle text-secondary" aria-hidden="true"></i>
                </span>
                </div>
                <button type="submit" class="btn btn-info w-100">Add product</button>
            </form>
        </div>

    </jsp:body>
</t:watchlist>