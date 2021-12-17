<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:account>
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
        <form class=" mx-auto shadow rounded-lg bg-white mt-5 " action="" method="post" id="formLogin">
            <!-- Logo -->
            <div class="text-center mb-3">
                <h3 class="text-infor">Login</h3>
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
                <button type="submit" class="btn btn-info w-75" id="btnLogIn">Login</button>
            </div>
            <div class="text-center mt-2">
                <a class="text-info" href="${pageContext.request.contextPath}/Account/ForgotPassword">
                    Forgot password?
                </a>
            </div>

            <hr class="w-75 mx-auto bg-info">
            <!-- Đăng nhập với Google -->
            <div class="text-center">
                <a class="btn btn-outline-info" href="#" role="button">
                    <i class="fa fa-google-plus mr-3" aria-hidden="true"></i>
                    Login with Google
                </a>
            </div>
            <div class="text-center mt-3">
                Don't have an account?
                <a class="btn btn-outline-info" id="switchRegister" href="${pageContext.request.contextPath}/Account/Register" role="button">
                    Register now
                </a>
            </div>
        </form>
    </jsp:body>
</t:account>
