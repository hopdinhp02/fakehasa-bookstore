<%-- 
    Document   : login
    Created on : Oct 24, 2022, 10:06:08 PM
    Author     : This Pc
--%>

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
    <link rel="stylesheet" href="./css/login.css">

</head>

<body>

    <!-- header -->
    <%@include file="header.jsp" %>
    <!-- end header -->
    <div id="login-form-wrap">
        <h2>Đăng nhập</h2>
        <form id="login-form" action="login" method="post">
            <p>
                <input type="text" id="username" name="user" placeholder="Tên đăng nhập" required>
            </p>
            <p>
                <input type="password" id="pass" name="pass" placeholder="Mật khẩu" required>
            </p>
            <p>
                <input type="submit" id="login" value="Đăng nhập">
            </p>
        </form>
        <p style="color: red">${requestScope.ms}</p>
        <div id="create-account-wrap">
            <p>Bạn chưa phải thành viên? <a href="signup">Đăng ký</a><p>
        </div><!--create-account-wrap-->
    </div><!--login-form-wrap-->
    <!-- partial -->
    <!-- footer -->
    <%@include file="footer.jsp" %>
    <!-- end footer -->

    <!-- app js -->
    <script src="./js/app.js"></script>
    <script src="./js/product-detail.js"></script>
</body>

</html>

