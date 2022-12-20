<%-- 
    Document   : header
    Created on : Oct 24, 2022, 10:41:42 PM
    Author     : This Pc
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>    
    </head>
    <body>

        <!-- header -->
        <header>
            <!-- mobile menu -->
            <div class="mobile-menu bg-second">
                <a href="home" class="mb-logo">Fakehasa</a>
                <span class="mb-menu-toggle" id="mb-menu-toggle">
                    <i class='bx bx-menu'></i>
                </span>
            </div>
            <!-- end mobile menu -->
            <!-- main header -->
            <div class="header-wrapper" id="header-wrapper">
                <span class="mb-menu-toggle mb-menu-close" id="mb-menu-close">
                    <i class='bx bx-x'></i>
                </span>
                <!-- top header -->
                <div class="bg-second">
                    <div class="top-header container">
                        <ul class="devided">
                            <li>
                                <a href="#">+840123456789</a>
                            </li>
                            <li>
                                <a href="#">fakehasa@mail.com</a>
                            </li>
                        </ul>
<!--                        <ul class="devided">
                            <li class="dropdown">
                                <a href="">USD</a>
                                <i class='bx bxs-chevron-down'></i>
                                <ul class="dropdown-content">
                                    <li><a href="#">VND</a></li>
                                    <li><a href="#">JPY</a></li>
                                    <li><a href="#">EUR</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="">ENGLISH</a>
                                <i class='bx bxs-chevron-down'></i>
                                <ul class="dropdown-content">
                                    <li><a href="#">VIETNAMESE</a></li>
                                    <li><a href="#">JAPANESE</a></li>
                                    <li><a href="#">FRENCH</a></li>
                                    <li><a href="#">SPANISH</a></li>
                                </ul>
                            </li>
                            <li><a href="#">ORDER TRACKING</a></li>
                        </ul>-->
                    </div>
                </div>
                <!-- end top header -->
                <!-- mid header -->
                <div class="bg-main">
                    <div class="mid-header container">
                        <a href="home" class="logo">Fakehasa</a>
                        
                        <form action="category" >
                            <input type="hidden" value="${category.id}" name="cid"/>
                            <input type="hidden" value="${subCategory.id}" name="sid"/>
                            <input type="hidden" value="${fprice}" name="fprice"/>
                            <input type="hidden" value="${tprice}" name="tprice"/>
                            <input type="hidden" value="${order}" name="order"/>
                            <div class="search">
                                <input type="text" placeholder="Search" name="search" value="${requestScope.search}">
                                <button style="border: 0px" onclick="this.form.submit()"><i style="display: block" class='bx bx-search-alt'></i></button>
                            </div>
                        </form>

                        <ul class="user-menu">
                            <li><a href="#"><i class='bx bx-bell'></i></a></li>
                            <li><a href="cart"><i class='bx bx-cart'></i></a></li>
                            <li>
                                <c:if test="${sessionScope.account.role!=1}">
                                    <a href="customer-account">
                                </c:if>
                                <c:if test="${sessionScope.account.role==1}">
                                    <a href="admin">
                                </c:if>
                                    <i class='bx bx-user-circle'></i></a></li>
                                    <c:if test="${sessionScope.account!=null}">
                                <li><a href="logout"><i class='bx bx-power-off' ></i></a></li>
                                    </c:if>
                        </ul>
                    </div>
                </div>
                <!-- end mid header -->
                <!-- bottom header -->
                <div class="bg-second">
                    <div class="bottom-header container">
                        <ul class="main-menu">
                            <li><a href="home">Trang chủ</a></li>
                            <!-- mega menu -->
                            <li>
                                <a href="category">Thể loại</i></a>
                            </li>
                            <!-- end mega menu -->
                            <li><a href="#">blog</a></li>
                            <li><a href="#">contact</a></li>
                        </ul>
                    </div>
                </div>
                <!-- end bottom header -->
            </div>
            <!-- end main header -->
        </header>
        <!-- end header -->
    </body>
</html>
