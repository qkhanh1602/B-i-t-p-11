<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - VideoHub (MSSV: 24110251)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .login-card {
            max-width: 420px;
            width: 100%;
            border-radius: 12px;
        }
    </style>
</head>
<body>

<div class="card login-card shadow border-0 p-3">
    <div class="card-body">
        <div class="text-center mb-4">
            <i class="bi bi-person-circle fs-1 text-primary"></i>
            <h3 class="fw-bold mt-2">Đăng Nhập Hệ Thống</h3>
            <p class="text-muted small">Môn Lập Trình Web - Đề số 03 (MSSV: 24110251)</p>
        </div>

        <c:if test="${param.error == 'invalid'}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-circle-fill me-1"></i>Tài khoản hoặc mật khẩu không chính xác, hoặc tài khoản chưa kích hoạt OTP!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.error == 'not_admin'}">
            <div class="alert alert-warning alert-dismissible fade show small" role="alert">
                <i class="bi bi-info-circle-fill me-1"></i>Đăng nhập thành công với vai trò User! Để truy cập trang quản trị Admin, vui lòng đăng nhập bằng tài khoản Quản trị viên.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.error == 'unauthorized'}">
            <div class="alert alert-warning alert-dismissible fade show small" role="alert">
                <i class="bi bi-shield-slash me-1"></i>Bạn cần đăng nhập với vai trò Admin để truy cập trang quản trị!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.msg == 'activated'}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                <i class="bi bi-check-circle-fill me-1"></i>Tài khoản đã kích hoạt OTP thành công! Vui lòng đăng nhập.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.msg == 'logged_out'}">
            <div class="alert alert-info alert-dismissible fade show small" role="alert">
                <i class="bi bi-info-circle-fill me-1"></i>Bạn đã đăng xuất khỏi hệ thống thành công.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="POST">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên đăng nhập</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Nhập username" required autofocus>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                </div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary py-2 fw-semibold">
                    <i class="bi bi-box-arrow-in-right me-1"></i>Đăng Nhập
                </button>
            </div>

            <div class="text-center small">
                <span class="text-muted">Chưa có tài khoản?</span>
                <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-decoration-none">Đăng ký ngay</a>
                <div class="mt-2">
                    <a href="${pageContext.request.contextPath}/home" class="text-muted text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i>Về trang chủ
                    </a>
                </div>
            </div>
        </form>

        <div class="mt-4 pt-3 border-top text-center text-muted fs-7">
            <small>Tài khoản mẫu: <code>admin</code> / <code>123456</code> (Admin) | <code>user</code> / <code>123456</code> (User)</small>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
