package com.template.controller;

import com.template.entity.User_24110251;
import com.template.entity.Video_24110251;
import com.template.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "VideoDetailController_24110251", urlPatterns = {"/video/detail"})
public class VideoDetailController_24110251 extends HttpServlet {

    private IVideoService_24110251 videoService = new VideoServiceImpl_24110251();
    private IShareService_24110251 shareService = new ShareServiceImpl_24110251();
    private IFavoriteService_24110251 favoriteService = new FavoriteServiceImpl_24110251();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String videoId = request.getParameter("id");
        if (videoId == null || videoId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");
        User_24110251 currentUser = (User_24110251) session.getAttribute("currentUser");

        if ("like".equalsIgnoreCase(action)) {
            if (currentUser != null) {
                favoriteService.toggleLike(currentUser.getUsername(), videoId);
            }
            response.sendRedirect(request.getContextPath() + "/video/detail?id=" + videoId);
            return;
        }

        if ("share".equalsIgnoreCase(action)) {
            String emails = request.getParameter("emails");
            if (currentUser != null && emails != null && !emails.trim().isEmpty()) {
                shareService.shareVideo(currentUser.getUsername(), videoId, emails.trim());
            }
            response.sendRedirect(request.getContextPath() + "/video/detail?id=" + videoId + "&shared=true");
            return;
        }

        videoService.incrementViews(videoId);

        Video_24110251 video = videoService.findById(videoId);
        if (video == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        long shareCount = shareService.countByVideoId(videoId);
        long likeCount = favoriteService.countByVideoId(videoId);
        boolean isLiked = false;
        if (currentUser != null) {
            isLiked = favoriteService.isLiked(currentUser.getUsername(), videoId);
        }

        request.setAttribute("video", video);
        request.setAttribute("shareCount", shareCount);
        request.setAttribute("likeCount", likeCount);
        request.setAttribute("isLiked", isLiked);

        request.getRequestDispatcher("/view/web/detail.jsp").include(request, response);
    }
}
