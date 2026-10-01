package com.template.model;

import java.io.Serializable;

public class OrderDetail_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private String videoId;
    private String videoTitle;
    private String poster;
    private double price;
    private int quantity;
    private double totalPrice;

    public OrderDetail_24110251() {
    }

    public OrderDetail_24110251(String videoId, String videoTitle, String poster, double price, int quantity) {
        this.videoId = videoId;
        this.videoTitle = videoTitle;
        this.poster = poster;
        this.price = price;
        this.quantity = quantity;
        this.totalPrice = price * quantity;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getVideoId() {
        return videoId;
    }

    public void setVideoId(String videoId) {
        this.videoId = videoId;
    }

    public String getVideoTitle() {
        return videoTitle;
    }

    public void setVideoTitle(String videoTitle) {
        this.videoTitle = videoTitle;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
        this.totalPrice = this.price * this.quantity;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.totalPrice = this.price * this.quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}
