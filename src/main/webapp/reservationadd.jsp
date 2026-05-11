<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Reservation | Hotel Management</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <div class="page-header">
            <h2>New Reservation</h2>
            <a href="DisplayReservationsServlet" class="btn btn-secondary">&#8592; Back</a>
        </div>

        <div class="form-card">
            <form action="AddReservationServlet" method="post">

                <div class="form-section-title">Guest Information</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="guestName">Full Name *</label>
                        <input type="text" id="guestName" name="guestName" required placeholder="John Smith">
                    </div>
                    <div class="form-group">
                        <label for="guestEmail">Email *</label>
                        <input type="email" id="guestEmail" name="guestEmail" required placeholder="john@example.com">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="guestPhone">Phone</label>
                        <input type="tel" id="guestPhone" name="guestPhone" placeholder="+91 9876543210">
                    </div>
                    <div class="form-group">
                        <label for="numGuests">Number of Guests *</label>
                        <input type="number" id="numGuests" name="numGuests" min="1" max="10" required value="1">
                    </div>
                </div>

                <div class="form-section-title">Room Details</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="roomType">Room Type *</label>
                        <select id="roomType" name="roomType" required>
                            <option value="">-- Select --</option>
                            <option value="STANDARD">Standard</option>
                            <option value="DELUXE">Deluxe</option>
                            <option value="SUITE">Suite</option>
                            <option value="PRESIDENTIAL">Presidential</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="roomNumber">Room Number *</label>
                        <input type="number" id="roomNumber" name="roomNumber" required placeholder="101">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="checkInDate">Check-In Date *</label>
                        <input type="date" id="checkInDate" name="checkInDate" required>
                    </div>
                    <div class="form-group">
                        <label for="checkOutDate">Check-Out Date *</label>
                        <input type="date" id="checkOutDate" name="checkOutDate" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="totalPrice">Total Price (₹) *</label>
                        <input type="number" id="totalPrice" name="totalPrice" step="0.01" min="0" required placeholder="5000.00">
                    </div>
                    <div class="form-group">
                        <label for="status">Status *</label>
                        <select id="status" name="status" required>
                           
                            <option value="CONFIRMED">Confirmed</option>
                            <option value="CANCELLED">Cancelled</option>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Save Reservation</button>
                    <a href="DisplayReservationsServlet" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
    <script>
        // Ensure check-out is after check-in
        document.getElementById('checkInDate').addEventListener('change', function() {
            document.getElementById('checkOutDate').min = this.value;
        });
    </script>
</body>
</html>
