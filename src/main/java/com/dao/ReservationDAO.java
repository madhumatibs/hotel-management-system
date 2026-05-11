package com.dao;

import com.model.Reservation;
import java.util.Map;
import java.util.LinkedHashMap;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    private static final String DB_URL      = "jdbc:mysql://localhost:3306/hoteldb?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER     = "root";
    private static final String DB_PASSWORD = "MADHU@2005";

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    // ─── CREATE ─────────────────────────────────────────────────────────────
    public boolean addReservation(Reservation r) {
        // ✅ FIX 1: Added missing comma after guest_address
        String sql = "INSERT INTO reservations (guest_name, guest_email, guest_phone, guest_address, " +
                     "room_type, room_number, check_in_date, check_out_date, " +
                     "num_guests, total_price, status) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1,  r.getGuestName());
            ps.setString(2,  r.getGuestEmail());
            ps.setString(3,  r.getGuestPhone());
            ps.setString(4,  r.getGuestAddress()); // ✅ FIX 2: index is 4, not 11
            ps.setString(5,  r.getRoomType());
            ps.setInt   (6,  r.getRoomNumber());
            ps.setDate  (7,  r.getCheckInDate());
            ps.setDate  (8,  r.getCheckOutDate());
            ps.setInt   (9,  r.getNumGuests());
            ps.setDouble(10, r.getTotalPrice());
            ps.setString(11, r.getStatus());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── REPORT: month-wise for a particular place ───────────────────────────
    public List<Reservation> getReservationsByMonthAndPlace(String month, String year, String place) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE 1=1" +
                     (month != null && !month.isEmpty() ? " AND MONTH(check_in_date) = ?" : "") +
                     (year  != null && !year.isEmpty()  ? " AND YEAR(check_in_date)  = ?" : "") +
                     (place != null && !place.isEmpty() ? " AND LOWER(guest_address) LIKE ?" : "") +
                     " ORDER BY check_in_date ASC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int idx = 1;
            if (month != null && !month.isEmpty()) ps.setInt   (idx++, Integer.parseInt(month));
            if (year  != null && !year.isEmpty())  ps.setInt   (idx++, Integer.parseInt(year));
            if (place != null && !place.isEmpty()) ps.setString(idx,   "%" + place.toLowerCase() + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── REPORT: month-wise summary (count + revenue grouped by month) ───────
    public List<Map<String, Object>> getMonthlysummary(String year, String place) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT MONTH(check_in_date) AS month, " +
                     "COUNT(*) AS total_bookings, " +
                     "SUM(total_price) AS total_revenue " +
                     "FROM reservations WHERE 1=1" +
                     (year  != null && !year.isEmpty()  ? " AND YEAR(check_in_date) = ?"     : "") +
                     (place != null && !place.isEmpty() ? " AND LOWER(guest_address) LIKE ?" : "") +
                     " GROUP BY MONTH(check_in_date) ORDER BY MONTH(check_in_date) ASC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int idx = 1;
            if (year  != null && !year.isEmpty())  ps.setInt   (idx++, Integer.parseInt(year));
            if (place != null && !place.isEmpty()) ps.setString(idx,   "%" + place.toLowerCase() + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> row = new LinkedHashMap<>();
                    row.put("month",         rs.getInt("month"));
                    row.put("totalBookings", rs.getInt("total_bookings"));
                    row.put("totalRevenue",  rs.getDouble("total_revenue"));
                    list.add(row);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── READ ALL ───────────────────────────────────────────────────────────
    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY check_in_date DESC";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── READ BY ID ─────────────────────────────────────────────────────────
    public Reservation getReservationById(int id) {
        String sql = "SELECT * FROM reservations WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ─── UPDATE ─────────────────────────────────────────────────────────────
    public boolean updateReservation(Reservation r) {
        // ✅ FIX 3: Added missing comma after guest_address=?
        // ✅ FIX 4: Added ps.setString for guest_address and fixed all indexes
        String sql = "UPDATE reservations SET guest_name=?, guest_email=?, guest_phone=?, guest_address=?, " +
                     "room_type=?, room_number=?, check_in_date=?, check_out_date=?, " +
                     "num_guests=?, total_price=?, status=? WHERE id=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1,  r.getGuestName());
            ps.setString(2,  r.getGuestEmail());
            ps.setString(3,  r.getGuestPhone());
            ps.setString(4,  r.getGuestAddress()); // ✅ FIX 4: was missing entirely
            ps.setString(5,  r.getRoomType());
            ps.setInt   (6,  r.getRoomNumber());
            ps.setDate  (7,  r.getCheckInDate());
            ps.setDate  (8,  r.getCheckOutDate());
            ps.setInt   (9,  r.getNumGuests());
            ps.setDouble(10, r.getTotalPrice());
            ps.setString(11, r.getStatus());
            ps.setInt   (12, r.getId());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── DELETE ─────────────────────────────────────────────────────────────
    public boolean deleteReservation(int id) {
        String sql = "DELETE FROM reservations WHERE id = ?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─── REPORT: filter by date range and/or status ─────────────────────────
    public List<Reservation> getReservationsByReport(String fromDate, String toDate, String status) {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations WHERE 1=1" +
                     (fromDate != null && !fromDate.isEmpty() ? " AND check_in_date >= ?" : "") +
                     (toDate   != null && !toDate.isEmpty()   ? " AND check_in_date <= ?" : "") +
                     (status   != null && !status.isEmpty() && !status.equals("ALL") ? " AND status = ?" : "") +
                     " ORDER BY check_in_date ASC";

        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            int idx = 1;
            if (fromDate != null && !fromDate.isEmpty()) ps.setDate(idx++, Date.valueOf(fromDate));
            if (toDate   != null && !toDate.isEmpty())   ps.setDate(idx++, Date.valueOf(toDate));
            if (status   != null && !status.isEmpty() && !status.equals("ALL")) ps.setString(idx, status);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── REPORT: summary counts ──────────────────────────────────────────────
    public int getTotalReservations() {
        return countQuery("SELECT COUNT(*) FROM reservations");
    }

    public int getReservationsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM reservations WHERE status=?";
        try (Connection con = getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_price), 0) FROM reservations WHERE status='CONFIRMED'";
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getDouble(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ─── HELPER ─────────────────────────────────────────────────────────────
    private Reservation mapRow(ResultSet rs) throws SQLException {
        Reservation r = new Reservation();
        r.setId          (rs.getInt("id"));
        r.setGuestName   (rs.getString("guest_name"));
        r.setGuestEmail  (rs.getString("guest_email"));
        r.setGuestPhone  (rs.getString("guest_phone"));
        r.setGuestAddress(rs.getString("guest_address")); // ✅ ADDED
        r.setRoomType    (rs.getString("room_type"));
        r.setRoomNumber  (rs.getInt("room_number"));
        r.setCheckInDate (rs.getDate("check_in_date"));
        r.setCheckOutDate(rs.getDate("check_out_date"));
        r.setNumGuests   (rs.getInt("num_guests"));
        r.setTotalPrice  (rs.getDouble("total_price"));
        r.setStatus      (rs.getString("status"));
        return r;
    }

    private int countQuery(String sql) {
        try (Connection con = getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}