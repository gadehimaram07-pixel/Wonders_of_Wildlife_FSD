package com.wildlife.servlet;

import com.wildlife.dao.AnimalDAO;
import com.wildlife.dao.ContactDAO;
import com.wildlife.dao.SanctuaryDAO;
import com.wildlife.model.AdminUser;
import com.wildlife.model.Animal;
import com.wildlife.model.ContactMessage;
import com.wildlife.model.Sanctuary;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Controller servlet for the Administrator Dashboard.
 * Provides central management to add or delete sanctuaries and animals.
 */
@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin-dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SanctuaryDAO sanctuaryDAO = new SanctuaryDAO();
    private final AnimalDAO animalDAO = new AnimalDAO();
    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminUser") == null) {
            response.sendRedirect("admin-login");
            return;
        }

        List<Sanctuary> sanctuaries = sanctuaryDAO.getAllSanctuaries();
        List<Animal> animals = animalDAO.getAllAnimals();
        List<ContactMessage> messages = contactDAO.getAllMessages();

        int animalCount = animalDAO.getCountByCategory("Animal");
        int birdCount = animalDAO.getCountByCategory("Bird");
        int sanctuaryCount = sanctuaryDAO.getCount();
        int messageCount = contactDAO.getCount();

        request.setAttribute("sanctuaries", sanctuaries);
        request.setAttribute("animals", animals);
        request.setAttribute("messages", messages);
        request.setAttribute("animalCount", animalCount);
        request.setAttribute("birdCount", birdCount);
        request.setAttribute("sanctuaryCount", sanctuaryCount);
        request.setAttribute("messageCount", messageCount);

        request.getRequestDispatcher("/admin-dashboard.jsp").forward(request, response);
    }
}
