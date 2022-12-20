<%-- 
    Document   : product-detail
    Created on : Oct 21, 2022, 10:33:34 AM
    Author     : This Pc
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${book.name}</title>
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

        <!-- header -->
        <%@include file="header.jsp" %>
        <!-- end header -->

        <!-- product-detail content -->
        <c:set value="${requestScope.book}" var="book"/>
        <div class="bg-main">
            <div class="container">
                <div class="box">
                    <div class="breadcumb">
                        <a href="./index.html">Trang chủ</a>
                        <span><i class='bx bxs-chevrons-right'></i></span>
                        <a href="category">Thể Loại</a>
                        <c:set value="${requestScope.category}" var="category" />
                        <c:set value="${requestScope.subCategory}" var="subCategory" />
                        <c:if test="${category!=null}">
                            <span><i class='bx bxs-chevrons-right'></i></span>
                            <a href="category?cid=${category.id}">${category.name}</a>
                        </c:if>
                        <c:if test="${subCategory!=null}">
                            <span><i class='bx bxs-chevrons-right'></i></span>
                            <a href="category?cid=${category.id}&sid=${subCategory.id}">${subCategory.name}</a>
                        </c:if>
                        <span><i class='bx bxs-chevrons-right'></i></span>
                        <a href="">${book.name}</a>
                    </div>
                </div>
                <div class="row product-row">
                    <div class="col-5 col-md-12">
                        <div class="product-img" id="product-img">
                            <img src="${book.image}" alt="">
                        </div>
                    </div>
                    <div class="col-7 col-md-12">
                        <div class="product-info">
                            <h1>
                                ${book.name}
                            </h1>
                            <div class="product-info-detail">
                                <span class="product-info-detail-title">Tác giả:</span>
                                <span>${book.author}</span>
                            </div>
                            <div class="product-info-detail">
                                <span class="product-info-detail-title">Nhà xuất bản:</span>
                                <span>${book.publisher}</span>
                            </div>
                            <div class="product-info-detail">
                                <span class="product-info-detail-title">Đánh giá:</span>
                                <span class="rating">
                                    <i class='bx bxs-star'></i>
                                    <i class='bx bxs-star'></i>
                                    <i class='bx bxs-star'></i>
                                    <i class='bx bxs-star'></i>
                                    <i class='bx bxs-star'></i>
                                </span>
                            </div>
                            <div class="product-card-price">
                                <span><del class="currency">${book.unitPrice*1.5}</del></span>
                                <span class="curr-price currency">${book.unitPrice*1.2}</span>
                            </div>
                            <!--                            <div class="product-quantity-wrapper">
                                                            <span class="product-quantity-btn">
                                                                <i class='bx bx-minus'></i>
                                                            </span>
                                                            <span class="product-quantity">1</span>
                                                            <span class="product-quantity-btn">
                                                                <i class='bx bx-plus'></i>
                                                            </span>
                                                        </div>-->
                            <div>
                                <c:if test="${book.quantity!=0}">
                                <form action="add-cart" method="get">
                                    <input type="hidden" name="id" value="${book.id}"/>
                                    <input type="hidden" name="num" value="1"/>
                                    <input type="submit" class="btn-flat btn-hover" value="Thêm vào giỏ hàng"/>
                                </form>
                                    </c:if>
                                <c:if test="${book.quantity==0}">
                                    <h2 style="color: red">Hết hàng</h4>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box">
                    <div class="box-header">
                        Sản phẩm liên quan
                    </div>
                    <div class="row" id="related-products">
                        <c:forEach var="b" items="${requestScope.relatedBooks}">
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
                                            <span class="curr-price currency">${b.unitPrice}</span>
                                            <br>
                                            <span><del class="currency">${b.unitPrice*1.2}</del></span>
                                        </div>
                                    </div>
                                </div>
                            </div>                                               
                        </c:forEach>
                    </div>
                </div>

                <div class="box">
                    <div class="box-header">
                        Thông tin sản phẩm
                    </div>
                    <div class="product-detail-description">
                        <button class="btn-flat btn-hover btn-view-description" id="view-all-description">
                            Xem thêm
                        </button>
                        <div class="product-info-detail">
                            <span class="product-info-detail-title">Mã hàng:</span>
                            <span>${book.id}</span>
                        </div>
                        <div class="product-info-detail">
                            <span class="product-info-detail-title">Tác giả:</span>
                            <span>${book.author}</span>
                        </div>
                        <div class="product-info-detail">
                            <span class="product-info-detail-title">Người dịch:</span>
                            <span>${book.translator}</span>
                        </div>
                        <div class="product-info-detail">
                            <span class="product-info-detail-title">NXB:</span>
                            <span>${book.publisher}</span>
                        </div>
                        <div class="product-info-detail">
                            <span class="product-info-detail-title">Năm xuất bản:</span>
                            <span>${book.publicationDate}</span>
                        </div>
                        <div class="product-info-detail">
                            <span class="product-info-detail-title">Số trang:</span>
                            <span>${book.page}</span>
                        </div>
                        <hr>
                        <div class="product-detail-description-content">
                            ${book.describe}
                        </div>
                    </div>
                </div>
                <div class="box">
                    <div class="box-header">
                        review
                    </div>
                    <div>
                        <div class="user-rate">
                            <div class="user-info">
                                <div class="user-avt">
                                    <img src="./images/tuat.jpg" alt="">
                                </div>
                                <div class="user-name">
                                    <span class="name">tuat tran anh</span>
                                    <span class="rating">
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                    </span>
                                </div>
                            </div>
                            <div class="user-rate-content">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Distinctio ea iste, veritatis nobis amet illum, cum alias magni dolores odio, eius quo excepturi veniam ipsa voluptatibus natus voluptas vero? Aspernatur!
                            </div>
                        </div>
                        <div class="user-rate">
                            <div class="user-info">
                                <div class="user-avt">
                                    <img src="./images/tuat.jpg" alt="">
                                </div>
                                <div class="user-name">
                                    <span class="name">tuat tran anh</span>
                                    <span class="rating">
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                    </span>
                                </div>
                            </div>
                            <div class="user-rate-content">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Distinctio ea iste, veritatis nobis amet illum, cum alias magni dolores odio, eius quo excepturi veniam ipsa voluptatibus natus voluptas vero? Aspernatur!
                            </div>
                        </div>
                        <div class="user-rate">
                            <div class="user-info">
                                <div class="user-avt">
                                    <img src="./images/tuat.jpg" alt="">
                                </div>
                                <div class="user-name">
                                    <span class="name">tuat tran anh</span>
                                    <span class="rating">
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                    </span>
                                </div>
                            </div>
                            <div class="user-rate-content">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Distinctio ea iste, veritatis nobis amet illum, cum alias magni dolores odio, eius quo excepturi veniam ipsa voluptatibus natus voluptas vero? Aspernatur!
                            </div>
                        </div>
                        <div class="user-rate">
                            <div class="user-info">
                                <div class="user-avt">
                                    <img src="./images/tuat.jpg" alt="">
                                </div>
                                <div class="user-name">
                                    <span class="name">tuat tran anh</span>
                                    <span class="rating">
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                    </span>
                                </div>
                            </div>
                            <div class="user-rate-content">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Distinctio ea iste, veritatis nobis amet illum, cum alias magni dolores odio, eius quo excepturi veniam ipsa voluptatibus natus voluptas vero? Aspernatur!
                            </div>
                        </div>
                        <div class="user-rate">
                            <div class="user-info">
                                <div class="user-avt">
                                    <img src="./images/tuat.jpg" alt="">
                                </div>
                                <div class="user-name">
                                    <span class="name">tuat tran anh</span>
                                    <span class="rating">
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                        <i class='bx bxs-star'></i>
                                    </span>
                                </div>
                            </div>
                            <div class="user-rate-content">
                                Lorem ipsum dolor sit amet consectetur adipisicing elit. Distinctio ea iste, veritatis nobis amet illum, cum alias magni dolores odio, eius quo excepturi veniam ipsa voluptatibus natus voluptas vero? Aspernatur!
                            </div>
                        </div>
                        <div class="box">
                            <ul class="pagination">
                                <li><a href="#"><i class='bx bxs-chevron-left'></i></a></li>
                                <li><a href="#" class="active">1</a></li>
                                <li><a href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#">4</a></li>
                                <li><a href="#">5</a></li>
                                <li><a href="#"><i class='bx bxs-chevron-right'></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <!-- end product-detail content -->

        <!-- footer -->
        <%@include file="footer.jsp" %>
        <!-- end footer -->

        <!-- app js -->
        <script src="./js/bootstrap.js"></script>
        <script src="./js/app.js"></script>
        <script src="./js/product-detail.js"></script>
    </body>
</html>
