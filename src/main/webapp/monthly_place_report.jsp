<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%@ page import="com.model.Reservation" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Monthly Place Report | Hotel Management</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>
<%@ include file="navbar.jsp" %>

<div class="container">

<h2>📅 Month-wise Report by Place</h2>

<!-- FILTER FORM -->
<form method="post" action="MonthlyPlaceReportServlet">

    Place:
    <input type="text" name="place"
        value="<%= request.getAttribute("place") != null ? request.getAttribute("place") : "" %>">

    Month:
    <select name="month">
        <option value="">All</option>
        <%
            String selMonth = (String) request.getAttribute("month");
            String[] months = {"January","February","March","April","May","June",
                               "July","August","September","October","November","December"};

            for(int i=1;i<=12;i++){
                String val = String.valueOf(i);
        %>
        <option value="<%=val%>" <%= val.equals(selMonth) ? "selected" : "" %>>
            <%= months[i-1] %>
        </option>
        <% } %>
    </select>

    Year:
    <select name="year">
        <option value="">All</option>
        <%
            String selYear = (String) request.getAttribute("year");
            for(int y=2023;y<=2027;y++){
                String val = String.valueOf(y);
        %>
        <option value="<%=val%>" <%= val.equals(selYear) ? "selected" : "" %>>
            <%= val %>
        </option>
        <% } %>
    </select>

    View:
    <select name="reportType">
        <%
            String rt = request.getAttribute("reportType") != null ?
                        (String) request.getAttribute("reportType") : "DETAIL";
        %>
        <option value="DETAIL" <%= "DETAIL".equals(rt) ? "selected" : "" %>>Detail</option>
        <option value="SUMMARY" <%= "SUMMARY".equals(rt) ? "selected" : "" %>>Summary</option>
    </select>

    <button type="submit">Generate</button>
</form>

<hr>

<!-- ================= SUMMARY VIEW ================= -->
<%
    List<Map<String,Object>> summary =
        (List<Map<String,Object>>) request.getAttribute("summary");

    if(summary != null){

        Object gbObj = request.getAttribute("grandBookings");
        Integer grandBookings = gbObj != null ? (Integer) gbObj : 0;

        Object gtObj = request.getAttribute("grandTotal");
        Double grandTotal = gtObj != null ? (Double) gtObj : 0.0;

        String[] monthNames = {"","January","February","March","April","May","June",
                              "July","August","September","October","November","December"};
%>

<h3>Summary</h3>

<p>Total Months: <%= summary.size() %></p>
<p>Total Bookings: <%= grandBookings %></p>
<p>Total Revenue: ₹<%= String.format("%,.2f", grandTotal) %></p>

<% if(summary.isEmpty()){ %>
    <p>No Data Found</p>
<% } else { %>

<table border="1">
<tr>
    <th>Month</th>
    <th>Bookings</th>
    <th>Revenue</th>
    <th>Average</th>
</tr>

<%
for(Map<String,Object> row : summary){

    Integer mObj = (Integer) row.get("month");
    Integer cntObj = (Integer) row.get("totalBookings");
    Double revObj = (Double) row.get("totalRevenue");

    int m = mObj != null ? mObj : 0;
    int cnt = cntObj != null ? cntObj : 0;
    double rev = revObj != null ? revObj : 0.0;

    double avg = cnt > 0 ? rev/cnt : 0;
%>

<tr>
    <td><%= (m>=1 && m<=12) ? monthNames[m] : "Invalid" %></td>
    <td><%= cnt %></td>
    <td><%= String.format("%,.2f", rev) %></td>
    <td><%= String.format("%,.2f", avg) %></td>
</tr>

<% } %>

</table>

<% } } %>

<!-- ================= DETAIL VIEW ================= -->
<%
    List<Reservation> results =
        (List<Reservation>) request.getAttribute("reportResults");

    if(results != null){

        Object trObj = request.getAttribute("totalRevenue");
        Double totalRevenue = trObj != null ? (Double) trObj : 0.0;

        Object rcObj = request.getAttribute("resultCount");
        Integer resultCount = rcObj != null ? (Integer) rcObj : 0;
%>

<h3>Details</h3>

<p>Total Reservations: <%= resultCount %></p>
<p>Total Revenue: ₹<%= String.format("%,.2f", totalRevenue) %></p>

<% if(results.isEmpty()){ %>
    <p>No Reservations Found</p>
<% } else { %>

<table border="1">
<tr>
    <th>#</th>
    <th>Name</th>
    <th>Address</th>
    <th>Phone</th>
    <th>Room</th>
    <th>No</th>
    <th>Check-In</th>
    <th>Check-Out</th>
    <th>Guests</th>
    <th>Total</th>
</tr>

<%
int i=1;
for(Reservation r : results){
%>

<tr>
    <td><%= i++ %></td>
    <td><%= r.getGuestName() != null ? r.getGuestName() : "" %></td>
    <td><%= r.getGuestAddress() != null ? r.getGuestAddress() : "" %></td>
    <td><%= r.getGuestPhone() != null ? r.getGuestPhone() : "" %></td>
    <td><%= r.getRoomType() != null ? r.getRoomType() : "" %></td>
    <td><%= r.getRoomNumber() %></td>
    <td><%= r.getCheckInDate() %></td>
    <td><%= r.getCheckOutDate() %></td>
    <td><%= r.getNumGuests() %></td>
    <td><%= String.format("%,.2f", r.getTotalPrice()) %></td>
</tr>

<% } %>

</table>

<% } } %>

</div>

<%@ include file="footer.jsp" %>
</body>
</html>