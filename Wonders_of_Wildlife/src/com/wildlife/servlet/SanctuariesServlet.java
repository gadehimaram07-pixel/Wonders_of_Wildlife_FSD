package com.wildlife.servlet;

import com.wildlife.dao.SanctuaryDAO;
import com.wildlife.model.Sanctuary;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller servlet to list Wildlife Sanctuaries.
 */
@WebServlet(name = "SanctuariesServlet", urlPatterns = {"/sanctuaries"})
public class SanctuariesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SanctuaryDAO sanctuaryDAO = new SanctuaryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Sanctuary> sanctuaries = sanctuaryDAO.getAllSanctuaries();
        request.setAttribute("sanctuaries", sanctuaries);
        request.getRequestDispatcher("/sanctuaries.jsp").forward(request, response);
    }
}
