<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="128kb" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - VideoHub (MSSV: 24110251)</title>
    <!-- Fallback Bootstrap 5 & Icons (tham khảo pattern từ project MVC 3-tier) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/common/web/header.jsp"/>

<div class="container py-3">
    <c:if test="${param.cartMsg == 'added'}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-cart-check-fill me-2"></i>Đã thêm sản phẩm vào giỏ hàng! <a href="${pageContext.request.contextPath}/cart" class="alert-link fw-bold">Xem giỏ hàng ngay</a>.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${param.cartMsg == 'max_reached'}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm mb-3" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>Lưu ý: Sản phẩm này đã đạt giới hạn tối đa cho phép trong giỏ hàng (tối đa 10 sản phẩm)! <a href="${pageContext.request.contextPath}/cart" class="alert-link fw-bold">Xem giỏ hàng</a>.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <div class="p-4 mb-4 bg-white rounded shadow-sm border d-flex justify-content-between align-items-center flex-wrap gap-2">
        <div>
            <h2 class="h4 fw-bold text-primary mb-1">
                <i class="bi bi-collection-play-fill me-2 text-danger"></i>Danh Sách Video Theo Danh Mục
            </h2>
            <p class="text-secondary mb-0">Hệ thống phân trang 3 video trên 1 trang theo từng Category (Câu 4 &amp; 5)</p>
        </div>
        <div class="d-flex align-items-center gap-2">
            <span class="badge bg-light text-dark border px-3 py-2">
                <i class="bi bi-person-circle me-1 text-primary"></i>Xin chào: <strong>${not empty sessionScope.currentUser.fullname ? sessionScope.currentUser.fullname : sessionScope.currentUser.username}</strong>
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-sm btn-danger fw-semibold">
                <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
            </a>
        </div>
    </div>

    <c:forEach var="cat" items="${categories}">
        <div class="card mb-4 shadow-sm border-0">
            <div class="card-header bg-white border-bottom py-3">
                <div class="d-flex justify-content-between align-items-center">
                    <h4 class="h5 fw-bold text-dark mb-0">
                        ${cat.categoryname} (${videoCountMap[cat.categoryId]})
                    </h4>
                    <span class="text-muted small">Mã danh mục: ${cat.categorycode}</span>
                </div>
            </div>

            <div class="card-body">
                <c:set var="videos" value="${categoryVideosMap[cat.categoryId]}" />
                <c:choose>
                    <c:when test="${not empty videos}">
                        <div class="row row-cols-1 row-cols-md-3 g-4 mb-3">
                            <c:forEach var="v" items="${videos}">
                                <div class="col">
                                    <div class="card h-100 video-card border shadow-sm">
                                        <div class="ratio ratio-16x9 bg-dark">
                                            <c:choose>
                                                <c:when test="${not empty v.poster && v.poster != 'default-poster.jpg'}">
                                                    <img src="${v.poster}" class="card-img-top object-fit-cover" alt="${v.title}">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="d-flex align-items-center justify-content-center text-secondary h-100">
                                                        <i class="bi bi-film fs-1"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="card-body d-flex flex-column">
                                            <h5 class="card-title fw-bold text-truncate mb-2" title="${v.title}">
                                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="text-decoration-none text-dark">
                                                    ${v.title}
                                                </a>
                                            </h5>

                                            <div class="small text-muted mb-2">
                                                <div><strong>Mã video:</strong> <code>${v.videoId}</code></div>
                                                <div><strong>Category name:</strong> <span class="text-primary">${v.category.categoryname}</span></div>
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <span><strong>View:</strong> ${v.views}</span>
                                                    <span class="badge bg-danger-subtle text-danger fw-bold fs-6">
                                                        <fmt:formatNumber value="${v.price}" pattern="#,###"/> ₫
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="mt-auto pt-2 border-top d-flex justify-content-between align-items-center flex-wrap gap-1">
                                                <div>
                                                    <span class="badge bg-light text-danger border me-1">
                                                        <i class="bi bi-heart-fill me-1"></i>Like(${likeCountMap[v.videoId]})
                                                    </span>
                                                    <span class="badge bg-light text-info border">
                                                        <i class="bi bi-share-fill me-1"></i>Share(${shareCountMap[v.videoId]})
                                                    </span>
                                                </div>
                                                <div class="d-flex gap-1">
                                                    <a href="${pageContext.request.contextPath}/cart?action=add&id=${v.videoId}" class="btn btn-sm btn-success" title="Thêm vào giỏ hàng">
                                                        <i class="bi bi-cart-plus me-1"></i>Thêm giỏ
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="btn btn-sm btn-outline-primary">
                                                        Chi tiết
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <c:set var="totalPages" value="${totalPagesMap[cat.categoryId]}" />
                        <c:set var="curPage" value="${currentPageMap[cat.categoryId]}" />
                        <c:if test="${totalPages > 1}">
                            <nav class="d-flex justify-content-center mt-3">
                                <ul class="pagination pagination-sm mb-0">
                                    <li class="page-item ${curPage <= 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="?page_${cat.categoryId}=${curPage - 1}">&lt;&lt;</a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${curPage == i ? 'active' : ''}">
                                            <a class="page-link" href="?page_${cat.categoryId}=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${curPage >= totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="?page_${cat.categoryId}=${curPage + 1}">&gt;&gt;</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-4 text-muted">
                            <i class="bi bi-inbox fs-3 d-block mb-1"></i>
                            Chưa có video nào trong danh mục này.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:forEach>
</div>

<jsp:include page="/common/web/footer.jsp"/>

</body>
</html>
