<%-- 
    Document   : customer-order
    Created on : Oct 25, 2022, 8:11:59 PM
    Author     : This Pc
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Fakehasa</title>
        <!-- google font -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,900&display=swap" rel="stylesheet">
        <!-- boxicons -->
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
        <!-- app css -->
        <link rel="stylesheet" href="./css/bootstrap.css">
        <link rel="stylesheet" href="./css/grid.css">
        <link rel="stylesheet" href="./css/app.css">
    </head>
    <body>

        <!-- header -->
        <%@include file="header.jsp" %>
        <!-- end header -->
        <div class="bg-main">
            <div class="container">

                <div class="box">
                    <div class="row">
                        <div class="col-3 filter-col" id="filter-col">
                            <div class="box filter-toggle-box">
                                <button class="btn-flat btn-hover" id="filter-close">close</button>
                            </div>
                            <div class="box">
                                <span class="filter-header">
                                    Tài Khoản
                                </span>

                                <ul class="filter-list">
                                    <li><a  href="customer-account">Thông tin tài khoản</a></li>
                                    <li><a class="selected-category" href="customer-order">Đơn hàng</a></li>
                                    <li><a  href="customer-change-password">Đổi mật khẩu</a></li>
                                    <li><a href="logout">Đăng xuất</a></li>



                                </ul>
                            </div>
                        </div>

                        <div class="col-9 col-md-12">
                            <div class="box filter-toggle-box">
                                <button class="btn-flat btn-hover" id="filter-toggle">Info</button>
                            </div>
                            <div class="box">
                                <c:set var="orders" value="${requestScope.order_list}"/>
                                <jsp:useBean id="d" class="dal.DAO" scope="request"/>
                                <c:forEach items="${orders}" var="o">
                                    <section class="h-100 h-custom">
                                        <div class="container h-100 py-5">
                                            <div class="row d-flex justify-content-center align-items-center h-100">
                                                <div class="col">

                                                    <div class="table-responsive">
                                                        <table class="table">
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col" class="h5">ID#${o.id}  ${o.orderDate}</th>
                                                                    <th scope="col">Quantity</th>
                                                                    <th scope="col">Price</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>

                                                                <c:forEach items="${d.getOrderDetailByOrderId(o.id)}" var="od">
                                                                    <c:set var="b" value="${d.getBookById(od.bookId)}"/>
                                                                    <tr>
                                                                        <th scope="row">
                                                                            <div class="d-flex align-items-center">
                                                                                <img src="${b.image}" class="img-fluid rounded-3"
                                                                                     style="width: 120px;" alt="Book">
                                                                                <div class="flex-column ms-4">
                                                                                    <p class="mb-2">${b.name}</p>
                                                                                    <p class="mb-0">${b.author}</p>
                                                                                </div>
                                                                            </div>
                                                                        </th>
                                                                        <td class="align-middle">
                                                                            <div class="d-flex flex-row">
                                                                                ${od.quantity}
                                                                            </div>
                                                                        </td>
                                                                        <td class="align-middle">
                                                                            <p class="currency mb-0">${od.salePrice}</p>

                                                                        </td>
                                                                    </tr>
                                                                </c:forEach>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <div class="card shadow-2-strong mb-5 mb-lg-0" style="border-radius: 16px;">
                                                        <div class="card-body p-4">

                                                            <div class="row">
                                                                <div class="col-md-12 col-lg-8 col-xl-9 mb-4 mb-md-0">
                                                                    Trạng thái:
                                                                    <c:if test="${o.state==6}">
                                                                        Đã huỷ đơn hàng
                                                                    </c:if>
                                                                    <c:if test="${o.state==1}">
                                                                        Chờ liên hệ
                                                                    </c:if>
                                                                    <c:if test="${o.state==2}">
                                                                        Chờ giao hàng
                                                                    </c:if>
                                                                    <c:if test="${o.state==3}">
                                                                        Đang giao hàng
                                                                    </c:if>
                                                                    <c:if test="${o.state==4}">
                                                                        Giao hàng thành công
                                                                    </c:if>
                                                                    <c:if test="${o.state==5}">
                                                                        Giao hàng không thành công
                                                                    </c:if>
                                                                </div>
<!--                                                                <div class="col-md-6 col-lg-4 col-xl-6">

                                                                </div>-->
                                                                <div class="col-lg-4 col-xl-3">


                                                                    <hr class="my-4">

                                                                    <div class="d-flex justify-content-between mb-4" style="font-weight: 500;">
                                                                        <p class="mb-2">Total</p>
                                                                        <p class="mb-2 currency">${o.total}</p>
                                                                    </div>


                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </section>
                                </c:forEach>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- footer -->
        <%@include file="footer.jsp" %>
        <!-- end footer -->

        <!-- app js -->


    </body>
</html>
<script src="./js/bootstrap.js"></script>
<script  src="./js/app.js"></script>
<script src="./js/products.js"></script>

