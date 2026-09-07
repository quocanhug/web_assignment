<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang chủ - WebShop</title>
    <style>
        /* === HERO SECTION === */
        .hero { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; text-align: center; padding: 60px 20px 40px; }
        .hero h1 { font-size: 36px; margin-bottom: 10px; }
        .hero p { font-size: 16px; opacity: 0.9; }

        /* === PRODUCT SECTION === */
        .section { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .section-title { font-size: 24px; color: #333; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 3px solid #667eea; display: inline-block; }

        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; }

        .product-card { background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 15px rgba(0,0,0,0.08); transition: all 0.3s; cursor: pointer; text-decoration: none; color: inherit; display: block; }
        .product-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.15); }
        .product-card .card-img { width: 100%; height: 200px; object-fit: cover; background: #eee; display: flex; align-items: center; justify-content: center; color: #999; font-size: 14px; }
        .product-card .card-img img { width: 100%; height: 100%; object-fit: cover; }
        .product-card .card-body { padding: 15px; }
        .product-card .card-title { font-size: 16px; font-weight: bold; color: #333; margin-bottom: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .product-card .card-category { font-size: 12px; color: #888; margin-bottom: 8px; }
        .product-card .card-price { font-size: 18px; font-weight: bold; color: #e74c3c; }

        .view-all { text-align: center; margin-top: 30px; }
        .view-all a { display: inline-block; padding: 12px 40px; background: linear-gradient(135deg, #667eea, #764ba2); color: white; text-decoration: none; border-radius: 25px; font-weight: bold; transition: all 0.3s; }
        .view-all a:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }

        .empty-msg { text-align: center; color: #999; padding: 40px; font-size: 16px; }
    </style>
</head>
<body>
    <!-- HERO -->
    <div class="hero">
        <h1>Chào mừng đến WebShop</h1>
        <p>Khám phá những sản phẩm công nghệ mới nhất</p>
    </div>

    <!-- SẢN PHẨM MỚI NHẤT -->
    <div class="section">
        <h2 class="section-title">🔥 Sản phẩm mới nhất</h2>

        <c:if test="${not empty latestProducts}">
            <div class="product-grid">
                <c:forEach items="${latestProducts}" var="p">
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

            <div class="view-all">
                <a href="${pageContext.request.contextPath}/product">Xem tất cả sản phẩm →</a>
            </div>
        </c:if>

        <c:if test="${empty latestProducts}">
            <div class="empty-msg">Chưa có sản phẩm nào.</div>
        </c:if>
    </div>
</body>
</html>
