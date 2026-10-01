<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP - VideoHub (MSSV: 24110251)</title>
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
        .otp-card {
            max-width: 440px;
            width: 100%;
            border-radius: 12px;
        }
    </style>
</head>
<body>

<div class="card otp-card shadow border-0 p-3">
    <div class="card-body">
        <div class="text-center mb-4">
            <i class="bi bi-shield-lock-fill fs-1 text-primary"></i>
            <h3 class="fw-bold mt-2">Kích Hoạt Tài Khoản</h3>
            <p class="text-muted small">Nhập mã OTP 6 chữ số để hoàn tất đăng ký</p>
        </div>

        <c:if test="${param.error == 'wrong'}">
            <div class="alert alert-danger alert-dismissible fade show small" role="alert">
                <i class="bi bi-x-circle-fill me-1"></i>Mã OTP không chính xác! Vui lòng thử lại.
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.registerOtp}">
            <div class="alert alert-info border border-info small mb-3">
                <div class="fw-bold mb-1"><i class="bi bi-info-circle-fill me-1"></i>Mã OTP đã được gửi đến: ${sessionScope.pendingEmail}</div>
                <div>Mã OTP để kích hoạt: <span class="badge bg-primary fs-6 tracking-wide">${sessionScope.registerOtp}</span></div>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/otp" method="POST">
            <div class="mb-4">
                <label class="form-label fw-semibold text-center d-block">Nhập mã OTP gồm 6 chữ số</label>
                <input type="text" name="otp" class="form-control form-control-lg text-center fw-bold fs-4"
                       placeholder="123456" maxlength="6" required autofocus>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary py-2 fw-semibold">
                    <i class="bi bi-check-circle me-1"></i>Xác Nhận Kích Hoạt
                </button>
            </div>

            <div class="text-center small">
                <a href="${pageContext.request.contextPath}/register" class="text-muted text-decoration-none">
                    <i class="bi bi-arrow-left me-1"></i>Quay lại trang Đăng ký
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
