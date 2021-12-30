<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<t:login_re>
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
            // Log in form
            Validator({
                form: '#formLogin',
                formGroupSelector: '.form-group',
                errorSelector: '.form-message',
                rules: [
                    Validator.isRequired('#loginEmail', 'Please fill your mail'),
                    Validator.isRequired('#loginPassword','Please fill your password'),
                ],
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
        <form class=" mx-auto shadow rounded-lg bg-white mt-5 " action="" method="post" id="formLogin">
            <!-- Logo -->
            <div class="text-center mb-3">
                <h3 class="text-primary" style="font-family: 'Russo One',sans-serif">Login</h3>
                <i class="fa fa-user-circle fa-3x mx-auto" aria-hidden="true"></i>
            </div>

                <%--Alert--%>
            <c:if test="${hasError}">
                <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                    <strong>Login failed!</strong> ${errorMessage}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>

            <!-- Email và password -->
            <div class="form-group justify-content-center d-flex">
                <input type="text" placeholder="Email" name="email" class="form-control w-75" id="loginEmail" autofocus >
                <span class="form-message" style="margin-right: 215px;"></span>
            </div>
            <div class="form-group justify-content-center d-flex">
                <input type="password" placeholder="Password" name="password" class="form-control w-75" id="loginPassword">
                <span class="form-message" style="margin-right: 185px;"></span>
            </div>


            <!-- Button đăng nhập -->
            <div class="text-center">
                <button type="submit" class="btn btn-primary w-75" id="btnLogIn">Login</button>
            </div>
            <div class="text-center mt-2">
                <a class="text-primary" href="${pageContext.request.contextPath}/Account/ForgotPassword">
                    Forgot password?
                </a>
            </div>

            <hr class="w-75 mx-auto bg-primary">
            <!-- Đăng nhập với Google -->
            <div class="text-center">
                    <%--Sửa port ở đây--%>
                <a class="btn btn-outline-danger" href="https://accounts.google.com/o/oauth2/auth?scope=https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email&redirect_uri=http://localhost:8082/auctionWebApp/Account/GoogleLogin&response_type=code
    &client_id=968786308056-9k67nqlp92f8m7ak4060b75n1pjsfj0n.apps.googleusercontent.com&approval_prompt=force" role="button">
                    <i class="fa fa-google-plus mr-3" aria-hidden="true"></i>
                    Login with Google
                </a>
            </div>
            <div class="text-center mt-3">
                Don't have an account?
                <a class="btn btn-outline-success" id="switchRegister" href="${pageContext.request.contextPath}/Account/Register" role="button">
                    Register now
                </a>
            </div>
        </form>
    </jsp:body>
</t:login_re>
