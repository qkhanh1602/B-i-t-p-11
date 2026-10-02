package com.template.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final String PAYMENT_METHOD_COD = "COD";
    public static final String PAYMENT_METHOD_COD_TEXT = "COD - Thanh toán khi nhận hàng (Cash on Delivery)";

    // 8 Trạng thái đơn hàng chuẩn
    public static final String STATUS_NEW = "Đơn hàng mới";
    public static final String STATUS_CONFIRMED = "Đã xác nhận";
    public static final String STATUS_PREPARING = "Chuẩn bị hàng";
    public static final String STATUS_SHIPPING = "Vận chuyển";
    public static final String STATUS_DELIVERING = "Giao hàng";
    public static final String STATUS_DELIVERED = "Đã giao";
    public static final String STATUS_CANCELLED = "Đơn hàng hủy";
    public static final String STATUS_RETURNED = "Đơn hàng hoàn";

    // Tương thích ngược với hằng số cũ
    public static final String STATUS_PENDING_CONFIRM = STATUS_NEW;
    public static final String STATUS_COMPLETED = STATUS_DELIVERED;

    public static final List<String> ALL_STATUSES = List.of(
            STATUS_NEW,
            STATUS_CONFIRMED,
            STATUS_PREPARING,
            STATUS_SHIPPING,
            STATUS_DELIVERING,
            STATUS_DELIVERED,
            STATUS_CANCELLED,
            STATUS_RETURNED
    );

    private String orderId;
    private String username;
    private String customerName;
    private String phone;
    private String address;
    private String note;
    private String paymentMethod = PAYMENT_METHOD_COD;
    private String paymentStatus = "Chờ thu tiền COD khi nhận hàng";
    private String orderStatus = STATUS_NEW;
    private Date orderDate = new Date();
    private double totalAmount;
    private List<OrderDetail_24110251> items = new ArrayList<>();

    public Order_24110251() {
        this.orderDate = new Date();
        this.paymentMethod = PAYMENT_METHOD_COD;
        this.orderStatus = STATUS_NEW;
    }

    public Order_24110251(String orderId, String username, String customerName, String phone, String address, String note, double totalAmount) {
        this.orderId = orderId;
        this.username = username;
        this.customerName = customerName;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.totalAmount = totalAmount;
        this.orderDate = new Date();
        this.paymentMethod = PAYMENT_METHOD_COD;
        this.orderStatus = STATUS_NEW;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public List<OrderDetail_24110251> getItems() {
        return items;
    }

    public void setItems(List<OrderDetail_24110251> items) {
        this.items = items;
    }

    public int getTotalQuantity() {
        int total = 0;
        if (items != null) {
            for (OrderDetail_24110251 item : items) {
                total += item.getQuantity();
            }
        }
        return total;
    }

    public static String normalizeStatus(String status) {
        if (status == null || status.trim().isEmpty()) {
            return "ALL";
        }
        String s = status.trim();
        if ("ALL".equalsIgnoreCase(s) || "Tất cả".equalsIgnoreCase(s) || "tat-ca".equalsIgnoreCase(s)) {
            return "ALL";
        }
        if (STATUS_NEW.equalsIgnoreCase(s) || "don-hang-moi".equalsIgnoreCase(s) || "new".equalsIgnoreCase(s) || "Chờ xác nhận & Giao hàng COD".equalsIgnoreCase(s)) {
            return STATUS_NEW;
        }
        if (STATUS_CONFIRMED.equalsIgnoreCase(s) || "da-xac-nhan".equalsIgnoreCase(s) || "confirmed".equalsIgnoreCase(s)) {
            return STATUS_CONFIRMED;
        }
        if (STATUS_PREPARING.equalsIgnoreCase(s) || "chuan-bi-hang".equalsIgnoreCase(s) || "preparing".equalsIgnoreCase(s)) {
            return STATUS_PREPARING;
        }
        if (STATUS_SHIPPING.equalsIgnoreCase(s) || "van-chuyen".equalsIgnoreCase(s) || "shipping".equalsIgnoreCase(s) || "vận chuyện".equalsIgnoreCase(s) || "Đang giao hàng".equalsIgnoreCase(s)) {
            return STATUS_SHIPPING;
        }
        if (STATUS_DELIVERING.equalsIgnoreCase(s) || "giao-hang".equalsIgnoreCase(s) || "delivering".equalsIgnoreCase(s)) {
            return STATUS_DELIVERING;
        }
        if (STATUS_DELIVERED.equalsIgnoreCase(s) || "da-giao".equalsIgnoreCase(s) || "delivered".equalsIgnoreCase(s) || "Đã giao hàng & Thu tiền thành công".equalsIgnoreCase(s) || "completed".equalsIgnoreCase(s)) {
            return STATUS_DELIVERED;
        }
        if (STATUS_CANCELLED.equalsIgnoreCase(s) || "don-hang-huy".equalsIgnoreCase(s) || "cancelled".equalsIgnoreCase(s) || "canceled".equalsIgnoreCase(s) || "Đã hủy".equalsIgnoreCase(s)) {
            return STATUS_CANCELLED;
        }
        if (STATUS_RETURNED.equalsIgnoreCase(s) || "don-hang-hoan".equalsIgnoreCase(s) || "returned".equalsIgnoreCase(s) || "Đã hoàn hàng".equalsIgnoreCase(s)) {
            return STATUS_RETURNED;
        }
        return s;
    }

    public static boolean isStatusMatch(String orderStatus, String filter) {
        if (filter == null || filter.trim().isEmpty()) {
            return true;
        }
        String normFilter = normalizeStatus(filter);
        if ("ALL".equalsIgnoreCase(normFilter)) {
            return true;
        }
        String normStatus = normalizeStatus(orderStatus);
        return normFilter.equalsIgnoreCase(normStatus);
    }

    public String getStatusBadgeClass() {
        if (STATUS_NEW.equalsIgnoreCase(orderStatus)) return "bg-primary text-white";
        if (STATUS_CONFIRMED.equalsIgnoreCase(orderStatus)) return "bg-info text-dark";
        if (STATUS_PREPARING.equalsIgnoreCase(orderStatus)) return "bg-warning text-dark";
        if (STATUS_SHIPPING.equalsIgnoreCase(orderStatus)) return "bg-secondary text-white";
        if (STATUS_DELIVERING.equalsIgnoreCase(orderStatus)) return "bg-primary-subtle text-primary border border-primary";
        if (STATUS_DELIVERED.equalsIgnoreCase(orderStatus)) return "bg-success text-white";
        if (STATUS_CANCELLED.equalsIgnoreCase(orderStatus)) return "bg-danger text-white";
        if (STATUS_RETURNED.equalsIgnoreCase(orderStatus)) return "bg-dark text-white";
        return "bg-secondary text-white";
    }

    public String getStatusIconClass() {
        if (STATUS_NEW.equalsIgnoreCase(orderStatus)) return "bi-bag-plus-fill";
        if (STATUS_CONFIRMED.equalsIgnoreCase(orderStatus)) return "bi-patch-check-fill";
        if (STATUS_PREPARING.equalsIgnoreCase(orderStatus)) return "bi-box-seam-fill";
        if (STATUS_SHIPPING.equalsIgnoreCase(orderStatus)) return "bi-truck";
        if (STATUS_DELIVERING.equalsIgnoreCase(orderStatus)) return "bi-bicycle";
        if (STATUS_DELIVERED.equalsIgnoreCase(orderStatus)) return "bi-check-circle-fill";
        if (STATUS_CANCELLED.equalsIgnoreCase(orderStatus)) return "bi-x-circle-fill";
        if (STATUS_RETURNED.equalsIgnoreCase(orderStatus)) return "bi-arrow-counterclockwise";
        return "bi-clock-history";
    }

    public int getStatusStep() {
        if (STATUS_NEW.equalsIgnoreCase(orderStatus)) return 1;
        if (STATUS_CONFIRMED.equalsIgnoreCase(orderStatus)) return 2;
        if (STATUS_PREPARING.equalsIgnoreCase(orderStatus)) return 3;
        if (STATUS_SHIPPING.equalsIgnoreCase(orderStatus)) return 4;
        if (STATUS_DELIVERING.equalsIgnoreCase(orderStatus)) return 5;
        if (STATUS_DELIVERED.equalsIgnoreCase(orderStatus)) return 6;
        if (STATUS_CANCELLED.equalsIgnoreCase(orderStatus)) return -1;
        if (STATUS_RETURNED.equalsIgnoreCase(orderStatus)) return -2;
        return 1;
    }

    public boolean canCancel() {
        return STATUS_NEW.equalsIgnoreCase(orderStatus) || STATUS_CONFIRMED.equalsIgnoreCase(orderStatus);
    }

    public boolean canReturn() {
        return STATUS_DELIVERED.equalsIgnoreCase(orderStatus);
    }
}
