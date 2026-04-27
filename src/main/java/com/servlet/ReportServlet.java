package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    private final ReservationDAO dao = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fromDate   = req.getParameter("fromDate");
        String toDate     = req.getParameter("toDate");
        String status     = req.getParameter("status");
        String reportType = req.getParameter("reportType");

        List<Reservation> results = dao.getReservationsByReport(fromDate, toDate, status);

        // Summary stats for the result page
        double totalRevenue = results.stream()
            .filter(r -> "CONFIRMED".equals(r.getStatus()))
            .mapToDouble(Reservation::getTotalPrice)
            .sum();

        long confirmedCount = results.stream().filter(r -> "CONFIRMED".equals(r.getStatus())).count();
        long pendingCount   = results.stream().filter(r -> "PENDING".equals(r.getStatus())).count();
        long cancelledCount = results.stream().filter(r -> "CANCELLED".equals(r.getStatus())).count();

        req.setAttribute("reportResults",   results);
        req.setAttribute("totalRevenue",    totalRevenue);
        req.setAttribute("confirmedCount",  confirmedCount);
        req.setAttribute("pendingCount",    pendingCount);
        req.setAttribute("cancelledCount",  cancelledCount);
        req.setAttribute("fromDate",        fromDate);
        req.setAttribute("toDate",          toDate);
        req.setAttribute("statusFilter",    status);
        req.setAttribute("reportType",      reportType);
        req.setAttribute("resultCount",     results.size());

        req.getRequestDispatcher("/report_result.jsp").forward(req, res);
    }
}
