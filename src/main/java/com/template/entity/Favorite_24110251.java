package com.template.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;


@Entity
@Table(name = "Favorites", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"Username", "VideoId"})
})
@NamedQueries({
    @NamedQuery(name = "Favorite_24110251.countByVideoId", query = "SELECT COUNT(f) FROM Favorite_24110251 f WHERE f.video.videoId = :videoId"),
    @NamedQuery(name = "Favorite_24110251.findByUserAndVideo", query = "SELECT f FROM Favorite_24110251 f WHERE f.user.username = :username AND f.video.videoId = :videoId")
})
public class Favorite_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "FavoriteId")
    private Integer favoriteId;

    @Temporal(TemporalType.DATE)
    @Column(name = "LikedDate")
    private Date likedDate = new Date();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Username")
    private User_24110251 user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "VideoId")
    private Video_24110251 video;

    public Favorite_24110251() {
    }

    public Favorite_24110251(Date likedDate, User_24110251 user, Video_24110251 video) {
        this.likedDate = likedDate;
        this.user = user;
        this.video = video;
    }

    public Integer getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(Integer favoriteId) {
        this.favoriteId = favoriteId;
    }

    public Date getLikedDate() {
        return likedDate;
    }

    public void setLikedDate(Date likedDate) {
        this.likedDate = likedDate;
    }

    public User_24110251 getUser() {
        return user;
    }

    public void setUser(User_24110251 user) {
        this.user = user;
    }

    public Video_24110251 getVideo() {
        return video;
    }

    public void setVideo(Video_24110251 video) {
        this.video = video;
    }
}
