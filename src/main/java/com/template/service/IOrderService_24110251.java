package com.template.service;

import com.template.entity.User_24110251;
import com.template.model.Cart_24110251;
import com.template.model.Order_24110251;
import jakarta.servlet.http.HttpSession;

import java.util.List;
import java.util.Map;

public interface IOrderService_24110251 {
    Order_24110251 createCodOrder(HttpSession session, User_24110251 user, Cart_24110251 cart,
                                  String customerName, String phone, String address, String note);

    List<Order_24110251> findByUsername(HttpSession session, String username);

    List<Order_24110251> findByUsernameAndStatus(HttpSession session, String username, String statusFilter);

    List<Order_24110251> findByUsernameAndStatusAndKeyword(HttpSession session, String username, String statusFilter, String keyword);

    Map<String, Integer> getStatusCountsByUsername(HttpSession session, String username);

    boolean updateOrderStatus(HttpSession session, String orderId, String newStatus);

    Order_24110251 findById(HttpSession session, String orderId);

    List<Order_24110251> findAll(HttpSession session);

    List<Order_24110251> findAllByStatus(HttpSession session, String statusFilter);

    Map<String, Integer> getAllStatusCounts(HttpSession session);
}
