package com.wildlife.dao;

import com.wildlife.model.Sanctuary;
import com.wildlife.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Sanctuaries.
 */
public class SanctuaryDAO {

    /**
     * Retrieves all wildlife sanctuaries.
     */
    public List<Sanctuary> getAllSanctuaries() {
        List<Sanctuary> list = new ArrayList<>();
        String sql = "SELECT id, name, state, description, key_animals, best_time, image_url FROM sanctuaries ORDER BY id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Sanctuary s = new Sanctuary(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("state"),
                    rs.getString("description"),
                    rs.getString("key_animals"),
                    rs.getString("best_time"),
                    rs.getString("image_url")
                );
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Retrieves a sanctuary by its primary key ID.
     */
    public Sanctuary getSanctuaryById(int id) {
        String sql = "SELECT id, name, state, description, key_animals, best_time, image_url FROM sanctuaries WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Sanctuary(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("state"),
                    rs.getString("description"),
                    rs.getString("key_animals"),
                    rs.getString("best_time"),
                    rs.getString("image_url")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return null;
    }

    /**
     * Adds a new sanctuary.
     */
    public boolean addSanctuary(Sanctuary s) {
        String sql = "INSERT INTO sanctuaries (id, name, state, description, key_animals, best_time, image_url) " +
                     "VALUES (seq_sanctuaries.NEXTVAL, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, s.getName());
            ps.setString(2, s.getState());
            ps.setString(3, s.getDescription());
            ps.setString(4, s.getKeyAnimals());
            ps.setString(5, s.getBestTime());
            ps.setString(6, s.getImageUrl());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    /**
     * Deletes a sanctuary by ID.
     */
    public boolean deleteSanctuary(int id) {
        String sql = "DELETE FROM sanctuaries WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    /**
     * Total count of all sanctuaries.
     */
    public int getCount() {
        String sql = "SELECT COUNT(*) FROM sanctuaries";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return 0;
    }
}
