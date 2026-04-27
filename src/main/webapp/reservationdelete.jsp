<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete Reservation | Hotel Management</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <%
        Reservation r = (Reservation) request.getAttribute("reservation");
        if (r == null) {
            response.sendRedirect("DisplayReservationsServlet");
            return;
        }
    %>

    <div class="container">
        <div class="page-header">
            <h2>Delete Reservation</h2>
        </div>

        <div class="form-card danger-card">
            <div class="danger-icon">&#9888;</div>
            <h3>Are you sure you want to delete this reservation?</h3>
            <p class="danger-msg">This action cannot be undone.</p>

            <div class="detail-grid">
                <div class="detail-item"><span class="detail-label">Reservation ID</span><span class="detail-value">#<%= r.getId() %></span></div>
                <div class="detail-item"><span class="detail-label">Guest Name</span><span class="detail-value"><%= r.getGuestName() %></span></div>
                <div class="detail-item"><span class="detail-label">Room</span><span class="detail-value"><%= r.getRoomType() %> — Room <%= r.getRoomNumber() %></span></div>
                <div class="detail-item"><span class="detail-label">Check-In</span><span class="detail-value"><%= r.getCheckInDate() %></span></div>
                <div class="detail-item"><span class="detail-label">Check-Out</span><span class="detail-value"><%= r.getCheckOutDate() %></span></div>
                <div class="detail-item"><span class="detail-label">Total Price</span><span class="detail-value">&#8377;<%= String.format("%.2f", r.getTotalPrice()) %></span></div>
            </div>

            <form action="DeleteReservationServlet" method="post">
                <input type="hidden" name="id" value="<%= r.getId() %>">
                <div class="form-actions">
                    <button type="submit" class="btn btn-danger">Yes, Delete</button>
                    <a href="DisplayReservationsServlet" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
