<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>
<style>
    body
    {
        height: 100vh;
    }
</style>
<t:EditUser>
    <jsp:attribute name="js">
        <script>

            Validator({
                form: '#formChangePwd',
                formGroupSelector: '.form-group',
                errorSelector: '.form-message',
                rules: [
                    Validator.isRequired('#changeNewPassword', 'Please fill your new password '),
                    Validator.isRequired('#changePassword','Please fill your password'),
                ],
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="container-fluid h-100 mt-5">
        <div class="row h-100 justify-content-center align-items-center mt-5">
            <form class="h-100 mx-auto shadow rounded-lg bg-white " action="" method="post" id="formChangePwd">
                <!-- Logo -->
                <div class="text-center mb-3">
                    <h3>Change Password</h3>
                </div>
                    <%--Alert--%>
                <c:if test="${hasError}">
                    <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                        <strong>Change failed!</strong> ${errorMessage}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>
                <c:if test="${success}">
                    <div class="alert alert-success alert-dismissible fade show w-75 mx-auto " >
                        <strong> Change Success !</strong>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:if>

                <!-- Email và password -->
                <div class="form-group justify-content-center d-flex">
                    <input type="hidden" name="uid" value="${authUser.id}">
                    <input type="password" placeholder="Password" name="password" class="form-control w-75" id="changePassword" autofocus >
                    <span class="form-message" style="margin-right: 215px;"></span>
                </div>
                <div class="form-group justify-content-center d-flex">
                    <input type="password" placeholder="New Password" name="newpassword" class="form-control w-75" id="changeNewPassword">
                    <span class="form-message" style="margin-right: 185px;"></span>
                </div>

                <!-- Button change -->
                <div class="text-center">
                    <button type="submit" class="btn btn-info w-75" id="btnChange">Save</button>
                </div>
                <hr class="w-75 mx-auto bg-info">
                    <div class="text-center mt-3">
                        <a class="text-info" href="${pageContext.request.contextPath}/Account/ForgotPassword">
                            Forgot password?
                        </a>
                    </div>

                    <div class="text-center mt-3">
                        <c:choose>
                            <c:when test="${authUser.role == 1}"><a class="btn btn-outline-info" id="switchLogin" href="${pageContext.request.contextPath}/Account/BidderProfile" role="button">
                                Return Profile
                            </a></c:when>
                            <c:when test="${authUser.role == 0}"><a class="btn btn-outline-info" id="switchLogin" href="${pageContext.request.contextPath}/Account/Profile" role="button">
                                Return Profile
                            </a></c:when>
                            <c:otherwise>
                                <a class="btn btn-outline-info" id="switchLogin" href="${pageContext.request.contextPath}/Account/SellerProfile" role="button">
                                    Return Profile
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
            </form>
        </div>
        </div>

    </jsp:body>
</t:EditUser>
