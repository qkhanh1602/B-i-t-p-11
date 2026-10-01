<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn Hàng Của Tôi - VideoHub (MSSV: 24110251)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
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
                <li class="breadcrumb-item active" aria-current="page">
                    <i class="bi bi-box-seam me-1"></i>Đơn Hàng Của Tôi
                </li>
            </ol>
        </nav>
        <span class="badge bg-light text-dark border px-3 py-2">
            <i class="bi bi-person-circle me-1 text-primary"></i>Tài khoản: <strong>${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
        </span>
    </div>

    <div class="card shadow-sm border-0 mb-4 bg-white">
        <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
                <h4 class="h5 fw-bold text-dark mb-1">
                    <i class="bi bi-card-checklist text-primary me-2"></i>Lịch Sử Đơn Hàng Của Tôi
                </h4>
                <p class="text-secondary small mb-0">Theo dõi tiến độ xử lý và thanh toán COD cho các đơn hàng đã đặt</p>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-primary btn-sm">
                <i class="bi bi-plus-circle me-1"></i>Đặt thêm đơn mới
            </a>
        </div>

        <div class="card-body p-0">
            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th scope="col" style="width: 50px;" class="text-center">#</th>
                                    <th scope="col" style="min-width: 140px;">Mã đơn</th>
                                    <th scope="col" style="min-width: 150px;">Thời gian đặt</th>
                                    <th scope="col" style="min-width: 180px;">Người nhận &amp; SĐT</th>
                                    <th scope="col" class="text-center" style="width: 100px;">Số món</th>
                                    <th scope="col" style="min-width: 130px;">Phương thức</th>
                                    <th scope="col" class="text-end" style="min-width: 130px;">Tổng tiền COD</th>
                                    <th scope="col" class="text-center" style="min-width: 150px;">Trạng thái</th>
                                    <th scope="col" class="text-center" style="width: 110px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="ord" items="${orders}" varStatus="status">
                                    <tr>
                                        <td class="text-center text-muted fw-semibold">${status.index + 1}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/order/detail?orderId=${ord.orderId}" class="fw-bold text-primary text-decoration-none">
                                                <code>${ord.orderId}</code>
                                            </a>
                                        </td>
                                        <td class="small text-muted">
                                            <fmt:formatDate value="${ord.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td>
                                            <div class="fw-semibold text-dark">${ord.customerName}</div>
                                            <div class="small text-muted"><i class="bi bi-telephone me-1"></i>${ord.phone}</div>
                                        </td>
                                        <td class="text-center fw-bold">
                                            <span class="badge bg-secondary-subtle text-secondary">${ord.totalQuantity}</span>
                                        </td>
                                        <td>
                                            <span class="badge bg-success-subtle text-success border border-success-subtle">
                                                <i class="bi bi-cash-stack me-1"></i>${ord.paymentMethod}
                                            </span>
                                        </td>
                                        <td class="text-end fw-bold text-danger">
                                            <fmt:formatNumber value="${ord.totalAmount}" pattern="#,###"/> ₫
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-warning text-dark">
                                                <i class="bi bi-clock-history me-1"></i>${ord.orderStatus}
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/order/detail?orderId=${ord.orderId}" 
                                               class="btn btn-sm btn-outline-info" 
                                               title="Xem chi tiết hóa đơn">
                                                <i class="bi bi-eye"></i> Chi tiết
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <div class="mb-3 text-secondary">
                            <i class="bi bi-inbox text-muted" style="font-size: 4rem;"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Bạn chưa có đơn hàng nào!</h5>
                        <p class="text-secondary mb-4">Hãy chọn các video hoặc khóa học yêu thích và đặt hàng bằng phương thức COD nhé.</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 py-2 fw-semibold">
                            <i class="bi bi-bag-plus me-1"></i>Khám phá sản phẩm ngay
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

</body>
</html>
