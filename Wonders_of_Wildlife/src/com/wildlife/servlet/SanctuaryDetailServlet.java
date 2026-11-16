package com.wildlife.servlet;

import com.wildlife.dao.SanctuaryDAO;
import com.wildlife.model.Sanctuary;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Controller servlet to view details of a specific wildlife sanctuary.
 */
@WebServlet(name = "SanctuaryDetailServlet", urlPatterns = {"/sanctuary-detail"})
public class SanctuaryDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SanctuaryDAO sanctuaryDAO = new SanctuaryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect("sanctuaries");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Sanctuary sanctuary = sanctuaryDAO.getSanctuaryById(id);
            if (sanctuary == null) {
                response.sendRedirect("sanctuaries");
                return;
            }
            request.setAttribute("sanctuary", sanctuary);
            request.getRequestDispatcher("/sanctuary-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("sanctuaries");
        }
    }
}
