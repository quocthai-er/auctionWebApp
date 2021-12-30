<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<t:login_re>
    <jsp:attribute name="js">
        <script>
            // Forgot password form
            $('#formForgot').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#formForgot',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#forgotName', 'Please fill your mail'),
                    ],
                });
                //Check when click send new password to email
                const email = $('#forgotName').val();
                const otp = $('#forgotOTP').val();
                $('#btnForgot').html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> &nbsp; Loading...')
                // check if email is exists
                if ($('#forgotName').val() == 0) {
                    swal({
                        title: "Invalid email!",
                        text: "Please fill your valid email!",
                        icon: "warning",
                        button: "OK!",
                    });
                    $('#btnForgot').html('Send password reset email')
                } else {
                    $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?email=' + email, function (data) {
                    if (data === false) {
                        // check otp
                        if (otp !== '') {
                            $.getJSON('${pageContext.request.contextPath}/Account/SendOTP?email=' + email+'&otp=' +otp, function (otpData) {
                                $('#btnOTP').html('Send again')
                                if (otpData === false) {
                                    swal({
                                        title: "Wrong OTP!",
                                        text: "Your OTP is invalid. Please try again!",
                                        icon: "error",
                                        button: "OK!",
                                        dangerMode: true,
                                        closeOnClickOutside: false,
                                    });
                                    $('#forgotOTP').empty();
                                    $('#btnForgot').html('Send password reset email')
                                } else {
                                    $('#formForgot').off('submit').submit();
                                    alert('Password Reset Processing...');
                                }
                            });
                        } else {
                            swal({
                                title: "Wrong OTP!",
                                text: "Your OTP is invalid. Please try again!",
                                icon: "error",
                                button: "OK!",
                                dangerMode: true,
                                closeOnClickOutside: false,
                            });
                            $('#btnForgot').html('Send password reset email')
                        }
                    } else {
                        swal({
                            title: "Invalid email!",
                            text: "Your email is not available. Please try again!",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                        $('#btnForgot').html('Send password reset email')
                    }
                });
                }
            });

            // Send OTP to client email
            $('#btnOTP').on('click', function () {
                if ($('#forgotName').val() == 0)
                {
                    swal({
                        title: "Invalid email!",
                        text: "Please fill your valid email!",
                        icon: "warning",
                        button: "OK!",
                    });
                } else {
                    $('#btnOTP').html('<div class="spinner-grow text-info" role="status"> <span class="sr-only">Loading...</span></div>');
                    const otp = $('#forgotOTP').val();
                    const email = $('#forgotName').val();
                    $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?email=' + email, function (data) {
                        if (data === false) {
                            $.getJSON('${pageContext.request.contextPath}/Account/SendOTP?email=' + email+'&otp=' +otp, function (data) {
                                $('#btnOTP').html('Send OTP')
                                if (data === false) {
                                    swal({
                                        title: "Failed!",
                                        text: "Please click send OTP to your email again!",
                                        icon: "error",
                                        button: "OK!",
                                    });
                                } else swal({
                                    title: "Successfully!",
                                    text: "Your OTP has been sent to your email!",
                                    icon: "success",
                                    button: "OK!",
                                });
                            });
                        } else {
                            $('#btnOTP').html('Send OTP')
                            swal({
                                title: "Invalid email!",
                                text: "Your email is not available. Please try again!",
                                icon: "error",
                                button: "OK!",
                                dangerMode: true,
                                closeOnClickOutside: false,
                            });
                        }
                    });
                }
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <form action="" method="post" class=" mx-auto shadow rounded-lg bg-white mt-5 " id="formForgot">
            <!-- Logo -->
            <div class="text-center mb-5 text-primary" style="font-family: 'Russo One',sans-serif">
                <h3>Forgot Password</h3>
            </div>

            <c:if test="${hasError}">
                <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                    <strong>Login failed!</strong> ${errorMessage}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>

            <!-- Email and button send OTP to email-->
            <div class="form-group justify-content-center d-flex">
                <div class="justify-content-center d-flex">
                    <input type="text" placeholder="Email" name="email" class="form-control mr-1 " style="width: 240px" id="forgotName">
                    <button type="button" name="button" class="btn btn-info p-0" style="width: 80px" id="btnOTP">Send OTP</button>
                </div>
            <span class="form-message" style="margin-right: 215px;"></span>
            </div>

            <%--OTP input--%>
            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="OTP" name="otp" class="form-control" style="width: 240px; margin-right: 80px" id="forgotOTP">
                <span class="form-message" style="margin-right: 215px;"></span>
            </div>

            <!-- Button send forgot password request -->
            <div class="text-center">
                <button id="btnForgot" type="submit" class="btn btn-info w-75" name="button" value="btnForgot">Send password reset email</button>
            </div>

            <hr class="w-75 mx-auto bg-info">
            <!-- Back to login page -->
            <div class="text-center">
                <a class="btn btn-outline-info" href="${pageContext.request.contextPath}/Account/Login" role="button">
                    <i class="fa fa-arrow-left mr-3" aria-hidden="true"></i>
                    Back to login page
                </a>
            </div>
        </form>
    </jsp:body>
</t:login_re>
