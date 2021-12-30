<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="category" scope="request" type="com.ute.auctionwebapp.beans.Category"/>

<t:manager>
    <jsp:body>
        <form action="" method="post">
            <div class="card w-50 mx-auto mt-3">
                <h4 class="card-header text-light" style="font-family: 'Russo One',sans-serif ; background-image: url('https://t3.ftcdn.net/jpg/03/05/08/54/360_F_305085456_qVPV5YYXv9kQoIndzZebtyR4ITmuX9dE.jpg');background-size: cover">
                    Category
                </h4>
                <div class="card-body">
                    <div class="form-group">
                        <label for="txtCatID">CategoryID</label>
                        <input type="text" class="form-control" id="txtCatID" name="CatID" readonly value="${category.catid}">
                    </div>
                    <div class="form-group">
                        <label for="txtCatName">CategoryName</label>
                        <input type="text" class="form-control" id="txtCatName" name="CatName" autofocus value="${category.catname}">
                    </div>
                    <c:if test="${hasError}">
                        <div class="alert alert-danger alert-dismissible fade show w-75 mx-auto" role="alert">
                            <strong>Error!</strong> ${errorMessage}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                </div>
                <div class="card-footer">
                    <a class="btn btn-outline-success" href="${pageContext.request.contextPath}/Admin/Category" role="button">
                        <i class="fa fa-backward" aria-hidden="true"></i>
                        List
                    </a>
                    <button type="submit" class="btn btn-danger" formaction="${pageContext.request.contextPath}/Admin/Delete">
                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                        Delete
                    </button>
                    <button type="submit" class="btn" formaction="${pageContext.request.contextPath}/Admin/Update" style="background-color: darkblue; color: white">
                        <i class="fa fa-check" aria-hidden="true"></i>
                        Save
                    </button>
                </div>
            </div>
        </form>
    </jsp:body>
</t:manager>