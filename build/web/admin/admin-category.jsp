<%-- 
    Document   : admin-category
    Created on : Oct 30, 2022, 11:07:28 AM
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
        <script type="text/javascript">
            function Show(id) {
                var x = document.getElementById(id);
                if (x.style.display === "block") {
                    x.style.display = "none";
                } else {
                    x.style.display = "block";
                }
            }

        </script>

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
                        <li   class="active"><a href="admin-category">Category</a></li>
                        <li><a href="admin-product">Product</a></li>
                        <li><a href="admin-order">Order</a></li>
                        <li><a href="home">Back to Home</a></li>
                        <li><a href="logout">Log out</a></li>
                    </ul>
                </div>
                <div class="col-10">
                    <h1>List of Category</h1>
                    <button onclick="AddNewCategory()">Add new</button>
                    <table border="1px" >
                        <tr>
                            <th>CID</th>
                            <th>CategoryName</th>
                        </tr>
                        <c:forEach items="${requestScope.category}" var="c">
                            <c:set var="cid" value="${c.id}"/>
                            <jsp:useBean id="d" class="dal.DAO" scope="request"/>
                            <tr>
                                <td>${cid}</td>
                                <td>${c.name}</td>                                
                                <td>

                                    <button onclick="Show('${cid}')">Show</button>
                                    <button onclick="RenameCategory('${cid}')">Rename</button>
                                    <button onclick="AddSub('${cid}')">Add Sub</button>
                                    <button onclick="DeleteCategory('${cid}')">Delete</button>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">

                                    <div id="${cid}" class="table-responsive hiden-table">
                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th scope="col" class="h5">SID</th>
                                                    <th scope="col">SubCategoryName</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <c:forEach items="${d.getAllSubCategoryByCID(cid)}" var="s">
                                                    <tr>

                                                        <td class="align-middle">
                                                            <div class="d-flex flex-row">
                                                                ${s.id}
                                                            </div>
                                                        </td>
                                                        <td class="align-middle">
                                                            <p class="mb-0">${s.name}</p>

                                                        </td>
                                                        <td class="align-middle">
                                                            <button onclick="RenameSubCategory('${s.id}')">Rename</button>
                                                            <button onclick="DeleteSubCategory('${s.id}')">Delete</button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </td>
                                <!--<td><a href="#">Add SubCategory</a></td>-->
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>

        </div>
        <script type="text/javascript">

            function RenameCategory(id) {
                let name = prompt("Enter new category's name:", "");
                if (name === null || name === "") {
                    window.alert("Rename Unsuccessfully");
                } else {
                    window.location = "admin-rename-category?cid=" + id + "&name=" + name;
                    window.alert("Rename Successfully");
                }
            }
            function RenameSubCategory(id) {
                let name = prompt("Enter new category's name:", "");
                if (name === null || name === "") {
                    window.alert("Rename Unsuccessfully");
                } else {
                    window.location = "admin-rename-subcategory?sid=" + id + "&name=" + name;
                    window.alert("Rename Successfully");
                }
            }

            function AddNewCategory() {

                let newCategory = prompt("Enter new category's name:", "");
                if (newCategory === null || newCategory === "") {
                    window.alert("Add Unsuccessfully");
                } else {
                    window.location = "admin-add-category?name=" + newCategory;
                    window.alert("Add Successfully");
                }
            }

            function AddSub(id) {
                let newSub = prompt("Enter new subcategory's name:", "");
                if (newSub === null || newSub === "") {
                    window.alert("Add Unsuccessfully");
                } else {
                    window.location = "admin-add-subcategory?cid=" + id + "&sname=" + newSub;
                    window.alert("Add Successfully");
                }
            }
            function DeleteCategory(cid) {
                if (confirm("Are you sure about deleting cid=" + cid + "?")) {
                    window.location = "admin-delete-category?id=" + cid;

                }
            }
            function DeleteSubCategory(sid) {
                if (confirm("Are you sure about deleting sid=" + sid + "?")) {
                    window.location = "admin-delete-subcategory?id=" + sid;
                }
            }
        </script>
    </body>
</html>