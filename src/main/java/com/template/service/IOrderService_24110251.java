package com.template.service;

import com.template.entity.User_24110251;
import com.template.model.Cart_24110251;
import com.template.model.Order_24110251;
import jakarta.servlet.http.HttpSession;

import java.util.List;

public interface IOrderService_24110251 {
    Order_24110251 createCodOrder(HttpSession session, User_24110251 user, Cart_24110251 cart,
                                  String customerName, String phone, String address, String note);

    List<Order_24110251> findByUsername(HttpSession session, String username);

    Order_24110251 findById(HttpSession session, String orderId);

    List<Order_24110251> findAll(HttpSession session);
}
