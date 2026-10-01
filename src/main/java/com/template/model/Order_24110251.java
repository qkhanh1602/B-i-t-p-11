package com.template.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final String PAYMENT_METHOD_COD = "COD";
    public static final String PAYMENT_METHOD_COD_TEXT = "COD - Thanh toán khi nhận hàng (Cash on Delivery)";

    public static final String STATUS_PENDING_CONFIRM = "Chờ xác nhận & Giao hàng COD";
    public static final String STATUS_SHIPPING = "Đang giao hàng";
    public static final String STATUS_COMPLETED = "Đã giao hàng & Thu tiền thành công";
    public static final String STATUS_CANCELLED = "Đã hủy";

    private String orderId;
    private String username;
    private String customerName;
    private String phone;
    private String address;
    private String note;
    private String paymentMethod = PAYMENT_METHOD_COD;
    private String paymentStatus = "Chờ thu tiền COD khi nhận hàng";
    private String orderStatus = STATUS_PENDING_CONFIRM;
    private Date orderDate = new Date();
    private double totalAmount;
    private List<OrderDetail_24110251> items = new ArrayList<>();

    public Order_24110251() {
        this.orderDate = new Date();
        this.paymentMethod = PAYMENT_METHOD_COD;
        this.orderStatus = STATUS_PENDING_CONFIRM;
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
        this.orderStatus = STATUS_PENDING_CONFIRM;
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
}
