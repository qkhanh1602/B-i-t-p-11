package com.template.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;


@Entity
@Table(name = "Videos")
@NamedQueries({
    @NamedQuery(name = "Video_24110251.findAll", query = "SELECT v FROM Video_24110251 v WHERE v.active = true"),
    @NamedQuery(name = "Video_24110251.countAll", query = "SELECT COUNT(v) FROM Video_24110251 v"),
    @NamedQuery(name = "Video_24110251.findByCategoryId", query = "SELECT v FROM Video_24110251 v WHERE v.category.categoryId = :categoryId AND v.active = true")
})
public class Video_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "VideoId", length = 50, nullable = false)
    private String videoId;

    @Column(name = "Title", length = 200)
    private String title;

    @Column(name = "Poster", length = 500)
    private String poster;

    @Column(name = "Views")
    private Integer views = 0;

    @Column(name = "Description", length = 500)
    private String description;

    @Column(name = "Active")
    private Boolean active = true;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "CategoryId")
    private Category_24110251 category;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Favorite_24110251> favorites;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Share_24110251> shares;

    public Video_24110251() {
    }

    public Video_24110251(String videoId, String title, String poster, Integer views, String description, Boolean active, Category_24110251 category) {
        this.videoId = videoId;
        this.title = title;
        this.poster = poster;
        this.views = views;
        this.description = description;
        this.active = active;
        this.category = category;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Category_24110251 getCategory() {
        return category;
    }

    public void setCategory(Category_24110251 category) {
        this.category = category;
    }

    public List<Favorite_24110251> getFavorites() {
        return favorites;
    }

    public void setFavorites(List<Favorite_24110251> favorites) {
        this.favorites = favorites;
    }

    @Transient
    private Double price;

    public Double getPrice() {
        if (price == null || price <= 0) {
            if (videoId != null) {
                int code = Math.abs(videoId.hashCode()) % 5;
                switch (code) {
                    case 0: return 150000.0;
                    case 1: return 199000.0;
                    case 2: return 249000.0;
                    case 3: return 299000.0;
                    default: return 350000.0;
                }
            }
            return 199000.0;
        }
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public List<Share_24110251> getShares() {
        return shares;
    }

    public void setShares(List<Share_24110251> shares) {
        this.shares = shares;
    }
}
