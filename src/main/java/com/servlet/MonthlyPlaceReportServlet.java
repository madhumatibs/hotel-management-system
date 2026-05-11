package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/MonthlyPlaceReportServlet")
public class MonthlyPlaceReportServlet extends HttpServlet {

    // GET: show the filter form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/monthly_place_report.jsp").forward(req, res);
    }

    // POST: run the report
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String month      = req.getParameter("month");       // "1"–"12" or ""
        String year       = req.getParameter("year");        // e.g. "2025"
        String place      = req.getParameter("place");       // free text
        String reportType = req.getParameter("reportType");  // "DETAIL" or "SUMMARY"

        ReservationDAO dao = new ReservationDAO();

        if ("SUMMARY".equals(reportType)) {
            // Month-wise grouped summary for the place
            List<Map<String, Object>> summary = dao.getMonthlysummary(year, place);

            double grandTotal = summary.stream()
                .mapToDouble(m -> (Double) m.get("totalRevenue"))
                .sum();
            int grandBookings = summary.stream()
                .mapToInt(m -> (Integer) m.get("totalBookings"))
                .sum();

            req.setAttribute("summary",       summary);
            req.setAttribute("grandTotal",    grandTotal);
            req.setAttribute("grandBookings", grandBookings);

        } else {
            // Detailed list of reservations
            List<Reservation> results = dao.getReservationsByMonthAndPlace(month, year, place);

            double totalRevenue = results.stream()
                .mapToDouble(Reservation::getTotalPrice)
                .sum();

            req.setAttribute("reportResults", results);
            req.setAttribute("totalRevenue",  totalRevenue);
            req.setAttribute("resultCount",   results.size());
        }

        req.setAttribute("month",      month);
        req.setAttribute("year",       year);
        req.setAttribute("place",      place);
        req.setAttribute("reportType", reportType);

        req.getRequestDispatcher("/monthly_place_report.jsp").forward(req, res);
    }
}