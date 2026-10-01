package com.template.service;

import com.template.entity.User_24110251;
import com.template.model.CartItem_24110251;
import com.template.model.Cart_24110251;
import com.template.model.OrderDetail_24110251;
import com.template.model.Order_24110251;
import jakarta.servlet.http.HttpSession;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

public class OrderServiceImpl_24110251 implements IOrderService_24110251 {

    public static final String SESSION_ORDERS_KEY = "myOrders";
    private static final Map<String, Order_24110251> GLOBAL_ORDER_MAP = new ConcurrentHashMap<>();

    @Override
    public Order_24110251 createCodOrder(HttpSession session, User_24110251 user, Cart_24110251 cart,
                                         String customerName, String phone, String address, String note) {
        if (cart == null || cart.isEmpty()) {
            return null;
        }

        String username = (user != null) ? user.getUsername() : "guest";
        String datePrefix = new SimpleDateFormat("yyyyMMdd").format(new Date());
        int randomCode = 1000 + new Random().nextInt(9000);
        String orderId = "COD-" + datePrefix + "-" + randomCode;

        Order_24110251 order = new Order_24110251(
                orderId,
                username,
                customerName,
                phone,
                address,
                note,
                cart.getTotalAmount()
        );

        order.setPaymentMethod(Order_24110251.PAYMENT_METHOD_COD);
        order.setPaymentStatus("Chờ thu tiền khi giao hàng (COD)");
        order.setOrderStatus(Order_24110251.STATUS_PENDING_CONFIRM);

        List<OrderDetail_24110251> details = new ArrayList<>();
        for (CartItem_24110251 cItem : cart.getItems()) {
            OrderDetail_24110251 d = new OrderDetail_24110251(
                    cItem.getVideo().getVideoId(),
                    cItem.getVideo().getTitle(),
                    cItem.getVideo().getPoster(),
                    cItem.getPrice(),
                    cItem.getQuantity()
            );
            details.add(d);
        }
        order.setItems(details);

        // Lưu vào kho đơn hàng toàn cục
        GLOBAL_ORDER_MAP.put(orderId, order);

        // Lưu vào danh sách đơn hàng của Session User
        if (session != null) {
            @SuppressWarnings("unchecked")
            List<Order_24110251> sessionOrders = (List<Order_24110251>) session.getAttribute(SESSION_ORDERS_KEY);
            if (sessionOrders == null) {
                sessionOrders = new ArrayList<>();
                session.setAttribute(SESSION_ORDERS_KEY, sessionOrders);
            }
            sessionOrders.add(0, order); // Đưa đơn hàng mới lên đầu

            // Lưu đơn hàng vừa tạo vào session để hiển thị trên trang xác nhận
            session.setAttribute("lastCreatedOrder", order);
        }

        // Làm trống giỏ hàng sau khi đặt thành công
        cart.clear();

        return order;
    }

    @Override
    public List<Order_24110251> findByUsername(HttpSession session, String username) {
        List<Order_24110251> list = new ArrayList<>();
        for (Order_24110251 ord : GLOBAL_ORDER_MAP.values()) {
            if (username != null && username.equalsIgnoreCase(ord.getUsername())) {
                list.add(ord);
            }
        }

        // Bổ sung các đơn trong session nếu có
        if (session != null) {
            @SuppressWarnings("unchecked")
            List<Order_24110251> sessionOrders = (List<Order_24110251>) session.getAttribute(SESSION_ORDERS_KEY);
            if (sessionOrders != null) {
                for (Order_24110251 sOrd : sessionOrders) {
                    if (!list.contains(sOrd)) {
                        list.add(sOrd);
                    }
                }
            }
        }

        // Sắp xếp đơn mới nhất lên đầu
        list.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));
        return list;
    }

    @Override
    public Order_24110251 findById(HttpSession session, String orderId) {
        if (orderId == null) return null;
        if (GLOBAL_ORDER_MAP.containsKey(orderId)) {
            return GLOBAL_ORDER_MAP.get(orderId);
        }
        if (session != null) {
            @SuppressWarnings("unchecked")
            List<Order_24110251> sessionOrders = (List<Order_24110251>) session.getAttribute(SESSION_ORDERS_KEY);
            if (sessionOrders != null) {
                for (Order_24110251 ord : sessionOrders) {
                    if (orderId.equalsIgnoreCase(ord.getOrderId())) {
                        return ord;
                    }
                }
            }
        }
        return null;
    }

    @Override
    public List<Order_24110251> findAll(HttpSession session) {
        List<Order_24110251> list = new ArrayList<>(GLOBAL_ORDER_MAP.values());
        list.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));
        return list;
    }
}
