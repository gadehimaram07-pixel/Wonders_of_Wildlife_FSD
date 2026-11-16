package com.wildlife.dao;

import com.wildlife.model.Animal;
import com.wildlife.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Animals and Birds.
 */
public class AnimalDAO {

    /**
     * Retrieves all animals and birds.
     */
    public List<Animal> getAllAnimals() {
        List<Animal> list = new ArrayList<>();
        String sql = "SELECT id, name, category, scientific_name, habitat, found_in, description, image_url FROM animals ORDER BY id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Animal a = new Animal(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getString("scientific_name"),
                    rs.getString("habitat"),
                    rs.getString("found_in"),
                    rs.getString("description"),
                    rs.getString("image_url")
                );
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Retrieves animals filtered by category ('Animal' or 'Bird').
     */
    public List<Animal> getAnimalsByCategory(String category) {
        List<Animal> list = new ArrayList<>();
        String sql = "SELECT id, name, category, scientific_name, habitat, found_in, description, image_url FROM animals WHERE LOWER(category) = LOWER(?) ORDER BY id ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, category);
            rs = ps.executeQuery();
            while (rs.next()) {
                Animal a = new Animal(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getString("scientific_name"),
                    rs.getString("habitat"),
                    rs.getString("found_in"),
                    rs.getString("description"),
                    rs.getString("image_url")
                );
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    /**
     * Retrieves a single animal by its primary key ID.
     */
    public Animal getAnimalById(int id) {
        String sql = "SELECT id, name, category, scientific_name, habitat, found_in, description, image_url FROM animals WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new Animal(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getString("scientific_name"),
                    rs.getString("habitat"),
                    rs.getString("found_in"),
                    rs.getString("description"),
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
     * Adds a new animal or bird to the database.
     */
    public boolean addAnimal(Animal a) {
        String sql = "INSERT INTO animals (id, name, category, scientific_name, habitat, found_in, description, image_url) " +
                     "VALUES (seq_animals.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, a.getName());
            ps.setString(2, a.getCategory());
            ps.setString(3, a.getScientificName());
            ps.setString(4, a.getHabitat());
            ps.setString(5, a.getFoundIn());
            ps.setString(6, a.getDescription());
            ps.setString(7, a.getImageUrl());
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
     * Deletes an animal or bird by ID.
     */
    public boolean deleteAnimal(int id) {
        String sql = "DELETE FROM animals WHERE id = ?";
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
     * Total count of all animals and birds.
     */
    public int getCount() {
        String sql = "SELECT COUNT(*) FROM animals";
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

    /**
     * Count filtered by category.
     */
    public int getCountByCategory(String category) {
        String sql = "SELECT COUNT(*) FROM animals WHERE LOWER(category) = LOWER(?)";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, category);
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
