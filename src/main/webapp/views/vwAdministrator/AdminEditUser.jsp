<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="users" scope="request" type="com.ute.auctionwebapp.beans.User"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<t:AdminEditUser>
<jsp:attribute name="css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css" integrity="sha512-f0tzWhCwVFS3WeYaofoLWkTP62ObhewQ1EZn65oSYDZUg1+CyywGKkWzm8BxaJj5HGKI72PnMH9jYyIFz+GH7g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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