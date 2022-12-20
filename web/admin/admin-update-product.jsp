<%-- 
    Document   : admin-update-product
    Created on : Oct 26, 2022, 6:04:32 PM
    Author     : This Pc
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <li><a href="admin-customer">Customer</a></li>
                        <li><a href="admin-category">Category</a></li>
                        <li class="active"><a href="admin-product">Product</a></li>
                        <li><a href="admin-order">Order</a></li>
                        <li><a href="home">Back to Home</a></li>
                        <li><a href="logout">Log out</a></li>
                    </ul>
                </div>
                <div class="col-10">

                    <c:set var="b" value="${requestScope.book}"/>
                    <h1>Update Product ID#${b.id}</h1>

                    <form action="update-product" method="post">
                        <table class="add" style="width: 100%">
                            <tr>
                                <td>Id:</td>
                                <td><input type="number" readonly name="id" value="${b.id}"/></td>
                            </tr>
                            <tr>
                                <td>Name:</td>
                                <td><input type="text" name="name" value="${b.name}"/></td>
                            </tr>
                            <tr>
                                <td>Author:</td>
                                <td><input type="text" name="author" value="${b.author}"/></td>
                            </tr>
                            <tr>
                                <td>UnitPrice:</td>
                                <td><input type="number" name="unitPrice" value="${b.unitPrice}"/></td>
                            </tr>
                            <tr>
                                <td>SubCategoryID:</td>
                                <td><input type="number" name="subCategoryID" value="${b.subCategoryID}"/></td>
                            </tr>
                            <tr>
                                <td>Describe:</td>
                                <td><textarea cols="100" rows="20" style="width: 100%" name="describe">${b.describe}</textarea></textarea></td>
                            </tr>
                            <tr>
                                <td>Publisher:</td>
                                <td><input type="text" name="publisher" value="${b.publisher}"/></td>
                            </tr>
                            <tr>
                                <td>PublicationDate:</td>
                                <td><input type="number" name="publicationDate" value="${b.publicationDate}"/></td>
                            </tr>
                            <tr>
                                <td>Page:</td>
                                <td><input type="number" name="page" value="${b.page}"/></td>
                            </tr>
                            <tr>
                                <td>Translator:</td>
                                <td><input type="text" name="translator" value="${b.translator}"/></td>
                            </tr>
                            <tr>
                                <td>Quantity:</td>
                                <td><input type="number" name="quantity" value="${b.quantity}"/></td>
                            </tr>
                            <tr>
                                <td>Image:</td>
                                <td><input type="text" name="image" value="${b.image}"/></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" value="Update"/></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>

        </div>
    </body>
</html>
