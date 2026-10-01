package com.template.service;

import com.template.model.Cart_24110251;
import jakarta.servlet.http.HttpSession;

public interface ICartService_24110251 {
    Cart_24110251 getCart(HttpSession session);
    int addToCart(HttpSession session, String videoId, int quantity);
    int updateQuantity(HttpSession session, String videoId, int quantity);
    boolean increaseQuantity(HttpSession session, String videoId);
    boolean decreaseQuantity(HttpSession session, String videoId);
    void removeItem(HttpSession session, String videoId);
    void clearCart(HttpSession session);
    int getTotalQuantity(HttpSession session);
    double getTotalAmount(HttpSession session);
}
