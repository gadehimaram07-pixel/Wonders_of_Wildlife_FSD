package com.wildlife.model;

import java.io.Serializable;

/**
 * Model class representing an Animal or Bird.
 */
public class Animal implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String category; // 'Animal' or 'Bird'
    private String scientificName;
    private String habitat;
    private String foundIn;
    private String description;
    private String imageUrl;

    public Animal() {
    }

    public Animal(int id, String name, String category, String scientificName, String habitat, String foundIn, String description, String imageUrl) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.scientificName = scientificName;
        this.habitat = habitat;
        this.foundIn = foundIn;
        this.description = description;
        this.imageUrl = imageUrl;
    }

    public Animal(String name, String category, String scientificName, String habitat, String foundIn, String description, String imageUrl) {
        this.name = name;
        this.category = category;
        this.scientificName = scientificName;
        this.habitat = habitat;
        this.foundIn = foundIn;
        this.description = description;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getScientificName() {
        return scientificName;
    }

    public void setScientificName(String scientificName) {
        this.scientificName = scientificName;
    }

    public String getHabitat() {
        return habitat;
    }

    public void setHabitat(String habitat) {
        this.habitat = habitat;
    }

    public String getFoundIn() {
        return foundIn;
    }

    public void setFoundIn(String foundIn) {
        this.foundIn = foundIn;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
