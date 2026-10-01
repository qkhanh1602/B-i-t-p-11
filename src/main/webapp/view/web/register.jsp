<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - VideoHub (MSSV: 24110251)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f1f5f9;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px 0;
        }
        .register-card {
            max-width: 520px;
            width: 100%;
            border-radius: 12px;
        }
    </style>
</head>
<body>

<div class="card register-card shadow border-0 p-3">
    <div class="card-body">
        <div class="text-center mb-4">
            <i class="bi bi-person-plus-fill fs-1 text-success"></i>
            <h3 class="fw-bold mt-2">Đăng Ký Tài Khoản</h3>
            <p class="text-muted small">Kích hoạt tài khoản bằng mã OTP (MSSV: 24110251)</p>
        </div>

        <c:if test="${param.error == 'exists'}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-1"></i>Tên đăng nhập đã tồn tại trong hệ thống!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.error == 'empty'}">
            <div class="alert alert-warning alert-dismissible fade show small" role="alert">
                <i class="bi bi-exclamation-circle-fill me-1"></i>Vui lòng điền đầy đủ các thông tin bắt buộc!
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="POST">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên đăng nhập (Username) <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Ví dụ: nguyenvana" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Họ và Tên</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-card-text"></i></span>
                    <input type="text" name="fullname" class="form-control" placeholder="Nguyễn Văn A">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Địa chỉ Email <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="example@email.com" required>
                </div>
                <div class="form-text">Mã OTP kích hoạt sẽ được gửi tới email này.</div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                    <input type="text" name="phone" class="form-control" placeholder="0901234567">
                </div>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-success py-2 fw-semibold">
                    <i class="bi bi-shield-check me-1"></i>Đăng Ký &amp; Nhận Mã OTP
                </button>
            </div>

            <div class="text-center small">
                <span class="text-muted">Đã có tài khoản?</span>
                <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-decoration-none">Đăng nhập</a>
                <div class="mt-2">
                    <a href="${pageContext.request.contextPath}/home" class="text-muted text-decoration-none">
                        <i class="bi bi-arrow-left me-1"></i>Về trang chủ
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
