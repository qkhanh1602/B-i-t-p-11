package com.template.controller;

import com.template.entity.User_24110251;
import com.template.model.Cart_24110251;
import com.template.model.Order_24110251;
import com.template.service.CartServiceImpl_24110251;
import com.template.service.ICartService_24110251;
import com.template.service.IOrderService_24110251;
import com.template.service.OrderServiceImpl_24110251;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CheckoutController_24110251", urlPatterns = {"/checkout", "/order/success", "/my-orders", "/order/detail", "/order/cancel", "/order/update-status", "/order/reorder", "/order/return"})
public class CheckoutController_24110251 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ICartService_24110251 cartService = new CartServiceImpl_24110251();
    private final IOrderService_24110251 orderService = new OrderServiceImpl_24110251();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(true);
        User_24110251 currentUser = (User_24110251) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        if ("/checkout".equals(path)) {
            Cart_24110251 cart = cartService.getCart(session);
            if (cart.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart?msg=empty_checkout");
                return;
            }

            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/view/web/checkout.jsp").forward(request, response);

        } else if ("/order/success".equals(path) || "/order/detail".equals(path)) {
            String orderId = request.getParameter("orderId");
            Order_24110251 order = null;

            if (orderId != null && !orderId.trim().isEmpty()) {
                order = orderService.findById(session, orderId.trim());
            }

            if (order == null) {
                order = (Order_24110251) session.getAttribute("lastCreatedOrder");
            }

            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/my-orders");
                return;
            }

            request.setAttribute("order", order);
            request.getRequestDispatcher("/view/web/order-success.jsp").forward(request, response);

        } else if ("/my-orders".equals(path)) {
            String status = request.getParameter("status");
            String keyword = request.getParameter("keyword");
            String normalizedStatus = Order_24110251.normalizeStatus(status);

            List<Order_24110251> orders = orderService.findByUsernameAndStatusAndKeyword(session, currentUser.getUsername(), normalizedStatus, keyword);
            java.util.Map<String, Integer> statusCounts = orderService.getStatusCountsByUsername(session, currentUser.getUsername());

            request.setAttribute("orders", orders);
            request.setAttribute("selectedStatus", normalizedStatus);
            request.setAttribute("keyword", keyword != null ? keyword.trim() : "");
            request.setAttribute("statusCounts", statusCounts);
            request.setAttribute("allStatuses", Order_24110251.ALL_STATUSES);
            request.getRequestDispatcher("/view/web/my-orders.jsp").forward(request, response);

        } else if ("/order/cancel".equals(path)) {
            String orderId = request.getParameter("orderId");
            String status = request.getParameter("status");
            if (orderId != null && !orderId.trim().isEmpty()) {
                orderService.updateOrderStatus(session, orderId.trim(), Order_24110251.STATUS_CANCELLED);
            }
            String redirectUrl = request.getContextPath() + "/my-orders?msg=cancelled";
            if (status != null && !status.trim().isEmpty()) {
                redirectUrl += "&status=" + java.net.URLEncoder.encode(status, "UTF-8");
            }
            response.sendRedirect(redirectUrl);

        } else if ("/order/return".equals(path)) {
            String orderId = request.getParameter("orderId");
            String status = request.getParameter("status");
            if (orderId != null && !orderId.trim().isEmpty()) {
                orderService.updateOrderStatus(session, orderId.trim(), Order_24110251.STATUS_RETURNED);
            }
            String redirectUrl = request.getContextPath() + "/my-orders?msg=returned";
            if (status != null && !status.trim().isEmpty()) {
                redirectUrl += "&status=" + java.net.URLEncoder.encode(status, "UTF-8");
            }
            response.sendRedirect(redirectUrl);

        } else if ("/order/reorder".equals(path)) {
            String orderId = request.getParameter("orderId");
            if (orderId != null && !orderId.trim().isEmpty()) {
                Order_24110251 order = orderService.findById(session, orderId.trim());
                if (order != null && order.getItems() != null) {
                    Cart_24110251 cart = cartService.getCart(session);
                    for (var item : order.getItems()) {
                        com.template.entity.Video_24110251 v = new com.template.entity.Video_24110251();
                        v.setVideoId(item.getVideoId());
                        v.setTitle(item.getVideoTitle());
                        v.setPoster(item.getPoster());
                        v.setPrice(item.getPrice());
                        cart.add(v, item.getQuantity());
                    }
                    response.sendRedirect(request.getContextPath() + "/cart?msg=reordered");
                    return;
                }
            }
            response.sendRedirect(request.getContextPath() + "/my-orders");

        } else if ("/order/update-status".equals(path)) {
            String orderId = request.getParameter("orderId");
            String newStatus = request.getParameter("newStatus");
            String currentStatus = request.getParameter("status");

            if (orderId != null && newStatus != null) {
                orderService.updateOrderStatus(session, orderId.trim(), newStatus.trim());
            }
            String redirectUrl = request.getContextPath() + "/my-orders?msg=updated";
            if (currentStatus != null && !currentStatus.trim().isEmpty()) {
                redirectUrl += "&status=" + java.net.URLEncoder.encode(currentStatus, "UTF-8");
            }
            response.sendRedirect(redirectUrl);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(true);
        User_24110251 currentUser = (User_24110251) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();

        if ("/order/update-status".equals(path)) {
            String orderId = request.getParameter("orderId");
            String newStatus = request.getParameter("newStatus");
            String currentStatus = request.getParameter("status");

            if (orderId != null && newStatus != null) {
                orderService.updateOrderStatus(session, orderId.trim(), newStatus.trim());
            }
            String redirectUrl = request.getContextPath() + "/my-orders?msg=updated";
            if (currentStatus != null && !currentStatus.trim().isEmpty()) {
                redirectUrl += "&status=" + java.net.URLEncoder.encode(currentStatus, "UTF-8");
            }
            response.sendRedirect(redirectUrl);
            return;
        }

        Cart_24110251 cart = cartService.getCart(session);
        if (cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?msg=empty_checkout");
            return;
        }

        String customerName = request.getParameter("customerName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        String paymentMethod = request.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
            paymentMethod = Order_24110251.PAYMENT_METHOD_COD;
        }

        // Kiểm tra hợp lệ dữ liệu
        if (customerName == null || customerName.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Vui lòng nhập đầy đủ Họ tên, Số điện thoại và Địa chỉ nhận hàng COD!");
            request.setAttribute("customerName", customerName);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("note", note);
            request.setAttribute("cart", cart);
            request.getRequestDispatcher("/view/web/checkout.jsp").forward(request, response);
            return;
        }

        // Tạo đơn hàng COD
        Order_24110251 order = orderService.createCodOrder(
                session,
                currentUser,
                cart,
                customerName.trim(),
                phone.trim(),
                address.trim(),
                note != null ? note.trim() : ""
        );

        response.sendRedirect(request.getContextPath() + "/order/success?orderId=" + order.getOrderId());
    }
}
