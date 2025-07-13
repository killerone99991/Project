/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import models.User;
import utils.DBConnection;

/**
 *
 * @author
 */
public class UserDAO {

    /**
     * Constructor.
     */
    public UserDAO() {
    }

    /**
     * Checks log-in from User
     * 
     * @param userName Username of User
     * @param userPassword Password of User
     * @return True if logged-in successfully, else false
     * @throws SQLException 
     */
    public boolean login(String userName, String userPassword) throws SQLException {
        if (!checkExistedUserByUsername(userName)) {
            return false;
        }
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT 1 FROM AppUser WHERE username = ? AND password_hash = ?";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, userName);
            statement.setString(2, userPassword);
            
            ResultSet result = statement.executeQuery();
                        
            return result.next();
        }        
    }
    
    /**
     * Register User into database
     * 
     * @param userName Username of User
     * @param userPassword Password of User
     * @param email Email of User
     * @return True if registered successfully, else false
     * @throws SQLException 
     */
    public boolean register(String userName, String userPassword, String email) throws SQLException {
        if (checkExistedUserByUsername(userName)) {
            return false;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO AppUser (username, password_hash, email) VALUES (?, ?, ?)";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, userName);
            statement.setString(2, userPassword);
            statement.setString(3, email);
            
            statement.executeQuery();
        }
        
        return true;
    }

    /**
     * Checks existed User by username
     * 
     * @param userName Using to find User
     * @return True if existed, false if not existed
     * @throws SQLException
     */
    public boolean checkExistedUserByUsername(String userName) throws SQLException {
        ResultSet result;
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT 1 FROM AppUser WHERE username = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, userName);
            result = statement.executeQuery();
        }

        return result.next();
    }

    /**
     * Gets all information of User by username
     * 
     * @param userName Using to find User
     * @return User
     * @throws SQLException 
     */
    public User getInformationByUsername(String userName) throws SQLException {
        String email;
        String phoneNumber;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT email, phone_number FROM AppUser WHERE username = " + userName;
            Statement statement = conn.createStatement();
            ResultSet result = statement.executeQuery(sql);

            email = result.getString("email");
            phoneNumber = result.getString("phone_number");
        }

        return new User(userName, email, phoneNumber);
    }
}
