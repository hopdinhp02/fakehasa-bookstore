/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


/**
 *
 * @author This Pc
 */
@WebServlet(name="AddCartServlet", urlPatterns={"/add-cart"})
public class AddCartServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        DAO d = new DAO();
//        List<Book> allBooks = d.getAllBooks();
        Cookie[] arr=request.getCookies();
        String txt="";
        if(arr!=null){
            for (Cookie c : arr) {
                if(c.getName().equals("cart")){
                    txt+=c.getValue();
                    c.setMaxAge(0);
                    response.addCookie(c);
                }
            }
        }
        String num = request.getParameter("num");
        String id = request.getParameter("id");
        try{
            int bid = Integer.parseInt(id);
            if(d.getBookById(bid).getQuantity()<Integer.parseInt(num)){
                num = Integer.toString(d.getBookById(bid).getQuantity()) ;
            }
        }catch(NumberFormatException e){
            System.out.println(e);
        }
        
        if(txt.isEmpty()){
            txt=id+":"+num;
        }else{
            txt=txt+"/"+id+":"+num;
        }
        Cookie c = new Cookie("cart", txt);
        c.setMaxAge(60*60*24*365);
        response.addCookie(c);
        response.sendRedirect(request.getHeader("referer"));
        
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
        processRequest(request, response);
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
        
        processRequest(request, response);
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
