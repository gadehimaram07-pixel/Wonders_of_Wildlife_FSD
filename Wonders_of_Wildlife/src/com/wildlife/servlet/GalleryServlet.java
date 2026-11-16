package com.wildlife.servlet;

import com.wildlife.dao.AnimalDAO;
import com.wildlife.model.Animal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller servlet for the Wildlife Gallery.
 * Supports filtering by category ('Animal', 'Bird', or all).
 */
@WebServlet(name = "GalleryServlet", urlPatterns = {"/gallery"})
public class GalleryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AnimalDAO animalDAO = new AnimalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        List<Animal> animals;

        if (category != null && !category.trim().isEmpty() && !"All".equalsIgnoreCase(category)) {
            animals = animalDAO.getAnimalsByCategory(category);
        } else {
            animals = animalDAO.getAllAnimals();
            category = "All";
        }

        request.setAttribute("animals", animals);
        request.setAttribute("selectedCategory", category);
        request.getRequestDispatcher("/gallery.jsp").forward(request, response);
    }
}
