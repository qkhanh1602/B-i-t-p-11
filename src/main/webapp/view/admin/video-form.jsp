<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty video.videoId ? 'Chỉnh Sửa Video' : 'Thêm Video Mới'} - Admin (MSSV: 24110251)</title>
    <!-- Fallback Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/common/admin/header.jsp"/>

<div class="container-fluid py-3">
<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h3 fw-bold text-dark">
        <i class="bi ${not empty video.videoId ? 'bi-pencil-square' : 'bi-plus-circle'} me-2 text-primary"></i>
        ${not empty video.videoId ? 'Chỉnh Sửa Video' : 'Thêm Video Mới'}
    </h1>
    <div class="btn-toolbar mb-2 mb-md-0 gap-2">
        <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-sm btn-outline-secondary">
            <i class="bi bi-arrow-left me-1"></i>Quay lại danh sách
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-danger fw-semibold">
            <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
        </a>
    </div>
</div>

<div class="row">
    <div class="col-lg-8">
        <div class="card shadow-sm border-0">
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/admin/videos" method="POST">
                    <input type="hidden" name="isEdit" value="${not empty video.videoId ? 'true' : 'false'}">

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mã Video (VideoId) <span class="text-danger">*</span></label>
                        <input type="text" name="videoId" class="form-control" value="${video.videoId}"
                               ${not empty video.videoId ? 'readonly' : 'required'} placeholder="Ví dụ: VID01">
                        <div class="form-text">Mã định danh duy nhất của video (tối đa 50 ký tự).</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tiêu Đề Video (Title) <span class="text-danger">*</span></label>
                        <input type="text" name="title" class="form-control" value="${video.title}"
                               placeholder="Nhập tiêu đề video..." required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Đường Dẫn Hình Ảnh Poster</label>
                        <input type="text" name="poster" class="form-control" value="${video.poster}"
                               placeholder="https://example.com/poster.jpg">
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Danh Mục (Category) <span class="text-danger">*</span></label>
                            <select name="categoryId" class="form-select" required>
                                <option value="">-- Chọn danh mục --</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.categoryId}" ${video.category != null && video.category.categoryId == cat.categoryId ? 'selected' : ''}>
                                        ${cat.categoryname} (${cat.categorycode})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label fw-semibold">Lượt Xem (Views)</label>
                            <input type="number" name="views" class="form-control" value="${video.views != null ? video.views : 0}" min="0">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mô Tả Chi Tiết (Description)</label>
                        <textarea name="description" class="form-control" rows="4" placeholder="Nhập tóm tắt nội dung video...">${video.description}</textarea>
                    </div>

                    <div class="mb-4 form-check form-switch">
                        <input class="form-check-input" type="checkbox" name="active" value="true" id="activeCheck"
                               ${video.active == null || video.active ? 'checked' : ''}>
                        <label class="form-check-label fw-semibold" for="activeCheck">Kích hoạt hiển thị video (Active)</label>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary px-4">
                            <i class="bi bi-save me-1"></i>Lưu Dữ Liệu
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-light border px-4">Hủy bỏ</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>

<jsp:include page="/common/admin/footer.jsp"/>

</body>
</html>
