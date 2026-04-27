<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Report Results | Hotel Management</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <%
        List<Reservation> results = (List<Reservation>) request.getAttribute("reportResults");
        String fromDate     = (String) request.getAttribute("fromDate");
        String toDate       = (String) request.getAttribute("toDate");
        String statusFilter = (String) request.getAttribute("statusFilter");
        String reportType   = (String) request.getAttribute("reportType");
        int resultCount     = (int) request.getAttribute("resultCount");
        double totalRevenue = (double) request.getAttribute("totalRevenue");
        long confirmedCount = (long) request.getAttribute("confirmedCount");
        long pendingCount   = (long) request.getAttribute("pendingCount");
        long cancelledCount = (long) request.getAttribute("cancelledCount");
    %>

    <div class="container">
        <div class="page-header">
            <h2>Report Results</h2>
            <div style="display:flex;gap:8px;">
                <a href="ReportCriteriaServlet" class="btn btn-secondary">New Report</a>
                <a href="DisplayReservationsServlet" class="btn btn-secondary">All Reservations</a>
                <button onclick="window.print()" class="btn btn-primary">&#128438; Print</button>
            </div>
        </div>

        <!-- Applied filters -->
        <div class="filter-summary">
            <strong>Filters:</strong>
            From: <%= (fromDate != null && !fromDate.isEmpty()) ? fromDate : "Any" %> &nbsp;|&nbsp;
            To: <%= (toDate != null && !toDate.isEmpty()) ? toDate : "Any" %> &nbsp;|&nbsp;
            Status: <%= (statusFilter != null) ? statusFilter : "ALL" %> &nbsp;|&nbsp;
            Type: <%= reportType %>
        </div>

        <!-- Summary cards -->
        <div class="summary-grid">
            <div class="summary-card">
                <div class="summary-label">Total Results</div>
                <div class="summary-value"><%= resultCount %></div>
            </div>
            <div class="summary-card confirmed">
                <div class="summary-label">Confirmed</div>
                <div class="summary-value"><%= confirmedCount %></div>
            </div>
            <div class="summary-card pending">
                <div class="summary-label">Pending</div>
                <div class="summary-value"><%= pendingCount %></div>
            </div>
            <div class="summary-card cancelled">
                <div class="summary-label">Cancelled</div>
                <div class="summary-value"><%= cancelledCount %></div>
            </div>
            <div class="summary-card revenue">
                <div class="summary-label">Total Revenue (₹)</div>
                <div class="summary-value">&#8377;<%= String.format("%,.0f", totalRevenue) %></div>
            </div>
        </div>

        <!-- Detailed table (hidden for SUMMARY type) -->
        <% if (!"SUMMARY".equals(reportType)) { %>
        <div class="table-wrapper">
            <% if (results == null || results.isEmpty()) { %>
                <div class="empty-state"><p>No reservations match the selected criteria.</p></div>
            <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Guest Name</th>
                        <th>Room</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Guests</th>
                        <th>Price (₹)</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Reservation r : results) { %>
                    <tr>
                        <td><%= r.getId() %></td>
                        <td><strong><%= r.getGuestName() %></strong><br><small><%= r.getGuestEmail() %></small></td>
                        <td><%= r.getRoomType() %> / Room <%= r.getRoomNumber() %></td>
                        <td><%= r.getCheckInDate() %></td>
                        <td><%= r.getCheckOutDate() %></td>
                        <td><%= r.getNumGuests() %></td>
                        <td><%= String.format("%,.2f", r.getTotalPrice()) %></td>
                        <td><span class="status-badge status-<%= r.getStatus().toLowerCase() %>"><%= r.getStatus() %></span></td>
                    </tr>
                    <% } %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="6" style="text-align:right;font-weight:500;">Total Revenue:</td>
                        <td colspan="2" style="font-weight:500;">&#8377;<%= String.format("%,.2f", totalRevenue) %></td>
                    </tr>
                </tfoot>
            </table>
            <% } %>
        </div>
        <% } %>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
