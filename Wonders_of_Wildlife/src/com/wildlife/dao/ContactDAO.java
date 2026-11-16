package com.wildlife.dao;

import com.wildlife.model.ContactMessage;
import com.wildlife.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Contact / Inquiry Messages.
 */
public class ContactDAO {

    /**
     * Saves a new contact message.
     */
    public boolean saveMessage(ContactMessage msg) {
        String sql = "INSERT INTO contact_messages (id, name, email, subject, message, submitted_at) " +
                     "VALUES (seq_contact_messages.NEXTVAL, ?, ?, ?, ?, CURRENT_TIMESTAMP)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, msg.getName());
            ps.setString(2, msg.getEmail());
            ps.setString(3, msg.getSubject());
            ps.setString(4, msg.getMessage());
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
     * Retrieves all contact inquiries.
     */
    public List<ContactMessage> getAllMessages() {
        List<ContactMessage> list = new ArrayList<>();
        String sql = "SELECT id, name, email, subject, message, submitted_at FROM contact_messages ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                ContactMessage m = new ContactMessage(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("subject"),
                    rs.getString("message"),
                    rs.getTimestamp("submitted_at")
                );
                list.add(m);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Gets count of contact messages.
     */
    public int getCount() {
        String sql = "SELECT COUNT(*) FROM contact_messages";
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
