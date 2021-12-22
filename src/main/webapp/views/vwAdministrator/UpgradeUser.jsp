
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="users" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.User>"/>

<t:manager>
     <jsp:attribute name="js">
        <script></script>
    </jsp:attribute>
    <jsp:body>
        <div class="title-box bg-info mt-1 mb-3 w-100 justify-content-center" style="border-radius: 5px;">
            <h2>User Manager</h2>
        </div>
        <div class="tableFixHistory" style="cursor: pointer">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Address</th>
                    <th scope="col">Dob</th>
                    <th scope="col">Role</th>
                    <th scope="col">Request</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${users.size()==0}">
                        <div class="card-body">
                            <p class="card-text">No data</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${users}" var="u">
                            <tr>
                                <th scope="col">${u.id}</th>
                                <th scope="col">${u.name}</th>
                                <th scope="col">${u.email}</th>
                                <th scope="col">${u.address}</th>
                                <th scope="col">${u.dob}</th>
                                <th scope="col">${u.role}</th>
                                <th scope="col">${u.reQuest}</th>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </jsp:body>
</t:manager>