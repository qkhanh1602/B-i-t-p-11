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
        order.setOrderStatus(Order_24110251.STATUS_NEW);

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
        if (username != null) {
            seedDemoOrdersIfEmpty(username);
        }

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
                    boolean exists = false;
                    for (Order_24110251 existing : list) {
                        if (existing.getOrderId().equalsIgnoreCase(sOrd.getOrderId())) {
                            exists = true;
                            break;
                        }
                    }
                    if (!exists) {
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
    public List<Order_24110251> findByUsernameAndStatus(HttpSession session, String username, String statusFilter) {
        return findByUsernameAndStatusAndKeyword(session, username, statusFilter, null);
    }

    @Override
    public List<Order_24110251> findByUsernameAndStatusAndKeyword(HttpSession session, String username, String statusFilter, String keyword) {
        List<Order_24110251> userOrders = findByUsername(session, username);
        List<Order_24110251> filtered = new ArrayList<>();

        String kw = (keyword != null) ? keyword.trim().toLowerCase() : null;

        for (Order_24110251 ord : userOrders) {
            boolean matchStatus = Order_24110251.isStatusMatch(ord.getOrderStatus(), statusFilter);
            if (!matchStatus) {
                continue;
            }

            if (kw != null && !kw.isEmpty()) {
                boolean matchKeyword = false;
                if (ord.getOrderId() != null && ord.getOrderId().toLowerCase().contains(kw)) {
                    matchKeyword = true;
                } else if (ord.getCustomerName() != null && ord.getCustomerName().toLowerCase().contains(kw)) {
                    matchKeyword = true;
                } else if (ord.getPhone() != null && ord.getPhone().contains(kw)) {
                    matchKeyword = true;
                } else if (ord.getAddress() != null && ord.getAddress().toLowerCase().contains(kw)) {
                    matchKeyword = true;
                } else if (ord.getItems() != null) {
                    for (OrderDetail_24110251 item : ord.getItems()) {
                        if (item.getVideoTitle() != null && item.getVideoTitle().toLowerCase().contains(kw)) {
                            matchKeyword = true;
                            break;
                        }
                    }
                }
                if (!matchKeyword) {
                    continue;
                }
            }

            filtered.add(ord);
        }
        return filtered;
    }

    @Override
    public Map<String, Integer> getStatusCountsByUsername(HttpSession session, String username) {
        List<Order_24110251> userOrders = findByUsername(session, username);
        Map<String, Integer> counts = new LinkedHashMap<>();

        counts.put("ALL", userOrders.size());
        for (String st : Order_24110251.ALL_STATUSES) {
            counts.put(st, 0);
        }

        for (Order_24110251 ord : userOrders) {
            for (String st : Order_24110251.ALL_STATUSES) {
                if (Order_24110251.isStatusMatch(ord.getOrderStatus(), st)) {
                    counts.put(st, counts.get(st) + 1);
                }
            }
        }
        return counts;
    }

    @Override
    public Map<String, Integer> getAllStatusCounts(HttpSession session) {
        List<Order_24110251> allOrders = findAll(session);
        Map<String, Integer> counts = new LinkedHashMap<>();

        counts.put("ALL", allOrders.size());
        for (String st : Order_24110251.ALL_STATUSES) {
            counts.put(st, 0);
        }

        for (Order_24110251 ord : allOrders) {
            for (String st : Order_24110251.ALL_STATUSES) {
                if (Order_24110251.isStatusMatch(ord.getOrderStatus(), st)) {
                    counts.put(st, counts.get(st) + 1);
                }
            }
        }
        return counts;
    }

    @Override
    public boolean updateOrderStatus(HttpSession session, String orderId, String newStatus) {
        Order_24110251 order = findById(session, orderId);
        if (order != null) {
            order.setOrderStatus(newStatus);
            if (Order_24110251.STATUS_DELIVERED.equals(newStatus)) {
                order.setPaymentStatus("Đã thu tiền COD thành công");
            } else if (Order_24110251.STATUS_CANCELLED.equals(newStatus)) {
                order.setPaymentStatus("Đã hủy - Không thu tiền");
            } else if (Order_24110251.STATUS_RETURNED.equals(newStatus)) {
                order.setPaymentStatus("Đã hoàn hàng / Đã hoàn tiền");
            }
            return true;
        }
        return false;
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
        if (GLOBAL_ORDER_MAP.isEmpty()) {
            seedDemoOrdersIfEmpty("user");
        }
        List<Order_24110251> list = new ArrayList<>(GLOBAL_ORDER_MAP.values());
        list.sort((o1, o2) -> o2.getOrderDate().compareTo(o1.getOrderDate()));
        return list;
    }

    @Override
    public List<Order_24110251> findAllByStatus(HttpSession session, String statusFilter) {
        List<Order_24110251> all = findAll(session);
        if (statusFilter == null || statusFilter.trim().isEmpty() || "ALL".equalsIgnoreCase(statusFilter) || "Tất cả".equalsIgnoreCase(statusFilter)) {
            return all;
        }

        List<Order_24110251> filtered = new ArrayList<>();
        for (Order_24110251 ord : all) {
            if (Order_24110251.isStatusMatch(ord.getOrderStatus(), statusFilter)) {
                filtered.add(ord);
            }
        }
        return filtered;
    }

    private boolean isStatusMatch(String orderStatus, String filter) {
        return Order_24110251.isStatusMatch(orderStatus, filter);
    }

    private void seedDemoOrdersIfEmpty(String username) {
        if (username == null || username.trim().isEmpty()) return;

        boolean hasUserOrder = false;
        for (Order_24110251 ord : GLOBAL_ORDER_MAP.values()) {
            if (username.equalsIgnoreCase(ord.getUsername())) {
                hasUserOrder = true;
                break;
            }
        }

        if (!hasUserOrder) {
            String[] statuses = {
                    Order_24110251.STATUS_NEW,
                    Order_24110251.STATUS_CONFIRMED,
                    Order_24110251.STATUS_PREPARING,
                    Order_24110251.STATUS_SHIPPING,
                    Order_24110251.STATUS_DELIVERING,
                    Order_24110251.STATUS_DELIVERED,
                    Order_24110251.STATUS_CANCELLED,
                    Order_24110251.STATUS_RETURNED
            };

            String[] itemTitles = {
                    "Khóa học Lập trình Servlet & JPA Starter",
                    "Video Hướng dẫn thiết kế giao diện Web Bootstrap 5",
                    "Khóa học Lập trình Web Fullstack với Spring Boot",
                    "Thủ thuật Tối ưu hóa Database SQL Server & MySQL",
                    "Tự học Restful API Security & JWT Tokens",
                    "Khóa học Microservices Architecture căn bản",
                    "Kỹ thuật Refactoring & Clean Code nâng cao",
                    "Video Đồ án môn học Servlet JSP & JPA 2026"
            };

            double[] amounts = {250000, 180000, 450000, 320000, 290000, 500000, 150000, 380000};
            long now = System.currentTimeMillis();

            for (int i = 0; i < statuses.length; i++) {
                String orderId = "COD-20261002-800" + (i + 1);
                Order_24110251 demoOrd = new Order_24110251(
                        orderId,
                        username,
                        "Nguyễn Văn A (" + username + ")",
                        "090123456" + i,
                        "Số " + (12 + i * 5) + " Võ Văn Ngân, TP. Thủ Đức, TP.HCM",
                        "Giao giờ hành chính, đơn thuộc nhóm: " + statuses[i],
                        amounts[i]
                );

                demoOrd.setOrderStatus(statuses[i]);
                demoOrd.setOrderDate(new Date(now - (i * 3600000L * 4)));

                if (Order_24110251.STATUS_DELIVERED.equals(statuses[i])) {
                    demoOrd.setPaymentStatus("Đã thu tiền COD thành công");
                } else if (Order_24110251.STATUS_CANCELLED.equals(statuses[i])) {
                    demoOrd.setPaymentStatus("Đã hủy - Không thu tiền");
                } else if (Order_24110251.STATUS_RETURNED.equals(statuses[i])) {
                    demoOrd.setPaymentStatus("Đã hoàn hàng / Xử lý refund");
                } else {
                    demoOrd.setPaymentStatus("Chờ thu tiền COD khi nhận hàng");
                }

                OrderDetail_24110251 d = new OrderDetail_24110251(
                        "V00" + (i + 1),
                        itemTitles[i],
                        "https://picsum.photos/300/200?random=" + (i + 1),
                        amounts[i],
                        1
                );
                demoOrd.getItems().add(d);

                GLOBAL_ORDER_MAP.put(orderId, demoOrd);
            }
        }
    }
}
