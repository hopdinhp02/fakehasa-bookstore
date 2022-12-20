<%-- 
    Document   : admin-account
    Created on : Oct 27, 2022, 9:26:26 AM
    Author     : This Pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
        <!-- app css -->
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
                    <h1>List of Customers</h1>
                    <c:set value="${requestScope.type}" var="type"/>
                    <c:set value="${requestScope.search}" var="search"/>
                    <form action="admin-customer">
                        Tìm kiếm:
                        <select name="type">
                            <option ${type==1?"selected":""} value="1">ID</option>
                            <option ${type==2?"selected":""} value="2">Name</option>
                            <option ${type==3?"selected":""} value="3">Phone</option>
                            <option ${type==4?"selected":""} value="4">Email</option>
                            <option ${type==5?"selected":""} value="5">Address</option>
                        </select>

                        <input type="search" name="search" value="${search}"/>
                        <input type="submit" value="Tìm kiếm"/>

                    </form>
                    <table border="1px">
                        <tr>
                            <th>CustomerID</th>
                            <th>FirstName</th>
                            <th>LastName</th>
                            <th>Gender</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th>Revenue</th>
                            <th>Profit</th>
                        </tr>

                        <c:forEach items="${requestScope.customer_list}" var="c">
                            <c:set var="id" value="${c.id}"/>
                            <jsp:useBean id="ad" class="dal.AdminDAO" scope="request"/>
                            <tr>
                                <td><a href="admin-customer-order?id=${id}" target="_blank">${id}</a> </td>
                                <td>${c.firstName}</td>
                                <td>${c.lastName}</td>
                                <td>${c.gender==true?"Male":"Female"}</td>
                                <td>${c.phone}</td>
                                <td>${c.email}</td>
                                <td>${c.address}</td>
                                <td class="currency">${ad.getCustomerRevenue(id)}</td>
                                <td class="currency">${ad.getCustomerProfit(id)}</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${requestScope.num!=0}" >
                        <div class="box">
                            <ul class="pagination">
                                <c:if test="${requestScope.page!=1}" >
                                    <li><a href="admin-customer?type=${type}&search=${search}&page=${requestScope.page-1}"><i class='bx bxs-chevron-left'></i></a></li>
                                        </c:if>  
                                        <c:forEach begin="1" end="${requestScope.num}" var="i">
                                            <c:if test="${i==requestScope.num and requestScope.page<=requestScope.num-4 and requestScope.num>5}">
                                        <li class="disable-li"><span>...</span></li>
                                        </c:if>  
                                        <c:if test="${i==1 or i==requestScope.num  or (requestScope.page>=requestScope.num-1 and i>=requestScope.num-4) or (requestScope.page>=3 and i>=requestScope.page-2 and i<=requestScope.page+2) or (requestScope.page<3 and i>=2 and i<=5)}">
                                        <li><a ${requestScope.page==i?"class='active'":""} href="admin-customer?type=${type}&search=${search}&page=${i}">${i}</a></li>
                                        </c:if>
                                        <c:if test="${i==1 and requestScope.page>4 and requestScope.num>5}">
                                        <li class="disable-li"><span>...</span></li>
                                        </c:if>  
                                    </c:forEach>
                                    <c:if test="${requestScope.page!=requestScope.num}" >
                                    <li><a href="admin-customer?type=${type}&search=${search}&page=${requestScope.page+1}"><i class='bx bxs-chevron-right'></i></a></li>
                                        </c:if>
                            </ul>
                        </div>
                    </c:if>
                </div>
            </div>

        </div>
        <script type="text/javascript" >
            let x = document.querySelectorAll(".currency");
            for (let i = 0, len = x.length; i < len; i++) {
                let num = Number(x[i].innerHTML)
                        .toLocaleString('en');
                x[i].innerHTML = num;
            }
        </script>
    </body>
</html>
