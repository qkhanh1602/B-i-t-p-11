package com.template.controller;

import com.template.model.Cart_24110251;
import com.template.service.CartServiceImpl_24110251;
import com.template.service.ICartService_24110251;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "CartController_24110251", urlPatterns = {"/cart"})
public class CartController_24110251 extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ICartService_24110251 cartService = new CartServiceImpl_24110251();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(true);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String id = request.getParameter("id");
        if (id == null || id.trim().isEmpty()) {
            id = request.getParameter("videoId");
        }

        Cart_24110251 cart = cartService.getCart(session);

        if (action != null) {
            try {
                if ("add".equalsIgnoreCase(action) && id != null) {
                    int quantity = 1;
                    String qtyParam = request.getParameter("quantity");
                    if (qtyParam != null && !qtyParam.trim().isEmpty()) {
                        try {
                            quantity = Integer.parseInt(qtyParam.trim());
                        } catch (NumberFormatException ignored) {
                            quantity = 1;
                        }
                    }

                    int resultCode = cartService.addToCart(session, id, quantity);

                    String isAjax = request.getParameter("ajax");
                    if ("true".equalsIgnoreCase(isAjax) || "XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                        response.setContentType("application/json;charset=UTF-8");
                        response.getWriter().write(String.format(
                                "{\"success\":true,\"code\":%d,\"totalItems\":%d,\"totalAmount\":%.0f}",
                                resultCode, cart.getTotalItems(), cart.getTotalAmount()
                        ));
                        return;
                    }

                    String redirect = request.getParameter("redirect");
                    if (redirect != null && !redirect.trim().isEmpty()) {
                        String msg = (resultCode == Cart_24110251.RESULT_REACHED_MAX) ? "max_reached" : "added";
                        response.sendRedirect(request.getContextPath() + redirect + (redirect.contains("?") ? "&" : "?") + "msg=" + msg);
                        return;
                    }

                    String referer = request.getHeader("referer");
                    String msg = (resultCode == Cart_24110251.RESULT_REACHED_MAX) ? "max_reached" : "added";
                    if (referer != null && !referer.isEmpty() && !referer.contains("/cart")) {
                        // Remove existing cartMsg if any
                        String cleanReferer = referer.replaceAll("[?&]cartMsg=[^&]*", "");
                        response.sendRedirect(cleanReferer + (cleanReferer.contains("?") ? "&" : "?") + "cartMsg=" + msg);
                        return;
                    }

                    response.sendRedirect(request.getContextPath() + "/cart?msg=" + msg);
                    return;

                } else if ("update".equalsIgnoreCase(action) && id != null) {
                    int quantity = 1;
                    String qtyParam = request.getParameter("quantity");
                    if (qtyParam != null && !qtyParam.trim().isEmpty()) {
                        try {
                            quantity = Integer.parseInt(qtyParam.trim());
                        } catch (NumberFormatException ignored) {
                            quantity = 1;
                        }
                    }

                    int resultCode = cartService.updateQuantity(session, id, quantity);
                    String msg = "updated";
                    if (resultCode == Cart_24110251.RESULT_REACHED_MAX) {
                        msg = "max_reached";
                    } else if (resultCode == Cart_24110251.RESULT_REMOVED) {
                        msg = "removed";
                    }
                    response.sendRedirect(request.getContextPath() + "/cart?msg=" + msg);
                    return;

                } else if ("increase".equalsIgnoreCase(action) && id != null) {
                    boolean ok = cartService.increaseQuantity(session, id);
                    response.sendRedirect(request.getContextPath() + "/cart?msg=" + (ok ? "increased" : "max_reached"));
                    return;

                } else if ("decrease".equalsIgnoreCase(action) && id != null) {
                    cartService.decreaseQuantity(session, id);
                    response.sendRedirect(request.getContextPath() + "/cart?msg=decreased");
                    return;

                } else if ("remove".equalsIgnoreCase(action) && id != null) {
                    cartService.removeItem(session, id);
                    response.sendRedirect(request.getContextPath() + "/cart?msg=removed");
                    return;

                } else if ("clear".equalsIgnoreCase(action)) {
                    cartService.clearCart(session);
                    response.sendRedirect(request.getContextPath() + "/cart?msg=cleared");
                    return;

                } else if ("checkout".equalsIgnoreCase(action)) {
                    if (cart.isEmpty()) {
                        response.sendRedirect(request.getContextPath() + "/cart?msg=empty_checkout");
                        return;
                    }
                    cartService.clearCart(session);
                    request.setAttribute("checkoutSuccess", true);
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        request.setAttribute("cart", cart);
        request.getRequestDispatcher("/view/web/cart.jsp").forward(request, response);
    }
}
