<%-- 
    Document   : admin-order
    Created on : Oct 26, 2022, 10:40:25 PM
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
                        <li><a href="admin-category">Category</a></li>
                        <li><a href="admin-product">Product</a></li>
                        <li  class="active"><a href="admin-order">Order</a></li>
                        <li><a href="home">Back to Home</a></li>
                        <li><a href="logout">Log out</a></li>
                    </ul>
                </div>
                <div class="col-10">
                    <c:set value="${requestScope.type}" var="type"/>
                    <c:set value="${requestScope.search}" var="search"/>
                    <c:set value="${requestScope.state}" var="state"/>
                    <c:set value="${requestScope.date}" var="date"/>
                    <h1>List of Orders</h1>
                    <form action="admin-order">
                        Tìm kiếm:
                        <select name="type">
                            <option ${type==1?"selected":""} value="1">OrderID</option>
                            <option ${type==2?"selected":""} value="2">CustomerID</option>
                        </select>
                        <input type="search" name="search" value="${search}"/>
                        <input type="date" name="date" value="${date}"/>
                        <select name="state">   
                            <option value="0">State</option>
                            <option ${state==1?"selected":""} value="1">Chờ liên hệ</option>
                            <option ${state==2?"selected":""} value="2">Chờ giao hàng</option>
                            <option ${state==3?"selected":""} value="3">Đang giao hàng</option>
                            <option ${state==4?"selected":""} value="4">Giao hàng thành công</option>
                            <option ${state==5?"selected":""} value="5">Giao hàng không thành công</option>
                            <option ${state==6?"selected":""} value="6">Trả lại hàng</option>
                            <option ${state==7?"selected":""} value="7">Đã huỷ đơn hàng</option>
                        </select>
                        <input type="submit" value="Tìm kiếm"/>
                    </form>
                    <table border="1px" style="width: 100%">
                        <tr>
                            <th>OrderID</th>
                            <th>CustomerID</th>
                            <th>OrderDate</th>
                            <th>Total</th>
                            <th>Profit</th>
                            <th>State</th>
                        </tr>
                        <c:forEach items="${requestScope.order_list}" var="o">
                            <c:set var="id" value="${o.id}"/>
                            <jsp:useBean id="d" class="dal.DAO" scope="request"/>
                            <jsp:useBean id="ad" class="dal.AdminDAO" scope="request"/>
                            <tr>
                                <td>${id}</td>
                                <td><a href="admin-customer?type=1&search=${o.customerID}" target="_blank">${o.customerID}</a> </td>
                                <td>${o.orderDate}</td>
                                <td class="currency">${o.total}</td>
                                <td class="currency">${ad.getProfit(id)}</td>
                                <td>
                                    <c:if test="${o.state==7}">
                                        Đã huỷ đơn hàng
                                    </c:if>
                                    <c:if test="${o.state!=7}">
                                        <select onchange="doUpdate('${id}')">                                      
                                            <option ${o.state==1?"selected":""} value="1">Chờ liên hệ</option>
                                            <option ${o.state==2?"selected":""} value="2">Chờ giao hàng</option>
                                            <option ${o.state==3?"selected":""} value="3">Đang giao hàng</option>
                                            <option ${o.state==4?"selected":""} value="4">Giao hàng thành công</option>
                                            <option ${o.state==5?"selected":""} value="5">Giao hàng không thành công</option>
                                            <option ${o.state==6?"selected":""} value="6">Trả lại hàng</option>
                                            <option ${o.state==7?"selected":""} value="7">Đã huỷ đơn hàng</option>
                                        </select>
                                    </c:if>                        
                                </td>
                                <td>
                                    <button onclick="Show('${id}')">Chi tiết</button>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="5">

                                    <div id="${id}" class="table-responsive hiden-table">
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
                                                                <a href="admin-product?type=1&search=${b.id}" target="_blank">
                                                                    <img src="${b.image}" class="img-fluid rounded-3"
                                                                         style="width: 120px;" alt="Book"/>
                                                                </a>

                                                                <div class="flex-column ms-4">
                                                                    <a href="admin-product?type=1&search=${b.id}" target="_blank">
                                                                        <p class="mb-2">${b.name}</p>
                                                                    </a>

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
                                </td>

                            </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${requestScope.num!=0}" >
                        <div class="box">
                            <ul class="pagination">
                                <c:if test="${requestScope.page!=1}" >
                                    <li><a href="admin-order?page=${requestScope.page-1}"><i class='bx bxs-chevron-left'></i></a></li>
                                        </c:if>  
                                        <c:forEach begin="1" end="${requestScope.num}" var="i">
                                            <c:if test="${i==requestScope.num and requestScope.page<=requestScope.num-4 and requestScope.num>5}">
                                        <li class="disable-li"><span>...</span></li>
                                        </c:if>  
                                        <c:if test="${i==1 or i==requestScope.num  or (requestScope.page>=requestScope.num-1 and i>=requestScope.num-4) or (requestScope.page>=3 and i>=requestScope.page-2 and i<=requestScope.page+2) or (requestScope.page<3 and i>=2 and i<=5)}">
                                        <li><a ${requestScope.page==i?"class='active'":""} href="admin-order?page=${i}">${i}</a></li>
                                        </c:if>
                                        <c:if test="${i==1 and requestScope.page>4 and requestScope.num>5}">
                                        <li class="disable-li"><span>...</span></li>
                                        </c:if>  
                                    </c:forEach>
                                    <c:if test="${requestScope.page!=requestScope.num}" >
                                    <li><a href="admin-order?page=${requestScope.page+1}"><i class='bx bxs-chevron-right'></i></a></li>
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
        <script type="text/javascript">
            function doUpdate(orderID) {
                if (confirm("Are you sure about updating state of OrderID#" + orderID + "?")) {
                    window.location = "admin-update-state?orderid=" + orderID + "&state=" + event.target.value;
                } else {
                    location.reload();
                }
            }
        </script>
    </body>
</html>

