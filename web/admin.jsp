<%-- 
    Document   : admin
    Created on : Oct 27, 2022, 10:35:16 PM
    Author     : This Pc
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <h1 ><a href="admin">Admin</a></h1>
                        <li class="active"><a href="admin">Dashboard</a></li>
                        <li><a href="admin-account">Account</a></li>
                        <li><a href="admin-customer">Customer</a></li>
                        <li><a href="admin-category">Category</a></li>
                        <li><a href="admin-product">Product</a></li>
                        <li><a href="admin-order">Order</a></li>
                        <li><a href="home">Back to Home</a></li>
                        <li><a href="logout">Log out</a></li>
                    </ul>
                </div>
                <div class="col-10">
                    <div class='row'>
                        &nbsp;
                        <form action="admin">
                            Chart by Month-Year:
                            <input type="month"  name="date" value="${requestScope.date}">
                            <input type="submit" value="Show">
                        </form>
                        <div class="col-6">
                            <canvas id="monthChart" ></canvas>
                        </div>
                        <div class="col-6">
                            <canvas id="yearChart" ></canvas>
                        </div>
                    </div>

                    <jsp:useBean id="d" class="dal.DAO" scope="request"/>
                    <jsp:useBean id="ad" class="dal.AdminDAO" scope="request"/>
                    <h3>Statistic of Revenue/Profit</h3>
                    <table style="width: 100%">
                        <tr>
                            <th></th>
                            <th>Number Of Orders</th>
                            <th>Revenue</th>
                            <th>Profit</th>
                        </tr>
                        <tr>
                            <td>Day</td>
                            <td>${ad.getOrders(1)}</td>
                            <td class="currency">${ad.getRevenues(1)}</td>
                            <td class="currency">${ad.getProfits(1)}</td>
                        </tr>
                        <tr>
                            <td>Month</td>
                            <td>${ad.getOrders(2)}</td>
                            <td class="currency">${ad.getRevenues(2)}</td>
                            <td class="currency">${ad.getProfits(2)}</td>
                        </tr>
                        <tr>
                            <td>Year</td>
                            <td>${ad.getOrders(3)}</td>
                            <td class="currency">${ad.getRevenues(3)}</td>
                            <td class="currency">${ad.getProfits(3)}</td>
                        </tr>
                        <tr>
                            <td>All</td>
                            <td>${ad.getOrders(0)}</td>
                            <td class="currency">${ad.getRevenues(3)}</td>
                            <td class="currency">${ad.getProfits(0)}</td>
                        </tr>
                    </table>
                    <h3>Top Customers of All times</h3>
                    <table style="width: 100%">
                        <tr>
                            <th>CustomerID</th>
                            <th>Number Of Orders</th>
                            <th>Revenue</th>
                            <th>Profit</th>
                        </tr>
                        <c:forEach var="c" items="${ad.getTopCustomers()}">
                            <tr>
                                <td><a href="admin-customer?type=1&search=${c.id}" target="_blank">${c.id}</a></td>
                                <td>${ad.getCustomerOrder(c.id)}</td>
                                <td class="currency">${ad.getCustomerRevenue(c.id)}</td>
                                <td class="currency">${ad.getCustomerProfit(c.id)}</td>
                            </tr>
                        </c:forEach>
                    </table>
                    <h3>Best Selling</h3>
                    <table style="width: 100%">
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
                        <c:forEach items="${d.getBestSellingBooks()}" var="b">
                            <c:set var="id" value="${b.id}"/>
                            <tr>
                                <td><a href="admin-product?type=1&search=${id}" target="_blank">${id}</a></td>
                                <td>${b.name}</td>
                                <td>${b.author}</td>
                                <td>${b.publisher}</td>
                                <td>${b.publicationDate}</td>
                                <td>${b.quantity}</td>
                                <td class="currency">${b.unitPrice}</td>
                                <td>${ad.getSoldQuantity(id)}</td>
                            </tr>
                        </c:forEach>
                    </table>

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

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            function getDaysInMonth(year, month) {
                return new Date(year, month, 0).getDate();
            }
            const monthLabels = [];
            const yearLabels = [];
            const monthProfit = [];
            const monthOrder = [];
            const yearProfit = [];
            const yearOrder = [];
            for (let i = 0; i < getDaysInMonth(${year}, ${month}); i++) {
                monthLabels[i] = i + 1;
            }
            for (let i = 0; i < 12; i++) {
                yearLabels[i] = i + 1;
            }
            <c:set value="${requestScope.month}" var="month"/>
            <c:set value="${requestScope.year}" var="year"/>
            <c:forEach begin="1" end="${requestScope.endDay}" var="i">
            monthProfit[${i-1}] = ${ad.getProfitsByDay(i, month, year)}
            monthOrder[${i-1}] = ${ad.getOrdersByDay(i, month, year)}
            </c:forEach>
            <c:forEach begin="1" end="${requestScope.endMonth}" var="i">
            yearProfit[${i-1}] = ${ad.getProfitsByMonth(i, year)}
            yearOrder[${i-1}] = ${ad.getOrdersByMonth(i, year)}
            </c:forEach>


            const monthData = {
                labels: monthLabels,
                datasets: [
                    {
                        label: 'Profit',
                        backgroundColor: '#CF0A0A',
                        borderColor: '#DC5F00',
                        data: monthProfit,
                        yAxisID: 'y',
                    },
                    {
                        label: 'Order',
                        data: monthOrder,
                        backgroundColor: '#000000',
                        borderColor: '#000000',
                        yAxisID: 'y1',
                    }
                ]
            };
            const yearData = {
                labels: yearLabels,
                datasets: [
                    {
                        label: 'Profit',
                        backgroundColor: '#CF0A0A',
                        borderColor: '#DC5F00',
                        data: yearProfit,
                        yAxisID: 'y',
                    },
                    {
                        label: 'Order',
                        data: yearOrder,
                        backgroundColor: '#000000',
                        borderColor: '#000000',
                        yAxisID: 'y1',
                    }
                ]
            };

            const monthConfig = {
                type: 'line',
                data: monthData,
                options: {
                    responsive: true,
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    stacked: false,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Profit-Order by day'
                        }
                    },
                    scales: {
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',

                            // grid line settings
                            grid: {
                                drawOnChartArea: false, // only want the grid lines for one axis to show up
                            },
                        },
                    }
                },
            };

            const yearConfig = {
                type: 'line',
                data: yearData,
                options: {
                    responsive: true,
                    interaction: {
                        mode: 'index',
                        intersect: false,
                    },
                    stacked: false,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Profit-Order by month'
                        }
                    },
                    scales: {
                        y: {
                            type: 'linear',
                            display: true,
                            position: 'left',
                        },
                        y1: {
                            type: 'linear',
                            display: true,
                            position: 'right',

                            // grid line settings
                            grid: {
                                drawOnChartArea: false, // only want the grid lines for one axis to show up
                            },
                        },
                    }
                },
            };


        </script>
        <script>
            const monthChart = new Chart(
                    document.getElementById('monthChart'),
                    monthConfig
                    );
            const yearChart = new Chart(
                    document.getElementById('yearChart'),
                    yearConfig
                    );
        </script>
    </body>
</html>
