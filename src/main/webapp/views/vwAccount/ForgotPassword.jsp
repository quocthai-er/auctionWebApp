<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:account>
    <jsp:attribute name="js">
        <script>
            // Forgot password form
            $('#formRegister').on('submit', function (e) {
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
                $.getJSON('${pageContext.request.contextPath}/Account/IsAvailable?email=' + email, function (data) {
                    if (data === false) {
                        // check otp
                        $.getJSON('${pageContext.request.contextPath}/Account/SendOTP?email=' + email+'&otp=' +otp, function (otpData) {
                            $('#btnOTP').html('Send password reset email')
                            if (otpData === false) {
                                swal({
                                    title: "Wrong OTP!",
                                    text: "Your OTP is invalid. Please try again!",
                                    icon: "error",
                                    button: "OK!",
                                    dangerMode: true,
                                    closeOnClickOutside: false,
                                });
                            } else {
                                $('#formForgot').off('submit').submit();
                                alert('Password Reset Successfully');
                            }
                        });
                    } else {
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
            <div class="text-center mb-5">
                <h3>Forgot Password</h3>
            </div>

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
</t:account>
