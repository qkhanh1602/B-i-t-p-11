package com.template.controller;

import com.template.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "AdminHomeController_24110251", urlPatterns = {"/admin/home"})
public class AdminHomeController_24110251 extends HttpServlet {

    private IVideoService_24110251 videoService = new VideoServiceImpl_24110251();
    private ICategoryService_24110251 categoryService = new CategoryServiceImpl_24110251();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        long totalVideos = videoService.countAll();
        int totalCategories = categoryService.findAll().size();

        request.setAttribute("totalVideos", totalVideos);
        request.setAttribute("totalCategories", totalCategories);

        request.getRequestDispatcher("/view/admin/home.jsp").forward(request, response);
    }
}
