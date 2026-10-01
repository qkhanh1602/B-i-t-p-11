<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng Của Bạn - VideoHub (MSSV: 24110251)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .cart-img-box {
            width: 100px;
            height: 65px;
            object-fit: cover;
            border-radius: 4px;
        }
        .qty-input-group {
            display: inline-flex;
            align-items: center;
        }
        .qty-btn {
            width: 32px;
            height: 31px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="container py-3">
    <!-- Breadcrumb & User Info Header -->
    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none">
                        <i class="bi bi-house-door me-1"></i>Trang Chủ
                    </a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="bi bi-cart3 me-1"></i>Giỏ Hàng
                </li>
            </ol>
        </nav>
        <div class="d-flex align-items-center gap-2">
            <span class="badge bg-light text-dark border px-3 py-2">
                <i class="bi bi-person-circle me-1 text-primary"></i>Xin chào: <strong>${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-outline-danger">
                <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
            </a>
        </div>
    </div>

    <!-- Thông báo trạng thái giỏ hàng -->
    <c:if test="${param.msg == 'added'}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>Đã thêm sản phẩm vào giỏ hàng thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'updated'}">
        <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-arrow-repeat me-2"></i>Đã cập nhật số lượng sản phẩm trong giỏ hàng thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'increased'}">
        <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-plus-circle me-2"></i>Đã tăng số lượng sản phẩm lên 1!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'decreased'}">
        <div class="alert alert-secondary alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-dash-circle me-2"></i>Đã giảm số lượng sản phẩm xuống 1!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'max_reached'}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Lưu ý về giới hạn số lượng:</strong> Mỗi sản phẩm chỉ được mua tối đa <strong>10</strong> món trong một đơn hàng! Hệ thống đã tự động giới hạn ở mức 10.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'removed'}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-trash-fill me-2"></i>Đã xóa sản phẩm khỏi giỏ hàng!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'cleared'}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-cart-x me-2"></i>Đã làm trống toàn bộ giỏ hàng của bạn!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.msg == 'empty_checkout'}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-circle me-2"></i>Giỏ hàng hiện đang trống! Vui lòng chọn sản phẩm trước khi thanh toán.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Thông báo đặt hàng thành công -->
    <c:if test="${checkoutSuccess}">
        <div class="card shadow-sm border-0 mb-4 text-center p-5 bg-white">
            <div class="mb-3">
                <i class="bi bi-patch-check-fill text-success" style="font-size: 4rem;"></i>
            </div>
            <h3 class="fw-bold text-success mb-2">Đặt Hàng Thành Công!</h3>
            <p class="text-secondary mb-4">Cảm ơn bạn đã lựa chọn mua khóa học / video tại <strong>VideoHub</strong>. Đơn hàng của bạn đã được tiếp nhận và xử lý kích hoạt.</p>
            <div>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 py-2 fw-semibold">
                    <i class="bi bi-bag-plus me-1"></i>Tiếp tục khám phá khóa học
                </a>
            </div>
        </div>
    </c:if>

    <!-- Nội dung chính Giỏ hàng -->
    <c:choose>
        <c:when test="${not empty cart and cart.totalItems > 0}">
            <div class="row g-4">
                <!-- Danh sách sản phẩm (Cột trái) -->
                <div class="col-lg-8">
                    <div class="card shadow-sm border-0 mb-3">
                        <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                            <h4 class="h5 fw-bold text-dark mb-0">
                                <i class="bi bi-cart-check-fill me-2 text-primary"></i>Danh Sách Sản Phẩm (${cart.totalItems} món)
                            </h4>
                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle">
                                MSSV: 24110251
                            </span>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col" style="width: 50px;" class="text-center">#</th>
                                            <th scope="col" style="min-width: 250px;">Sản phẩm / Video</th>
                                            <th scope="col" class="text-end" style="width: 120px;">Đơn giá</th>
                                            <th scope="col" class="text-center" style="width: 190px;">Số lượng (1 - 10)</th>
                                            <th scope="col" class="text-end" style="width: 130px;">Thành tiền</th>
                                            <th scope="col" class="text-center" style="width: 80px;">Xóa</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${cart.items}" varStatus="status">
                                            <tr>
                                                <td class="text-center text-muted fw-semibold">${status.index + 1}</td>
                                                <td>
                                                    <div class="d-flex align-items-center gap-3">
                                                        <a href="${pageContext.request.contextPath}/video/detail?id=${item.video.videoId}">
                                                            <c:choose>
                                                                <c:when test="${not empty item.video.poster && item.video.poster != 'default-poster.jpg'}">
                                                                    <img src="${item.video.poster}" alt="${item.video.title}" class="cart-img-box shadow-sm border">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="cart-img-box bg-secondary text-white d-flex align-items-center justify-content-center">
                                                                        <i class="bi bi-film fs-3"></i>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </a>
                                                        <div>
                                                            <h6 class="mb-1 fw-bold">
                                                                <a href="${pageContext.request.contextPath}/video/detail?id=${item.video.videoId}" class="text-decoration-none text-dark">
                                                                    ${item.video.title}
                                                                </a>
                                                            </h6>
                                                            <div class="small text-muted">
                                                                <span class="me-2">Mã: <code>${item.video.videoId}</code></span>
                                                                <c:if test="${not empty item.video.category}">
                                                                    <span class="badge bg-secondary-subtle text-secondary">${item.video.category.categoryname}</span>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-end fw-semibold text-secondary">
                                                    <fmt:formatNumber value="${item.price}" pattern="#,###"/> ₫
                                                </td>
                                                <td>
                                                    <!-- Form sửa/cập nhật số lượng trong giới hạn -->
                                                    <form action="${pageContext.request.contextPath}/cart" method="POST" class="d-flex flex-column align-items-center gap-1 mb-0">
                                                        <input type="hidden" name="action" value="update">
                                                        <input type="hidden" name="id" value="${item.video.videoId}">
                                                        
                                                        <div class="input-group input-group-sm" style="max-width: 140px;">
                                                            <!-- Nút giảm -->
                                                            <a href="${pageContext.request.contextPath}/cart?action=decrease&id=${item.video.videoId}" 
                                                               class="btn btn-outline-secondary" 
                                                               title="Giảm số lượng">
                                                                <i class="bi bi-dash"></i>
                                                            </a>
                                                            
                                                            <!-- Ô nhập số lượng (Giới hạn min=1 max=10) -->
                                                            <input type="number" 
                                                                   name="quantity" 
                                                                   value="${item.quantity}" 
                                                                   min="1" 
                                                                   max="10" 
                                                                   class="form-control text-center fw-bold" 
                                                                   required 
                                                                   title="Số lượng từ 1 đến 10"
                                                                   onchange="this.form.submit()">
                                                            
                                                            <!-- Nút tăng (disable nếu đã đạt max 10) -->
                                                            <c:choose>
                                                                <c:when test="${item.quantity >= 10}">
                                                                    <button type="button" class="btn btn-outline-secondary disabled" title="Đã đạt giới hạn tối đa (10)">
                                                                        <i class="bi bi-plus"></i>
                                                                    </button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="${pageContext.request.contextPath}/cart?action=increase&id=${item.video.videoId}" 
                                                                       class="btn btn-outline-secondary" 
                                                                       title="Tăng số lượng">
                                                                        <i class="bi bi-plus"></i>
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>

                                                        <div class="d-flex align-items-center gap-1 mt-1">
                                                            <button type="submit" class="btn btn-sm btn-link p-0 text-decoration-none text-primary" style="font-size: 0.75rem;" title="Lưu số lượng đã nhập">
                                                                <i class="bi bi-arrow-repeat"></i> Cập nhật
                                                            </button>
                                                            <span class="text-muted" style="font-size: 0.7rem;">(Tối đa: 10)</span>
                                                        </div>
                                                    </form>
                                                </td>
                                                <td class="text-end fw-bold text-danger">
                                                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> ₫
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/cart?action=remove&id=${item.video.videoId}" 
                                                       class="btn btn-sm btn-outline-danger" 
                                                       title="Xóa sản phẩm"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?');">
                                                        <i class="bi bi-trash"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="card-footer bg-white py-3 border-top d-flex justify-content-between align-items-center flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-arrow-left me-1"></i>Tiếp tục chọn thêm sản phẩm
                            </a>
                            <a href="${pageContext.request.contextPath}/cart?action=clear" 
                               class="btn btn-outline-danger btn-sm"
                               onclick="return confirm('Bạn có chắc chắn muốn làm trống toàn bộ giỏ hàng?');">
                                <i class="bi bi-cart-x me-1"></i>Làm trống giỏ hàng
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Tóm tắt thanh toán (Cột phải) -->
                <div class="col-lg-4">
                    <div class="card shadow-sm border-0 sticky-top" style="top: 20px;">
                        <div class="card-header bg-white py-3 border-bottom">
                            <h4 class="h5 fw-bold text-dark mb-0">
                                <i class="bi bi-receipt me-2 text-primary"></i>Tóm Tắt Đơn Hàng
                            </h4>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Tổng số lượng:</span>
                                <span class="fw-bold text-dark">${cart.totalItems} sản phẩm</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Tạm tính:</span>
                                <span class="fw-bold text-dark"><fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> ₫</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Phí dịch vụ / giao hàng:</span>
                                <span class="badge bg-success-subtle text-success">Miễn phí</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3 text-secondary">
                                <span>Giảm giá:</span>
                                <span class="fw-semibold text-muted">0 ₫</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <span class="h6 fw-bold mb-0">Tổng thanh toán:</span>
                                <span class="h4 fw-bold text-danger mb-0">
                                    <fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> ₫
                                </span>
                            </div>

                            <a href="${pageContext.request.contextPath}/checkout" 
                               class="btn btn-success w-100 py-3 fw-bold shadow-sm d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-cash-coin fs-4"></i>Tiến Hành Thanh Toán COD
                            </a>

                            <div class="mt-3 text-center text-muted small">
                                <i class="bi bi-shield-check text-success me-1"></i>Bảo mật thanh toán &amp; Kích hoạt khóa học ngay lập tức
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <c:if test="${empty checkoutSuccess or not checkoutSuccess}">
                <div class="card shadow-sm border-0 text-center py-5 my-4 bg-white">
                    <div class="card-body">
                        <div class="mb-3 text-secondary">
                            <i class="bi bi-cart-x text-muted" style="font-size: 5rem;"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-2">Giỏ hàng của bạn đang trống!</h4>
                        <p class="text-secondary mb-4">Hiện tại bạn chưa chọn bất kỳ video hoặc sản phẩm nào vào giỏ hàng.</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 py-2 fw-semibold">
                            <i class="bi bi-bag-plus me-1"></i>Quay lại Trang Chủ chọn sản phẩm
                        </a>
                    </div>
                </div>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>
