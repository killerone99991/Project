/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.List;

/**
 *
 * @author
 */
public class Film {
    private String title;
    private int releaseYear;
    private String videoPath;
    private String posterPath;
    private List<String> genres;
    private List<String> directors;
    private List<String> distributors;

    public Film(String title, int releaseYear, String videoPath, String posterPath, List<String> genres, List<String> directors, List<String> distributors) {
        this.title = title;
        this.releaseYear = releaseYear;
        this.videoPath = videoPath;
        this.posterPath = posterPath;
        this.genres = genres;
        this.directors = directors;
        this.distributors = distributors;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPath) {
        this.videoPath = videoPath;
    }

    public String getPosterPath() {
        return posterPath;
    }

    public void setPosterPath(String posterPath) {
        this.posterPath = posterPath;
    }

    public List<String> getGenres() {
        return genres;
    }

    public void setGenres(List<String> genres) {
        this.genres = genres;
    }

    public List<String> getDirectors() {
        return directors;
    }

    public void setDirectors(List<String> directors) {
        this.directors = directors;
    }

    public List<String> getDistributors() {
        return distributors;
    }

    public void setDistributors(List<String> distributors) {
        this.distributors = distributors;
    }
    
    
}
