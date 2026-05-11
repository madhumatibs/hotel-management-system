package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/UpdateReservationServlet")
public class UpdateReservationServle extends HttpServlet {

    private final ReservationDAO dao = new ReservationDAO();

    // GET: load existing reservation into the update form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            res.sendRedirect("DisplayReservationsServlet");
            return;
        }

        int id = Integer.parseInt(idParam);
        Reservation r = dao.getReservationById(id);

        if (r == null) {
            req.getSession().setAttribute("message", "Reservation not found.");
            req.getSession().setAttribute("msgType", "error");
            res.sendRedirect("DisplayReservationsServlet");
            return;
        }

        req.setAttribute("reservation", r);
        req.getRequestDispatcher("/reservationupdate.jsp").forward(req, res);
    }

    // POST: save updated reservation
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        try {
            Reservation r = new Reservation();
            r.setId          (Integer.parseInt(req.getParameter("id")));
            r.setGuestName   (req.getParameter("guestName").trim());
            r.setGuestEmail  (req.getParameter("guestEmail").trim());
            r.setGuestPhone  (req.getParameter("guestPhone").trim());
            r.setRoomType    (req.getParameter("roomType"));
            r.setRoomNumber  (Integer.parseInt(req.getParameter("roomNumber")));
            r.setCheckInDate (Date.valueOf(req.getParameter("checkInDate")));
            r.setCheckOutDate(Date.valueOf(req.getParameter("checkOutDate")));
            r.setNumGuests   (Integer.parseInt(req.getParameter("numGuests")));
            r.setTotalPrice  (Double.parseDouble(req.getParameter("totalPrice")));
            r.setStatus      (req.getParameter("status"));

            boolean success = dao.updateReservation(r);

            if (success) {
                req.getSession().setAttribute("message",
                    "✅ Reservation #" + r.getId() + " updated successfully.");
                req.getSession().setAttribute("msgType", "success");
            } else {
                req.getSession().setAttribute("message",
                    "Update failed. Please try again.");
                req.getSession().setAttribute("msgType", "error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("message", "Error: " + e.getMessage());
            req.getSession().setAttribute("msgType", "error");
        }

        res.sendRedirect("DisplayReservationsServlet");
    }
}
