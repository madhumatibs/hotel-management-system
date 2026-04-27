<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports | Hotel Management</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <div class="page-header">
            <h2>Reports</h2>
        </div>

        <div class="card-grid">
            <div class="card">
                <div class="card-icon">&#128202;</div>
                <h3>Custom Report</h3>
                <p>Filter reservations by date range and status.</p>
                <a href="ReportCriteriaServlet" class="btn btn-primary">Generate</a>
            </div>
            <div class="card">
                <div class="card-icon">&#9989;</div>
                <h3>All Confirmed</h3>
                <p>View all confirmed reservations instantly.</p>
                <a href="ReportServlet?fromDate=&toDate=&status=CONFIRMED&reportType=DETAIL" class="btn btn-primary">View</a>
            </div>
            <div class="card">
                <div class="card-icon">&#128336;</div>
                <h3>All Pending</h3>
                <p>Review reservations awaiting confirmation.</p>
                <a href="ReportServlet?fromDate=&toDate=&status=PENDING&reportType=DETAIL" class="btn btn-primary">View</a>
            </div>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
