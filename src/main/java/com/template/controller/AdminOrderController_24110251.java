package com.template.controller;

import com.template.model.Order_24110251;
import com.template.service.IOrderService_24110251;
import com.template.service.OrderServiceImpl_24110251;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "AdminOrderController_24110251", urlPatterns = {"/admin/orders", "/admin/order/update-status"})
public class AdminOrderController_24110251 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final IOrderService_24110251 orderService = new OrderServiceImpl_24110251();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(true);
        String path = request.getServletPath();

        if ("/admin/order/update-status".equals(path)) {
            String orderId = request.getParameter("orderId");
            String newStatus = request.getParameter("newStatus");
            String currentStatusFilter = request.getParameter("status");

            if (orderId != null && newStatus != null) {
                orderService.updateOrderStatus(session, orderId.trim(), newStatus.trim());
            }

            String redirectUrl = request.getContextPath() + "/admin/orders?msg=updated";
            if (currentStatusFilter != null && !currentStatusFilter.trim().isEmpty()) {
                redirectUrl += "&status=" + URLEncoder.encode(currentStatusFilter, "UTF-8");
            }
            response.sendRedirect(redirectUrl);
            return;
        }

        String statusFilter = request.getParameter("status");
        String keyword = request.getParameter("keyword");
        String normalizedStatus = Order_24110251.normalizeStatus(statusFilter);

        List<Order_24110251> orders = orderService.findAllByStatus(session, normalizedStatus);
        if (keyword != null && !keyword.trim().isEmpty()) {
            String kw = keyword.trim().toLowerCase();
            orders = orders.stream().filter(ord ->
                (ord.getOrderId() != null && ord.getOrderId().toLowerCase().contains(kw)) ||
                (ord.getCustomerName() != null && ord.getCustomerName().toLowerCase().contains(kw)) ||
                (ord.getUsername() != null && ord.getUsername().toLowerCase().contains(kw)) ||
                (ord.getPhone() != null && ord.getPhone().contains(kw)) ||
                (ord.getItems() != null && ord.getItems().stream().anyMatch(i -> i.getVideoTitle() != null && i.getVideoTitle().toLowerCase().contains(kw)))
            ).toList();
        }

        Map<String, Integer> statusCounts = orderService.getAllStatusCounts(session);

        request.setAttribute("orders", orders);
        request.setAttribute("selectedStatus", normalizedStatus);
        request.setAttribute("keyword", keyword != null ? keyword.trim() : "");
        request.setAttribute("statusCounts", statusCounts);
        request.setAttribute("allStatuses", Order_24110251.ALL_STATUSES);

        request.getRequestDispatcher("/view/admin/order-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
