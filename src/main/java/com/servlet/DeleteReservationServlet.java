package com.servlet;

import com.dao.ReservationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DeleteReservationServlet")
public class DeleteReservationServlet extends HttpServlet {

    private final ReservationDAO dao = new ReservationDAO();

    // GET: show confirmation page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            res.sendRedirect("DisplayReservationsServlet");
            return;
        }

        int id = Integer.parseInt(idParam);
        req.setAttribute("reservationId", id);
        req.setAttribute("reservation", dao.getReservationById(id));
        req.getRequestDispatcher("/reservationdelete.jsp").forward(req, res);
    }

    // POST: perform delete
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            res.sendRedirect("DisplayReservationsServlet");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            boolean success = dao.deleteReservation(id);

            if (success) {
                req.getSession().setAttribute("message", "Reservation deleted successfully.");
                req.getSession().setAttribute("msgType", "success");
            } else {
                req.getSession().setAttribute("message", "Delete failed. Reservation not found.");
                req.getSession().setAttribute("msgType", "error");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("message", "Error: " + e.getMessage());
            req.getSession().setAttribute("msgType", "error");
        }

        res.sendRedirect("DisplayReservationsServlet");
    }
}
