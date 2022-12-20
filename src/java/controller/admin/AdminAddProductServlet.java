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
import model.Book;

/**
 *
 * @author This Pc
 */
@WebServlet(name="AdminAddProductServlet", urlPatterns={"/add-product"})
public class AdminAddProductServlet extends HttpServlet {
   
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
            out.println("<title>Servlet AdminAddProductServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAddProductServlet at " + request.getContextPath () + "</h1>");
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
        request.getRequestDispatcher("admin/admin-add-product.jsp").forward(request, response);
        
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
        String name = request.getParameter("name");
        String author = request.getParameter("author");
        String unitPrice_raw = request.getParameter("unitPrice");
        String subCategoryID_raw = request.getParameter("subCategoryID");
        String describe = request.getParameter("describe");
        String publisher = request.getParameter("publisher");
        String publicationDate_raw = request.getParameter("publicationDate");
        String page_raw = request.getParameter("page");
        String translator = request.getParameter("translator");
        String quantity_raw = request.getParameter("quantity");
        String image = request.getParameter("image");
        int unitPrice, subCategoryID, publicationDate, page, quantity;
        AdminDAO ad = new AdminDAO();
        try{
            unitPrice = Integer.parseInt(unitPrice_raw);
            subCategoryID = Integer.parseInt(subCategoryID_raw);
            publicationDate = Integer.parseInt(publicationDate_raw);
            page = Integer.parseInt(page_raw);
            quantity = Integer.parseInt(quantity_raw);
            
               ad.addBook(new Book(-1, name, author, unitPrice, subCategoryID, describe, publisher, publicationDate, page, translator, quantity, image));
                

        }catch(NumberFormatException e){
            System.out.println(e);
        }
        response.sendRedirect("admin-product");
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
