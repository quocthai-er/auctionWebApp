<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="users" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.User>"/>
<t:manager>
     <jsp:attribute name="js">
        <script>

            $('#updateDob').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
            });
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="title-box bg-danger mt-1 mb-3 w-100 justify-content-center" style="border-radius: 5px;">
            <h2 style="font-family: 'Bauhaus 93'">Bidder Manager</h2>
        </div>
        <div class="tableFixHistory" style="cursor: pointer ; height: 50%">
            <table class="table  table-hover " style="width: 75%; height: 5px; margin: auto">
                <thead>
                <tr>
                    <th scope="col" style="background-color: black"><p style="color: white">ID</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Name</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Email</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Address</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Date of Birth</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Edit</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Upgrade</p></th>
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
                            <c:if test="${u.role == 1}">
                                <tr>
                                    <th scope="col">${u.id}</th>
                                    <th>${u.name}</th>
                                    <th >${u.email}</th>
                                    <th >${u.address}</th>
                                    <fmt:parseDate value="${u.dob}" pattern="yyyy-MM-dd" var="parsedDateTime" type="both" />
                                    <th ><fmt:formatDate pattern="dd/MM/YYYY" value="${parsedDateTime}"/></th>
                                    <th >
                                        <a type="button" class="btn btn-outline-dark btn-sm btn-block w-51" href="${pageContext.request.contextPath}/Admin/EditUser?uid=${u.id}">
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </a>
                                    </th>
                                    <th >
                                        <c:if test="${u.reQuest == 1}">
                                            <a type="button" class="btn btn-outline-success btn-sm btn-block w-50" href="${pageContext.request.contextPath}/Admin/UpgrageSeller?uid=${u.id}">
                                                <i class="fa fa-check" aria-hidden="true"></i>
                                            </a>
                                        </c:if>
                                    </th>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <div class="title-box bg-danger mt-1 mb-3 w-100 justify-content-center" style="border-radius: 5px;">
            <h2 style="font-family: 'Bauhaus 93'">Seller Manager</h2>
        </div>
        <div class="tableFixHistory" style="cursor: pointer; height: 50%">
            <table class="table table-hover" style="width: 75%; height: 5px; margin: auto">
                <thead>
                <tr>
                    <th scope="col" style="background-color: black"><p style="color: white">ID</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Name</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Email</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Address</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Date of Birth</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Edit</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Upgrade</p></th>
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
                            <c:if test="${u.role == 2}">
                                <tr>
                                    <th scope="col">${u.id}</th>
                                    <th scope="col">${u.name}</th>
                                    <th scope="col">${u.email}</th>
                                    <th scope="col">${u.address}</th>
                                    <fmt:parseDate value="${u.dob}" pattern="yyyy-MM-dd" var="parsedDateTime" type="both" />
                                    <th ><fmt:formatDate pattern="dd/MM/YYYY" value="${parsedDateTime}"/></th>
                                    <th scope="col">
                                        <a type="button" class="btn btn-outline-dark btn-sm btn-block w-51 "href="${pageContext.request.contextPath}/Admin/EditUser?uid=${u.id}">
                                            <i class="fa fa-pencil" aria-hidden="true"></i>
                                        </a>
                                    </th>
                                    <th scope="col">
                                        <a type="button" class="btn btn-outline-danger btn-sm btn-block w-50" href="${pageContext.request.contextPath}/Admin/DownSeller?uid=${u.id}">
                                            <i class="fa fa-arrow-down" aria-hidden="true"></i>
                                        </a>
                                    </th>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </jsp:body>
</t:manager>