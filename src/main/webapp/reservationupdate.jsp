<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Reservation | Hotel Management</title>
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
            <h2>Update Reservation #<%= r.getId() %></h2>
            <a href="DisplayReservationsServlet" class="btn btn-secondary">&#8592; Back</a>
        </div>

        <div class="form-card">
            <form action="UpdateReservationServlet" method="post">
                <input type="hidden" name="id" value="<%= r.getId() %>">

                <div class="form-section-title">Guest Information</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="guestName">Full Name *</label>
                        <input type="text" id="guestName" name="guestName" required value="<%= r.getGuestName() %>">
                    </div>
                    <div class="form-group">
                        <label for="guestEmail">Email *</label>
                        <input type="email" id="guestEmail" name="guestEmail" required value="<%= r.getGuestEmail() %>">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="guestPhone">Phone</label>
                        <input type="tel" id="guestPhone" name="guestPhone" value="<%= r.getGuestPhone() %>">
                    </div>
                    <div class="form-group">
                        <label for="numGuests">Number of Guests *</label>
                        <input type="number" id="numGuests" name="numGuests" min="1" max="10" required value="<%= r.getNumGuests() %>">
                    </div>
                </div>

                <div class="form-section-title">Room Details</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="roomType">Room Type *</label>
                        <select id="roomType" name="roomType" required>
                            <option value="STANDARD"      <%= "STANDARD".equals(r.getRoomType())      ? "selected" : "" %>>Standard</option>
                            <option value="DELUXE"        <%= "DELUXE".equals(r.getRoomType())        ? "selected" : "" %>>Deluxe</option>
                            <option value="SUITE"         <%= "SUITE".equals(r.getRoomType())         ? "selected" : "" %>>Suite</option>
                            <option value="PRESIDENTIAL"  <%= "PRESIDENTIAL".equals(r.getRoomType())  ? "selected" : "" %>>Presidential</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="roomNumber">Room Number *</label>
                        <input type="number" id="roomNumber" name="roomNumber" required value="<%= r.getRoomNumber() %>">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="checkInDate">Check-In Date *</label>
                        <input type="date" id="checkInDate" name="checkInDate" required value="<%= r.getCheckInDate() %>">
                    </div>
                    <div class="form-group">
                        <label for="checkOutDate">Check-Out Date *</label>
                        <input type="date" id="checkOutDate" name="checkOutDate" required value="<%= r.getCheckOutDate() %>">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="totalPrice">Total Price (₹) *</label>
                        <input type="number" id="totalPrice" name="totalPrice" step="0.01" min="0" required value="<%= r.getTotalPrice() %>">
                    </div>
                    <div class="form-group">
                        <label for="status">Status *</label>
                        <select id="status" name="status" required>
                            <option value="PENDING"   <%= "PENDING".equals(r.getStatus())   ? "selected" : "" %>>Pending</option>
                            <option value="CONFIRMED" <%= "CONFIRMED".equals(r.getStatus()) ? "selected" : "" %>>Confirmed</option>
                            <option value="CANCELLED" <%= "CANCELLED".equals(r.getStatus()) ? "selected" : "" %>>Cancelled</option>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Update Reservation</button>
                    <a href="DisplayReservationsServlet" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
