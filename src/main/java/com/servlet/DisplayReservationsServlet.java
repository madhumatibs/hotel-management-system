package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DisplayReservationsServlet")
public class DisplayReservationsServlet extends HttpServlet {

    private final ReservationDAO dao = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<Reservation> reservations = dao.getAllReservations();
        req.setAttribute("reservations", reservations);
        req.setAttribute("totalCount", reservations.size());

        // Counts for dashboard summary
        req.setAttribute("confirmedCount", dao.getReservationsByStatus("CONFIRMED"));
        req.setAttribute("pendingCount",   dao.getReservationsByStatus("PENDING"));
        req.setAttribute("cancelledCount", dao.getReservationsByStatus("CANCELLED"));
        req.setAttribute("totalRevenue",   dao.getTotalRevenue());

        req.getRequestDispatcher("/reservationdisplay.jsp").forward(req, res);
    }
}
