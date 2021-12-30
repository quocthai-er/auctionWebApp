<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="users" scope="request" type="java.util.List<com.ute.auctionwebapp.beans.User>"/>


<t:manager>
    <jsp:attribute name="css">
        <style>
            body{
                background-image: url("https://cdn.tgdd.vn/mwgcart/mwg-site/ContentMwg/images/noel/BG-min.png?v=2&fbclid=IwAR0GDK8iX1hJ5pGL0sqMAr7t8UlbK2XVlOKT73L1wWfkYXqa3vDspcMYBMs");
                background-size: cover;
                background-color: #daf5ff !important;
                background-attachment: fixed;
            }
    /* customizable snowflake styling */
    .snowflake {
        color: #fff;
        font-size: 1em;
        font-family: Arial, sans-serif;
        text-shadow: 0 0 5px #000;
    }

    @-webkit-keyframes snowflakes-fall{0%{top:-10%}100%{top:100%}}@-webkit-keyframes snowflakes-shake{0%,100%{-webkit-transform:translateX(0);transform:translateX(0)}50%{-webkit-transform:translateX(80px);transform:translateX(80px)}}@keyframes snowflakes-fall{0%{top:-10%}100%{top:100%}}@keyframes snowflakes-shake{0%,100%{transform:translateX(0)}50%{transform:translateX(80px)}}.snowflake{position:fixed;top:-10%;z-index:9999;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;cursor:default;-webkit-animation-name:snowflakes-fall,snowflakes-shake;-webkit-animation-duration:10s,3s;-webkit-animation-timing-function:linear,ease-in-out;-webkit-animation-iteration-count:infinite,infinite;-webkit-animation-play-state:running,running;animation-name:snowflakes-fall,snowflakes-shake;animation-duration:10s,3s;animation-timing-function:linear,ease-in-out;animation-iteration-count:infinite,infinite;animation-play-state:running,running}.snowflake:nth-of-type(0){left:1%;-webkit-animation-delay:0s,0s;animation-delay:0s,0s}.snowflake:nth-of-type(1){left:10%;-webkit-animation-delay:1s,1s;animation-delay:1s,1s}.snowflake:nth-of-type(2){left:20%;-webkit-animation-delay:6s,.5s;animation-delay:6s,.5s}.snowflake:nth-of-type(3){left:30%;-webkit-animation-delay:4s,2s;animation-delay:4s,2s}.snowflake:nth-of-type(4){left:40%;-webkit-animation-delay:2s,2s;animation-delay:2s,2s}.snowflake:nth-of-type(5){left:50%;-webkit-animation-delay:8s,3s;animation-delay:8s,3s}.snowflake:nth-of-type(6){left:60%;-webkit-animation-delay:6s,2s;animation-delay:6s,2s}.snowflake:nth-of-type(7){left:70%;-webkit-animation-delay:2.5s,1s;animation-delay:2.5s,1s}.snowflake:nth-of-type(8){left:80%;-webkit-animation-delay:1s,0s;animation-delay:1s,0s}.snowflake:nth-of-type(9){left:90%;-webkit-animation-delay:3s,1.5s;animation-delay:3s,1.5s}.snowflake:nth-of-type(10){left:25%;-webkit-animation-delay:2s,0s;animation-delay:2s,0s}.snowflake:nth-of-type(11){left:65%;-webkit-animation-delay:4s,2.5s;animation-delay:4s,2.5s}
</style>
    </jsp:attribute>
     <jsp:attribute name="js">
        <script>

            $('#updateDob').datetimepicker({
                format: 'd/m/Y',
                timepicker: false,
            });
            function forward() {
                if ($('#tableFixHistory1').hasClass('d-none')) {
                    $('#tableFixHistory1').removeClass('d-none')
                    $('#tableFixHistory2').addClass('d-none')
                    $('#switch').html("<i class='fa fa-list-ul' aria-hidden='true'></i> List Upgarde")
                } else {
                    $('#tableFixHistory2').removeClass('d-none')
                    $('#tableFixHistory1').addClass('d-none')
                    $('#switch').html("<i class='fa fa-arrow-left' aria-hidden='true'></i> Back")
                }
            }
            function remove (otp){
                $.getJSON(otp, function (data) {
                    if (data === false) {
                        swal({
                            title: "Failed!",
                            text: "Failed deleted to this user!",
                            icon: "error",
                            button: "OK!",
                            dangerMode: true,
                            closeOnClickOutside: false,
                        });
                    } else
                    {
                        swal({
                            title: "Successfully!",
                            text: "Successfully deleted to this user!",
                            icon: "success",
                            button: "OK!",
                            closeOnClickOutside: false,
                        })
                            .then(function(){
                                    location.reload();
                                }
                            );
                    }
                });
            }
        </script>
    </jsp:attribute>
    <jsp:body>
        <div class="snowflakes" aria-hidden="true">
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
            <div class="snowflake">
                ❅
            </div>
            <div class="snowflake">
                ❆
            </div>
        </div>

        <div class="title-box bg-danger mt-3 w-75 mx-auto justify-content-center" style="border-radius: 5px;background-image: url('https://www.thebutlerspantry.ie/wp-content/uploads/2020/10/trim-header-christmas.png');background-size: cover">
            <h2 style="font-family: 'Russo One',sans-serif">Bidder Manager</h2>
        </div>
        <div class="w-75 mx-auto" style="background-color: white;" >
            <div style="text-align: center; margin: auto; display: flex; width: 25%; justify-content: center;">
                <a class="btn btn-outline-success mx-auto mt-2 mb-2" href="${pageContext.request.contextPath}/Admin/User/AddUser" role="button">
                    <i class="fa fa-plus" aria-hidden="true"></i>
                    Add User
                </a>
                <button class="btn btn-outline-info mx-auto mt-2 mb-2" id="switch" onclick="forward()" role="button">
                    <i class="fa fa-list-ul" aria-hidden="true"></i>
                    List Upgrade
                </button>
            </div>
        </div>
        <div class="tableFixHistory w-75 mx-auto" style="cursor: pointer; background-color: white; height: 40%" id="tableFixHistory1">
            <table class="table  table-hover " style=" height: 5px; margin: auto">
                <thead>
                <tr>
                    <th scope="col" style="background-color: black"><p style="color: white">ID</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Name</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Email</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Address</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Date of Birth</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Edit</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Delete</p></th>
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
                                    <th>
                                           <button type="button" id="deleteUser" onclick="remove('${pageContext.request.contextPath}/Admin/DeleteUser?uid=${u.id}')" class="btn btn-outline-danger btn-sm btn-block">
                                               <i class="fa fa-trash" aria-hidden="true"></i>
                                           </button>
                                    </th>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <div class="tableFixHistory d-none w-75 mx-auto" style="cursor: pointer; background-color: white ;height: 40%" id="tableFixHistory2">
            <table class="table table-hover " style=" height: 5px; margin: auto">
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
                            <c:if test="${u.reQuest == 1}">
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
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
        <div class="title-box bg-danger mt-4 w-75 mx-auto justify-content-center" style="border-radius: 5px;background-image: url('https://www.thebutlerspantry.ie/wp-content/uploads/2020/10/trim-header-christmas.png');background-size: cover">
            <h2 style="font-family: 'Russo One',sans-serif">Seller Manager</h2>
        </div>
        <div class="tableFixHistory w-75 mx-auto" style="cursor: pointer; background-color: white; height: 40%">
            <table class="table table-hover" style=" height: 5px; margin: auto">
                <thead>
                <tr>
                    <th scope="col" style="background-color: black"><p style="color: white">ID</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Name</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Email</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Address</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Date of Birth</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Edit</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Downgrade</p></th>
                    <th scope="col" style="background-color: black"><p style="color: white">Delete</p></th>
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
                                        <a type="button" class="btn btn-outline-danger btn-sm btn-block w-50 mx-auto" href="${pageContext.request.contextPath}/Admin/DownSeller?uid=${u.id}">
                                            <i class="fa fa-arrow-down" aria-hidden="true"></i>
                                        </a>
                                    </th>
                                    <th scope="col">
                                    <button type="button" id="deleteUser2" onclick="remove('${pageContext.request.contextPath}/Admin/DeleteUser?uid=${u.id}')" class="btn btn-outline-danger btn-sm btn-block">
                                        <i class="fa fa-trash" aria-hidden="true"></i>
                                    </button>
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