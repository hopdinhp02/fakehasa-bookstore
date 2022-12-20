<%-- 
    Document   : admin-product
    Created on : Oct 26, 2022, 5:10:41 PM
    Author     : This Pc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure delete id=" + id + "?")) {
                    window.location = "delete-product?id=" + id;

                }
            }
        </script>
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
                        <li  class="active"><a href="admin-product">Product</a></li>
                        <li><a href="admin-order">Order</a></li>
                        <li><a href="home">Back to Home</a></li>
                        <li><a href="logout">Log out</a></li>
                    </ul>
                </div>
                <div class="col-10">
                    <h1>List of Products</h1>
                    <c:set value="${requestScope.type}" var="type"/>
                    <c:set value="${requestScope.search}" var="search"/>
                    <c:set value="${requestScope.cid}" var="cid"/>
                    <c:set value="${requestScope.state}" var="state"/>
                    <a style="border: 1px solid black" href="add-product">Add new</a><br>
                    <table border="1px">
                        <tr>
                            <th>BookID</th>
                            <th>Tên</th>
                            <th>Tác giả</th>
                            <th>Nhà Xuất bản</th>
                            <th>Năm xuất bản</th>
                            <th>Số lượng</th>
                            <th>UnitPrice</th>
                            <th>Đã bán</th>
                        </tr>
                        <form action="admin-product">
                            Tìm kiếm:
                            <select name="type">
                                <option ${type==1?"selected":""} value="1">ID</option>
                                <option ${type==2?"selected":""} value="2">Tên</option>
                                <option ${type==3?"selected":""} value="3">Tác giả</option>
                                <option ${type==4?"selected":""} value="4">NXB</option>
                            </select>

                            <input type="search" name="search" value="${search}"/>
                            <select name="cid">
                                <option value="0">Thể loại</option>
                                <c:forEach items="${requestScope.category}" var="c">
                                    <option ${c.id==cid?"selected":""} value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select>
                            <input ${state==1?"checked":""} type="radio" name="state" value="1"/>Còn hàng
                            <input ${state==0?"checked":""}  type="radio" name="state" value="0"/>Hết hàng
                            <input type="submit" value="Tìm kiếm"/>
                        </form>
                        <c:forEach items="${requestScope.book}" var="b">
                            <c:set var="id" value="${b.id}"/>
                            <jsp:useBean id="ad" class="dal.AdminDAO" scope="request"/>
                            <tr>
                                <td>${id}</td>
                                <td>${b.name}</td>
                                <td>${b.author}</td>
                                <td>${b.publisher}</td>
                                <td>${b.publicationDate}</td>
                                <td>${b.quantity}</td>
                                <td class="currency">${b.unitPrice}</td>
                                <td>${ad.getSoldQuantity(id)}</td>
                                <td>
                                    <a href="#" onclick="doDelete('${id}')">Delete</a>
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                    <a href="update-product?id=${id}" target="_blank">Update</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <c:if test="${requestScope.num!=0}" >
                        <div class="box">
                            <ul class="pagination">
                                <c:if test="${requestScope.page!=1}" >
                                    <li><a href="admin-product?type=${type}&search=${search}&cid=${cid}&page=${requestScope.page-1}"><i class='bx bxs-chevron-left'></i></a></li>
                                        </c:if>  
                                        <c:forEach begin="1" end="${requestScope.num}" var="i">
                                            <c:if test="${i==requestScope.num and requestScope.page<=requestScope.num-4 and requestScope.num>5}">
                                        <li class="disable-li"><span>...</span></li>
                                        </c:if>  
                                        <c:if test="${i==1 or i==requestScope.num  or (requestScope.page>=requestScope.num-1 and i>=requestScope.num-4) or (requestScope.page>=3 and i>=requestScope.page-2 and i<=requestScope.page+2) or (requestScope.page<3 and i>=2 and i<=5)}">
                                        <li><a ${requestScope.page==i?"class='active'":""} href="admin-product?type=${type}&search=${search}&cid=${cid}&page=${i}">${i}</a></li>
                                        </c:if>
                                        <c:if test="${i==1 and requestScope.page>4 and requestScope.num>5}">
                                        <li class="disable-li"><span>...</span></li>
                                        </c:if>  
                                    </c:forEach>
                                    <c:if test="${requestScope.page!=requestScope.num}" >
                                    <li><a href="admin-product?type=${type}&search=${search}&cid=${cid}&page=${requestScope.page+1}"><i class='bx bxs-chevron-right'></i></a></li>
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