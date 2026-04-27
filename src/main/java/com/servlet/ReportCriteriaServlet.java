package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ReportCriteriaServlet")
public class ReportCriteriaServlet extends HttpServlet {

    // GET: show the report filter form
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/report_form.jsp").forward(req, res);
    }

    // POST: collect criteria and forward to ReportServlet
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fromDate  = req.getParameter("fromDate");
        String toDate    = req.getParameter("toDate");
        String status    = req.getParameter("status");
        String reportType = req.getParameter("reportType");

        // Pass criteria forward to ReportServlet via redirect with query params
        String url = "ReportServlet?fromDate=" + (fromDate != null ? fromDate : "")
                   + "&toDate=" + (toDate != null ? toDate : "")
                   + "&status=" + (status != null ? status : "ALL")
                   + "&reportType=" + (reportType != null ? reportType : "DETAIL");

        res.sendRedirect(url);
    }
}
