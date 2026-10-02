<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hóa Đơn Đặt Hàng COD - ${order.orderId} (MSSV: 24110251)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .invoice-card {
            max-width: 900px;
            margin: 0 auto;
        }
        .order-thumb {
            width: 70px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
        }
        @media print {
            .no-print {
                display: none !important;
            }
            body {
                background-color: #fff !important;
            }
        }
    </style>
</head>
<body>

<div class="container py-4">
    <!-- Top Action bar -->
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2 no-print">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Quay lại Trang Chủ
        </a>
        <div class="d-flex gap-2">
            <button onclick="window.print()" class="btn btn-outline-dark btn-sm">
                <i class="bi bi-printer me-1"></i>In Hóa Đơn
            </button>
            <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-primary btn-sm">
                <i class="bi bi-card-checklist me-1"></i>Đơn Hàng Của Tôi
            </a>
        </div>
    </div>

    <!-- Hộp thông báo đặt COD thành công -->
    <div class="card invoice-card shadow-sm border-0 mb-4 bg-white overflow-hidden">
        <div class="bg-success text-white p-4 text-center">
            <div class="mb-2">
                <i class="bi bi-check-circle-fill" style="font-size: 3.5rem;"></i>
            </div>
            <h2 class="fw-bold mb-1">ĐẶT HÀNG THÀNH CÔNG!</h2>
            <p class="mb-0 fs-6 opacity-75">
                Cảm ơn quý khách đã đặt hàng với phương thức <strong>Thanh toán khi nhận hàng (COD)</strong>
            </p>
        </div>

        <div class="card-body p-4 p-md-5">
            <!-- Thông tin đơn hàng & Header -->
            <div class="row align-items-center mb-4 pb-3 border-bottom g-3">
                <div class="col-md-6">
                    <h5 class="fw-bold text-primary mb-1">
                        <i class="bi bi-receipt-cutoff me-2"></i>BIÊN LAI ĐƠN HÀNG COD
                    </h5>
                    <div class="text-secondary small">
                        Hệ thống VideoHub &bull; Sinh viên: <strong>Nguyễn Quốc Khánh</strong> &bull; MSSV: <code>24110251</code>
                    </div>
                </div>
                <div class="col-md-6 text-md-end">
                    <div><strong>Mã đơn hàng:</strong> <code class="fs-5 text-dark fw-bold">${order.orderId}</code></div>
                    <div class="text-secondary small">
                        <strong>Ngày đặt:</strong> <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </div>
                </div>
            </div>

            <!-- Tình trạng thanh toán & Giao hàng -->
            <div class="row g-3 mb-4">
                <div class="col-md-4">
                    <div class="p-3 bg-light rounded border h-100">
                        <div class="text-secondary small fw-semibold mb-1">Phương thức thanh toán:</div>
                        <span class="badge bg-success fs-6">
                            <i class="bi bi-cash-stack me-1"></i>${order.paymentMethod}
                        </span>
                        <div class="text-muted small mt-1">Trả tiền mặt khi nhận hàng</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3 bg-light rounded border h-100">
                        <div class="text-secondary small fw-semibold mb-1">Trạng thái thanh toán:</div>
                        <span class="badge bg-info text-dark fs-6">
                            <i class="bi bi-hourglass-split me-1"></i>${order.paymentStatus}
                        </span>
                        <div class="text-muted small mt-1">Shipper thu tiền tận nơi</div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="p-3 bg-light rounded border h-100">
                        <div class="text-secondary small fw-semibold mb-1">Trạng thái đơn hàng:</div>
                        <span class="badge ${order.statusBadgeClass} fs-6 shadow-sm">
                            <i class="bi ${order.statusIconClass} me-1"></i>${order.orderStatus}
                        </span>
                        <div class="text-muted small mt-1">Đang chuẩn bị gói hàng</div>
                    </div>
                </div>
            </div>

            <!-- Thông tin người nhận -->
            <div class="card bg-light border-0 mb-4">
                <div class="card-body p-3">
                    <h6 class="fw-bold text-dark mb-2">
                        <i class="bi bi-person-lines-fill text-primary me-2"></i>Thông Tin Giao Nhận Hàng (COD):
                    </h6>
                    <div class="row g-2 small">
                        <div class="col-sm-6">
                            <strong>Người nhận:</strong> ${order.customerName}
                        </div>
                        <div class="col-sm-6">
                            <strong>Số điện thoại:</strong> ${order.phone}
                        </div>
                        <div class="col-12">
                            <strong>Địa chỉ giao hàng:</strong> ${order.address}
                        </div>
                        <c:if test="${not empty order.note}">
                            <div class="col-12">
                                <strong>Ghi chú:</strong> <em>${order.note}</em>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Bảng danh sách sản phẩm -->
            <h6 class="fw-bold text-dark mb-3">
                <i class="bi bi-box-seam text-primary me-2"></i>Danh Sách Sản Phẩm Đã Đặt:
            </h6>
            <div class="table-responsive mb-4">
                <table class="table table-hover align-middle mb-0 border">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center" style="width: 50px;">#</th>
                            <th>Sản phẩm / Video</th>
                            <th class="text-end" style="width: 130px;">Đơn giá</th>
                            <th class="text-center" style="width: 100px;">Số lượng</th>
                            <th class="text-end" style="width: 140px;">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${order.items}" varStatus="status">
                            <tr>
                                <td class="text-center text-muted">${status.index + 1}</td>
                                <td>
                                    <div class="d-flex align-items-center gap-3">
                                        <c:choose>
                                            <c:when test="${not empty item.poster && item.poster != 'default-poster.jpg'}">
                                                <img src="${item.poster}" alt="${item.videoTitle}" class="order-thumb shadow-sm border">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="order-thumb bg-secondary text-white d-flex align-items-center justify-content-center">
                                                    <i class="bi bi-film"></i>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <div class="fw-bold text-dark">${item.videoTitle}</div>
                                            <small class="text-muted">Mã: <code>${item.videoId}</code></small>
                                        </div>
                                    </div>
                                </td>
                                <td class="text-end">
                                    <fmt:formatNumber value="${item.price}" pattern="#,###"/> ₫
                                </td>
                                <td class="text-center fw-bold">
                                    ${item.quantity}
                                </td>
                                <td class="text-end fw-bold text-dark">
                                    <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> ₫
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot class="table-light">
                        <tr>
                            <td colspan="4" class="text-end fw-bold">Tổng tiền hàng:</td>
                            <td class="text-end fw-bold"><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> ₫</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-end text-secondary">Phí vận chuyển COD:</td>
                            <td class="text-end text-success fw-bold">0 ₫ (Miễn phí)</td>
                        </tr>
                        <tr>
                            <td colspan="4" class="text-end text-secondary">Phí thu hộ tiền mặt:</td>
                            <td class="text-end text-success fw-bold">0 ₫ (Miễn phí)</td>
                        </tr>
                        <tr class="table-warning">
                            <td colspan="4" class="text-end fw-bold fs-6 text-dark">
                                TỔNG TIỀN PHẢI THANH TOÁN KHI NHẬN HÀNG (COD):
                            </td>
                            <td class="text-end fw-bold fs-5 text-danger">
                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> ₫
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <!-- Hướng dẫn nhận hàng COD -->
            <div class="alert alert-info border-0 mb-4" role="alert">
                <h6 class="fw-bold mb-1"><i class="bi bi-info-circle-fill me-2"></i>Hướng dẫn quy trình nhận hàng COD:</h6>
                <ul class="mb-0 small ps-3">
                    <li>Nhân viên CSKH sẽ liên hệ với số điện thoại <strong>${order.phone}</strong> để xác nhận đơn hàng trước khi gửi đi.</li>
                    <li>Khi shipper giao hàng tới, bạn được quyền <strong>đồng kiểm mở gói hàng</strong> trước khi thanh toán.</li>
                    <li>Vui lòng chuẩn bị sẵn số tiền mặt <strong><fmt:formatNumber value="${order.totalAmount}" pattern="#,###"/> ₫</strong> để thanh toán cho shipper.</li>
                </ul>
            </div>

            <!-- Nút điều hướng -->
            <div class="text-center no-print d-flex justify-content-center gap-2 flex-wrap">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 py-2 fw-semibold">
                    <i class="bi bi-bag-plus me-1"></i>Tiếp Tục Mua Sắm
                </a>
                <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-outline-secondary px-4 py-2 fw-semibold">
                    <i class="bi bi-clock-history me-1"></i>Xem Lịch Sử Đơn Hàng
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
