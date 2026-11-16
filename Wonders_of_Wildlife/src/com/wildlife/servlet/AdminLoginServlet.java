package com.wildlife.servlet;

import com.wildlife.dao.AdminDAO;
import com.wildlife.model.AdminUser;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller servlet for Admin Login.
 * Only administrators log in here to access the Admin Panel.
 */
@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/admin-login"})
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminUser") != null) {
            response.sendRedirect("admin-dashboard");
            return;
        }
        request.getRequestDispatcher("/admin-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String uname = request.getParameter("username");
        String pass = request.getParameter("password");

        if (uname != null) uname = uname.trim();
        if (pass != null) pass = pass.trim();

        AdminUser user = adminDAO.validate(uname, pass);
        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("adminUser", user);
            response.sendRedirect("admin-dashboard");
        } else {
            response.sendRedirect("admin-login?error=invalid");
        }
    }
}
