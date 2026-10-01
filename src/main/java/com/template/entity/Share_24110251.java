package com.template.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Date;


@Entity
@Table(name = "Shares")
@NamedQueries({
    @NamedQuery(name = "Share_24110251.countByVideoId", query = "SELECT COUNT(s) FROM Share_24110251 s WHERE s.video.videoId = :videoId")
})
public class Share_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ShareId")
    private Integer shareId;

    @Column(name = "Emails", length = 50)
    private String emails;

    @Temporal(TemporalType.DATE)
    @Column(name = "SharedDate")
    private Date sharedDate = new Date();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "Username")
    private User_24110251 user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "VideoId")
    private Video_24110251 video;

    public Share_24110251() {
    }

    public Share_24110251(String emails, Date sharedDate, User_24110251 user, Video_24110251 video) {
        this.emails = emails;
        this.sharedDate = sharedDate;
        this.user = user;
        this.video = video;
    }

    public Integer getShareId() {
        return shareId;
    }

    public void setShareId(Integer shareId) {
        this.shareId = shareId;
    }

    public String getEmails() {
        return emails;
    }

    public void setEmails(String emails) {
        this.emails = emails;
    }

    public Date getSharedDate() {
        return sharedDate;
    }

    public void setSharedDate(Date sharedDate) {
        this.sharedDate = sharedDate;
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
