package com.template.service;

import com.template.dao.IVideoDao_24110251;
import com.template.dao.VideoDaoImpl_24110251;
import com.template.entity.Video_24110251;
import com.template.model.Cart_24110251;
import jakarta.servlet.http.HttpSession;

public class CartServiceImpl_24110251 implements ICartService_24110251 {

    public static final String SESSION_CART_KEY = "cart";
    private final IVideoDao_24110251 videoDao = new VideoDaoImpl_24110251();

    @Override
    public Cart_24110251 getCart(HttpSession session) {
        if (session == null) {
            return new Cart_24110251();
        }
        Cart_24110251 cart = (Cart_24110251) session.getAttribute(SESSION_CART_KEY);
        if (cart == null) {
            cart = new Cart_24110251();
            session.setAttribute(SESSION_CART_KEY, cart);
        }
        return cart;
    }

    @Override
    public int addToCart(HttpSession session, String videoId, int quantity) {
        if (videoId == null || quantity <= 0) {
            return 0;
        }
        Cart_24110251 cart = getCart(session);
        Video_24110251 video = videoDao.findById(videoId);
        if (video == null) {
            return 0;
        }
        return cart.add(video, quantity);
    }

    @Override
    public int updateQuantity(HttpSession session, String videoId, int quantity) {
        Cart_24110251 cart = getCart(session);
        return cart.update(videoId, quantity);
    }

    @Override
    public boolean increaseQuantity(HttpSession session, String videoId) {
        Cart_24110251 cart = getCart(session);
        return cart.increase(videoId);
    }

    @Override
    public boolean decreaseQuantity(HttpSession session, String videoId) {
        Cart_24110251 cart = getCart(session);
        return cart.decrease(videoId);
    }

    @Override
    public void removeItem(HttpSession session, String videoId) {
        Cart_24110251 cart = getCart(session);
        cart.remove(videoId);
    }

    @Override
    public void clearCart(HttpSession session) {
        Cart_24110251 cart = getCart(session);
        cart.clear();
    }

    @Override
    public int getTotalQuantity(HttpSession session) {
        return getCart(session).getTotalItems();
    }

    @Override
    public double getTotalAmount(HttpSession session) {
        return getCart(session).getTotalAmount();
    }
}
