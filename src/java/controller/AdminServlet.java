/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author This Pc
 */
@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminServlet at " + request.getContextPath() + "</h1>");
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
        LocalDate curDate = LocalDate.now();
        String date = request.getParameter("date") == null||request.getParameter("date").isEmpty()? curDate.getYear() + "-" + curDate.getMonthValue() : request.getParameter("date");
        int month = curDate.getMonthValue();
        int year = curDate.getYear();
        int day = curDate.getDayOfMonth();

        try {
            year = Integer.parseInt(date.split("-")[0]);
            month = Integer.parseInt(date.split("-")[1]);
        } catch (NumberFormatException e) {
            System.out.println(e);
        }
        YearMonth yearMonthObject = YearMonth.of(year, month);
        int daysInMonth = yearMonthObject.lengthOfMonth();
        if (year > curDate.getYear()) {
            request.setAttribute("endDay", 0);
            request.setAttribute("endMonth", 0);
        } else if (curDate.getYear() == year && month > curDate.getMonthValue()) {
            request.setAttribute("endDay", 0);
            request.setAttribute("endMonth", curDate.getMonthValue());
        } else if (curDate.getYear() == year && curDate.getMonthValue() == month) {
            request.setAttribute("endDay", day);
            request.setAttribute("endMonth", curDate.getMonthValue());
        } else if (curDate.getYear() == year && month < curDate.getMonthValue()) {
            request.setAttribute("endDay", daysInMonth);
            request.setAttribute("endMonth", curDate.getMonthValue());
        } else {
            request.setAttribute("endDay", daysInMonth);
            request.setAttribute("endMonth", 12);
        }
        request.setAttribute("date", date);
        request.setAttribute("month", month);
        request.setAttribute("year", year);
        request.getRequestDispatcher("admin.jsp").forward(request, response);
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
