package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/AddReservationServlet")
public class AddReservationServlet extends HttpServlet {

    private final ReservationDAO dao = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {
            Reservation r = new Reservation();
            r.setGuestName(req.getParameter("guestName").trim());
            r.setGuestEmail(req.getParameter("guestEmail").trim());
            r.setGuestPhone(req.getParameter("guestPhone").trim());
            r.setRoomType(req.getParameter("roomType"));
            r.setRoomNumber(Integer.parseInt(req.getParameter("roomNumber")));
            r.setCheckInDate(Date.valueOf(req.getParameter("checkInDate")));
            r.setCheckOutDate(Date.valueOf(req.getParameter("checkOutDate")));
            r.setNumGuests(Integer.parseInt(req.getParameter("numGuests")));
            r.setTotalPrice(Double.parseDouble(req.getParameter("totalPrice")));
            r.setStatus(req.getParameter("status"));

            boolean success = dao.addReservation(r);

            if (success) {
                req.getSession().setAttribute("message", "Reservation added successfully!");
                req.getSession().setAttribute("msgType", "success");
            } else {
                req.getSession().setAttribute("message", "Failed to add reservation. Please try again.");
                req.getSession().setAttribute("msgType", "error");
            }

        } catch (Exception e) {
            req.getSession().setAttribute("message", "Invalid input: " + e.getMessage());
            req.getSession().setAttribute("msgType", "error");
        }

        res.sendRedirect("DisplayReservationsServlet");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/reservationadd.jsp").forward(req, res);
    }
}
