<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch Sử Đơn Hàng - VideoHub (MSSV: 24110251)</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        .nav-pills-custom {
            scrollbar-width: thin;
        }
        .nav-pills-custom .nav-link {
            color: #495057;
            font-weight: 500;
            border-radius: 20px;
            padding: 8px 16px;
            white-space: nowrap;
            transition: all 0.2s ease-in-out;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .nav-pills-custom .nav-link:hover {
            background-color: #e9ecef;
            color: #0d6efd;
            transform: translateY(-1px);
        }
        .nav-pills-custom .nav-link.active {
            background-color: #0d6efd;
            color: #ffffff;
            border-color: #0d6efd;
            box-shadow: 0 4px 10px rgba(13, 110, 253, 0.25);
        }
        .status-badge {
            font-size: 0.85rem;
            padding: 6px 12px;
            border-radius: 50rem;
            font-weight: 600;
            letter-spacing: 0.2px;
        }
        .order-card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border-radius: 12px;
            overflow: hidden;
        }
        .order-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.08) !important;
        }
        .order-thumb {
            width: 75px;
            height: 52px;
            object-fit: cover;
            border-radius: 6px;
        }
        /* Stepper Mini Tracker */
        .order-stepper {
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: relative;
            margin: 15px 0 10px 0;
            padding: 0 10px;
        }
        .order-stepper::before {
            content: '';
            position: absolute;
            top: 14px;
            left: 20px;
            right: 20px;
            height: 3px;
            background-color: #e9ecef;
            z-index: 1;
        }
        .stepper-item {
            position: relative;
            z-index: 2;
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 0.72rem;
            color: #6c757d;
        }
        .stepper-circle {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background-color: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.75rem;
            margin-bottom: 4px;
            border: 2px solid #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.06);
            transition: all 0.2s ease;
        }
        .stepper-item.completed .stepper-circle {
            background-color: #198754;
            color: #ffffff;
        }
        .stepper-item.active .stepper-circle {
            background-color: #0d6efd;
            color: #ffffff;
            box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.2);
        }
        .stepper-item.completed, .stepper-item.active {
            color: #212529;
            font-weight: 600;
        }
    </style>
</head>
<body class="bg-light">

<div class="container py-4">
    <!-- Breadcrumb & User Info -->
    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="${pageContext.request.contextPath}/home" class="text-decoration-none">
                        <i class="bi bi-house-door me-1"></i>Trang Chủ
                    </a>
                </li>
                <li class="breadcrumb-item active fw-semibold" aria-current="page">
                    <i class="bi bi-clock-history me-1 text-primary"></i>Lịch Sử Đơn Hàng
                </li>
            </ol>
        </nav>
        <div class="d-flex align-items-center gap-2">
            <span class="badge bg-white text-dark border shadow-sm px-3 py-2">
                <i class="bi bi-person-circle me-1 text-primary"></i>Tài khoản: <strong>${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
            </span>
            <c:if test="${sessionScope.currentUser.admin}">
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-warning btn-sm fw-semibold shadow-sm">
                    <i class="bi bi-shield-check me-1"></i>Admin Quản Lý Đơn
                </a>
            </c:if>
        </div>
    </div>

    <!-- Thông báo kết quả tác vụ -->
    <c:if test="${param.msg eq 'cancelled'}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm border-0 mb-4" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>Đơn hàng đã được chuyển sang trạng thái <strong>Đơn hàng hủy</strong> thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.msg eq 'returned'}">
        <div class="alert alert-dark alert-dismissible fade show shadow-sm border-0 mb-4" role="alert">
            <i class="bi bi-arrow-counterclockwise me-2"></i>Đã gửi yêu cầu chuyển sang trạng thái <strong>Đơn hàng hoàn</strong> thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${param.msg eq 'updated'}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-4" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>Đã cập nhật trạng thái đơn hàng thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Header Card -->
    <div class="card shadow-sm border-0 mb-4 bg-white rounded-3">
        <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center flex-wrap gap-2">
            <div>
                <h4 class="h5 fw-bold text-dark mb-1">
                    <i class="bi bi-receipt-cutoff text-primary me-2"></i>Lịch Sử Đặt Hàng Theo Trạng Thái
                </h4>
                <p class="text-secondary small mb-0">Hỗ trợ lọc theo 8 trạng thái: đơn hàng mới, đã xác nhận, chuẩn bị hàng, vận chuyển, giao hàng, đã giao, đơn hàng hủy, đơn hàng hoàn (MSSV: 24110251)</p>
            </div>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary btn-sm rounded-pill px-3 shadow-sm">
                <i class="bi bi-plus-circle me-1"></i>Đặt Thêm Đơn Hàng Mới
            </a>
        </div>

        <!-- Filter 8 Status Navigation Tabs -->
        <div class="card-body border-bottom bg-body-tertiary py-3">
            <div class="d-flex overflow-auto pb-1 nav-pills-custom gap-2">
                <a href="${pageContext.request.contextPath}/my-orders?status=ALL${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'ALL' || empty selectedStatus ? 'active' : ''}">
                    🌐 Tất cả 
                    <span class="badge rounded-pill bg-white text-dark ms-1 shadow-sm">${statusCounts['ALL']}</span>
                </a>

                <a href="${pageContext.request.contextPath}/my-orders?status=Đơn hàng mới${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'Đơn hàng mới' ? 'active' : ''}">
                    🆕 Đơn hàng mới 
                    <span class="badge rounded-pill bg-primary-subtle text-primary border border-primary ms-1">${statusCounts['Đơn hàng mới']}</span>
                </a>

                <a href="${pageContext.request.contextPath}/my-orders?status=Đã xác nhận${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'Đã xác nhận' ? 'active' : ''}">
                    ⏳ Đã xác nhận 
                    <span class="badge rounded-pill bg-info-subtle text-info border border-info ms-1">${statusCounts['Đã xác nhận']}</span>
                </a>

                <a href="${pageContext.request.contextPath}/my-orders?status=Chuẩn bị hàng${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'Chuẩn bị hàng' ? 'active' : ''}">
                    📦 Chuẩn bị hàng 
                    <span class="badge rounded-pill bg-warning-subtle text-warning-emphasis border border-warning ms-1">${statusCounts['Chuẩn bị hàng']}</span>
                </a>

                <a href="${pageContext.request.contextPath}/my-orders?status=Vận chuyển${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'Vận chuyển' ? 'active' : ''}">
                    🚚 Vận chuyển 
                    <span class="badge rounded-pill bg-secondary-subtle text-secondary border border-secondary ms-1">${statusCounts['Vận chuyển']}</span>
                </a>

                <a href="${pageContext.request.contextPath}/my-orders?status=Giao hàng${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'Giao hàng' ? 'active' : ''}">
                    🚴 Giao hàng 
                    <span class="badge rounded-pill bg-primary-subtle text-primary border border-primary ms-1">${statusCounts['Giao hàng']}</span>
                </a>

                <a href="${pageContext.request.contextPath}/my-orders?status=Đã giao${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'Đã giao' ? 'active' : ''}">
                    ✅ Đã giao 
                    <span class="badge rounded-pill bg-success-subtle text-success border border-success ms-1">${statusCounts['Đã giao']}</span>
                </a>

                <a href="${pageContext.request.contextPath}/my-orders?status=Đơn hàng hủy${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'Đơn hàng hủy' ? 'active' : ''}">
                    ❌ Đơn hàng hủy 
                    <span class="badge rounded-pill bg-danger-subtle text-danger border border-danger ms-1">${statusCounts['Đơn hàng hủy']}</span>
                </a>

                <a href="${pageContext.request.contextPath}/my-orders?status=Đơn hàng hoàn${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="nav-link ${selectedStatus eq 'Đơn hàng hoàn' ? 'active' : ''}">
                    🔄 Đơn hàng hoàn 
                    <span class="badge rounded-pill bg-dark-subtle text-dark border border-dark ms-1">${statusCounts['Đơn hàng hoàn']}</span>
                </a>
            </div>
        </div>

        <!-- Toolbar tìm kiếm nhanh trong đơn hàng -->
        <div class="card-body bg-white py-3 border-bottom">
            <form method="get" action="${pageContext.request.contextPath}/my-orders" class="row g-2 align-items-center">
                <input type="hidden" name="status" value="${selectedStatus}">
                <div class="col-md-5">
                    <div class="input-group input-group-sm">
                        <span class="input-group-text bg-light"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo mã đơn, người nhận, tên sản phẩm...">
                    </div>
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-sm btn-outline-primary">
                        <i class="bi bi-funnel me-1"></i>Tìm kiếm
                    </button>
                </div>
                <c:if test="${not empty keyword || (selectedStatus ne 'ALL' && not empty selectedStatus)}">
                    <div class="col-auto">
                        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-sm btn-outline-secondary">
                            <i class="bi bi-x-circle me-1"></i>Bỏ lọc
                        </a>
                    </div>
                </c:if>
                <div class="col text-end text-muted small">
                    Có <strong>${orders.size()}</strong> đơn hàng được tìm thấy
                </div>
            </form>
        </div>

        <!-- Danh sách chi tiết các đơn hàng -->
        <div class="card-body p-3 p-md-4">
            <c:choose>
                <c:when test="${not empty orders}">
                    <div class="d-flex flex-column gap-4">
                        <c:forEach var="ord" items="${orders}" varStatus="statusLoop">
                            <div class="card order-card shadow-sm border bg-white">
                                <!-- Card Header -->
                                <div class="card-header bg-light bg-opacity-75 py-3 d-flex justify-content-between align-items-center flex-wrap gap-2 border-bottom">
                                    <div class="d-flex align-items-center gap-3">
                                        <span class="badge bg-secondary rounded-pill px-2 py-1">#${statusLoop.index + 1}</span>
                                        <div>
                                            <span class="text-secondary small me-1">Mã đơn:</span>
                                            <a href="${pageContext.request.contextPath}/order/detail?orderId=${ord.orderId}" class="fw-bold text-primary text-decoration-none">
                                                <code>${ord.orderId}</code>
                                            </a>
                                        </div>
                                        <span class="text-muted small d-none d-sm-inline">&bull;</span>
                                        <span class="text-muted small d-none d-sm-inline">
                                            <i class="bi bi-calendar3 me-1"></i><fmt:formatDate value="${ord.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </span>
                                    </div>
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="badge ${ord.statusBadgeClass} status-badge shadow-sm">
                                            <i class="bi ${ord.statusIconClass} me-1"></i>${ord.orderStatus}
                                        </span>
                                    </div>
                                </div>

                                <!-- Card Body: Visual Step Tracker (Nếu đơn không bị Hủy hoặc Hoàn) -->
                                <div class="card-body pt-3 pb-2 border-bottom bg-body-tertiary">
                                    <c:choose>
                                        <c:when test="${ord.orderStatus eq 'Đơn hàng hủy' || ord.orderStatus eq 'Đã hủy'}">
                                            <div class="alert alert-danger py-2 mb-1 d-flex align-items-center gap-2 small">
                                                <i class="bi bi-x-circle-fill fs-5"></i>
                                                <div>Đơn hàng này đã bị hủy. Cảm ơn bạn và mong sớm được phục vụ lại!</div>
                                            </div>
                                        </c:when>
                                        <c:when test="${ord.orderStatus eq 'Đơn hàng hoàn' || ord.orderStatus eq 'Đã hoàn hàng'}">
                                            <div class="alert alert-dark py-2 mb-1 d-flex align-items-center gap-2 small">
                                                <i class="bi bi-arrow-counterclockwise fs-5"></i>
                                                <div>Đơn hàng đã được hoàn về kho. Hệ thống đã cập nhật trạng thái hoàn tiền/hoàn hàng.</div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Stepper 6 bước chuẩn -->
                                            <div class="order-stepper">
                                                <div class="stepper-item ${ord.statusStep >= 1 ? (ord.statusStep > 1 ? 'completed' : 'active') : ''}">
                                                    <div class="stepper-circle">
                                                        <c:choose>
                                                            <c:when test="${ord.statusStep > 1}"><i class="bi bi-check"></i></c:when>
                                                            <c:otherwise>1</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span>Đơn hàng mới</span>
                                                </div>

                                                <div class="stepper-item ${ord.statusStep >= 2 ? (ord.statusStep > 2 ? 'completed' : 'active') : ''}">
                                                    <div class="stepper-circle">
                                                        <c:choose>
                                                            <c:when test="${ord.statusStep > 2}"><i class="bi bi-check"></i></c:when>
                                                            <c:otherwise>2</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span>Đã xác nhận</span>
                                                </div>

                                                <div class="stepper-item ${ord.statusStep >= 3 ? (ord.statusStep > 3 ? 'completed' : 'active') : ''}">
                                                    <div class="stepper-circle">
                                                        <c:choose>
                                                            <c:when test="${ord.statusStep > 3}"><i class="bi bi-check"></i></c:when>
                                                            <c:otherwise>3</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span>Chuẩn bị hàng</span>
                                                </div>

                                                <div class="stepper-item ${ord.statusStep >= 4 ? (ord.statusStep > 4 ? 'completed' : 'active') : ''}">
                                                    <div class="stepper-circle">
                                                        <c:choose>
                                                            <c:when test="${ord.statusStep > 4}"><i class="bi bi-check"></i></c:when>
                                                            <c:otherwise>4</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span>Vận chuyển</span>
                                                </div>

                                                <div class="stepper-item ${ord.statusStep >= 5 ? (ord.statusStep > 5 ? 'completed' : 'active') : ''}">
                                                    <div class="stepper-circle">
                                                        <c:choose>
                                                            <c:when test="${ord.statusStep > 5}"><i class="bi bi-check"></i></c:when>
                                                            <c:otherwise>5</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span>Giao hàng</span>
                                                </div>

                                                <div class="stepper-item ${ord.statusStep >= 6 ? 'completed' : ''}">
                                                    <div class="stepper-circle">
                                                        <c:choose>
                                                            <c:when test="${ord.statusStep >= 6}"><i class="bi bi-check"></i></c:when>
                                                            <c:otherwise>6</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <span>Đã giao</span>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- Card Body: Danh sách món hàng & thông tin giao nhận -->
                                <div class="card-body p-3">
                                    <div class="row g-3">
                                        <!-- Danh sách sản phẩm -->
                                        <div class="col-lg-7">
                                            <div class="d-flex flex-column gap-2">
                                                <c:forEach var="item" items="${ord.items}">
                                                    <div class="d-flex align-items-center gap-3 p-2 rounded bg-light border">
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
                                                        <div class="flex-grow-1 min-w-0">
                                                            <div class="fw-semibold text-dark text-truncate" title="${item.videoTitle}">${item.videoTitle}</div>
                                                            <div class="small text-muted">
                                                                Mã: <code>${item.videoId}</code> &bull; SL: <span class="badge bg-secondary-subtle text-secondary px-2">x${item.quantity}</span>
                                                            </div>
                                                        </div>
                                                        <div class="text-end ps-2">
                                                            <div class="fw-bold text-danger">
                                                                <fmt:formatNumber value="${item.totalPrice}" pattern="#,###"/> ₫
                                                            </div>
                                                            <div class="small text-muted" style="font-size: 0.75rem;">
                                                                (<fmt:formatNumber value="${item.price}" pattern="#,###"/> ₫/món)
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <!-- Thông tin giao hàng & Tổng tiền -->
                                        <div class="col-lg-5">
                                            <div class="p-3 bg-light rounded border h-100 d-flex flex-column justify-content-between">
                                                <div>
                                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                                        <div class="fw-bold text-dark">
                                                            <i class="bi bi-geo-alt-fill text-danger me-1"></i>Địa chỉ nhận hàng:
                                                        </div>
                                                        <span class="badge bg-success-subtle text-success border border-success">
                                                            ${ord.paymentMethod}
                                                        </span>
                                                    </div>
                                                    <div class="small text-dark mb-1">
                                                        <strong>${ord.customerName}</strong> - <i class="bi bi-telephone text-muted"></i> ${ord.phone}
                                                    </div>
                                                    <div class="small text-secondary mb-2">
                                                        ${ord.address}
                                                    </div>
                                                    <c:if test="${not empty ord.note}">
                                                        <div class="small text-muted fst-italic mb-2">
                                                            <i class="bi bi-chat-left-dots me-1"></i>Ghi chú: ${ord.note}
                                                        </div>
                                                    </c:if>
                                                    <div class="small text-info-emphasis bg-white p-2 rounded border mb-2">
                                                        <i class="bi bi-shield-check me-1 text-success"></i>Trạng thái tiền: <strong>${ord.paymentStatus}</strong>
                                                    </div>
                                                </div>

                                                <div class="pt-2 border-top d-flex justify-content-between align-items-center">
                                                    <span class="text-secondary small">Tổng tiền COD:</span>
                                                    <span class="fs-5 fw-bold text-danger">
                                                        <fmt:formatNumber value="${ord.totalAmount}" pattern="#,###"/> ₫
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Card Footer: Actions -->
                                <div class="card-footer bg-white py-2 px-3 border-top d-flex justify-content-between align-items-center flex-wrap gap-2">
                                    <div class="small text-muted">
                                        Tổng cộng: <strong>${ord.totalQuantity}</strong> món hàng &bull; Phương thức: <strong>COD (Tiền mặt)</strong>
                                    </div>
                                    <div class="d-flex align-items-center gap-2 flex-wrap">
                                        <!-- Chi tiết -->
                                        <a href="${pageContext.request.contextPath}/order/detail?orderId=${ord.orderId}" 
                                           class="btn btn-sm btn-outline-primary px-3">
                                            <i class="bi bi-eye me-1"></i>Xem Chi Tiết
                                        </a>

                                        <!-- Mua lại -->
                                        <a href="${pageContext.request.contextPath}/order/reorder?orderId=${ord.orderId}" 
                                           class="btn btn-sm btn-outline-success px-3" 
                                           title="Thêm lại sản phẩm của đơn này vào giỏ hàng">
                                            <i class="bi bi-cart-plus me-1"></i>Mua lại
                                        </a>

                                        <!-- Hủy đơn (Nếu Đơn hàng mới hoặc Đã xác nhận) -->
                                        <c:if test="${ord.canCancel()}">
                                            <a href="${pageContext.request.contextPath}/order/cancel?orderId=${ord.orderId}&status=${selectedStatus}" 
                                               class="btn btn-sm btn-outline-danger px-3" 
                                               onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng ${ord.orderId} này?');">
                                                <i class="bi bi-x-circle me-1"></i>Hủy đơn
                                            </a>
                                        </c:if>

                                        <!-- Yêu cầu hoàn hàng (Nếu Đã giao) -->
                                        <c:if test="${ord.canReturn()}">
                                            <a href="${pageContext.request.contextPath}/order/return?orderId=${ord.orderId}&status=${selectedStatus}" 
                                               class="btn btn-sm btn-outline-dark px-3" 
                                               onclick="return confirm('Bạn muốn gửi yêu cầu hoàn đơn ${ord.orderId}?');">
                                                <i class="bi bi-arrow-counterclockwise me-1"></i>Hoàn hàng
                                            </a>
                                        </c:if>

                                        <!-- Dropdown đổi trạng thái thử nghiệm để kiểm tra chấm điểm -->
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-light border dropdown-toggle px-2" type="button" data-bs-toggle="dropdown" aria-expanded="false" title="Đổi trạng thái thử nghiệm cho giảng viên chấm">
                                                <i class="bi bi-sliders text-secondary me-1"></i>Đổi trạng thái demo
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow fs-7">
                                                <li><h6 class="dropdown-header">Chuyển sang 1 trong 8 trạng thái:</h6></li>
                                                <c:forEach var="stItem" items="${allStatuses}">
                                                    <li>
                                                        <a class="dropdown-item ${stItem eq ord.orderStatus ? 'active fw-bold' : ''}" 
                                                           href="${pageContext.request.contextPath}/order/update-status?orderId=${ord.orderId}&newStatus=${stItem}&status=${selectedStatus}">
                                                            ${stItem}
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Empty State -->
                    <div class="text-center py-5">
                        <div class="mb-3 text-secondary">
                            <i class="bi bi-funnel text-muted" style="font-size: 3.5rem;"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">
                            Không tìm thấy đơn hàng nào ở trạng thái "${selectedStatus eq 'ALL' ? 'Tất cả' : selectedStatus}"
                        </h5>
                        <p class="text-secondary mb-4">
                            Bạn hãy thử bấm vào các tab trạng thái khác ở phía trên hoặc đặt đơn hàng mới để trải nghiệm tiến trình nhé!
                        </p>
                        <a href="${pageContext.request.contextPath}/my-orders?status=ALL" class="btn btn-outline-primary px-4 me-2 rounded-pill shadow-sm">
                            <i class="bi bi-list-ul me-1"></i>Xem Tất Cả Đơn Hàng
                        </a>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-primary px-4 rounded-pill fw-semibold shadow-sm">
                            <i class="bi bi-bag-plus me-1"></i>Khám Phá Sản Phẩm Ngay
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
