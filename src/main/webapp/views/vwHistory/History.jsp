<%--
  Created by IntelliJ IDEA.
  User: Tri
  Date: 12/9/2021
  Time: 8:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="histories" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.History>"/>

<t:history>
     <jsp:attribute name="js">
        <script></script>
    </jsp:attribute>
    <jsp:body>
        <div class="title-box bg-info mt-1 mb-3 w-100 justify-content-center" style="border-radius: 5px;">
            <h2>History</h2>
        </div>
        <div class="tableFixHistory" style="cursor: pointer">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">Time</th>
                    <th scope="col">Product</th>
                    <th scope="col">Price</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${histories.size()==0}">
                        <div class="card-body">
                            <p class="card-text">No data</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${histories}" var="h">
                            <tr>
                                <td>
                                    <fmt:parseDate value="${h.buy_day}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDateTime" type="both" />
                                    <fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${ parsedDateTime }" />
                                </td>
                                <td>${h.proname}</td>
                                <td>$ <fmt:formatNumber value="${h.price}" type="number" /></td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </jsp:body>
</t:history>