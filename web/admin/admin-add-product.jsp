<%-- 
    Document   : admin-add-product
    Created on : Oct 26, 2022, 8:22:53 PM
    Author     : This Pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
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
                        <li  class="active"><a href="admin-product">Product</a></li>
                        <li><a href="admin-order">Order</a></li>
                        <li><a href="home">Back to Home</a></li>
                        <li><a href="logout">Log out</a></li>
                    </ul>
                </div>
                <div class="col-10">
        <h1>ADD Product</h1>

        <form action="add-product" method="post">
            <table class="add" style="width: 100%">
                <tr>
                    <td>Name:</td>
                    <td><input type="text" required name="name"/></td>
                </tr>
                <tr>
                    <td>Author:</td>
                    <td><input type="text" name="author"/></td>
                </tr>
                <tr>
                    <td>UnitPrice:</td>
                    <td><input type="number" required name="unitPrice"/></td>
                </tr>
                <tr>
                    <td>SubCategoryID:</td>
                    <td><input type="number" name="subCategoryID"/></td>
                </tr>
                <tr>
                    <td>Describe:</td>
                    <td><textarea cols="100" rows="20" style="width: 100%" name="describe"></textarea></td>
                </tr>
                <tr>
                    <td>Publisher:</td>
                    <td><input type="text" name="publisher" /></td>
                </tr>
                <tr>
                    <td>PublicationDate:</td>
                    <td><input type="number" required name="publicationDate"/></td>
                </tr>
                <tr>
                    <td>Page:</td>
                    <td><input type="number" required name="page"/></td>
                </tr>
                <tr>
                    <td>Translator:</td>
                    <td><input type="text" name="translator"/></td>
                </tr>
                <tr>
                    <td>Quantity:</td>
                    <td><input type="number" required name="quantity"/></td>
                </tr>
                <tr>
                    <td>Image:</td>
                    <td><input type="text" name="image"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Add"/></td>
                </tr>
            </table>

        </form>
        </div>
            </div>

        </div>
    </body>
</html>
