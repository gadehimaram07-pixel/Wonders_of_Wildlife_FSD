package com.wildlife.servlet;

import com.wildlife.dao.AnimalDAO;
import com.wildlife.model.Animal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Controller servlet for Admin operations on Animals and Birds (Add and Delete).
 */
@WebServlet(name = "AdminAnimalServlet", urlPatterns = {"/admin/animal"})
public class AdminAnimalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AnimalDAO animalDAO = new AnimalDAO();

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
            String category = request.getParameter("category");
            String scientificName = request.getParameter("scientificName");
            String habitat = request.getParameter("habitat");
            String foundIn = request.getParameter("foundIn");
            String description = request.getParameter("description");
            String imageUrl = request.getParameter("imageUrl");

            if (name != null && !name.trim().isEmpty()) {
                if (imageUrl == null || imageUrl.trim().isEmpty()) {
                    imageUrl = "image1.jpg"; // sensible fallback
                }
                if (category == null || category.trim().isEmpty()) {
                    category = "Animal";
                }

                Animal animal = new Animal(
                    name.trim(),
                    category.trim(),
                    scientificName != null ? scientificName.trim() : "",
                    habitat != null ? habitat.trim() : "",
                    foundIn != null ? foundIn.trim() : "",
                    description != null ? description.trim() : "",
                    imageUrl.trim()
                );
                boolean success = animalDAO.addAnimal(animal);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/admin-dashboard?msg=animal_added");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin-dashboard?err=animal_add_failed");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard?err=missing_fields");
            }
        } else if ("delete".equalsIgnoreCase(action)) {
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    boolean success = animalDAO.deleteAnimal(id);
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/admin-dashboard?msg=animal_deleted");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/admin-dashboard?err=animal_delete_failed");
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
