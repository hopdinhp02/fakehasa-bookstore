<%-- 
    Document   : admin-account
    Created on : Oct 27, 2022, 9:49:47 PM
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
                    <h1>List of Accounts</h1>
                    <c:set value="${requestScope.type}" var="type"/>
                    <c:set value="${requestScope.search}" var="search"/>
                    <form action="admin-account">
                        Username:                
                        <input type="search" name="search" value="${search}"/>
                        <select name="type">
                            <option  value="0">Role</option>
                            <option ${type==1?"selected":""} value="1">Admin</option>
                            <option ${type==2?"selected":""} value="2">Customer</option>
                            <option ${type==3?"selected":""} value="3">Ban</option>
                        </select>
                        <input type="submit" value="Tìm kiếm"/>

                    </form>
                    <table border="1px">
                        <tr>
                            <th>username</th>
                            <th>role</th>
                        </tr>
                        <c:forEach items="${requestScope.account}" var="a">
                            <tr>
                                <td>${a.username}</td>
                                <td><select onchange="doUpdate('${a.username}')">
                                        <option ${a.role==1?"selected":""} value="1">Admin</option>
                                        <option ${a.role==2?"selected":""} value="2">Customer</option>
                                        <option ${a.role==3?"selected":""} value="3">Ban</option>
                                    </select>
                                </td>
                                <c:if test="${a.role==1}">
                                <td>
                                    <a href="admin-update-account?username=${a.username}" target="_blank">Change Password</a>
                                </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${requestScope.num!=0}" >
                        <div class="box">
                            <ul class="pagination">
                                <c:if test="${requestScope.page!=1}" >
                                    <li><a href="admin-account?page=${requestScope.page-1}"><i class='bx bxs-chevron-left'></i></a></li>
                                        </c:if>  
                                        <c:forEach begin="1" end="${requestScope.num}" var="i">
                                            <c:if test="${i==requestScope.num and requestScope.page<=requestScope.num-4 and requestScope.num>5}">
                                        <li class="disable-li"><span>...</span></li>
                                        </c:if>  
                                        <c:if test="${i==1 or i==requestScope.num  or (requestScope.page>=requestScope.num-1 and i>=requestScope.num-4) or (requestScope.page>=3 and i>=requestScope.page-2 and i<=requestScope.page+2) or (requestScope.page<3 and i>=2 and i<=5)}">
                                        <li><a ${requestScope.page==i?"class='active'":""} href="admin-account?page=${i}">${i}</a></li>
                                        </c:if>
                                        <c:if test="${i==1 and requestScope.page>4 and requestScope.num>5}">
                                        <li class="disable-li"><span>...</span></li>
                                        </c:if>  
                                    </c:forEach>
                                    <c:if test="${requestScope.page!=requestScope.num}" >
                                    <li><a href="admin-account?page=${requestScope.page+1}"><i class='bx bxs-chevron-right'></i></a></li>
                                        </c:if>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>

        </div>
<script type="text/javascript">
            function doUpdate(username) {
                if (confirm("Are you sure about updating role of username '" + username + "'?")) {
                    window.location = "admin-update-role?username=" + username +"&role="+event.target.value;
                }else{
                    location.reload();
                }
            }
        </script>
    </body>
</html>
