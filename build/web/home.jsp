<%-- 
    Document   : home
    Created on : Oct 25, 2022, 11:11:20 PM
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
    </head>
    <body>
        <%@include file="header.jsp" %>
        <!-- hero section -->
        <div class="hero">
            <div class="slider">
                <div class="container">
                    <!-- slide item -->
                    <div class="slide active">
                        <div class="info">
                            <div class="info-content">
                                <h3 class="top-down">
                                    Albert Rutherford
                                </h3>
                                <h2 class="top-down trans-delay-0-2">
                                    Rèn Luyện Tư Duy Phản Biện
                                </h2>
                                <p class="top-down trans-delay-0-4">
                                    Như bạn có thể thấy, chìa khóa để trở thành một người có tư duy phản biện tốt chính là sự tự nhận thức. Bạn cần phải đánh giá trung thực những điều trước đây bạn nghĩ là đúng, cũng như quá trình suy nghĩ đã dẫn bạn tới những kết luận đó. Nếu bạn không có những lý lẽ hợp lý, hoặc nếu suy nghĩ của bạn bị ảnh hưởng bởi những kinh nghiệm và cảm xúc, thì lúc đó hãy cân nhắc sử dụng tư duy phản biện! Bạn cần phải nhận ra được rằng con người, kể từ khi sinh ra, rất giỏi việc đưa ra những lý do lý giải cho những suy nghĩ khiếm khuyết của mình.
                                </p>
                                <div class="top-down trans-delay-0-6">
                                    <button onclick="location.href = 'product-detail?cid=3&sid=&bid=4178'" class="btn-flat btn-hover">
                                        <span>Chi tiết</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="img top-down">
                            <img src="./images/ren-luyen-tu-duy-phan-bien.jpg" alt="">
                        </div>
                    </div>
                    <!-- end slide item -->
                    <!-- slide item -->
                    <div class="slide">
                        <div class="info">
                            <div class="info-content">
                                <h3 class="top-down">
                                    Michael Goodwin
                                </h3>
                                <h2 class="top-down trans-delay-0-2">
                                    Economix
                                </h2>
                                <p class="top-down trans-delay-0-4">
                                    Nếu các bạn từng tìm cách hiểu những khái niệm kinh tế qua việc đọc vô số giáo trình kinh tế học, nhưng vẫn thấy thật khó hình dung được bức tranh toàn cảnh về bộ môn này, thì cuốn sách sẽ cung cấp cho các bạn một mảnh ghép hoàn chỉnh cho những mảnh nho nhỏ mà các bạn đã đọc qua.

                                    Chúng ta sẽ hiểu rõ hơn về những khái niệm kinh tế cơ bản cùng những học thuyết kinh tế lớn còn ảnh hưởng tới ngày nay, qua tư tưởng của các nhà kinh tế học lớn như: Adam Smith, John Keynes...

                                </p>
                                <div class="top-down trans-delay-0-6">
                                    <button onclick="location.href = 'product-detail?cid=1&sid=5&bid=3203'" class="btn-flat btn-hover">
                                        <span>Chi tiết</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="img right-left">
                            <img src="./images/economix.jpg" alt="">
                        </div>
                    </div>
                    <!-- end slide item -->
                    <!-- slide item -->
                    <div class="slide">
                        <div class="info">
                            <div class="info-content">
                                <h3 class="top-down">
                                    Mario Puzo
                                </h3>
                                <h2 class="top-down trans-delay-0-2">
                                    Bố Già 
                                </h2>
                                <p class="top-down trans-delay-0-4">
                                    Thế giới ngầm được phản ánh trong tiểu thuyết Bố già là sự gặp gỡ giữa một bên là ý chí cương cường và nền tảng gia tộc chặt chẽ theo truyền thống mafia xứ Sicily với một bên là xã hội Mỹ nhập nhằng đen trắng, mảnh đất màu mỡ cho những cơ hội làm ăn bất chính hứa hẹn những món lợi kếch xù. Trong thế giới ấy, hình tượng Bố già được tác giả dày công khắc họa đã trở thành bức chân dung bất hủ trong lòng người đọc. Từ một kẻ nhập cư tay trắng đến ông trùm tột đỉnh quyền uy, Don Vito Corleone là con rắn hổ mang thâm trầm, nguy hiểm khiến kẻ thù phải kiềng nể, e dè, nhưng cũng được bạn bè, thân quyến xem như một đấng toàn năng đầy nghĩa khí. Nhân vật trung tâm ấy đồng thời cũng là hiện thân của một pho triết lí rất “đời” được nhào nặn từ vốn sống của hàng chục năm lăn lộn giữa chốn giang hồ bao phen vào sinh ra tử, vì thế mà có ý kiến cho rằng “Bố già là sự tổng hòa của mọi hiểu biết. Bố già là đáp án cho mọi câu hỏi”.
                                </p>
                                <div class="top-down trans-delay-0-6">
                                    <button onclick="location.href = 'product-detail?cid=2&sid=&bid=3519'" class="btn-flat btn-hover">
                                        <span>Chi tiết</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="img left-right">
                            <img src="./images/bo-gia.jpg" alt="">
                        </div>
                    </div>
                    <!-- end slide item -->
                </div>
                <!-- slider controller -->
                <button class="slide-controll slide-next">
                    <i class='bx bxs-chevron-right'></i>
                </button>
                <button class="slide-controll slide-prev">
                    <i class='bx bxs-chevron-left'></i>
                </button>
                <!-- end slider controller -->
            </div>
        </div>
        <!-- end hero section -->

        <!-- promotion section -->
        <div class="promotion">
            <div class="row">
                <div class="col-4 col-md-12 col-sm-12">
                    <div class="promotion-box">
                        <div class="text">
                            <h3>Kinh tế</h3>
                            <button onclick="location.href = 'category?cid=1'" class="btn-flat btn-hover"><span>Tìm kiếm</span></button>
                        </div>
                        <img src="./images/tren-dinh-pho-wall.png" alt="">
                    </div>
                </div>
                <div class="col-4 col-md-12 col-sm-12">
                    <div class="promotion-box">
                        <div class="text">
                            <h3>Văn học</h3>
                            <button onclick="location.href = 'category?cid=2'" class="btn-flat btn-hover"><span>Tìm kiếm</span></button>
                        </div>
                        <img src="./images/than-thoai-bac-au.png" alt="">
                    </div>
                </div>
                <div class="col-4 col-md-12 col-sm-12">
                    <div class="promotion-box">
                        <div class="text">
                            <h3>Manga - Comic</h3>
                            <button onclick="location.href = 'category?cid=5'" class="btn-flat btn-hover"><span>Tìm kiếm</span></button>
                        </div>
                        <img src="./images/one-piece.png" alt="">
                    </div>
                </div>
            </div>
        </div>
        <!-- end promotion section -->

        <!-- product list -->
        <div class="section">
            <div class="container">
                <div class="section-header">
                    <h2>Latest product</h2>
                </div>
                <div class="row" id="latest-products">
                    <c:forEach var="b" items="${requestScope.latest}">
                        <div class="col-3 col-md-6 col-sm-12">
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
                                        <span><del class="currency">${b.unitPrice*1.5}</del></span>
                                        <span class="curr-price currency">${b.unitPrice*1.2}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="section-footer">
                    <a href="category" class="btn-flat btn-hover">Xem thêm</a>
                </div>
            </div>
        </div>
        <!-- end product list -->

        <!-- special product -->
        <div class="bg-second">
            <div class="section container">
                <div class="row">
                    <div class="col-4 col-md-4">
                        <div class="sp-item-img">
                            <img src="./images/dr.stone---tap-19---thanh-pho-ngo-1-trieu-dan.png" alt="">
                        </div>
                    </div>
                    <div class="col-7 col-md-8">
                        <div class="sp-item-info">
                            <div class="sp-item-name">Dr.STONE - Tập 19: Thành Phố Ngô 1 Triệu Dân</div>
                            <p class="sp-item-description">
                                Các thành viên của Vương quốc khoa học phân tán ra để tiếp tục triển khai kế hoạch chế tác liều chết hòng bắt giữ Dr. Xeno!! Mặt khác, ở phe địch cũng đang phát triển một “vũ khí bí mật” gây sốc!! Trận quyết chiến khoa học vô tiền 
                                khoáng hậu sẽ là một trận đấu căng thẳng nhằm tranh giành quyền chi phối bầu trời, mặt đất và mặt nước!!
                            </p>
                            <button onclick="location.href = 'product-detail?cid=5&sid=&bid=5040'" class="btn-flat btn-hover">Chi tiết</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- end special product -->

        <!-- product list -->
        <div class="section">
            <div class="container">
                <div class="section-header">
                    <h2>best selling</h2>
                </div>
                <div class="row" id="best-products">
                    <c:forEach var="b" items="${requestScope.best_selling}">
                        <div class="col-3 col-md-6 col-sm-12">
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
                                        <span><del class="currency">${b.unitPrice*1.5}</del></span>
                                        <span class="curr-price currency">${b.unitPrice*1.2}</span>
                                    </div>
                                </div>
                            </div>
                        </div>                                               
                    </c:forEach>
                </div>
                <div class="section-footer">
                    <a href="category" class="btn-flat btn-hover">Xem thêm</a>
                </div>
            </div>
        </div>
        <!-- end product list -->


        <%@include file="footer.jsp" %>
        <!-- app js -->
        <script src="./js/app.js"></script>
        <script src="./js/index.js"></script>
    </body>
</html>
