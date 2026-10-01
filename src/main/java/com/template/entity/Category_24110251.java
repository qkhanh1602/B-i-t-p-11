package com.template.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;


@Entity
@Table(name = "Category")
@NamedQueries({
    @NamedQuery(name = "Category_24110251.findAll", query = "SELECT c FROM Category_24110251 c WHERE c.status = true")
})
public class Category_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private Integer categoryId;

    @Column(name = "Categoryname", length = 100)
    private String categoryname;

    @Column(name = "Categorycode", length = 100)
    private String categorycode;

    @Column(name = "Images", length = 500)
    private String images;

    @Column(name = "Status")
    private Boolean status = true;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Video_24110251> videos;

    public Category_24110251() {
    }

    public Category_24110251(String categoryname, String categorycode, String images, Boolean status) {
        this.categoryname = categoryname;
        this.categorycode = categorycode;
        this.images = images;
        this.status = status;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getCategorycode() {
        return categorycode;
    }

    public void setCategorycode(String categorycode) {
        this.categorycode = categorycode;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public List<Video_24110251> getVideos() {
        return videos;
    }

    public void setVideos(List<Video_24110251> videos) {
        this.videos = videos;
    }
}
