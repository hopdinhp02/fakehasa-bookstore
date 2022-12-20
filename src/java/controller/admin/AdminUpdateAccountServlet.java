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
import model.Account;

/**
 *
 * @author This Pc
 */
@WebServlet(name="AdminUpdateAccountServlet", urlPatterns={"/admin-update-account"})
public class AdminUpdateAccountServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminUpdateAccountServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUpdateAccountServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("username");
        AdminDAO ad = new AdminDAO();
        Account a = ad.getAccount(username);
        request.setAttribute("account", a);
        request.getRequestDispatcher("admin/admin-update-account.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        AdminDAO ad = new AdminDAO();
        DAO d = new DAO();
        String username = request.getParameter("username");
        Account a = ad.getAccount(username);
        String newPass, confirm;
        newPass = request.getParameter("new");
        confirm = request.getParameter("confirm");
        request.setAttribute("account", a);
        if(newPass.isEmpty()){
            request.setAttribute("ms", "Mật khẩu mới không được để trống!");
            request.getRequestDispatcher("admin/admin-update-account.jsp").forward(request, response);
            
        }else if(!newPass.equals(confirm)){
            request.setAttribute("ms", "Mật khẩu mới và Mật khẩu xác nhận không giống nhau!");
            request.getRequestDispatcher("admin/admin-update-account.jsp").forward(request, response);
            
        }else{
            request.setAttribute("ms", "Password has been changed!");
            d.changePass(a.getUsername(), newPass);
            request.getRequestDispatcher("admin/admin-update-account.jsp").forward(request, response);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
