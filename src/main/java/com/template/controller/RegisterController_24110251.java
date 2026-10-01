package com.template.controller;

import com.template.entity.User_24110251;
import com.template.service.IUserService_24110251;
import com.template.service.UserServiceImpl_24110251;
import com.template.util.EmailUtil_24110251;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "RegisterController_24110251", urlPatterns = {"/register"})
public class RegisterController_24110251 extends HttpServlet {

    private IUserService_24110251 userService = new UserServiceImpl_24110251();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/web/register.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String images = request.getParameter("images");

        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/register?error=empty");
            return;
        }

        if (userService.findById(username.trim()) != null) {
            response.sendRedirect(request.getContextPath() + "/register?error=exists");
            return;
        }

        User_24110251 user = new User_24110251();
        user.setUsername(username.trim());
        user.setPassword(password.trim());
        user.setPhone(phone != null ? phone.trim() : "");
        user.setFullname(fullname != null ? fullname.trim() : "");
        user.setEmail(email.trim());
        user.setImages(images != null && !images.trim().isEmpty() ? images.trim() : "default-avatar.png");
        user.setAdmin(false);
        user.setActive(false);

        boolean created = userService.register(user);

        if (created) {
            String otp = EmailUtil_24110251.generateOtp();
            EmailUtil_24110251.sendOtpEmail(user.getEmail(), otp);

            HttpSession session = request.getSession();
            session.setAttribute("registerOtp", otp);
            session.setAttribute("pendingUsername", user.getUsername());
            session.setAttribute("pendingEmail", user.getEmail());

            response.sendRedirect(request.getContextPath() + "/otp");
        } else {
            response.sendRedirect(request.getContextPath() + "/register?error=failed");
        }
    }
}
