package com.template.controller;

import com.template.entity.Category_24110251;
import com.template.entity.Video_24110251;
import com.template.service.CategoryServiceImpl_24110251;
import com.template.service.ICategoryService_24110251;
import com.template.service.IVideoService_24110251;
import com.template.service.VideoServiceImpl_24110251;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminVideoController_24110251", urlPatterns = {"/admin/videos"})
public class AdminVideoController_24110251 extends HttpServlet {

    private IVideoService_24110251 videoService = new VideoServiceImpl_24110251();
    private ICategoryService_24110251 categoryService = new CategoryServiceImpl_24110251();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");

        if ("new".equalsIgnoreCase(action)) {
            List<Category_24110251> categories = categoryService.findAll();
            request.setAttribute("categories", categories);
            request.setAttribute("video", new Video_24110251());
            request.getRequestDispatcher("/view/admin/video-form.jsp").include(request, response);
            return;
        }

        if ("edit".equalsIgnoreCase(action)) {
            String videoId = request.getParameter("id");
            Video_24110251 video = videoService.findById(videoId);
            List<Category_24110251> categories = categoryService.findAll();
            request.setAttribute("categories", categories);
            request.setAttribute("video", video);
            request.getRequestDispatcher("/view/admin/video-form.jsp").include(request, response);
            return;
        }

        if ("delete".equalsIgnoreCase(action)) {
            String videoId = request.getParameter("id");
            if (videoId != null && !videoId.trim().isEmpty()) {
                videoService.delete(videoId);
            }
            response.sendRedirect(request.getContextPath() + "/admin/videos?msg=deleted");
            return;
        }

        int pageSize = 6;
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException ignored) {
            }
        }

        long totalVideos = videoService.countAll();
        int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
        if (totalPages == 0) totalPages = 1;
        if (page > totalPages) page = totalPages;

        List<Video_24110251> videos = videoService.findAllPaginated(page, pageSize);

        request.setAttribute("videos", videos);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalVideos", totalVideos);

        request.getRequestDispatcher("/view/admin/video-list.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String videoId = request.getParameter("videoId");
        String title = request.getParameter("title");
        String poster = request.getParameter("poster");
        String viewsStr = request.getParameter("views");
        String description = request.getParameter("description");
        String activeStr = request.getParameter("active");
        String categoryIdStr = request.getParameter("categoryId");
        String isEdit = request.getParameter("isEdit");

        if (videoId == null || videoId.trim().isEmpty() ||
            title == null || title.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/videos?error=invalid");
            return;
        }

        int views = 0;
        if (viewsStr != null && !viewsStr.trim().isEmpty()) {
            try {
                views = Integer.parseInt(viewsStr.trim());
            } catch (NumberFormatException ignored) {
            }
        }

        boolean active = "true".equalsIgnoreCase(activeStr) || "on".equalsIgnoreCase(activeStr);

        Category_24110251 category = null;
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryIdStr.trim());
                category = categoryService.findById(catId);
            } catch (NumberFormatException ignored) {
            }
        }

        Video_24110251 video = new Video_24110251();
        video.setVideoId(videoId.trim());
        video.setTitle(title.trim());
        video.setPoster(poster != null && !poster.trim().isEmpty() ? poster.trim() : "default-poster.jpg");
        video.setViews(views);
        video.setDescription(description != null ? description.trim() : "");
        video.setActive(active);
        video.setCategory(category);

        if ("true".equalsIgnoreCase(isEdit)) {
            videoService.update(video);
        } else {
            if (videoService.findById(videoId.trim()) != null) {
                videoService.update(video);
            } else {
                videoService.create(video);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/videos?msg=saved");
    }
}
