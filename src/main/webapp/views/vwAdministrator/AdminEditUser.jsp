<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="users" scope="request" type="com.ute.auctionwebapp.beans.User"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:AdminEditUser>
<jsp:attribute name="css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            // $('#formUpdate').on('submit', function (e) {
            //     e.preventDefault();
                Validator({
                    form: '#formUpdate',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#updateName', 'Please fill your full name'),
                        Validator.isRequired('#updateAddress', 'Please fill your address'),
                        Validator.isRequired('#updateDob','Please fill your date of birth')
                    ],
                });
            //     $('#formUpdate').off('submit').submit();
            // });

            $('#updateDob').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
            });
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

        <form class="mx-auto shadow rounded-lg bg-white mt-5 " action="" method="post" id="formUpdate" >
            <!-- Logo -->
            <div class="text-center mb-3">
                <h3 class="text-primary" style="font-family: 'Russo One',sans-serif">Edit User</h3>
                <input type="hidden" name="uid" value="${users.id}">
            </div>

            <!-- Họ và tên va dob -->
            <div class="form-group d-flex">
                <input type="text" placeholder="Full name" class="form-control w-75" id="updateName" name="name" value="${users.name}">
                <span class="form-message" style="margin-right: 100px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">

                <fmt:parseDate value="${users.dob}" pattern="yyyy-MM-dd" var="parsedDateTime" type="both" />
                <input type="text" name="dob" placeholder="Date of birth (d/m/Y)" class="form-control w-75" id="updateDob"

                       value="<fmt:formatDate pattern="dd/MM/YYYY" value="${parsedDateTime}"/>"
                    <%-- value="${authUser.dob}"--%>
                >
                <span class="form-message" style="margin-right: 160px;"></span>
            </div>

            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Address" class="form-control w-75" id="updateAddress" name="address" value="${users.address}">
                <span class="form-message" style="margin-right: 185px;"></span>
            </div>
            <c:if test="${hasSuccess}">
                <div class="alert alert-success alert-dismissible fade show w-75 mx-auto" role="alert">
                    <strong>${Message}</strong>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>
            <div class="d-flex justify-content-center">
                <div class="text-center mr-3">
                    <button type="submit" class="btn btn-success w-100" id="btnReset" formaction="${pageContext.request.contextPath}/Admin/User/ResetPassword?email=${users.email}">Reset Password</button>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary w-100" id="btnUpdate">Save </button>
                </div>
            </div>
            <div class="text-center mt-3">
                <a class="btn btn-outline-danger" id="switchLogin" href="${pageContext.request.contextPath}/Admin/User" role="button">
                    Return Manage User
                </a>
            </div>
        </form>
    </jsp:body>
</t:AdminEditUser>