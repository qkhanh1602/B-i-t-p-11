package com.template.model;

import com.template.entity.Video_24110251;
import java.io.Serializable;

public class CartItem_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final int DEFAULT_MAX_QUANTITY = 10;
    public static final int DEFAULT_MIN_QUANTITY = 1;

    private Video_24110251 video;
    private int quantity;
    private double price;
    private int maxQuantity = DEFAULT_MAX_QUANTITY;

    public CartItem_24110251() {
        this.quantity = DEFAULT_MIN_QUANTITY;
        this.maxQuantity = DEFAULT_MAX_QUANTITY;
    }

    public CartItem_24110251(Video_24110251 video, int quantity, double price, int maxQuantity) {
        this.video = video;
        this.maxQuantity = maxQuantity > 0 ? maxQuantity : DEFAULT_MAX_QUANTITY;
        this.price = price;
        setQuantity(quantity);
    }

    public Video_24110251 getVideo() {
        return video;
    }

    public void setVideo(Video_24110251 video) {
        this.video = video;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        if (quantity < DEFAULT_MIN_QUANTITY) {
            this.quantity = DEFAULT_MIN_QUANTITY;
        } else if (quantity > maxQuantity) {
            this.quantity = maxQuantity;
        } else {
            this.quantity = quantity;
        }
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getMaxQuantity() {
        return maxQuantity;
    }

    public void setMaxQuantity(int maxQuantity) {
        this.maxQuantity = maxQuantity;
    }

    public double getTotalPrice() {
        return this.price * this.quantity;
    }
}
