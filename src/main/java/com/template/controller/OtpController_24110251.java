package com.template.controller;

import com.template.service.IUserService_24110251;
import com.template.service.UserServiceImpl_24110251;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "OtpController_24110251", urlPatterns = {"/otp"})
public class OtpController_24110251 extends HttpServlet {

    private IUserService_24110251 userService = new UserServiceImpl_24110251();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/web/otp.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession();

        String sessionOtp = (String) session.getAttribute("registerOtp");
        String pendingUsername = (String) session.getAttribute("pendingUsername");

        if (sessionOtp != null && sessionOtp.equals(enteredOtp != null ? enteredOtp.trim() : "")) {
            userService.activateUser(pendingUsername);

            session.removeAttribute("registerOtp");
            session.removeAttribute("pendingUsername");
            session.removeAttribute("pendingEmail");

            response.sendRedirect(request.getContextPath() + "/login?msg=activated");
        } else {
            response.sendRedirect(request.getContextPath() + "/otp?error=wrong");
        }
    }
}
