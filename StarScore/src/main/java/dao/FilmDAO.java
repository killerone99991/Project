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
import java.util.ArrayList;
import java.util.List;
import models.Film;
import utils.DBConnection;

/**
 *
 * @author
 */
public class FilmDAO {

    /**
     * Constructor.
     */
    public FilmDAO() {
    }

    /**
     * Gets film's genres by ID
     * 
     * @param id The ID of film which use to get film's genres
     * @return ArrayList<String>
     * @throws SQLException 
     */
    public ArrayList<String> getGenresById(int id) throws SQLException {
        ArrayList<String> genres = new ArrayList<>();
    
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT name FROM Film JOIN Film_Genre ON Film.id = Film_Genre.film_id JOIN Genre ON Film_Genre.genre_id = Genre.id WHERE Film_Genre.film_id = " + String.valueOf(id);
            
            Statement statement = conn.createStatement();
            ResultSet result = statement.executeQuery(sql);
            
            while (result.next()) {
                genres.add(result.getString("name"));
            }
        }
        
        return genres;
    }

    /**
     * Gets film's directors by ID
     * 
     * @param id The ID of film which use to get film's directors
     * @return ArrayList<String>
     * @throws SQLException 
     */
    public ArrayList<String> getDirectorsById(int id) throws SQLException {
        ArrayList<String> directors = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT name FROM Film JOIN Film_Director ON Film.id = Film_Director.film_id JOIN Director ON Film_Director.director_id = Director.id WHERE Film_Director.film_id = " + String.valueOf(id);
            
            Statement statement = conn.createStatement();
            ResultSet result = statement.executeQuery(sql);
            
            while (result.next()) {
                directors.add(result.getString("name"));
            }
        }
        
        return directors;
    }

    /**
     * Gets film's distributors by ID
     * 
     * @param id The ID of distributor which use to get film's distributors
     * @return ArrayList<String>
     * @throws SQLException 
     */
    public ArrayList<String> getDistributorsById(int id) throws SQLException {
        ArrayList<String> distributors = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT name FROM Film JOIN Distributor ON Film.distributor_id = Distributor.id WHERE Distributor.id = " + String.valueOf(id);
            
            Statement statement = conn.createStatement();
            ResultSet result = statement.executeQuery(sql);
            
            while (result.next()) {
                distributors.add(result.getString("name"));
            }
        }

        return distributors;
    }

    /**
     * Gets film's score by ID
     * 
     * @param id The ID of film which use to get film's rating
     * @return Float
     * @throws SQLException 
     */
    public float getRatingById(int id) throws SQLException {
        float score;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT score FROM FilmRating JOIN Film ON FilmRating.film_id = Film.id WHERE Film.id = " + String.valueOf(id);
            
            Statement statement = conn.createStatement();
            ResultSet result = statement.executeQuery(sql);
            
            if (!result.next()) {
                return -1;
            }
            
            score = result.getFloat("score");
        }
        
        return score;
    }
    
    /**
     * Gets film's score by ID
     * 
     * @param id The ID of film which use to get film's rating
     * @param score The score of film which use to set film's score
     * @return True if updated successfully, else false
     * @throws SQLException 
     */
    public boolean setRatingById(int id, float score) throws SQLException {

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE FilmRating SET score = ? WHERE film_id = " + String.valueOf(id);
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setFloat(1, score);
            
            int rowsInserted = statement.executeUpdate();
            
            return rowsInserted > 0;
        }
        
    }
    
    /**
     * Adds rating by User
     * 
     * @param id The ID of film which use to get film's rating
     * @param score The score of film which use to set film's score
     * @param userId The name of User
     * @return True if added successfully, else false
     * @throws SQLException 
     */
    public boolean addRatingByUser(int id, float score, int userId) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO FilmRating (film_id, user_id, score) VALUES (?, ?, ?)";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            statement.setInt(2, userId);
            statement.setFloat(3, score);
            
            int rowsInserted = statement.executeUpdate();
            
            return rowsInserted > 0;
        }
        
    }
    
    /**
     * Adds Film
     * 
     * @param title The title of Film
     * @param releaseYear The released year of Film
     * @param distributorId The ID of distributor
     * @param videoPath The video's path
     * @param posterPath The poster's path
     * @return True if added successfully, else false
     * @throws SQLException 
     */
    public boolean addFilm(String title, int releaseYear, int distributorId, String videoPath, String posterPath) throws SQLException {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO Film (title, release_year, distributor_id, video_path, poster_path) VALUES (?, ?, ?, ?, ?)";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, title);
            statement.setInt(2, releaseYear);
            statement.setInt(3, distributorId);
            statement.setString(4, videoPath);
            statement.setString(5, posterPath);

            
            int rowsInserted = statement.executeUpdate();
            
            return rowsInserted > 0;
        }
        
    }

    /**
     * Gets film by ID
     * 
     * @param id The ID of film which use to get all of film's information
     * @return The film after being found
     * @throws SQLException 
     */
    public Film getFilmById(int id) throws SQLException {
        String title;
        int releaseYear;
        String videoPath;
        String posterPath;
        List<String> genres;
        List<String> directors;
        List<String> distributors;
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT title, release_year, video_path, poster_path FROM Film WHERE id = " + String.valueOf(id);
            Statement statement = conn.createStatement();
            ResultSet result = statement.executeQuery(sql);
            if (!result.next()) {
                return null;
            }   title = result.getString("title");
            releaseYear = result.getInt("release_year");
            videoPath = result.getString("video_path");
            posterPath = result.getString("poster_path");
            genres = getGenresById(id);
            directors = getDirectorsById(id);
            distributors = getDistributorsById(id);
        }
        
        return new Film(id, title, releaseYear, videoPath, posterPath, genres, directors, distributors);
    }

    /**
     * Gets all of films in database
     * 
     * @return Film ArrayList
     * @throws SQLException 
     */
    public ArrayList<Film> getAllFilms() throws SQLException {
        ArrayList<Film> films = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT id, title, release_year, distributor_id, video_path, poster_path FROM Film";
            
            Statement statement = conn.createStatement();
            ResultSet result = statement.executeQuery(sql);
            
            while (result.next()) {
                int id = result.getInt("id");
                String title = result.getString("title");
                int releaseYear = result.getInt("release_year");
                int distributorId = result.getInt("distributor_id");
                String videoPath = result.getString("video_path");
                String posterPath = result.getString("poster_path");
                List<String> genres = getGenresById(id);
                List<String> directors = getDirectorsById(id);
                List<String> distributors = getDistributorsById(distributorId);
                
                films.add(new Film(id, title, releaseYear, videoPath, posterPath, genres, directors, distributors));
            }
        }

        return films;
    }
}
