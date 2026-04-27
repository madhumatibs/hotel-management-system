<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Management System</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="hero">
        <h1>Hotel Management System</h1>
        <p>Manage reservations, guests, and reports from one place.</p>
        <div class="hero-actions">
            <a href="AddReservationServlet" class="btn btn-primary">+ New Reservation</a>
            <a href="DisplayReservationsServlet" class="btn btn-secondary">View All Reservations</a>
        </div>
    </div>

    <div class="container">
        <div class="card-grid">
            <div class="card">
                <div class="card-icon">&#128203;</div>
                <h3>Add Reservation</h3>
                <p>Create a new guest reservation with room and date details.</p>
                <a href="AddReservationServlet" class="btn btn-primary">Add Now</a>
            </div>
            <div class="card">
                <div class="card-icon">&#128196;</div>
                <h3>View Reservations</h3>
                <p>Browse, search, and manage all current reservations.</p>
                <a href="DisplayReservationsServlet" class="btn btn-primary">View All</a>
            </div>
            <div class="card">
                <div class="card-icon">&#128202;</div>
                <h3>Reports</h3>
                <p>Generate filtered reports by date range and status.</p>
                <a href="ReportCriteriaServlet" class="btn btn-primary">Run Report</a>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
