<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Videos - Admin (MSSV: 24110251)</title>
    <!-- Fallback Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/common/admin/header.jsp"/>

<div class="container-fluid py-3">
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <div>
        <h1 class="h3 fw-bold text-dark mb-0"><i class="bi bi-collection-play me-2 text-primary"></i>Quản Trị Bảng Videos</h1>
        <p class="text-muted small mb-0">Chức năng CRUD dữ liệu bảng Videos có phân trang 6 video/trang (Câu 2 - 2.5 điểm)</p>
    </div>
    <div class="btn-toolbar mb-2 mb-md-0 gap-2">
        <a href="${pageContext.request.contextPath}/admin/videos?action=new" class="btn btn-primary">
            <i class="bi bi-plus-circle me-1"></i>Thêm Video Mới
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger fw-semibold">
            <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
        </a>
    </div>
</div>

<c:if test="${param.msg == 'saved'}">
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i>Lưu thông tin video thành công vào CSDL!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<c:if test="${param.msg == 'deleted'}">
    <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <i class="bi bi-trash-fill me-2"></i>Đã xóa video thành công khỏi CSDL!
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
</c:if>

<div class="card shadow-sm border-0 mb-4">
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="ps-3" style="width: 120px;">Mã Video</th>
                        <th style="width: 100px;">Poster</th>
                        <th>Tiêu Đề Video</th>
                        <th>Danh Mục (Category)</th>
                        <th style="width: 100px;">Lượt Xem</th>
                        <th style="width: 110px;">Trạng Thái</th>
                        <th class="text-center" style="width: 140px;">Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty videos}">
                            <c:forEach var="v" items="${videos}">
                                <tr>
                                    <td class="ps-3 fw-bold"><code>${v.videoId}</code></td>
                                    <td>
                                        <div class="ratio ratio-16x9 bg-dark rounded overflow-hidden" style="width: 80px;">
                                            <c:choose>
                                                <c:when test="${not empty v.poster && v.poster != 'default-poster.jpg'}">
                                                    <img src="${v.poster}" class="object-fit-cover" alt="${v.title}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="d-flex align-items-center justify-content-center text-secondary h-100">
                                                        <i class="bi bi-film"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark">${v.title}</div>
                                        <small class="text-muted text-truncate d-inline-block" style="max-width: 320px;">${v.description}</small>
                                    </td>
                                    <td>
                                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle">
                                            ${v.category != null ? v.category.categoryname : 'N/A'}
                                        </span>
                                    </td>
                                    <td><span class="badge bg-light text-dark border">${v.views}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${v.active}">
                                                <span class="badge bg-success-subtle text-success border border-success-subtle">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary-subtle text-secondary border">Ẩn</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/admin/videos?action=edit&id=${v.videoId}"
                                           class="btn btn-sm btn-outline-primary me-1" title="Chỉnh sửa">
                                            <i class="bi bi-pencil-square"></i>
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/videos?action=delete&id=${v.videoId}"
                                           class="btn btn-sm btn-outline-danger"
                                           onclick="return confirm('Bạn có chắc muốn xóa video này?');" title="Xóa">
                                            <i class="bi bi-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="text-center py-4 text-muted">
                                    <i class="bi bi-inbox fs-3 d-block mb-1"></i>
                                    Chưa có dữ liệu video nào trong hệ thống.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<c:if test="${totalPages > 1}">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <span class="text-muted small">Hiển thị trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong> (Tổng cộng: ${totalVideos} videos)</span>
        <nav>
            <ul class="pagination pagination-sm mb-0">
                <li class="page-item ${currentPage <= 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=${currentPage - 1}">&laquo; Trước</a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=${i}">${i}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/admin/videos?page=${currentPage + 1}">Sau &raquo;</a>
                </li>
            </ul>
        </nav>
    </div>
</c:if>
</div>

<jsp:include page="/common/admin/footer.jsp"/>

</body>
</html>
