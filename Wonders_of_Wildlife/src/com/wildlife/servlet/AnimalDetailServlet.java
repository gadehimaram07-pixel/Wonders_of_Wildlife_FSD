package com.wildlife.servlet;

import com.wildlife.dao.AnimalDAO;
import com.wildlife.model.Animal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller servlet to view details of a specific animal or bird.
 */
@WebServlet(name = "AnimalDetailServlet", urlPatterns = {"/animal-detail"})
public class AnimalDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AnimalDAO animalDAO = new AnimalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("gallery");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Animal animal = animalDAO.getAnimalById(id);
            if (animal == null) {
                response.sendRedirect("gallery");
                return;
            }
            request.setAttribute("animal", animal);
            request.getRequestDispatcher("/animal-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("gallery");
        }
    }
}
