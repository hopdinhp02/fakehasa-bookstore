<%-- 
    Document   : cart
    Created on : Oct 22, 2022, 8:43:57 PM
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
        <link rel="stylesheet" href="./css/customer.css">
    </head>
    <body>

        <!-- header -->
        <%@include file="header.jsp" %>
        <c:set value="${sessionScope.customerinfo}" var="cus"/>
        <!-- end header -->
        <section class="h-100 h-custom">
            <div class="container h-100 py-5">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col">

                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col" class="h5">Shopping Bag</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="cart" value="${requestScope.cart}"/>
                                    <c:forEach items="${cart.items}" var="i">
                                        <tr>
                                            <th scope="row">
                                                <div class="d-flex align-items-center">
                                                    <img src="${i.book.image}" class="img-fluid rounded-3"
                                                         style="width: 120px;" alt="Book">
                                                    <div class="flex-column ms-4">
                                                        <p class="mb-2">${i.book.name}</p>
                                                        <p class="mb-0">${i.book.author}</p>
                                                    </div>
                                                </div>
                                            </th>
                                            <td class="align-middle">
                                                <div class="d-flex flex-row">
                                                    <button class="btn btn-link px-2">
                                                        <a href="process-cart?num=-1&id=${i.book.id}"><i class="bx bx-minus"></i></a>
                                                    </button>

                                                        <input id="form1" min="0" name="quantity" readonly value="${i.quantity}" type="number"
                                                           class="form-control form-control-sm" style="width: 50px;" />

                                                    <button class="btn btn-link px-2">
                                                        <a href="process-cart?num=1&id=${i.book.id}"><i class="bx bx-plus"></i></a>
                                                    </button>
                                                </div>
                                            </td>
                                            <td class="align-middle">
                                                <p class="mb-0 currency">${i.price}</p>

                                            </td>
                                            <td class="align-middle border-bottom-0">
                                                <form id="remove" action="process-cart" method="post">
                                                    <input type="hidden" name="id" value="${i.book.id}"/>
                                                    <button type="submit" form="remove" style="border: 0px;background-color: white;"><i class="bx bx-trash"></i></button>

                                                </form>


                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <a href="category">Tiếp tục mua hàng</a>
                        <form action="checkout" method="post">
                            <div class="card shadow-2-strong mb-5 mb-lg-0" style="border-radius: 16px;">
                                <div class="card-body p-4">

                                    <div class="row">

                                        <div class="col-md-12 col-lg-8 col-xl-9">
                                            <div class="box">
                                                <h4>Thông tin nhận hàng </h4>
                                                <a style="float: right" href="customer-account">Đăng nhập</a>

                                                <table class="cus-info">
                                                    <tr>
                                                        <td>Họ:</td>
                                                        <td><input type="text" name="lastName" value="${cus.lastName}"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Tên:</td>
                                                        <td><input type="text" name="firstName" required value="${cus.firstName}"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Giới tính:</td>
                                                        <td><input type="radio" ${cus.gender?"checked":""} name="gender" value="true">Nam
                                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                                            <input type="radio" ${cus.gender?"":"checked"} name="gender" value="false">Nữ
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Số điện thoại:</td>
                                                        <td><input type="number" name="phone" required value="${cus.phone}"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Email:</td>
                                                        <td><input type="text" name="email" value="${cus.email}"></td>
                                                    </tr>
                                                    <tr>
                                                        <td>Địa chỉ:</td>
                                                        <td><input type="text" name="address" required value="${cus.address}"></td>
                                                    </tr>

                                                </table>
                                                        <h4 class="ms" style="color: red">${requestScope.ms}</h4>
                                                        
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-xl-3">

                                            <hr class="my-4">

                                            <div class="d-flex justify-content-between mb-4" style="font-weight: 500;">
                                                <p class="mb-2">Total</p>
                                                <p class="mb-2 currency">${cart.totalMoney}</p>
                                            </div>

                                            <button type="submit" class="btn btn-primary btn-block btn-lg">
                                                <div class="d-flex justify-content-between">
                                                    <span>Checkout</span>
                                                </div>
                                            </button>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </section>
        <!-- footer -->
        <%@include file="footer.jsp" %>
        <!-- end footer -->

        <!-- app js -->


    </body>
</html>
<script src="./js/bootstrap.js"></script>
<script  src="./js/app.js"></script>
<script src="./js/products.js"></script>
