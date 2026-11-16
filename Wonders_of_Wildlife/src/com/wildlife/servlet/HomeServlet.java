package com.wildlife.servlet;

import com.wildlife.dao.AnimalDAO;
import com.wildlife.dao.SanctuaryDAO;
import com.wildlife.model.Animal;
import com.wildlife.model.Sanctuary;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller servlet for the Home and Welcome pages.
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"/home", "/homepage"})
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AnimalDAO animalDAO = new AnimalDAO();
    private final SanctuaryDAO sanctuaryDAO = new SanctuaryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Animal> animals = animalDAO.getAllAnimals();
        List<Sanctuary> sanctuaries = sanctuaryDAO.getAllSanctuaries();

        request.setAttribute("animals", animals);
        request.setAttribute("sanctuaries", sanctuaries);

        String path = request.getServletPath();
        if ("/homepage".equals(path)) {
            request.getRequestDispatcher("/homepage.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        }
    }
}
