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
            <h2 style="font-family: 'Bauhaus 93'">Category Manager</h2>
        </div>
        <div style="text-align: center; margin: auto; display: flex; display: grid; width: 12%">
        <a class="btn btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category/AddCategory" role="button">
            <i class="fa fa-plus" aria-hidden="true"></i>
            Add Category
        </a>
            &nbsp;
        </div>
        <div class="tableFixHistory" style="cursor: pointer">
            <table class="table table-hover" style="width: 50%; height: 70%; margin-left: auto; margin-right: auto">
                <thead>
                <tr>
                    <th scope="col" style="background-color: black"><p style="color: white">CatID</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">CatName</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Edit</p></th>
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
                                <th scope="col">
                                    <a type="button" class="btn btn-outline-dark btn-sm btn-block w-50">
                                        <i class="fa fa-pencil" aria-hidden="true"></i>
                                    </a>
                                </th>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </jsp:body>
</t:manager>
