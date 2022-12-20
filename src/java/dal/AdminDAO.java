/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Book;
import model.Customer;
import model.Order;
import model.OrderDetail;

/**
 *
 * @author This Pc
 */
public class AdminDAO extends DBContext {

    public List<Account> getAccount(int type, String search) {
        List<Account> list = new ArrayList<>();
        String sql = "Select * from account where username like ?";
        if (type > 0) {
            sql += " and role = ? ";
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, "%" + search + "%");
            if (type > 0) {
                st.setInt(2, type);
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getString(1), rs.getString(2), rs.getInt(3)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Account> getAccountByPage(List<Account> acc, int start, int end) {
        List<Account> list = new ArrayList<>();
        for (int i = start; i < end; i++) {
            list.add(acc.get(i));
        }
        return list;
    }

    public void addNewCategory(String name) {
        String sql = "INSERT INTO [dbo].[Category]\n"
                + "           ([CategoryName])\n"
                + "     VALUES (?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, name);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addBook(Book b) {
        String sql = "INSERT INTO [dbo].[Book]\n"
                + "           ([Name]\n"
                + "           ,[Author]\n"
                + "           ,[UnitPrice]\n"
                + "           ,[SubCategoryID]\n"
                + "           ,[Describe]\n"
                + "           ,[Publisher]\n"
                + "           ,[PublicationDate]\n"
                + "           ,[page]\n"
                + "           ,[Translator]\n"
                + "           ,[Quantity]\n"
                + "           ,[Image])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, b.getName());
            st.setNString(2, b.getAuthor());
            st.setInt(3, b.getUnitPrice());
            st.setInt(4, b.getSubCategoryID());
            st.setNString(5, b.getDescribe());
            st.setNString(6, b.getPublisher());
            st.setInt(7, b.getPublicationDate());
            st.setInt(8, b.getPage());
            st.setNString(9, b.getTranslator());
            st.setInt(10, b.getQuantity());
            st.setNString(11, b.getImage());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addNewSubCategory(int cid, String name) {
        String sql = "INSERT INTO [dbo].[SubCategory]\n"
                + "           ([SubCategoryName]\n"
                + "           ,[CategoryID])\n"
                + "     VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, name);
            st.setInt(2, cid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Customer> getCustomers(int type, String search) {
        List<Customer> list = new ArrayList<>();
        String sql = "Select * from customer where 1=1 ";
        switch (type) {
            case 1:
                if (search == null || search.isEmpty()) {
                    sql += " and CustomerID = CustomerID";
                } else {
                    sql += " and CustomerID = ?";
                }
                break;
            case 2:
                sql += " and FistName Like ? or [LastName] like ?";
                break;
            case 3:
                sql += "and [Phone] Like ?";
                break;
            case 4:
                sql += "and [Email] Like ?";
                break;
            case 5:
                sql += "and [Address] Like ?";
                break;
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            switch (type) {
                case 1:
                    if (search != null && !search.isEmpty()) {
                        st.setString(1, search);
                    }
                    break;
                case 2:
                    st.setNString(1, "%" + search + "%");
                    st.setNString(2, "%" + search + "%");
                    break;
                default:
                    st.setNString(1, "%" + search + "%");
                    break;
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Customer> getCustomersByPage(List<Customer> cus, int start, int end) {
        List<Customer> list = new ArrayList<>();
        for (int i = start; i < end; i++) {
            list.add(cus.get(i));
        }
        return list;
    }

    public void deleteCategory(int cid) {
        String sql = "DELETE FROM [dbo].[Category]\n"
                + "      WHERE ID = " + cid;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public int deleteBook(int id) {
        String sql = "Delete from [dbo].[Book]\n"
                + "where BookID=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            return st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public void deleteSubCategory(int sid) {
        String sql = "DELETE FROM [dbo].[SubCategory]\n"
                + "      WHERE ID = " + sid;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Order> getOrders(int type, String search, String date, int state) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order] where 1 = 1 ";
        if (type == 1) {
            if (search == null || search.isEmpty()) {
                sql += " and OrderID = OrderID ";
            } else {
                sql += " and OrderID = ? ";
            }
        } else if (type == 2) {
            if (search == null || search.isEmpty()) {
                sql += " and CustomerID = CustomerID ";
            } else {
                sql += " and CustomerID = ? ";
            }
        }
        if (date != null && !date.isEmpty()) {
            sql += " and OrderDate = ? ";
        }
        if (state != 0) {
            sql += " and state = ? ";
        }
        sql += " order by OrderDate desc";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if (search != null && !search.isEmpty()) {
                st.setString(1, search);
                if (date != null && !date.isEmpty()) {
                    st.setString(2, date);
                    if (state != 0) {
                        st.setInt(3, state);
                    }
                } else if (state != 0) {
                    st.setInt(2, state);
                }
            } else if (date != null && !date.isEmpty()) {
                st.setString(1, date);
                if (state != 0) {
                    st.setInt(2, state);
                }
            } else if (state != 0) {
                st.setInt(1, state);
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getString(2), rs.getInt(4), rs.getDouble(5), rs.getInt(6)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Order> getOrdersByPage(List<Order> or, int start, int end) {
        List<Order> list = new ArrayList<>();
        for (int i = start; i < end; i++) {
            list.add(or.get(i));
        }
        return list;
    }

    public int countBooks(int type, String search, int state, int cid) {

        String sql = "Select count(*) from Book where 1=1";
        switch (type) {
            case 1:
                if (search == null || search.isEmpty()) {
                    sql += " and BookID = BookID";
                } else {
                    sql += " and BookID = ?";
                }
                break;
            case 2:
                sql += " and Name Like ? ";
                break;
            case 3:
                sql += " and Author Like ? ";
                break;
            case 4:
                sql += " and Publisher Like ? ";
                break;
        }
        if (state == 0) {
            sql += " and Quantity = 0 ";
        } else {
            sql += " and Quantity > 0 ";
        }
        if (cid > 0) {
            sql += " and SubCategoryID in (select id from SubCategory where CategoryID = " + cid + ")";
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if (type == 1) {
                if (search != null && !search.isEmpty()) {
                    st.setNString(1, search);
                }
            } else {
                st.setNString(1, "%" + search + "%");
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Book> searchBooksByAdmin(int type, String search, int cid, int state, int page, int booksPerPage) {
        List<Book> list = new ArrayList<>();
        String sql = "Select * from Book where 1=1";
        switch (type) {
            case 1:
                if (search == null || search.isEmpty()) {
                    sql += " and BookID = BookID";
                } else {
                    sql += " and BookID = ?";
                }
                break;
            case 2:
                sql += " and Name Like ? ";
                break;
            case 3:
                sql += " and Author Like ? ";
                break;
            case 4:
                sql += " and Publisher Like ? ";
                break;
        }
        if (state == 0) {
            sql += " and Quantity = 0 ";
        } else {
            sql += " and Quantity > 0 ";
        }
        if (cid > 0) {
            sql += " and SubCategoryID in (select id from SubCategory where CategoryID = " + cid + ")";
        }

        sql += " ORDER BY BookID \n"
                + "OFFSET " + (page - 1) * booksPerPage + " ROWS FETCH NEXT " + booksPerPage + " ROWS ONLY;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if (type == 1) {
                if (search != null && !search.isEmpty()) {
                    st.setNString(1, search);
                }
            } else {
                st.setNString(1, "%" + search + "%");
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setId(rs.getInt(1));
                b.setName(rs.getNString(2));
                b.setAuthor(rs.getNString(3));
                b.setUnitPrice(rs.getInt(4));
                b.setSubCategoryID(rs.getInt(5));
                b.setDescribe(rs.getNString(6));
                b.setPublisher(rs.getNString(7));
                b.setPublicationDate(rs.getInt(8));
                b.setPage(rs.getInt(9));
                b.setTranslator(rs.getNString(10));
                b.setQuantity(rs.getInt(11));
                b.setImage(rs.getNString(12));
                list.add(b);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void renameCategory(int cid, String name) {
        String sql = "UPDATE [dbo].[Category]\n"
                + "   SET [CategoryName] = ?\n"
                + " WHERE ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, name);
            st.setInt(2, cid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void renameSubCategory(int sid, String name) {
        String sql = "UPDATE [dbo].[SubCategory]\n"
                + "   SET [SubCategoryName] = ?\n"
                + " WHERE ID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, name);
            st.setInt(2, sid);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Account getAccount(String username) {
        String sql = "Select * from account where username=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(username, rs.getString(2), rs.getInt(3));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Customer getCustomer(int id) {
        String sql = "Select * from customer where CustomerID=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updateBook(Book b) {
        String sql = "UPDATE [dbo].[Book]\n"
                + "   SET [Name] = ?\n"
                + "      ,[Author] = ?\n"
                + "      ,[UnitPrice] = ?\n"
                + "      ,[SubCategoryID] = ?\n"
                + "      ,[Describe] = ?\n"
                + "      ,[Publisher] = ?\n"
                + "      ,[PublicationDate] = ?\n"
                + "      ,[page] = ?\n"
                + "      ,[Translator] = ?\n"
                + "      ,[Quantity] = ?\n"
                + "      ,[Image] = ?\n"
                + " WHERE [BookID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, b.getName());
            st.setNString(2, b.getAuthor());
            st.setInt(3, b.getUnitPrice());
            st.setInt(4, b.getSubCategoryID());
            st.setNString(5, b.getDescribe());
            st.setNString(6, b.getPublisher());
            st.setInt(7, b.getPublicationDate());
            st.setInt(8, b.getPage());
            st.setNString(9, b.getTranslator());
            st.setInt(10, b.getQuantity());
            st.setNString(11, b.getImage());
            st.setInt(12, b.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void updateAccountRole(String username, int role) {
        String sql = "UPDATE [dbo].[account]\n"
                + "   SET [role] = ?\n"
                + " WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, role);
            st.setNString(2, username);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public void updateOrderState(int orderId, int state) {
        String sql = "UPDATE [dbo].[Order]\n"
                + "   SET [State] = ?\n"
                + " WHERE OrderID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, state);
            st.setInt(2, orderId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void cancelOrder(int orderId) {
        List<OrderDetail> list = getOrderDetailByOrderId(orderId);
        String sql = "UPDATE [dbo].[OrderDetail]\n"
                + "   SET [Profit] = 0\n"
                + " WHERE OrderID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            st.executeUpdate();
            String sql1 = "update Book set quantity=quantity+? where BookId = ?";
            PreparedStatement st1 = connection.prepareStatement(sql1);
            for (OrderDetail i : list) {
                st1.setInt(1, i.getQuantity());
                st1.setInt(2, i.getBookId());
                st1.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<OrderDetail> getOrderDetailByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "select * from OrderDetail where OrderID = " + orderId;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new OrderDetail(orderId, rs.getInt(2), rs.getInt(3), rs.getInt(4)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;

    }

    public List<Order> getOrderByCustomerId(int customerId, int type, String search, String date, int state) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order] where CustomerID = " + customerId;
        if (type == 1) {
            if (search == null || search.isEmpty()) {
                sql += " and OrderID = OrderID ";
            } else {
                sql += " and OrderID = ? ";
            }
        } else if (type == 2) {
            if (search == null || search.isEmpty()) {
                sql += " and CustomerID = CustomerID ";
            } else {
                sql += " and CustomerID = ? ";
            }
        }
        if (date != null && !date.isEmpty()) {
            sql += " and OrderDate = ? ";
        }
        if (state != 0) {
            sql += " and state = ? ";
        }
        sql += " order by [OrderDate] desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if (search != null && !search.isEmpty()) {
                st.setString(1, search);
                if (date != null && !date.isEmpty()) {
                    st.setString(2, date);
                    if (state != 0) {
                        st.setInt(3, state);
                    }
                } else if (state != 0) {
                    st.setInt(2, state);
                }
            } else if (date != null && !date.isEmpty()) {
                st.setString(1, date);
                if (state != 0) {
                    st.setInt(2, state);
                }
            } else if (state != 0) {
                st.setInt(1, state);
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getString(2), customerId, rs.getDouble(5), rs.getInt(6)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Order> getOrderOfUserByPage(List<Order> all_order, int start, int end) {
        List<Order> list = new ArrayList<>();
        for (int i = start; i < end; i++) {
            list.add(all_order.get(i));
        }
        return list;
    }

    public double getProfit(int orderID) {
        String sql = "SELECT sum([Profit]) as Profit\n"
                + "  FROM [BookShop_PRJ301].[dbo].[OrderDetail]\n where [OrderID] = ?"
                + "  group by [OrderID]";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getCustomerRevenue(int id) {
        String sql = "SELECT CustomerID, sum(total) as revenue\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] \n"
                + "  where CustomerID = ? and state != 7 \n"
                + "  group by CustomerID";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(2);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getCustomerProfit(int id) {
        String sql = "SELECT CustomerID, sum(Profit) as Profit\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] inner join OrderDetail on [Order].OrderID = OrderDetail.OrderID\n"
                + "  where CustomerID = ? group by CustomerID\n"
                + "  order by Profit desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(2);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getSoldQuantity(int bookID) {
        String sql = "SELECT [BookID],sum(Quantity) as total_order\n"
                + "FROM [BookShop_PRJ301].[dbo].[OrderDetail]\n"
                + "where [BookID] = ? "
                + "group by BookID\n";
//        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, bookID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(2);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public int getOrders(int type) {
        LocalDate curDate = LocalDate.now();
        String date = curDate.toString();
        String sql = "SELECT count([Order].OrderID)\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] where 1=1 ";
        switch (type) {
            case 1:
                sql += " and OrderDate = '" + date + "'";
                break;
            case 2:
                sql += " and month(OrderDate) = " + curDate.getMonthValue() + " and year(OrderDate) = " + curDate.getYear();
                break;
            case 3:
                sql += " and year(OrderDate) = " + curDate.getYear();
                break;
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getRevenues(int type) {
        LocalDate curDate = LocalDate.now();
        String date = curDate.toString();
        String sql = "SELECT sum(Total) FROM [BookShop_PRJ301].[dbo].[Order] where State != 7 ";
        switch (type) {
            case 1:
                sql += " and OrderDate = '" + date + "'";
                break;
            case 2:
                sql += " and month(OrderDate) = " + curDate.getMonthValue() + " and year(OrderDate) = " + curDate.getYear();
                break;
            case 3:
                sql += " and year(OrderDate) = " + curDate.getYear();
                break;
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getProfits(int type) {
        LocalDate curDate = LocalDate.now();
        String date = curDate.toString();
        String sql = "SELECT sum(Profit)\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] inner join OrderDetail on [Order].OrderID = OrderDetail.OrderID\n"
                + "  where 1=1 ";
        switch (type) {
            case 1:
                sql += " and OrderDate = '" + date + "'";
                break;
            case 2:
                sql += " and month(OrderDate) = " + curDate.getMonthValue() + " and year(OrderDate) = " + curDate.getYear();
                break;
            case 3:
                sql += " and year(OrderDate) = " + curDate.getYear();
                break;
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Customer> getTopCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT top 5 CustomerID, sum(Profit) as Profit\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] inner join OrderDetail on [Order].OrderID = OrderDetail.OrderID\n"
                + "  group by CustomerID\n"
                + "  order by Profit desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(getCustomer(rs.getInt(1)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int getCustomerOrder(int id) {
        String sql = "SELECT CustomerID, count(OrderID) as [order]\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] \n"
                + "  where CustomerID = ?\n"
                + "  group by CustomerID";
//        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(2);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getProfitsByDay(int day, int month, int year) {
//        LocalDate curDate = LocalDate.now();

        String sql = "SELECT sum(Profit)\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] inner join OrderDetail on [Order].OrderID = OrderDetail.OrderID\n"
                + "  where 1=1 ";

        sql += " and day(OrderDate) = " + day + " and month(OrderDate) = " + month + " and year(OrderDate) = " + year;
//        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getOrdersByDay(int day, int month, int year) {
//        LocalDate curDate = LocalDate.now();

        String sql = "SELECT count([Order].OrderID)\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] where 1=1 ";

        sql += " and day(OrderDate) = " + day + " and month(OrderDate) = " + month + " and year(OrderDate) = " + year;
//        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getProfitsByMonth(int month, int year) {
//        LocalDate curDate = LocalDate.now();

        String sql = "SELECT sum(Profit)\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] inner join OrderDetail on [Order].OrderID = OrderDetail.OrderID\n"
                + "  where 1=1 ";

        sql += " and month(OrderDate) = " + month + " and year(OrderDate) = " + year;
//        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public double getOrdersByMonth(int month, int year) {
//        LocalDate curDate = LocalDate.now();

        String sql = "SELECT count([Order].OrderID)\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Order] where 1=1 ";

        sql += " and month(OrderDate) = " + month + " and year(OrderDate) = " + year;
//        System.out.println(sql);
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }
}
