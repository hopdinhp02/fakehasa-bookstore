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
import java.util.List;
import model.Book;
import model.Cart;
import model.Category;
import model.Item;
import model.SubCategory;

/**
 *
 * @author This Pc
 */
@WebServlet(name = "CategoryServlet", urlPatterns = {"/category"})
public class CategoryServlet extends HttpServlet {

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
            out.println("<title>Servlet Category</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Category at " + request.getContextPath() + "</h1>");
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
        DAO d = new DAO();
//        List<Book> allBooks = d.getAllBooks();
        Cookie[] arr=request.getCookies();
        String txt="";
        if(arr!=null){
            for (Cookie c : arr) {
                if(c.getName().equals("cart")){
                    txt+=c.getValue();
                }
            }
        }
        Cart cart = new Cart(txt);
        List<Item> listItem= cart.getItems();
        int n;
        if(listItem!=null){
            n = listItem.size();
        }else{
            n=0;
        }
        request.setAttribute("sizeCart", n);
        String search = request.getParameter("search")==null?"":request.getParameter("search");
        String cid_raw = request.getParameter("cid");
        String sid_raw = request.getParameter("sid");
        String page_raw = request.getParameter("page");
        String fprice_raw = request.getParameter("fprice");
        String tprice_raw = request.getParameter("tprice");
        String order_raw = request.getParameter("order");
        int bookPerPage = 24;
        
        try {
            int cid = cid_raw==null||cid_raw.equals("")?0:Integer.parseInt(cid_raw);
            int sid = sid_raw==null||sid_raw.equals("")?0:Integer.parseInt(sid_raw);
            int fprice = fprice_raw==null||fprice_raw.equals("")?0:Integer.parseInt(fprice_raw);
            int tprice = tprice_raw==null||tprice_raw.equals("")?0:Integer.parseInt(tprice_raw);
            int order = order_raw==null||order_raw.equals("")?0:Integer.parseInt(order_raw);
            List<SubCategory> list_sub = d.getAllSubCategoryByCID(cid);
            request.setAttribute("cid", cid);
            request.setAttribute("sid", sid);
            int size = d.countBooks(cid, sid, search, fprice, tprice);
            int num = (int)Math.ceil((double)size/bookPerPage);
            int page = page_raw==null?1:Integer.parseInt(page_raw);
            List<Book> list = d.getBooks(cid, sid, search, fprice, tprice, order, page, bookPerPage);
            Category category = d.getCategoryById(cid);
            SubCategory subCategory = d.getSubCategoryByID(sid);
            request.setAttribute("book", list);
            request.setAttribute("num", num);
            request.setAttribute("page", page);
            request.setAttribute("cid", cid);
            request.setAttribute("sid", sid);
            request.setAttribute("fprice", fprice);
            request.setAttribute("tprice", tprice);
            request.setAttribute("order", order);
            request.setAttribute("search", search);
            request.setAttribute("category", category);
            request.setAttribute("subCategory", subCategory);
            request.setAttribute("ListSubCategories", list_sub);
            List<Category> list_c = d.getAllCategories();
            request.setAttribute("ListCategories", list_c);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        request.getRequestDispatcher("products.jsp").forward(request, response);
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
        processRequest(request, response);
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
