<%-- 
    Document   : admin-update-customer
    Created on : Oct 27, 2022, 9:55:29 AM
    Author     : This Pc
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                        <li><a href="admin-account">Account</a></li>
                        <li  class="active"><a href="admin-customer">Customer</a></li>
                        <li><a href="admin-category">Category</a></li>
                        <li><a href="admin-product">Product</a></li>
                        <li><a href="admin-order">Order</a></li>
                        <li><a href="home">Back to Home</a></li>
                        <li><a href="logout">Log out</a></li>
                    </ul>
                </div>
                <div class="col-10">

                    <div class="box">
                        <c:set value="${requestScope.customerinfo}" var="cus"/>
                        <h2>Thông tin khách hàng ID#${cus.id}</h2>
                        <form action="update-customer" method="post">
                            <input type="hidden" name="id" value="${cus.id}"/>
                            <table class="cus-info add" style="width: 50%;">
                                <tr>
                                    <td>Họ:</td>
                                    <td><input type="text" name="lastName" value="${cus.lastName}"></td>
                                </tr>
                                <tr>
                                    <td>Tên:</td>
                                    <td><input type="text" name="firstName" value="${cus.firstName}"></td>
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
                                <tr>
                                    <td></td>
                                    <td><input type="submit" value="Lưu thông tin"></td>
                                </tr>
                            </table>

                        </form>
                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
