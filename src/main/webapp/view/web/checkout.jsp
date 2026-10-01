<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán Đơn Hàng COD - VideoHub (MSSV: 24110251)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .checkout-img {
            width: 60px;
            height: 45px;
            object-fit: cover;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<div class="container py-3">
    <!-- Breadcrumb -->
    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none">
                        <i class="bi bi-house-door me-1"></i>Trang Chủ
                    </a>
                </li>
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/cart" class="text-decoration-none">
                        <i class="bi bi-cart3 me-1"></i>Giỏ Hàng
                    </a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="bi bi-cash-coin me-1"></i>Thanh toán COD
                </li>
            </ol>
        </nav>
        <span class="badge bg-light text-dark border px-3 py-2">
            <i class="bi bi-person-circle me-1 text-primary"></i>Tài khoản: <strong>${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
        </span>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="p-3 mb-4 bg-white rounded shadow-sm border border-success-subtle d-flex align-items-center gap-3">
        <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 48px; height: 48px;">
            <i class="bi bi-cash-stack fs-4"></i>
        </div>
        <div>
            <h5 class="fw-bold text-dark mb-0">Thanh Toán Đơn Hàng Bằng Hình Thức COD</h5>
            <small class="text-secondary">Cash On Delivery - Nhận hàng tại nhà rồi mới thanh toán tiền mặt cho nhân viên giao hàng</small>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/checkout" method="POST">
        <div class="row g-4">
            <!-- Cột trái: Thông tin nhận hàng & Phương thức thanh toán COD -->
            <div class="col-lg-7">
                <div class="card shadow-sm border-0 mb-4">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-geo-alt-fill text-danger me-2"></i>1. Thông Tin Người Nhận Hàng (COD)
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Họ và tên người nhận <span class="text-danger">*</span></label>
                                <input type="text" 
                                       name="customerName" 
                                       value="${not empty customerName ? customerName : sessionScope.currentUser.fullname}" 
                                       class="form-control" 
                                       placeholder="Ví dụ: Nguyễn Văn An" 
                                       required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Số điện thoại liên hệ <span class="text-danger">*</span></label>
                                <input type="tel" 
                                       name="phone" 
                                       value="${not empty phone ? phone : sessionScope.currentUser.phone}" 
                                       class="form-control" 
                                       placeholder="Ví dụ: 0912345678" 
                                       required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Địa chỉ giao hàng chi tiết <span class="text-danger">*</span></label>
                                <textarea name="address" 
                                          class="form-control" 
                                          rows="3" 
                                          placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..." 
                                          required>${address}</textarea>
                                <small class="text-muted">Shipper sẽ đến giao hàng và thu tiền COD tại địa chỉ này.</small>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Ghi chú giao hàng (Tùy chọn)</label>
                                <textarea name="note" 
                                          class="form-control" 
                                          rows="2" 
                                          placeholder="Ví dụ: Giao giờ hành chính, gọi điện trước khi tới...">${note}</textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0 mb-3">
                    <div class="card-header bg-white py-3 border-bottom">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-wallet2 text-success me-2"></i>2. Phương Thức Thanh Toán
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="form-check p-3 border border-success rounded bg-success-subtle mb-3">
                            <input class="form-check-input ms-0 me-3" type="radio" name="paymentMethod" id="codMethod" value="COD" checked>
                            <label class="form-check-label fw-bold text-dark" for="codMethod">
                                <i class="bi bi-cash-coin text-success fs-5 me-1"></i>Thanh toán khi nhận hàng (COD - Cash On Delivery)
                            </label>
                            <div class="mt-2 text-secondary small ps-4">
                                Bạn sẽ thanh toán bằng tiền mặt trực tiếp cho nhân viên vận chuyển (Shipper) khi bưu tá giao tài liệu kích hoạt &amp; giáo trình khóa học tới tay bạn.
                            </div>
                            <div class="mt-2 ps-4">
                                <span class="badge bg-success me-2"><i class="bi bi-check2"></i> Miễn phí thu hộ</span>
                                <span class="badge bg-primary"><i class="bi bi-shield-check"></i> Được kiểm tra trước khi trả tiền</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Cột phải: Tóm tắt đơn hàng & Nút đặt COD -->
            <div class="col-lg-5">
                <div class="card shadow-sm border-0 sticky-top" style="top: 20px;">
                    <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                        <h5 class="fw-bold text-dark mb-0">
                            <i class="bi bi-bag-check-fill text-primary me-2"></i>Chi Tiết Đơn Hàng (${cart.totalItems} món)
                        </h5>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-sm btn-outline-primary" style="font-size: 0.75rem;">
                            Sửa giỏ hàng
                        </a>
                    </div>
                    <div class="card-body p-3">
                        <div class="table-responsive mb-3" style="max-height: 260px; overflow-y: auto;">
                            <table class="table table-sm align-middle mb-0">
                                <tbody>
                                    <c:forEach var="item" items="${cart.items}">
                                        <tr>
                                            <td style="width: 65px;">
                                                <c:choose>
                                                    <c:when test="${not empty item.video.poster && item.video.poster != 'default-poster.jpg'}">
                                                        <img src="${item.video.poster}" alt="${item.video.title}" class="checkout-img shadow-sm border">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="checkout-img bg-secondary text-white d-flex align-items-center justify-content-center">
                                                            <i class="bi bi-film"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="fw-bold text-dark small text-truncate" style="max-width: 170px;" title="${item.video.title}">
                                                    ${item.video.title}
                                                </div>
                                                <div class="text-muted" style="font-size: 0.75rem;">
                                                    <fmt:formatNumber value="${item.price}" pattern="#,###"/> ₫ &times; <strong>${item.quantity}</strong>
                                                </div>
                                            </td>
                                            <td class="text-end fw-bold text-danger small">
                                                <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> ₫
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="border-top pt-3">
                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Tổng số lượng:</span>
                                <span class="fw-bold text-dark">${cart.totalItems} sản phẩm</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Tạm tính tiền hàng:</span>
                                <span class="fw-bold text-dark"><fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> ₫</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Phí vận chuyển giao tận nhà:</span>
                                <span class="text-success fw-bold">0 ₫ (Miễn phí)</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2 text-secondary">
                                <span>Phí dịch vụ thu tiền COD:</span>
                                <span class="text-success fw-bold">0 ₫ (Miễn phí)</span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <div>
                                    <div class="h6 fw-bold mb-0">Số tiền cần trả khi nhận COD:</div>
                                    <small class="text-muted">Đã bao gồm tất cả các loại phí</small>
                                </div>
                                <div class="h3 fw-bold text-danger mb-0">
                                    <fmt:formatNumber value="${cart.totalAmount}" pattern="#,###"/> ₫
                                </div>
                            </div>

                            <button type="submit" class="btn btn-success btn-lg w-100 fw-bold shadow py-3 d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-check2-circle fs-4"></i>
                                <span>XÁC NHẬN ĐẶT HÀNG COD</span>
                            </button>

                            <div class="mt-3 text-center text-muted" style="font-size: 0.8rem;">
                                <i class="bi bi-shield-lock-fill text-success me-1"></i>Đơn hàng sẽ được nhân viên gọi xác nhận trước khi giao
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

</body>
</html>
