/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import controller.*;
import dal.AdminDAO;
import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;

/**
 *
 * @author This Pc
 */
@WebServlet(name = "AdminAccountServlet", urlPatterns = {"/admin-account"})
public class AdminAccountServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAccountServlet at " + request.getContextPath() + "</h1>");
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
        AdminDAO ad = new AdminDAO();
        String type_raw = request.getParameter("type");
        String search = request.getParameter("search") == null ? "" : request.getParameter("search");
        String page_raw = request.getParameter("page");
        int AccPerPage = 24;
        
        try {
            int type = (type_raw == null || type_raw.isEmpty()) ? 0 : Integer.parseInt(type_raw);
            List<Account> all_account = ad.getAccount(type, search);
            int size = all_account.size();
            int num = (int) Math.ceil((double) size / AccPerPage);
            int page = page_raw == null ? 1 : Integer.parseInt(page_raw);
            int start = (page - 1) * AccPerPage;
            int end = Math.min(page * AccPerPage, size);
            List<Account> list = ad.getAccountByPage(all_account, start, end);
            request.setAttribute("page", page);
            request.setAttribute("num", num);
            request.setAttribute("page", page);
            request.setAttribute("account", list);
            request.setAttribute("type", type);
            request.setAttribute("search", search);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }

        request.getRequestDispatcher("admin/admin-account.jsp").forward(request, response);
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
