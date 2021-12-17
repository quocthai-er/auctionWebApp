
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="categories" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.Category>"/>
<t:manager>
    <jsp:attribute name="js">
        <script></script>
    </jsp:attribute>
    <jsp:body>
        <div class="title-box bg-info mt-1 mb-3 w-100 justify-content-center" style="border-radius: 5px;">
            <h2>Category Manager</h2>
        </div>
        <div class="tableFixHistory" style="cursor: pointer">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">CatID</th>
                    <th scope="col">CatName</th>
                    <th scope="col">Level</th>
                    <th scope="col">PID</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${categoriess.size()==0}">
                        <div class="card-body">
                            <p class="card-text">No data</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${categories}" var="c">
                            <tr>
                                <th scope="col">${c.catid}</th>
                                <th scope="col">${c.catname}</th>
                                <th scope="col">${c.level}</th>
                                <th scope="col">${c.pid}</th>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </jsp:body>
</t:manager>
