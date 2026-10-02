<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Đơn Hàng (Admin) - VideoHub (MSSV: 24110251)</title>
    <style>
        .admin-status-tab .nav-link {
            color: #495057;
            font-weight: 500;
            border-radius: 8px;
            padding: 8px 14px;
            white-space: nowrap;
            transition: all 0.2s ease-in-out;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
        }
        .admin-status-tab .nav-link:hover {
            background-color: #e2e8f0;
            color: #0d6efd;
        }
        .admin-status-tab .nav-link.active {
            background-color: #0d6efd;
            color: #ffffff;
            border-color: #0d6efd;
            box-shadow: 0 4px 10px rgba(13, 110, 253, 0.25);
        }
        .status-badge {
            font-size: 0.82rem;
            padding: 5px 10px;
            border-radius: 50rem;
            font-weight: 600;
        }
    </style>
</head>
<body>

<div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
    <div>
        <h4 class="h4 fw-bold text-dark mb-1">
            <i class="bi bi-card-checklist text-primary me-2"></i>Quản Lý &amp; Lọc Đơn Hàng
        </h4>
        <p class="text-secondary small mb-0">Theo dõi toàn bộ đơn hàng hệ thống qua 8 trạng thái xử lý chuẩn (MSSV: 24110251)</p>
    </div>
    <div class="d-flex align-items-center gap-2">
        <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-clockwise me-1"></i>Làm mới
        </a>
    </div>
</div>

<c:if test="${param.msg eq 'updated'}">
    <div class="alert alert-success alert-dismissible fade show shadow-sm border-0 mb-3" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>Cập nhật trạng thái đơn hàng thành công!
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
</c:if>

<!-- Thẻ lọc 8 trạng thái -->
<div class="card shadow-sm border-0 mb-4 bg-white">
    <div class="card-header bg-white py-3 border-bottom">
        <div class="d-flex overflow-auto pb-1 admin-status-tab gap-2">
            <a href="${pageContext.request.contextPath}/admin/orders?status=ALL${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'ALL' || empty selectedStatus ? 'active' : ''}">
                🌐 Tất cả 
                <span class="badge rounded-pill bg-white text-dark ms-1">${statusCounts['ALL']}</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders?status=Đơn hàng mới${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'Đơn hàng mới' ? 'active' : ''}">
                🆕 Đơn hàng mới 
                <span class="badge rounded-pill bg-primary-subtle text-primary border border-primary ms-1">${statusCounts['Đơn hàng mới']}</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders?status=Đã xác nhận${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'Đã xác nhận' ? 'active' : ''}">
                ⏳ Đã xác nhận 
                <span class="badge rounded-pill bg-info-subtle text-info border border-info ms-1">${statusCounts['Đã xác nhận']}</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders?status=Chuẩn bị hàng${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'Chuẩn bị hàng' ? 'active' : ''}">
                📦 Chuẩn bị hàng 
                <span class="badge rounded-pill bg-warning-subtle text-warning-emphasis border border-warning ms-1">${statusCounts['Chuẩn bị hàng']}</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders?status=Vận chuyển${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'Vận chuyển' ? 'active' : ''}">
                🚚 Vận chuyển 
                <span class="badge rounded-pill bg-secondary-subtle text-secondary border border-secondary ms-1">${statusCounts['Vận chuyển']}</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders?status=Giao hàng${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'Giao hàng' ? 'active' : ''}">
                🚴 Giao hàng 
                <span class="badge rounded-pill bg-primary-subtle text-primary border border-primary ms-1">${statusCounts['Giao hàng']}</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders?status=Đã giao${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'Đã giao' ? 'active' : ''}">
                ✅ Đã giao 
                <span class="badge rounded-pill bg-success-subtle text-success border border-success ms-1">${statusCounts['Đã giao']}</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders?status=Đơn hàng hủy${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'Đơn hàng hủy' ? 'active' : ''}">
                ❌ Đơn hàng hủy 
                <span class="badge rounded-pill bg-danger-subtle text-danger border border-danger ms-1">${statusCounts['Đơn hàng hủy']}</span>
            </a>

            <a href="${pageContext.request.contextPath}/admin/orders?status=Đơn hàng hoàn${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
               class="nav-link ${selectedStatus eq 'Đơn hàng hoàn' ? 'active' : ''}">
                🔄 Đơn hàng hoàn 
                <span class="badge rounded-pill bg-dark-subtle text-dark border border-dark ms-1">${statusCounts['Đơn hàng hoàn']}</span>
            </a>
        </div>
    </div>

    <!-- Thanh tìm kiếm -->
    <div class="card-body bg-light border-bottom py-3">
        <form method="get" action="${pageContext.request.contextPath}/admin/orders" class="row g-2 align-items-center">
            <input type="hidden" name="status" value="${selectedStatus}">
            <div class="col-md-5">
                <div class="input-group">
                    <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                    <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Tìm theo mã đơn, người nhận, SĐT, tên video...">
                </div>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-funnel me-1"></i>Lọc Dữ Liệu
                </button>
            </div>
            <c:if test="${not empty keyword || selectedStatus ne 'ALL'}">
                <div class="col-auto">
                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline-secondary">
                        <i class="bi bi-x-circle me-1"></i>Bỏ lọc
                    </a>
                </div>
            </c:if>
            <div class="col text-end text-muted small">
                Hiển thị: <strong>${orders.size()}</strong> đơn hàng
            </div>
        </form>
    </div>

    <!-- Bảng danh sách đơn hàng -->
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${not empty orders}">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light text-secondary">
                            <tr>
                                <th scope="col" class="text-center py-3" style="width: 45px;">#</th>
                                <th scope="col" class="py-3" style="min-width: 140px;">Mã đơn hàng</th>
                                <th scope="col" class="py-3" style="min-width: 130px;">Thời gian</th>
                                <th scope="col" class="py-3" style="min-width: 160px;">Khách hàng / User</th>
                                <th scope="col" class="py-3" style="min-width: 200px;">Chi tiết sản phẩm</th>
                                <th scope="col" class="text-end py-3" style="min-width: 120px;">Tổng tiền COD</th>
                                <th scope="col" class="text-center py-3" style="min-width: 150px;">Trạng thái</th>
                                <th scope="col" class="text-center py-3" style="min-width: 170px;">Cập nhật trạng thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ord" items="${orders}" varStatus="loop">
                                <tr>
                                    <td class="text-center text-muted fw-semibold">${loop.index + 1}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/order/detail?orderId=${ord.orderId}" target="_blank" class="fw-bold text-primary text-decoration-none">
                                            <code>${ord.orderId}</code>
                                        </a>
                                        <div class="small text-muted"><span class="badge bg-light text-secondary border">${ord.paymentMethod}</span></div>
                                    </td>
                                    <td class="small text-muted">
                                        <i class="bi bi-calendar3 me-1"></i><fmt:formatDate value="${ord.orderDate}" pattern="dd/MM/yyyy"/><br>
                                        <i class="bi bi-clock me-1"></i><fmt:formatDate value="${ord.orderDate}" pattern="HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark">${ord.customerName}</div>
                                        <div class="small text-muted"><i class="bi bi-telephone me-1"></i>${ord.phone}</div>
                                        <div class="small text-secondary text-truncate" style="max-width: 200px;" title="${ord.address}">
                                            <i class="bi bi-geo-alt me-1"></i>${ord.address}
                                        </div>
                                    </td>
                                    <td>
                                        <c:forEach var="item" items="${ord.items}" varStatus="iStat">
                                            <div class="small text-dark text-truncate" style="max-width: 220px;" title="${item.videoTitle}">
                                                &bull; ${item.videoTitle} <strong>(x${item.quantity})</strong>
                                            </div>
                                        </c:forEach>
                                    </td>
                                    <td class="text-end fw-bold text-danger">
                                        <fmt:formatNumber value="${ord.totalAmount}" pattern="#,###"/> ₫
                                    </td>
                                    <td class="text-center">
                                        <span class="badge ${ord.statusBadgeClass} status-badge shadow-sm">
                                            <i class="bi ${ord.statusIconClass} me-1"></i>${ord.orderStatus}
                                        </span>
                                        <div class="small text-muted mt-1" style="font-size: 0.75rem;">
                                            ${ord.paymentStatus}
                                        </div>
                                    </td>
                                    <td class="text-center">
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="bi bi-arrow-repeat me-1"></i>Đổi trạng thái
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow-sm">
                                                <li><h6 class="dropdown-header">Chọn trạng thái mới:</h6></li>
                                                <c:forEach var="st" items="${allStatuses}">
                                                    <li>
                                                        <a class="dropdown-item ${st eq ord.orderStatus ? 'active fw-bold' : ''}" 
                                                           href="${pageContext.request.contextPath}/admin/order/update-status?orderId=${ord.orderId}&newStatus=${st}&status=${selectedStatus}">
                                                            ${st}
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                    <h5 class="fw-bold text-dark mt-2">Không có đơn hàng nào phù hợp</h5>
                    <p class="text-secondary small mb-3">Thử chọn trạng thái khác hoặc xóa từ khóa tìm kiếm</p>
                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-sm btn-outline-primary">
                        Xem tất cả đơn hàng
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

</body>
</html>
