package com.wildlife.servlet;

import com.wildlife.dao.ContactDAO;
import com.wildlife.model.ContactMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller servlet for Contact inquiries.
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (name != null && email != null && subject != null && message != null &&
            !name.trim().isEmpty() && !email.trim().isEmpty() && !subject.trim().isEmpty() && !message.trim().isEmpty()) {
            ContactMessage msg = new ContactMessage(name.trim(), email.trim(), subject.trim(), message.trim());
            contactDAO.saveMessage(msg);
            response.sendRedirect(request.getContextPath() + "/contact?status=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/contact?status=error");
        }
    }
}
