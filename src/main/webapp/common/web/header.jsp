<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-play-circle-fill me-2 text-danger"></i>VideoHub
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#userNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="userNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door me-1"></i>Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-grid me-1"></i>Sản phẩm
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold position-relative" href="${pageContext.request.contextPath}/cart">
                        <i class="bi bi-cart3 me-1 text-warning"></i>Giỏ hàng
                        <c:if test="${not empty sessionScope.cart and sessionScope.cart.totalItems > 0}">
                            <span class="badge rounded-pill bg-danger ms-1">${sessionScope.cart.totalItems}</span>
                        </c:if>
                    </a>
                </li>
                <c:if test="${sessionScope.currentUser != null}">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/my-orders">
                            <i class="bi bi-box-seam me-1 text-info"></i>Đơn hàng của tôi
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.currentUser == null}">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/login">
                            <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                        </a>
                    </li>
                </c:if>
                <c:if test="${sessionScope.currentUser != null && sessionScope.currentUser.admin}">
                    <li class="nav-item">
                        <a class="nav-link fw-semibold text-warning" href="${pageContext.request.contextPath}/admin/home">
                            <i class="bi bi-shield-lock me-1"></i>Trang quản trị
                        </a>
                    </li>
                </c:if>
            </ul>
            <ul class="navbar-nav ms-auto">
                <c:choose>
                    <c:when test="${sessionScope.currentUser == null}">
                        <li class="nav-item">
                            <a class="btn btn-outline-light btn-sm me-2" href="${pageContext.request.contextPath}/login">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath}/register">
                                <i class="bi bi-person-plus me-1"></i>Đăng ký
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item d-flex align-items-center me-3">
                            <span class="text-white small">
                                <i class="bi bi-person-circle me-1 text-info fs-6"></i>
                                Xin chào, <strong>${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
                                <c:if test="${sessionScope.currentUser.admin}">
                                    <span class="badge bg-danger ms-1">Admin</span>
                                </c:if>
                            </span>
                        </li>
                        <c:if test="${sessionScope.currentUser.admin}">
                            <li class="nav-item me-2">
                                <a class="btn btn-warning btn-sm fw-semibold" href="${pageContext.request.contextPath}/admin/home">
                                    <i class="bi bi-speedometer2 me-1"></i>Trang quản trị
                                </a>
                            </li>
                        </c:if>
                        <li class="nav-item">
                            <a class="btn btn-outline-danger btn-sm fw-semibold" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
