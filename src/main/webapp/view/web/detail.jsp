<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Video - ${video.title} (MSSV: 24110251)</title>
    <!-- Fallback Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/common/web/header.jsp"/>

<div class="container py-3">
    <c:if test="${param.cartMsg == 'added'}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-cart-check-fill me-2"></i>Đã thêm sản phẩm vào giỏ hàng thành công! <a href="${pageContext.request.contextPath}/cart" class="alert-link fw-bold">Xem giỏ hàng ngay</a>.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.cartMsg == 'max_reached'}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>Lưu ý: Sản phẩm này đã đạt giới hạn tối đa cho phép trong giỏ hàng (tối đa 10 sản phẩm)! <a href="${pageContext.request.contextPath}/cart" class="alert-link fw-bold">Xem giỏ hàng</a>.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="mb-3 d-flex justify-content-between align-items-center">
        <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-sm">
            <i class="bi bi-arrow-left me-1"></i>Quay lại Trang Chủ
        </a>
        <div class="d-flex align-items-center gap-2">
            <span class="small text-muted">
                <i class="bi bi-person-circle me-1"></i>${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
            </a>
        </div>
    </div>

    <c:if test="${param.shared == 'true'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>Đã ghi nhận lượt chia sẻ video thành công!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <div class="card shadow-sm border border-secondary">
        <div class="card-body p-4">
            <div class="row g-4 align-items-center mb-4">
                <div class="col-md-5">
                    <div class="ratio ratio-16x9 bg-dark rounded border overflow-hidden">
                        <c:choose>
                            <c:when test="${not empty video.poster && video.poster != 'default-poster.jpg'}">
                                <img src="${video.poster}" class="img-fluid object-fit-cover w-100 h-100" alt="${video.title}">
                            </c:when>
                            <c:otherwise>
                                <div class="d-flex align-items-center justify-content-center text-secondary h-100">
                                    <i class="bi bi-film fs-1"></i>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="col-md-7">
                    <h3 class="fw-bold text-dark mb-3">${video.title}</h3>

                    <div class="fs-6 mb-2">
                        <span class="text-secondary fw-semibold">Mã video:</span>
                        <code class="fs-6 text-dark ms-1">${video.videoId}</code>
                    </div>

                    <div class="fs-6 mb-2">
                        <span class="text-secondary fw-semibold">Category name:</span>
                        <span class="badge bg-primary ms-1">${video.category.categoryname}</span>
                    </div>

                    <div class="fs-6 mb-2">
                        <span class="text-secondary fw-semibold">View:</span>
                        <span class="fw-bold text-dark ms-1">${video.views}</span>
                    </div>

                    <div class="fs-5 mb-3">
                        <span class="text-secondary fw-semibold">Giá bán:</span>
                        <span class="fw-bold text-danger ms-1 fs-4"><fmt:formatNumber value="${video.price}" pattern="#,###"/> ₫</span>
                    </div>

                    <!-- Form Giỏ hàng: Thêm vào giỏ & Mua ngay với giới hạn số lượng -->
                    <form action="${pageContext.request.contextPath}/cart" method="POST" class="p-3 bg-light border rounded mb-3">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="id" value="${video.videoId}">
                        <div class="d-flex align-items-center flex-wrap gap-2">
                            <label class="form-label mb-0 fw-semibold text-dark">Số lượng (tối đa 10):</label>
                            <input type="number" name="quantity" value="1" min="1" max="10" class="form-control text-center fw-bold" style="width: 75px;" required>
                            <button type="submit" class="btn btn-success fw-semibold">
                                <i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ hàng
                            </button>
                            <button type="submit" name="redirect" value="/cart" class="btn btn-primary fw-semibold">
                                <i class="bi bi-bag-check me-1"></i>Mua ngay
                            </button>
                        </div>
                        <small class="text-muted mt-2 d-block">
                            <i class="bi bi-info-circle me-1"></i>Giới hạn số lượng đặt mua: từ 1 đến 10 sản phẩm cho mỗi đơn hàng.
                        </small>
                    </form>

                    <div class="d-flex gap-2">
                        <c:choose>
                            <c:when test="${sessionScope.currentUser != null}">
                                <a href="${pageContext.request.contextPath}/video/detail?id=${video.videoId}&action=like"
                                   class="btn btn-sm ${isLiked ? 'btn-danger' : 'btn-outline-danger'}">
                                    <i class="bi bi-heart-fill me-1"></i>Like(${likeCount})
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-outline-danger" title="Đăng nhập để thích">
                                    <i class="bi bi-heart me-1"></i>Like(${likeCount})
                                </a>
                            </c:otherwise>
                        </c:choose>

                        <button type="button" class="btn btn-sm btn-outline-info" data-bs-toggle="modal" data-bs-target="#shareModal">
                            <i class="bi bi-share-fill me-1"></i>Share(${shareCount})
                        </button>
                    </div>
                </div>
            </div>

            <hr class="border-secondary">

            <div>
                <h5 class="fw-bold text-secondary mb-2">Mô tả (description):</h5>
                <p class="text-dark lh-base mb-0">
                    <c:choose>
                        <c:when test="${not empty video.description}">
                            ${video.description}
                        </c:when>
                        <c:otherwise>
                            <em class="text-muted">Chưa có mô tả cho video này.</em>
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="shareModal" tabindex="-1" aria-labelledby="shareModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form action="${pageContext.request.contextPath}/video/detail" method="GET" class="modal-content">
            <input type="hidden" name="id" value="${video.videoId}">
            <input type="hidden" name="action" value="share">
            <div class="modal-header">
                <h5 class="modal-title fw-bold" id="shareModalLabel"><i class="bi bi-share me-2"></i>Chia Sẻ Video</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <c:choose>
                    <c:when test="${sessionScope.currentUser != null}">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Gửi đến danh sách Email (cách nhau bởi dấu phẩy):</label>
                            <input type="text" name="emails" class="form-control" placeholder="friend@example.com, colleague@example.com" required>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning mb-0">
                            Bạn cần <a href="${pageContext.request.contextPath}/login" class="alert-link">đăng nhập</a> để thực hiện tính năng chia sẻ video.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <c:if test="${sessionScope.currentUser != null}">
                    <button type="submit" class="btn btn-info text-white"><i class="bi bi-send me-1"></i>Xác nhận Share</button>
                </c:if>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/common/web/footer.jsp"/>

</body>
</html>
