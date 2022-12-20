<%-- 
    Document   : change-password
    Created on : Oct 25, 2022, 10:34:25 PM
    Author     : This Pc
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="./css/grid.css">
        <link rel="stylesheet" href="./css/app.css">
        <link rel="stylesheet" href="./css/customer.css">
    </head>
    <body>
        <%@include file="header.jsp" %>

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
                                    <li><a  href="customer-order">Đơn hàng</a></li>
                                    <li><a class="selected-category" href="customer-change-password">Đổi mật khẩu</a></li>
                                    <li><a href="logout">Đăng xuất</a></li>



                                </ul>
                            </div>
                        </div>

                        <div class="col-9 col-md-12">
                            <div class="box filter-toggle-box">
                                <button class="btn-flat btn-hover" id="filter-toggle">Info</button>
                            </div>
                            <div class="box">
                                <h2>Thay đổi mật khẩu</h2>
                                <form action="change-password" method="post">
                                    <table class="cus-info">
                                        <tr>
                                            <td>Mật khẩu hiện tại:</td>
                                            <td><input type="password" name="old"/><br></td>
                                        </tr>
                                        <tr>
                                            <td>Mật khẩu mới:</td>
                                            <td><input type="password" name="new"/></td>
                                        </tr>
                                        <tr>
                                            <td>Xác nhận mật khẩu:</td>
                                            <td><input type="password" name="confirm"/></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><input type="submit" value="Thay đổi"></td>
                                        </tr>
                                    </table>

                                </form>
                                <h3 style="color: red">${requestScope.ms}</h3>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
