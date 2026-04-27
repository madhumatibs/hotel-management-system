<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Reservations | Hotel Management</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <%
        // Flash message
        String message = (String) session.getAttribute("message");
        String msgType  = (String) session.getAttribute("msgType");
        if (message != null) {
            session.removeAttribute("message");
            session.removeAttribute("msgType");
        }
        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
    %>

    <div class="container">
        <% if (message != null) { %>
            <div class="alert alert-<%= msgType %>"><%= message %></div>
        <% } %>

        <div class="page-header">
            <h2>All Reservations</h2>
            <a href="AddReservationServlet" class="btn btn-primary">+ New Reservation</a>
        </div>

        <!-- Summary Cards -->
        <div class="summary-grid">
            <div class="summary-card">
                <div class="summary-label">Total</div>
                <div class="summary-value"><%= request.getAttribute("totalCount") %></div>
            </div>
            <div class="summary-card confirmed">
                <div class="summary-label">Confirmed</div>
                <div class="summary-value"><%= request.getAttribute("confirmedCount") %></div>
            </div>
            <div class="summary-card pending">
                <div class="summary-label">Pending</div>
                <div class="summary-value"><%= request.getAttribute("pendingCount") %></div>
            </div>
            <div class="summary-card cancelled">
                <div class="summary-label">Cancelled</div>
                <div class="summary-value"><%= request.getAttribute("cancelledCount") %></div>
            </div>
            <div class="summary-card revenue">
                <div class="summary-label">Revenue (₹)</div>
                <div class="summary-value">&#8377;<%= String.format("%,.0f", (Double)request.getAttribute("totalRevenue")) %></div>
            </div>
        </div>

        <!-- Reservations Table -->
        <div class="table-wrapper">
            <% if (reservations == null || reservations.isEmpty()) { %>
                <div class="empty-state">
                    <p>No reservations found. <a href="AddReservationServlet">Add your first one.</a></p>
                </div>
            <% } else { %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Guest</th>
                        <th>Contact</th>
                        <th>Room</th>
                        <th>Check-In</th>
                        <th>Check-Out</th>
                        <th>Guests</th>
                        <th>Price (₹)</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Reservation r : reservations) { %>
                    <tr>
                        <td><%= r.getId() %></td>
                        <td><strong><%= r.getGuestName() %></strong></td>
                        <td>
                            <small><%= r.getGuestEmail() %></small><br>
                            <small><%= r.getGuestPhone() %></small>
                        </td>
                        <td><%= r.getRoomType() %> / <%= r.getRoomNumber() %></td>
                        <td><%= r.getCheckInDate() %></td>
                        <td><%= r.getCheckOutDate() %></td>
                        <td><%= r.getNumGuests() %></td>
                        <td><%= String.format("%,.2f", r.getTotalPrice()) %></td>
                        <td>
                            <span class="status-badge status-<%= r.getStatus().toLowerCase() %>">
                                <%= r.getStatus() %>
                            </span>
                        </td>
                        <td class="action-cell">
                            <a href="UpdateReservationServlet?id=<%= r.getId() %>" class="btn-sm btn-edit">Edit</a>
                            <a href="DeleteReservationServlet?id=<%= r.getId() %>" class="btn-sm btn-delete"
                               onclick="return confirm('Delete reservation #<%= r.getId() %>?')">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } %>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
