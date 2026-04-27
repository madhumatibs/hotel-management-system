<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Generate Report | Hotel Management</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container">
        <div class="page-header">
            <h2>Generate Report</h2>
            <a href="DisplayReservationsServlet" class="btn btn-secondary">&#8592; Back</a>
        </div>

        <div class="form-card">
            <form action="ReportCriteriaServlet" method="post">

                <div class="form-section-title">Filter Criteria</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="fromDate">From Date</label>
                        <input type="date" id="fromDate" name="fromDate">
                    </div>
                    <div class="form-group">
                        <label for="toDate">To Date</label>
                        <input type="date" id="toDate" name="toDate">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="status">Reservation Status</label>
                        <select id="status" name="status">
                            <option value="ALL">All Statuses</option>
                            <option value="CONFIRMED">Confirmed</option>
                            <option value="PENDING">Pending</option>
                            <option value="CANCELLED">Cancelled</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="reportType">Report Type</label>
                        <select id="reportType" name="reportType">
                            <option value="DETAIL">Detailed List</option>
                            <option value="SUMMARY">Summary Only</option>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Generate Report</button>
                    <button type="reset" class="btn btn-secondary">Clear</button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
