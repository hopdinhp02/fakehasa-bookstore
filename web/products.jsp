<%-- 
    Document   : products
    Created on : Oct 18, 2022, 9:59:28 PM
    Author     : This Pc
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    </head>
    <body>
        <%@include file="header.jsp" %>

        <!-- products content -->
        <div class="bg-main">
            <div class="container">
                <div class="box">
                    <div class="breadcumb">
                        <a href="home">Trang chủ</a>
                        <span><i class='bx bxs-chevrons-right'></i></span>
                        <a href="category">Thể Loại</a>
                        <c:set value="${category}" var="category" />
                        <c:set value="${subCategory}" var="subCategory" />
                        <c:if test="${category!=null}">
                            <span><i class='bx bxs-chevrons-right'></i></span>
                            <a href="category?cid=${category.id}&search=${requestScope.search}&fprice=${fprice}&tprice=${tprice}&order=${order}">${category.name}</a>
                        </c:if>
                        <c:if test="${subCategory!=null}">
                            <span><i class='bx bxs-chevrons-right'></i></span>
                            <a href="category?cid=${category.id}&sid=${subCategory.id}&search=${requestScope.search}&fprice=${fprice}&tprice=${tprice}&order=${order}">${subCategory.name}</a>
                        </c:if>
                    </div>
                </div>
                <div class="box">
                    <div class="row">
                        <div class="col-3 filter-col" id="filter-col">
                            <div class="box filter-toggle-box">
                                <button class="btn-flat btn-hover" id="filter-close">close</button>
                            </div>
                            <div class="box">
                                <span class="filter-header">
                                    Thể Loại
                                </span>

                                <ul class="filter-list">
                                    <li><a ${requestScope.cid==0?"class='selected-category'":""} href="category?cid=${0}&search=${requestScope.search}&fprice=${fprice}&tprice=${tprice}&order=${order}">Tất Cả</a></li>
                                        <c:forEach items="${requestScope.ListCategories}" var="c">
                                        <li><a ${requestScope.cid==c.id?"class='selected-category'":""} href="category?cid=${c.id}&search=${requestScope.search}&fprice=${fprice}&tprice=${tprice}&order=${order}">${c.name}</a>
                                            <c:if test="${requestScope.cid==c.id}" >
                                                <ul>
                                                    <c:forEach items="${requestScope.ListSubCategories}" var="s">
                                                        <li class="sub-category"><a ${requestScope.sid==s.id?"class='selected-sub-category'":""} href="category?cid=${c.id}&sid=${s.id}&search=${requestScope.search}&fprice=${fprice}&tprice=${tprice}&order=${order}">${s.name}</a></li>
                                                        </c:forEach>
                                                </ul>
                                            </c:if>
                                        </li>
                                    </c:forEach>

                                </ul>
                            </div>
                            <form action="category">
                                <div class="box">
                                    <span class="filter-header">
                                        Giá
                                    </span>
                                    <c:set value="${requestScope.fprice}" var="fprice"/>
                                    <c:set value="${requestScope.tprice}" var="tprice"/>
                                    <c:set value="${requestScope.order}" var="order"/>
                                    <input type="hidden" value="${category.id}" name="cid"/>
                                    <input type="hidden" value="${subCategory.id}" name="sid"/>
                                    <input type="hidden" name="search" value="${requestScope.search}">
                                    <div class="price-range">
                                        <input type="number" name="fprice" value="${fprice}">&nbsp;đ
                                        <span>-</span>
                                        <input type="text" name="tprice" value="${tprice==0?"":tprice}">&nbsp;đ
                                    </div>
                                    <input type="submit" hidden />

                                </div>
                                <div class="box">
                                    <span class="filter-header">
                                        Sắp xếp theo:
                                    </span>
                                    <ul class="filter-list">
                                        <li>
                                            <div class="group-checkbox">
                                                <input type="radio" onclick="this.form.submit()" ${order==1?"checked":""} name="order" value="1" id="status1">
                                                <label for="status1">
                                                    Giá tăng dần
                                                    <i class='bx bx-check'></i>
                                                </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="group-checkbox">
                                                <input type="radio" onclick="this.form.submit()" ${order==2?"checked":""} name="order" value="2" id="status2">
                                                <label for="status2">
                                                    Giá giảm dần
                                                    <i class='bx bx-check'></i>
                                                </label>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="group-checkbox">
                                                <input type="radio" onclick="this.form.submit()" ${order==3?"checked":""} name="order" value="3" id="status3">
                                                <label for="status3">
                                                    Mới nhất
                                                    <i class='bx bx-check'></i>
                                                </label>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </form>
                        </div>
                        <div class="col-9 col-md-12">
                            <div class="box filter-toggle-box">
                                <button class="btn-flat btn-hover" id="filter-toggle">filter</button>
                            </div>
                            <div class="box">
                                <div class="row" id="products">
                                    <c:forEach items="${requestScope.book}" var="b" >
                                        <div class="col-4 col-md-6 col-sm-12">
                                            <div class="product-card">
                                                <a href="product-detail?cid=${category.id}&sid=${subCategory.id}&bid=${b.id}">
                                                    <div class="product-card-img">
                                                        <img src="${b.image}" alt="">
                                                        <img src="${b.image}" alt="">
                                                    </div>
                                                </a>
                                                <div class="product-card-info">
                                                    <a href="product-detail?cid=${category.id}&sid=${subCategory.id}&bid=${b.id}">
                                                        <div class="product-card-name">
                                                            ${b.name}
                                                        </div>
                                                    </a>

                                                    <div class="product-card-price">
                                                        <span class="curr-price currency">${b.unitPrice*1.2}</span>
                                                        <br>
                                                        <span><del class="currency">${b.unitPrice*1.5}</del></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <c:if test="${requestScope.num!=0}" >
                                <div class="box">
                                    <ul class="pagination">
                                        <c:if test="${requestScope.page!=1}" >
                                            <li><a href="category?cid=${requestScope.cid}&sid=${requestScope.sid}&search=${requestScope.search}&fprice=${fprice}&tprice=${tprice}&order=${order}&page=${requestScope.page-1}"><i class='bx bxs-chevron-left'></i></a></li>
                                                </c:if>  
                                                <c:forEach begin="1" end="${requestScope.num}" var="i">
                                                    <c:if test="${i==requestScope.num and requestScope.page<=requestScope.num-4 and requestScope.num>5}">
                                                <li class="disable-li"><span>...</span></li>
                                                </c:if>  
                                                <c:if test="${i==1 or i==requestScope.num  or (requestScope.page>=requestScope.num-1 and i>=requestScope.num-4) or (requestScope.page>=3 and i>=requestScope.page-2 and i<=requestScope.page+2) or (requestScope.page<3 and i>=2 and i<=5)}">
                                                <li><a ${requestScope.page==i?"class='active'":""} href="category?cid=${requestScope.cid}&sid=${requestScope.sid}&search=${requestScope.search}&fprice=${fprice}&tprice=${tprice}&order=${order}&page=${i}">${i}</a></li>
                                                </c:if>
                                                <c:if test="${i==1 and requestScope.page>4 and requestScope.num>5}">
                                                <li class="disable-li"><span>...</span></li>
                                                </c:if>  
                                            </c:forEach>
                                            <c:if test="${requestScope.page!=requestScope.num}" >
                                            <li><a href="category?cid=${requestScope.cid}&sid=${requestScope.sid}&search=${requestScope.search}&fprice=${fprice}&tprice=${tprice}&order=${order}&page=${requestScope.page+1}"><i class='bx bxs-chevron-right'></i></a></li>
                                                </c:if>
                                    </ul>
                                </div>
                            </c:if>
                            <c:if test="${requestScope.book.size()==0}">
                                <h4 style="color: red">Không có sản phẩm phù hợp tìm kiếm của bạn!</h4>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end products content -->

        <%@include file="footer.jsp" %>

        <!-- app js -->
        <script  src="./js/app.js"></script>
        <script src="./js/products.js"></script>
    </body>
</html>
