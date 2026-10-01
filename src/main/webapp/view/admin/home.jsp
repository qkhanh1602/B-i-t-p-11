<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Trị Hệ Thống - Admin Dashboard (MSSV: 24110251)</title>
    <!-- Fallback Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/common/admin/header.jsp"/>

<div class="container-fluid py-3">
    <h1 class="h3 fw-bold text-dark"><i class="bi bi-speedometer2 me-2 text-primary"></i>Tổng Quan Quản Trị</h1>
    <div class="btn-toolbar mb-2 mb-md-0 gap-2">
        <a href="${pageContext.request.contextPath}/admin/videos?action=new" class="btn btn-sm btn-primary">
            <i class="bi bi-plus-circle me-1"></i>Thêm Video Mới
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-danger fw-semibold">
            <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
        </a>
    </div>
</div>

<div class="row g-4 mb-4">
    <div class="col-md-6 col-xl-4">
        <div class="card border-0 shadow-sm bg-primary text-white h-100">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase text-white-50 mb-1">Tổng Số Videos</h6>
                        <h2 class="display-6 fw-bold mb-0">${totalVideos}</h2>
                    </div>
                    <i class="bi bi-camera-video display-5 opacity-75"></i>
                </div>
            </div>
            <div class="card-footer bg-transparent border-0 pt-0">
                <a href="${pageContext.request.contextPath}/admin/videos" class="text-white text-decoration-none small">
                    Quản lý danh sách videos <i class="bi bi-arrow-right ms-1"></i>
                </a>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-4">
        <div class="card border-0 shadow-sm bg-success text-white h-100">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase text-white-50 mb-1">Tổng Số Danh Mục</h6>
                        <h2 class="display-6 fw-bold mb-0">${totalCategories}</h2>
                    </div>
                    <i class="bi bi-folder display-5 opacity-75"></i>
                </div>
            </div>
            <div class="card-footer bg-transparent border-0 pt-0">
                <span class="text-white-50 small">Ánh xạ bảng Category trong CSDL</span>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-4">
        <div class="card border-0 shadow-sm bg-info text-white h-100">
            <div class="card-body p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase text-white-50 mb-1">Môn Thi &amp; Sinh Viên</h6>
                        <h4 class="fw-bold mb-0">MSSV: 24110251</h4>
                        <span class="small">Đề số 03 - ThS. Nguyễn Hữu Trung</span>
                    </div>
                    <i class="bi bi-mortarboard display-5 opacity-75"></i>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="card shadow-sm border-0">
    <div class="card-header bg-white py-3">
        <h5 class="fw-bold mb-0"><i class="bi bi-lightning-charge me-2 text-warning"></i>Truy Cập Nhanh Chức Năng</h5>
    </div>
    <div class="card-body">
        <div class="row g-3">
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/admin/videos" class="text-decoration-none">
                    <div class="p-3 border rounded bg-light hover-shadow">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-list-check me-2 text-primary"></i>Quản trị Dữ liệu Bảng Videos</div>
                        <div class="small text-muted">CRUD (Tạo, xem, cập nhật, xóa) có phân trang 6 video/trang (Câu 2 - 2.5 điểm)</div>
                    </div>
                </a>
            </div>
            <div class="col-md-6">
                <a href="${pageContext.request.contextPath}/home" target="_blank" class="text-decoration-none">
                    <div class="p-3 border rounded bg-light hover-shadow">
                        <div class="fw-bold text-dark mb-1"><i class="bi bi-window-fullscreen me-2 text-success"></i>Xem Trang Chủ Người Dùng</div>
                        <div class="small text-muted">Trang Home hiển thị video theo từng category phân trang 3 video/trang (Câu 4 &amp; 5)</div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>
</div>

<jsp:include page="/common/admin/footer.jsp"/>

</body>
</html>
