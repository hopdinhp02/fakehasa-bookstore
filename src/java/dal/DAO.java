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
import model.Cart;
import model.Category;
import model.Customer;
import model.Item;
import model.Order;
import model.OrderDetail;
import model.SubCategory;

/**
 *
 * @author This Pc
 */
public class DAO extends DBContext {

    public Account getAccount(String username, String password) {
        String sql = "Select * from account where username=? and password=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Account(username, password, rs.getInt(3));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Account> getAccount() {
        List<Account> list = new ArrayList<>();
        String sql = "Select * from account";
        try {
            PreparedStatement st = connection.prepareStatement(sql);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Account(rs.getString(1), rs.getString(2), rs.getInt(3)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Customer getCustomer(String username) {
        String sql = "Select * from customer where username=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4), rs.getString(5), rs.getString(6), rs.getString(7), username);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = "Select * from customer";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getBoolean(4), rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Account register(String username, String password) {
        String sql = "INSERT INTO [dbo].[account]\n"
                + "           ([Username]\n"
                + "           ,[Password],role)\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?,?\n)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            st.setInt(3, 2);
            st.executeUpdate();
            String sql1 = "INSERT INTO [dbo].[Customer]([username])\n"
                    + "     VALUES(?)";
            PreparedStatement st1 = connection.prepareStatement(sql1);
            st1.setString(1, username);
            st1.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return getAccount(username, password);
    }

    public Account changePass(String username, String password) {
        String sql = "update account\n"
                + "set password=?\n"
                + "where username=?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, username);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return getAccount(username, password);
    }

    public void updateCustomerInfo(Customer c) {
        String sql = "UPDATE [dbo].[Customer]\n"
                + "   SET [FistName] = ?\n"
                + "      ,[LastName] = ?\n"
                + "      ,[Gender] = ?\n"
                + "      ,[Phone] = ?\n"
                + "      ,[Email] = ?\n"
                + "      ,[Address] = ?\n"
                + " WHERE [CustomerID] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getFirstName());
            st.setString(2, c.getLastName());
            st.setBoolean(3, c.isGender());
            st.setString(4, c.getPhone());
            st.setString(5, c.getEmail());
            st.setString(6, c.getAddress());
            st.setInt(7, c.getId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    public int insertCustomerWithoutLogin(Customer c) {
        String sql = "INSERT INTO [dbo].[Customer]\n"
                + "           ([FistName]\n"
                + "           ,[LastName]\n"
                + "           ,[Gender]\n"
                + "           ,[Phone]\n"
                + "           ,[Email]\n"
                + "           ,[Address])\n"
                + "     VALUES\n"
                + "           (?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, c.getFirstName());
            st.setString(2, c.getLastName());
            st.setBoolean(3, c.isGender());
            st.setString(4, c.getPhone());
            st.setString(5, c.getEmail());
            st.setString(6, c.getAddress());
            st.executeUpdate();
            String sql1 = "select top 1 [CustomerID] from [Customer] order by [CustomerID] desc";
            PreparedStatement st1 = connection.prepareStatement(sql1);
            ResultSet rs = st1.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return -1;
    }

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "Select * from Category";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Category(rs.getInt("id"), rs.getString("CategoryName")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<SubCategory> getAllSubCategoryByCID(int cid) {
        List<SubCategory> list = new ArrayList<>();
        String sql = "Select * from SubCategory where CategoryID = " + cid;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new SubCategory(rs.getInt("ID"), rs.getNString("SubCategoryName"), rs.getInt("CategoryID")));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public int countBooks(int cid, int sid) {
        String sql = "Select count(*) from Book where 1=1";
        if (sid > 0) {
            sql += " and SubCategoryID = " + sid;
        } else if (cid > 0) {
            sql += " and SubCategoryID in (select id from SubCategory where CategoryID = " + cid + ")";
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

    public int countBooks(int cid, int sid, String search, int fprice, int tprice) {
        String sql = "Select count(*) from Book where 1=1";
        if (sid > 0) {
            sql += " and SubCategoryID = " + sid;
        } else if (cid > 0) {
            sql += " and SubCategoryID in (select id from SubCategory where CategoryID = " + cid + ")";
        }
        sql += " and ([Name] like ? or [Author] like ?)";
        sql += " and [UnitPrice] >= " + fprice;
        if (tprice > 0) {
            sql += " and [UnitPrice] <= " + tprice;
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, "%" + search + "%");
            st.setNString(2, "%" + search + "%");
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    public List<Book> getAllBooks() {
        List<Book> list = new ArrayList<>();
        String sql = "Select * from Book";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
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

    public List<Book> getLastestBooks() {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT top 8 *\n"
                + "  FROM [BookShop_PRJ301].[dbo].[Book]\n"
                + "  order by PublicationDate desc";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
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

    public List<Book> getBestSellingBooks() {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT top 8 [BookID],sum(Quantity) as total_order\n"
                + "FROM [BookShop_PRJ301].[dbo].[OrderDetail]\n"
                + "group by BookID\n"
                + "order by total_order desc";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Book b = getBookById(rs.getInt(1));
                list.add(b);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Book> getBooks(int cid, int sid, String search, int fprice, int tprice, int order, int page, int booksPerPage) {
        List<Book> list = new ArrayList<>();
        String sql = "Select * from Book where 1=1";
        if (sid > 0) {
            sql += " and SubCategoryID = " + sid;
        } else if (cid > 0) {
            sql += " and SubCategoryID in (select id from SubCategory where CategoryID = " + cid + ")";
        }
        sql += " and ([Name] like ? or [Author] like ?) ";
        sql += " and [UnitPrice] >= " + fprice;
        if (tprice > 0) {
            sql += " and [UnitPrice] <= " + tprice;
        }
        switch (order) {
            case 0:
                sql += " ORDER BY BookID \n";
                break;
            case 1:
                sql += " ORDER BY UnitPrice asc \n";
                break;
            case 2:
                sql += " ORDER BY UnitPrice desc \n";
                break;
            case 3:
                sql += " ORDER BY PublicationDate desc \n";
                break;
        }

        sql += " OFFSET " + (page - 1) * booksPerPage + " ROWS FETCH NEXT " + booksPerPage + " ROWS ONLY;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setNString(1, "%" + search + "%");
            st.setNString(2, "%" + search + "%");
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

    public Book getBookById(int id) {
        String sql = "select * from Book where BookID=" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
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
                return b;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Category getCategoryById(int id) {
        String sql = "Select * from Category where ID=" + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Category c = new Category(rs.getInt("id"), rs.getString("CategoryName"));
                return c;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public SubCategory getSubCategoryByID(int id) {
        String sql = "Select * from SubCategory where ID = " + id;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                SubCategory s = new SubCategory(rs.getInt("ID"), rs.getNString("SubCategoryName"), rs.getInt("CategoryID"));
                return s;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Book> getRandomBooks(int cid, int sid, int num) {
        List<Book> list = new ArrayList<>();
        String sql = "Select top " + num + " * from Book where 1=1";
        if (sid > 0) {
            sql += " and SubCategoryID = " + sid;
        } else if (cid > 0) {
            sql += " and SubCategoryID in (select id from SubCategory where CategoryID = " + cid + ")";
        }

        sql += "ORDER BY newid()";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
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

    public void addOrder(Customer c, Cart cart) {
        LocalDate curDate = LocalDate.now();
        String date = curDate.toString();

        try {
            //add order
            String sql = "insert into [Order]([OrderDate] ,[CustomerID],[Total], [State]) values(?,?,?,?)";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, date);
            st.setInt(2, c.getId());
            st.setDouble(3, cart.getTotalMoney());
            st.setInt(4, 1);
            st.executeUpdate();
            //get orderID
            String sql1 = "select top 1 OrderID from [order] order by OrderID desc";
            PreparedStatement st1 = connection.prepareStatement(sql1);
            ResultSet rs = st1.executeQuery();
            //add to table orderDetail
            if (rs.next()) {
                int orderId = rs.getInt("OrderID");
                for (Item i : cart.getItems()) {
                    String sql2 = "INSERT INTO [dbo].[OrderDetail]([OrderID],[BookID],[SalePrice],[Quantity],[Discount],[Profit])\n"
                            + "VALUES(?,?,?,?,?,?)";
                    PreparedStatement st2 = connection.prepareStatement(sql2);
                    st2.setInt(1, orderId);
                    st2.setInt(2, i.getBook().getId());
                    st2.setDouble(3, i.getPrice());
                    st2.setInt(4, i.getQuantity());
                    st2.setDouble(5, 0);
                    st2.setDouble(6, (i.getPrice() - i.getBook().getUnitPrice()) * i.getQuantity());
                    st2.executeUpdate();
                }
            }
            //update quantity of product
            String sql3 = "update Book set quantity=quantity-? where BookId = ?";
            PreparedStatement st3 = connection.prepareStatement(sql3);
            for (Item i : cart.getItems()) {
                st3.setInt(1, i.getQuantity());
                st3.setInt(2, i.getBook().getId());
                st3.executeUpdate();
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Order> getOrderByCustomerId(int customerId) {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order] where CustomerID = " + customerId + " order by [OrderID] desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getString(2), customerId, rs.getDouble(5), rs.getInt(6)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
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

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "select * from [Order] order by OrderDate desc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Order(rs.getInt(1), rs.getString(2), rs.getInt(4), rs.getDouble(5), rs.getInt(6)));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
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

//    public List<Book> getBooks(int cid, int sid) {
//        List<Book> list = new ArrayList<>();
//        String sql = "Select * from Book where 1=1";
//        if (sid > 0) {
//            sql += " and SubCategoryID = " + sid;
//        } else if (cid > 0) {
//            sql += " and SubCategoryID in (select id from SubCategory where CategoryID = " + cid + ")";
//        }
//        try {
//            PreparedStatement st = connection.prepareStatement(sql);
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
//                Book b = new Book();
//                b.setId(rs.getInt(1));
//                b.setName(rs.getNString(2));
//                b.setAuthor(rs.getNString(3));
//                b.setUnitPrice(rs.getInt(4));
//                b.setSubCategoryID(rs.getInt(5));
//                b.setDescribe(rs.getNString(6));
//                b.setPublisher(rs.getNString(7));
//                b.setPublicationDate(rs.getInt(8));
//                b.setPage(rs.getInt(9));
//                b.setTranslator(rs.getNString(10));
//                b.setQuantity(rs.getInt(11));
//                b.setImage(rs.getNString(12));
//                list.add(b);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return list;
//    }
//
//    public List<Book> getBooksByPage(List<Book> books, int start, int end) {
//        List<Book> list = new ArrayList<>();
//        for (int i = start; i < end; i++) {
//            list.add(books.get(i));
//        }
//        return list;
//    }


}
