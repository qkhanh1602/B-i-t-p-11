<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-dark bg-dark shadow-sm py-2">
    <div class="container-fluid px-4 d-flex justify-content-between align-items-center">
        <!-- Logo / Brand -->
        <div class="d-flex align-items-center">
            <a class="navbar-brand fw-bold text-white me-3" href="${pageContext.request.contextPath}/admin/home">
                <i class="bi bi-shield-shaded me-2 text-warning"></i>ADMIN DASHBOARD
            </a>
            <div class="d-none d-md-flex align-items-center gap-2">
                <a class="nav-link text-white-50 small hover-white" href="${pageContext.request.contextPath}/admin/home">
                    <i class="bi bi-speedometer2 me-1"></i>Tổng Quan
                </a>
                <span class="text-secondary">|</span>
                <a class="nav-link text-white-50 small hover-white" href="${pageContext.request.contextPath}/admin/videos">
                    <i class="bi bi-collection-play me-1"></i>Quản lý Videos
                </a>
                <span class="text-secondary">|</span>
                <a class="nav-link text-white-50 small hover-white" href="${pageContext.request.contextPath}/home" target="_blank">
                    <i class="bi bi-box-arrow-up-right me-1"></i>Trang User
                </a>
            </div>
        </div>

        <!-- User Greeting & Direct Logout Button -->
        <div class="d-flex align-items-center gap-2">
            <span class="text-white-50 small d-none d-sm-inline">
                <i class="bi bi-person-badge me-1 text-info fs-6"></i>
                Xin chào: <strong class="text-white">${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
                <span class="badge bg-danger ms-1">Admin</span>
            </span>
            <a class="btn btn-outline-light btn-sm d-none d-md-inline-flex align-items-center" href="${pageContext.request.contextPath}/home" target="_blank" title="Xem Trang Chủ Người Dùng">
                <i class="bi bi-eye me-1"></i>Xem Web
            </a>
            <a class="btn btn-danger btn-sm fw-bold px-3 shadow-sm d-inline-flex align-items-center" href="${pageContext.request.contextPath}/logout" title="Đăng xuất khỏi tài khoản Admin">
                <i class="bi bi-box-arrow-right me-1 fs-6"></i>Đăng xuất
            </a>
        </div>
    </div>
</nav>
