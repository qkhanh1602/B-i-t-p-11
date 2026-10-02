<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property='title'/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8fafc;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .admin-main {
            flex: 1;
        }
        .sidebar {
            min-height: calc(100vh - 120px);
            background-color: #ffffff;
            border-right: 1px solid #e2e8f0;
        }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>

    <jsp:include page="/common/admin/header.jsp"/>

    <div class="admin-main container-fluid">
        <div class="row">
            <nav class="col-md-3 col-lg-2 d-md-block sidebar py-3 px-3">
                <div class="position-sticky">
                    <h6 class="sidebar-heading px-3 mt-2 mb-2 text-muted text-uppercase fs-7">Quản Trị Hệ Thống</h6>
                    <ul class="nav flex-column">
                        <li class="nav-item mb-1">
                            <a class="nav-link text-dark fw-semibold rounded px-3 py-2 bg-light" href="${pageContext.request.contextPath}/admin/home">
                                <i class="bi bi-speedometer2 me-2 text-primary"></i>Tổng Quan Admin
                            </a>
                        </li>
                        <li class="nav-item mb-1">
                            <a class="nav-link text-dark fw-semibold rounded px-3 py-2" href="${pageContext.request.contextPath}/admin/videos">
                                <i class="bi bi-camera-video me-2 text-primary"></i>Quản lý Videos
                            </a>
                        </li>
                        <li class="nav-item mb-1">
                            <a class="nav-link text-dark fw-semibold rounded px-3 py-2" href="${pageContext.request.contextPath}/admin/orders">
                                <i class="bi bi-card-checklist me-2 text-primary"></i>Quản lý Đơn hàng
                            </a>
                        </li>
                        <li class="nav-item mb-1">
                            <a class="nav-link text-secondary px-3 py-2" href="${pageContext.request.contextPath}/home" target="_blank">
                                <i class="bi bi-box-arrow-up-right me-2"></i>Trang Người Dùng
                            </a>
                        </li>
                        <li class="nav-item mt-3 pt-3 border-top">
                            <a class="nav-link text-danger fw-bold rounded px-3 py-2 hover-bg-danger-subtle" href="${pageContext.request.contextPath}/logout">
                                <i class="bi bi-box-arrow-right me-2 text-danger"></i>Đăng xuất Admin
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
                <sitemesh:write property='body'/>
            </main>
        </div>
    </div>

    <jsp:include page="/common/admin/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
