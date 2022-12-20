/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Account;
import model.Book;
import model.Cart;
import model.Customer;
import model.Item;

/**
 *
 * @author This Pc
 */
@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAO d = new DAO();
//        List<Book> allBooks = d.getAllBooks();
        Cookie[] arr = request.getCookies();
        String txt = "";
        if (arr != null) {
            for (Cookie c : arr) {
                if (c.getName().equals("cart")) {
                    txt += c.getValue();
                    c.setMaxAge(0);
                    response.addCookie(c);
                }
            }
        }
        if (!txt.isEmpty()) {
            boolean flag = true;
            Cart cart = new Cart(txt);
            for (Item i : cart.getItems()) {
                Book b = d.getBookById(i.getBook().getId());
                if (i.getQuantity() > b.getQuantity()) {
                    flag = false;
                    double price = b.getUnitPrice();
                    Item t = new Item(b, b.getQuantity() - i.getQuantity(), price);
                    cart.addItem(t);
                }
            }
            if (flag == false) {
                List<Item> items = cart.getItems();
                txt = "";
                if (!items.isEmpty()) {
                    txt = items.get(0).getBook().getId() + ":" + items.get(0).getQuantity();
                    for (int i = 1; i < items.size(); i++) {
                        txt += "/" + items.get(i).getBook().getId() + ":" + items.get(i).getQuantity();

                    }
                }
                Cookie c = new Cookie("cart", txt);
                c.setMaxAge(60 * 60 * 24 * 365);
                response.addCookie(c);
                request.setAttribute("cart", cart);
                request.setAttribute("ms", "Đã chỉnh sửa số lượng sách vượt quá cho phép!!!");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }
            HttpSession session = request.getSession();
            Account a = (Account) session.getAttribute("account");
            Customer cus;
            if (a == null) {
                cus = new Customer();
                cus.setId(d.insertCustomerWithoutLogin(cus));

            } else {
                cus = d.getCustomer(a.getUsername());
            }
            String lastName = request.getParameter("lastName");
            String firstName = request.getParameter("firstName");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");

            if (lastName != null && !lastName.isEmpty()) {
                cus.setLastName(lastName);
            }
            if (firstName != null && !firstName.isEmpty()) {
                cus.setFirstName(firstName);
            }
            if (phone != null && !phone.isEmpty()) {
                cus.setPhone(phone);
            }
            if (email != null && !email.isEmpty()) {
                cus.setEmail(email);
            }
            if (address != null && !address.isEmpty()) {
                cus.setAddress(address);
            }
            cus.setGender(Boolean.parseBoolean(gender));
            d.updateCustomerInfo(cus);
            session.setAttribute("customerinfo", cus);
            d.addOrder(cus, cart);
            Cookie c = new Cookie("cart", "");
            c.setMaxAge(0);
            response.addCookie(c);
            request.setAttribute("ms", "Đặt hàng thành công!!");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } else {
            response.sendRedirect("cart");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
