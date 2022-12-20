<%-- 
    Document   : admin-update-account
    Created on : Oct 27, 2022, 10:41:33 AM
    Author     : This Pc
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="./css/bootstrap.css">
        <link rel="stylesheet" href="./css/admin.css">
    </head>
    <body>
        <div class="container-fluid">
            <div class='row'>
                <div class="col-2 sidebar">
                    <ul>
                        <h1><a href="admin">Admin</a></h1>
                        <li><a href="admin">Dashboard</a></li>
                        <li  class="active"><a href="admin-account">Account</a></li>
                        <li><a href="admin-customer">Customer</a></li>
                        <li><a href="admin-category">Category</a></li>
                        <li><a href="admin-product">Product</a></li>
                        <li><a href="admin-order">Order</a></li>
                        <li><a href="home">Back to Home</a></li>
                        <li><a href="logout">Log out</a></li>
                    </ul>
                </div>
                <div class="col-10">

                    <div class="box">
                        <h2>Thông tin tài khoản</h2>
                        <c:set var="a" value="${requestScope.account}"/>
                        <form action="admin-update-account" method="post">
                            <table class="cus-info add">
                                <tr>
                                    <td>Username:</td>
                                    <td><input type="text" readonly name="username" value="${a.username}"/><br></td>
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
                                    <!--<a href="admin-customer">Quay lại</a>-->
                                    <td><input type="submit" value="Thay đổi"></td>
                                </tr>
                            </table>

                        </form>
                        <h3 style="color: red">${requestScope.ms}</h3>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
