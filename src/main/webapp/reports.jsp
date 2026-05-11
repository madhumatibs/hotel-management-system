<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Reports | Hotel Management</title>

<link rel="stylesheet" href="css/style.css">

<style>

body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#f5f7fb;
    color:#1a0933;
}

/* ================= NAVBAR ================= */

.navbar{
    background:#180028;
    padding:18px 40px;

    display:flex;
    justify-content:space-between;
    align-items:center;
}

.logo{
    color:white;
    font-size:22px;
    font-weight:700;
    text-decoration:none;
}

.nav-links a{
    color:#ddd;
    text-decoration:none;
    margin-left:35px;
    font-size:17px;
    transition:0.3s;
}

.nav-links a:hover{
    color:white;
}

/* ================= REPORT SECTION ================= */

.report-container{
    width:100%;
    display:flex;
    flex-direction:column;
    align-items:center;

    padding:35px 0 60px;
}

.report-title{
    font-size:32px;
    margin-bottom:30px;
    color:#130025;
}

/* ================= CARDS ================= */

.report-cards{
    display:flex;
    flex-direction:column;
    gap:25px;
}

/* SINGLE CARD */

.report-card{

    width:360px;

    background:white;

    border:1px solid #eadcff;
    border-radius:20px;

    padding:28px 22px;

    display:flex;
    flex-direction:column;

    align-items:center;
    text-align:center;

    box-shadow:0 4px 12px rgba(0,0,0,0.05);

    transition:0.3s ease;
}

.report-card:hover{
    transform:translateY(-4px);

    box-shadow:0 8px 18px rgba(0,0,0,0.08);
}

/* ================= ICON ================= */

.report-icon{

    width:72px;
    height:72px;

    border-radius:18px;

    display:flex;
    align-items:center;
    justify-content:center;

    font-size:34px;

    margin-bottom:12px;
}

/* ICON COLORS */

.green-bg{
    background:#eefaf2;
}

.blue-bg{
    background:#eef4ff;
}

.purple-bg{
    background:#f3eeff;
}

/* ================= CONTENT ================= */

.report-content h2{
    margin:10px 0;
    font-size:22px;
    color:#0f172a;
}

.report-content p{
    margin-top:8px;
    font-size:16px;
    color:#555;
    line-height:1.5;
}

/* ================= STATUS BADGE ================= */

.status-badge{

    display:inline-block;

    margin-top:14px;

    background:#e9f8ee;
    color:#219653;

    padding:7px 16px;

    border-radius:50px;

    font-size:14px;
    font-weight:600;
}

/* ================= BUTTON ================= */

.report-btn{

    display:inline-block;

    margin-top:18px;

    color:white;
    text-decoration:none;

    padding:10px 24px;

    border-radius:12px;

    font-size:16px;
    font-weight:600;

    transition:0.3s;
}

/* BUTTON COLORS */

.green-btn{
    background:linear-gradient(135deg,#2ecc71,#27ae60);
}

.green-btn:hover{
    background:linear-gradient(135deg,#27ae60,#1e944f);
}

.blue-btn{
    background:linear-gradient(135deg,#4285f4,#2563eb);
}

.blue-btn:hover{
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
}

.purple-btn{
    background:linear-gradient(135deg,#8b5cf6,#6d28d9);
}

.purple-btn:hover{
    background:linear-gradient(135deg,#6d28d9,#5b21b6);
}

/* ================= FOOTER ================= */

.footer{
    background:#180028;
    color:#ddd;

    text-align:center;

    padding:20px;

    font-size:16px;
}

/* ================= RESPONSIVE ================= */

@media(max-width:500px){

    .report-card{
        width:85%;
    }

    .nav-links{
        display:none;
    }

    .logo{
        font-size:20px;
    }
}

</style>
</head>

<body>

<!-- ================= NAVBAR ================= -->

<div class="navbar">

    <a href="dashboard.jsp" class="logo">
        🏨 Hotel MS
    </a>

    <div class="nav-links">

        <a href="dashboard.jsp">Home</a>

        <a href="reservations.jsp">Reservations</a>

        <a href="addReservation.jsp">+ Add</a>

        <a href="reports.jsp">Reports</a>

    </div>

</div>

<!-- ================= REPORT SECTION ================= -->

<div class="report-container">

    <h1 class="report-title">
        Reports
    </h1>

    <div class="report-cards">

        <!-- CARD 1 -->

        <div class="report-card">

            <div class="report-icon green-bg">
                📊
            </div>

            <div class="report-content">

                <h2>Custom Report</h2>

                <p>
                    Filter reservations by date range and status.
                </p>

                <span class="status-badge">
                    ✔ Ready to generate
                </span>

            </div>

            <a href="ReportCriteriaServlet"
               class="report-btn green-btn">

                Generate

            </a>

        </div>

        <!-- CARD 2 -->

        <div class="report-card">

            <div class="report-icon blue-bg">
                ✅
            </div>

            <div class="report-content">

                <h2>All Confirmed</h2>

                <p>
                    View all confirmed reservations instantly.
                </p>

            </div>

            <a href="ReportServlet?fromDate=&toDate=&status=CONFIRMED&reportType=DETAIL"
               class="report-btn blue-btn">

                View

            </a>

        </div>

        <!-- CARD 3 -->

        <div class="report-card">

            <div class="report-icon purple-bg">
                📅
            </div>

            <div class="report-content">

                <h2>Monthly Place Report</h2>

                <p>
                    View month-wise reservation reports by place.
                </p>

            </div>

            <a href="MonthlyPlaceReportServlet"
               class="report-btn purple-btn">

                Open Report

            </a>

        </div>

    </div>

</div>

<!-- ================= FOOTER ================= -->

<div class="footer">
    © 2024 Hotel Management System. All rights reserved.
</div>

</body>
</html>