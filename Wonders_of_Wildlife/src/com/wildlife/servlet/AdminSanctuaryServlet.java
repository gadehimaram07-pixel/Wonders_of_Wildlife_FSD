package com.wildlife.servlet;

import com.wildlife.dao.SanctuaryDAO;
import com.wildlife.model.Sanctuary;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller servlet for Admin operations on Wildlife Sanctuaries (Add and Delete).
 */
@WebServlet(name = "AdminSanctuaryServlet", urlPatterns = {"/admin/sanctuary"})
public class AdminSanctuaryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SanctuaryDAO sanctuaryDAO = new SanctuaryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect(request.getContextPath() + "/admin-login");
            return;
        }

        String action = request.getParameter("action");
        if ("add".equalsIgnoreCase(action)) {
            String name = request.getParameter("name");
            String state = request.getParameter("state");
            String description = request.getParameter("description");
            String keyAnimals = request.getParameter("keyAnimals");
            String bestTime = request.getParameter("bestTime");
            String imageUrl = request.getParameter("imageUrl");

            if (name != null && !name.trim().isEmpty() && state != null && !state.trim().isEmpty()) {
                if (imageUrl == null || imageUrl.trim().isEmpty()) {
                    imageUrl = "sanbg.jpg"; // sensible fallback
                }

                Sanctuary sanctuary = new Sanctuary(
                    name.trim(),
                    state.trim(),
                    description != null ? description.trim() : "",
                    keyAnimals != null ? keyAnimals.trim() : "",
                    bestTime != null ? bestTime.trim() : "",
                    imageUrl.trim()
                );
                boolean success = sanctuaryDAO.addSanctuary(sanctuary);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin-dashboard?msg=sanctuary_added");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin-dashboard?err=sanctuary_add_failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard?err=missing_fields");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    boolean success = sanctuaryDAO.deleteSanctuary(id);
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/admin-dashboard?msg=sanctuary_deleted");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin-dashboard?err=sanctuary_delete_failed");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/admin-dashboard?err=invalid_id");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin-dashboard");
        }
    }
}
