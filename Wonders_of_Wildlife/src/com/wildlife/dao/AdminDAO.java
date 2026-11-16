package com.wildlife.dao;

import com.wildlife.model.AdminUser;
import com.wildlife.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object for Administrator Authentication.
 */
public class AdminDAO {

    /**
     * Validates administrator credentials against Oracle DB.
     */
    public AdminUser validate(String username, String password) {
        String sql = "SELECT id, username, password, full_name FROM admin_users WHERE username = ? AND password = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new AdminUser(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("full_name")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }
}
