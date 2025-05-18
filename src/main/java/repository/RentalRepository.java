package repository;

import model.Rental;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class RentalRepository {
    private final String JDBC_URL = "jdbc:mysql://localhost:3306/TComplexDB?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private final String USER = "root";
    private final String PASS = "hoanglongdang99";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL driver not found", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(JDBC_URL, USER, PASS);
    }

    public boolean existsByCode(String code) {
        String sql = "SELECT 1 FROM rental WHERE code = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void save(Rental rental) {
        String sql = "INSERT INTO rental(code, status, area, floor, type, price, start_date, end_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rental.getCode());
            ps.setString(2, rental.getStatus());
            ps.setDouble(3, rental.getArea());
            ps.setInt(4, rental.getFloor());
            ps.setString(5, rental.getType());
            ps.setLong(6, rental.getPrice());
            ps.setDate(7, Date.valueOf(rental.getStartDate()));
            ps.setDate(8, Date.valueOf(rental.getEndDate()));
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Rental> findAll(String type, String floor, String price) {
        List<Rental> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM rental WHERE 1=1");

        if (type != null && !type.isEmpty()) sql.append(" AND type = '").append(type).append("'");
        if (floor != null && !floor.isEmpty()) sql.append(" AND floor = ").append(floor);
        if (price != null && !price.isEmpty()) sql.append(" AND price <= ").append(price);

        sql.append(" ORDER BY area ASC");

        try (Connection conn = getConnection(); Statement stmt = conn.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql.toString());
            while (rs.next()) {
                Rental r = new Rental();
                r.setCode(rs.getString("code"));
                r.setStatus(rs.getString("status"));
                r.setArea(rs.getDouble("area"));
                r.setFloor(rs.getInt("floor"));
                r.setType(rs.getString("type"));
                r.setPrice(rs.getLong("price"));
                r.setStartDate(rs.getDate("start_date").toLocalDate());
                r.setEndDate(rs.getDate("end_date").toLocalDate());
                list.add(r);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    public void deleteByCode(String code) {
        String sql = "DELETE FROM rental WHERE code = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, code);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}