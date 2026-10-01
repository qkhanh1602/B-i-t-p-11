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

@WebServlet(name = "CheckoutController_24110251", urlPatterns = {"/checkout", "/order/success", "/my-orders", "/order/detail"})
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
            List<Order_24110251> orders = orderService.findByUsername(session, currentUser.getUsername());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/view/web/my-orders.jsp").forward(request, response);
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
