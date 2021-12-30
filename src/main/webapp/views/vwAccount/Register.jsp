<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
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
    <jsp:attribute name="css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </jsp:attribute>
    <jsp:attribute name="js">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js" integrity="sha512-AIOTidJAcHBH2G/oZv9viEGXRqDNmfdPVPYOYKGy3fti0xIplnlgMHUGfuNRzC6FkzIo0iIxgFnr9RikFxK+sw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script>
            $('#formRegister').on('submit', function (e) {
                e.preventDefault();
                Validator({
                    form: '#formRegister',
                    formGroupSelector: '.form-group',
                    errorSelector: '.form-message',
                    rules: [
                        Validator.isRequired('#registerName', 'Please fill your full name'),
                        Validator.isRequired('#registerAddress', 'Please fill your address'),
                        Validator.isRequired('#registerEmail', 'Please fill your mail correctly'),
                        Validator.isRequired('#registerPassword','Please fill your password'),
                        Validator.isRequired('#registerDob','Please fill your date of birth'),
                        Validator.isRequired('#registerOTP','Please fill your OTP'),
                        Validator.isEmail('#registerEmail','Please fill your mail correctly'),
                        Validator.minLength('#registerPassword',6),
                        Validator.isConfirmed('#registerConfirmPassword',function () {
                            return document.querySelector('#formRegister #registerPassword').value;
                        }, 'Please fill your password correctly')
                    ],
                });
                let response = grecaptcha.getResponse();
                const email = $('#registerEmail').val();
                const otp = $('#registerOTP').val();
                // Check if email exists
                $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?email=' + email, function (data) {
                    if (data === true) {
                        let dob = $('#registerDob').val().toString();
                        let parts = dob.split('/');
                        let d = new Date().getFullYear().toString();
                        if ((parseInt(d) - parseInt(parts[2])) < 18) {
                            swal({
                                title: "Warning!",
                                text: "You are under 18 years old!",
                                icon: "warning",
                                button: "OK!",
                                closeOnClickOutside: false,
                            });
                        } else {
                        // Check captcha
                        $.getJSON('${pageContext.request.contextPath}/Account/IsVerifyCaptcha?g-recaptcha-response=' + response, function (data) {

                            if(data === false) {
                                swal({
                                    title: "Warning!",
                                    text: "Please verify your captcha!",
                                    icon: "warning",
                                    button: "OK!",
                                    closeOnClickOutside: false,
                                });
                                grecaptcha. reset();
                            } else {
                                // Check OTP
                                if (otp !== '') {
                                    $.getJSON('${pageContext.request.contextPath}/Account/SendOTP?email=' + email+'&otp=' +otp, function (otpData) {
                                        if (otpData === false) {
                                            swal({
                                                title: "Wrong OTP!",
                                                text: "Your OTP is invalid. Please try again!",
                                                icon: "error",
                                                button: "OK!",
                                                dangerMode: true,
                                                closeOnClickOutside: false,
                                            });
                                            grecaptcha. reset();
                                        } else {
                                            $('#formRegister').off('submit').submit();
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
                                    grecaptcha. reset();
                                }
                            }
                        });
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
                        grecaptcha. reset();
                    }
                });
            });
            // Send OTP to client email
            $('#btnOTP').on('click', function () {
                $('#btnOTP').html('<div class="spinner-grow text-primary" role="status"> <span class="sr-only">Loading...</span></div>');
                if ($('#registerEmail').val() == 0)
                {
                    swal({
                        title: "Invalid email!",
                        text: "Please fill your valid email!",
                        icon: "warning",
                        button: "OK!",
                    });
                } else {
                    const otp = $('#registerOTP').val();
                    const email = $('#registerEmail').val();
                    $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?email=' + email, function (data) {
                        if (data === true) {
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

            $('#registerDob').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
            })

            $('registerName').select();
        </script>
    </jsp:attribute>
    <jsp:body>
        <form class="mx-auto shadow rounded-lg bg-white mt-5 " action="" method="post" id="formRegister">
            <!-- Logo -->
            <div class="text-center mb-3">
                <h3 class="text-primary" style="font-family: 'Russo One',sans-serif">Register</h3>
            </div>

            <!-- Họ và tên va dob -->
            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Full name" class="form-control w-75" id="registerName" name="name">
                <span class="form-message" style="margin-right: 185px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="text" name="dob" placeholder="Date of birth (dd/mm/yyyy)" class="form-control w-75" id="registerDob">
                <span class="form-message" style="margin-right: 160px;"></span>
            </div>

            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Address" class="form-control w-75" id="registerAddress" name="address">
                <span class="form-message" style="margin-right: 185px;"></span>
            </div>

            <!-- Email và password, OTP -->
            <div class="form-group justify-content-center d-flex">
                <div class="justify-content-center d-flex">
                    <input type="text" placeholder="Email" name="email" class="form-control mr-1 " style="width: 240px" id="registerEmail">
                    <button type="button" name="button" class="btn btn-primary p-0" style="width: 80px" id="btnOTP">Send OTP</button>
                </div>
                <span class="form-message" style="margin-right: 215px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="password" name="rawpwd" placeholder="Password" class="form-control w-75" id="registerPassword">
                <span class="form-message" style="margin-right: 180px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="password" placeholder="Confirm password" class="form-control w-75" id="registerConfirmPassword">
                <span class="form-message" style="margin-right: 130px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="OTP" name="otp" class="form-control w-75" id="registerOTP">
                <span class="form-message" style="margin-right: 215px;"></span>
            </div>

            <!-- reCaptcha -->
            <div class="form-group justify-content-center d-flex">
                <div class="g-recaptcha" data-sitekey="6LfnC1IdAAAAABU-jCMtW_w5y6dbyCbFHm05XZVZ"></div>
            </div>

            <!-- Button đăng ký -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary w-75" id="btnRegister">Register</button>
            </div>

            <hr class="w-75 mx-auto bg-primary">
            <!-- Quay lai Home -->
            <div class="text-center">
                <a class="btn btn-outline-info" href="${pageContext.request.contextPath}/Home" role="button">
                    <i class="fa fa-home" aria-hidden="true"></i> Home
                </a>
            </div>
            <div class="text-center mt-3">
                You already have an account?
                <a class="btn btn-outline-danger" id="switchLogin"  href="${pageContext.request.contextPath}/Account/Login" role="button">
                    Login now
                </a>
            </div>
        </form>
    </jsp:body>
</t:login_re>

