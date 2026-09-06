<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm - WebShop</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }

        /* === NAVBAR === */
        .navbar { background: linear-gradient(135deg, #667eea, #764ba2); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.2); }
        .navbar .logo { color: white; font-size: 22px; font-weight: bold; text-decoration: none; }
        .navbar .nav-links { display: flex; gap: 20px; align-items: center; }
        .navbar .nav-links a { color: white; text-decoration: none; font-size: 14px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s; }
        .navbar .nav-links a:hover { background: rgba(255,255,255,0.2); }
        .navbar .nav-links a.active { background: rgba(255,255,255,0.3); }

        /* === PAGE HEADER === */
        .page-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; text-align: center; padding: 40px 20px 30px; }
        .page-header h1 { font-size: 28px; margin-bottom: 5px; }
        .page-header p { font-size: 14px; opacity: 0.9; }

        /* === PRODUCT SECTION === */
        .section { max-width: 1200px; margin: 30px auto; padding: 0 20px; }

        .product-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }

        .product-card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 15px rgba(0,0,0,0.08); transition: all 0.3s; cursor: pointer; text-decoration: none; color: inherit; display: block; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.15); }
        .product-card .card-img { width: 100%; height: 200px; object-fit: cover; background: #eee; display: flex; align-items: center; justify-content: center; color: #999; font-size: 14px; }
        .product-card .card-img img { width: 100%; height: 100%; object-fit: cover; }
        .product-card .card-body { padding: 15px; }
        .product-card .card-title { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .product-card .card-category { font-size: 12px; color: #888; margin-bottom: 8px; }
        .product-card .card-price { font-size: 18px; font-weight: bold; color: #e74c3c; }

        /* === PAGINATION === */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 5px; margin-top: 30px; padding: 20px 0; }
        .pagination a, .pagination span { display: inline-block; padding: 10px 16px; text-decoration: none; border-radius: 6px; font-size: 14px; transition: all 0.3s; }
        .pagination a { background: white; color: #667eea; border: 1px solid #ddd; }
        .pagination a:hover { background: #667eea; color: white; border-color: #667eea; }
        .pagination span.current { background: linear-gradient(135deg, #667eea, #764ba2); color: white; font-weight: bold; }
        .pagination span.disabled { background: #f0f0f0; color: #ccc; border: 1px solid #eee; }

        .empty-msg { text-align: center; color: #999; padding: 40px; font-size: 16px; }
    </style>
</head>
<body>
    <!-- NAVBAR -->
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="logo">🛒 WebShop</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/product" class="active">Sản phẩm</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="#">Xin chào, ${sessionScope.user.fullname}</a>
                    <a href="${pageContext.request.contextPath}/account/logout">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/account/login">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/account/register">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- PAGE HEADER -->
    <div class="page-header">
        <h1>Tất cả sản phẩm</h1>
        <p>Trang ${currentPage} / ${totalPages}</p>
    </div>

    <!-- PRODUCT LIST -->
    <div class="section">
        <c:if test="${not empty products}">
            <div class="product-grid">
                <c:forEach items="${products}" var="p">
                    <a href="${pageContext.request.contextPath}/product/detail?id=${p.productId}" class="product-card">
                        <div class="card-img">
                            <c:choose>
                                <c:when test="${not empty p.image && p.image.length() >= 5 && p.image.substring(0,5) == 'https'}">
                                    <img src="${p.image}" alt="${p.productName}"/>
                                </c:when>
                                <c:when test="${not empty p.image}">
                                    <c:url value="/image" var="imgUrl">
                                        <c:param name="fname" value="${p.image}"/>
                                    </c:url>
                                    <img src="${imgUrl}" alt="${p.productName}"/>
                                </c:when>
                                <c:otherwise>
                                    📷 Không có ảnh
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-body">
                            <div class="card-title">${p.productName}</div>
                            <div class="card-category">${p.category != null ? p.category.categoryname : ''}</div>
                            <div class="card-price"><fmt:formatNumber value="${p.price}" type="number" groupingUsed="true"/>đ</div>
                        </div>
                    </a>
                </c:forEach>
            </div>

            <!-- PAGINATION -->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/product?page=${currentPage - 1}">&laquo; Trước</a>
                </c:if>
                <c:if test="${currentPage <= 1}">
                    <span class="disabled">&laquo; Trước</span>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="i">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="current">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/product?page=${i}">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/product?page=${currentPage + 1}">Sau &raquo;</a>
                </c:if>
                <c:if test="${currentPage >= totalPages}">
                    <span class="disabled">Sau &raquo;</span>
                </c:if>
            </div>
        </c:if>

        <c:if test="${empty products}">
            <div class="empty-msg">Không có sản phẩm nào.</div>
        </c:if>
    </div>
</body>
</html>
