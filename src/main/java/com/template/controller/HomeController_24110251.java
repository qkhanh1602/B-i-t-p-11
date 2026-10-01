package com.template.controller;

import com.template.entity.Category_24110251;
import com.template.entity.Video_24110251;
import com.template.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "HomeController_24110251", urlPatterns = {"/home"})
public class HomeController_24110251 extends HttpServlet {

    private ICategoryService_24110251 categoryService = new CategoryServiceImpl_24110251();
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

        List<Category_24110251> categories = categoryService.findAll();
        Map<Integer, Long> videoCountMap = new HashMap<>();
        Map<Integer, List<Video_24110251>> categoryVideosMap = new LinkedHashMap<>();
        Map<Integer, Integer> totalPagesMap = new HashMap<>();
        Map<Integer, Integer> currentPageMap = new HashMap<>();
        Map<String, Long> shareCountMap = new HashMap<>();
        Map<String, Long> likeCountMap = new HashMap<>();

        int pageSize = 3;

        for (Category_24110251 cat : categories) {
            Integer catId = cat.getCategoryId();
            long totalVideos = videoService.countByCategoryId(catId);
            videoCountMap.put(catId, totalVideos);

            int totalPages = (int) Math.ceil((double) totalVideos / pageSize);
            if (totalPages == 0) {
                totalPages = 1;
            }
            totalPagesMap.put(catId, totalPages);

            String pageParam = request.getParameter("page_" + catId);
            int currentPage = 1;
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                    if (currentPage < 1) currentPage = 1;
                    if (currentPage > totalPages) currentPage = totalPages;
                } catch (NumberFormatException ignored) {
                }
            }
            currentPageMap.put(catId, currentPage);

            List<Video_24110251> videos = videoService.findByCategoryId(catId, currentPage, pageSize);
            categoryVideosMap.put(catId, videos);

            for (Video_24110251 v : videos) {
                String vid = v.getVideoId();
                if (!shareCountMap.containsKey(vid)) {
                    shareCountMap.put(vid, shareService.countByVideoId(vid));
                }
                if (!likeCountMap.containsKey(vid)) {
                    likeCountMap.put(vid, favoriteService.countByVideoId(vid));
                }
            }
        }

        request.setAttribute("categories", categories);
        request.setAttribute("videoCountMap", videoCountMap);
        request.setAttribute("categoryVideosMap", categoryVideosMap);
        request.setAttribute("totalPagesMap", totalPagesMap);
        request.setAttribute("currentPageMap", currentPageMap);
        request.setAttribute("shareCountMap", shareCountMap);
        request.setAttribute("likeCountMap", likeCountMap);

        request.getRequestDispatcher("/view/web/home.jsp").include(request, response);
    }
}
