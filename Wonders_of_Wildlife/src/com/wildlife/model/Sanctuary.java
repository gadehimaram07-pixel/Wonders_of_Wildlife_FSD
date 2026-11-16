package com.wildlife.model;

import java.io.Serializable;

/**
 * Model class representing a Wildlife Sanctuary or National Park.
 */
public class Sanctuary implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String state;
    private String description;
    private String keyAnimals;
    private String bestTime;
    private String imageUrl;

    public Sanctuary() {
    }

    public Sanctuary(int id, String name, String state, String description, String keyAnimals, String bestTime, String imageUrl) {
        this.id = id;
        this.name = name;
        this.state = state;
        this.description = description;
        this.keyAnimals = keyAnimals;
        this.bestTime = bestTime;
        this.imageUrl = imageUrl;
    }

    public Sanctuary(String name, String state, String description, String keyAnimals, String bestTime, String imageUrl) {
        this.name = name;
        this.state = state;
        this.description = description;
        this.keyAnimals = keyAnimals;
        this.bestTime = bestTime;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getKeyAnimals() {
        return keyAnimals;
    }

    public void setKeyAnimals(String keyAnimals) {
        this.keyAnimals = keyAnimals;
    }

    public String getBestTime() {
        return bestTime;
    }

    public void setBestTime(String bestTime) {
        this.bestTime = bestTime;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
