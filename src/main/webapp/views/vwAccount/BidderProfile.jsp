<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<jsp:useBean id="authUser" scope="session" type="com.ute.auctionwebapp.beans.User"/>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:bidder>

    <jsp:body>

        <div class="card mx-auto justify-content-center d-flex mt-5" style="width: 30rem;">
            <div class="text-center mt-3">
                <h3 class="text-info">Profile</h3>
            </div>
            <i class="fa fa-user-circle fa-3x mx-auto" aria-hidden="true"></i>
            <div class="card-body justify-content-center d-flex">
                <h5 class="card-title"><b>${authUser.name}</b> </h5>
            </div>
            <ul class="list-group list-group-flush">
                    <li class="list-group-item"><b>Email:</b> ${authUser.email} </li>
                    <li class="list-group-item"><b>Address:</b> ${authUser.address} </li>
                <fmt:parseDate value="${authUser.dob}" pattern="yyyy-MM-dd" var="parsedDateTime" type="both" />
                <li class="list-group-item"><b>Birthday: </b><fmt:formatDate pattern="dd/MM/yyyy" value="${parsedDateTime}"/></li>
            </ul>
            <div class="card-body justify-content-center d-flex">
                <a href="${pageContext.request.contextPath}/Account/EditProfile" class=" btn btn-outline-primary mr-1">
                    Edit Information
                    <i class="fa fa-pencil" aria-hidden="true"></i>
                </a>
                <a href="${pageContext.request.contextPath}/Account/ChangePwd" class="btn btn-outline-primary ml-1">
                    Change Password
                    <i class="fa fa-key" aria-hidden="true"></i>
                </a>
            </div>
        </div>
    </jsp:body>
</t:bidder>

