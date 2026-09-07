<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${product.productName} - WebShop</title>
    <style>
        /* === BREADCRUMB === */
        .breadcrumb { max-width: 1000px; margin: 20px auto 0; padding: 0 20px; font-size: 14px; color: #888; }
        .breadcrumb a { color: #667eea; text-decoration: none; }
        .breadcrumb a:hover { text-decoration: underline; }

        /* === PRODUCT DETAIL === */
        .product-detail { max-width: 1000px; margin: 20px auto; padding: 0 20px; }
        .detail-card { background: white; border-radius: 12px; box-shadow: 0 2px 20px rgba(0,0,0,0.08); overflow: hidden; display: flex; }
        .detail-img { flex: 0 0 400px; height: 400px; background: #eee; display: flex; align-items: center; justify-content: center; color: #999; font-size: 16px; }
        .detail-img img { width: 100%; height: 100%; object-fit: cover; }
        .detail-info { flex: 1; padding: 30px; }
        .detail-info h1 { font-size: 24px; color: #333; margin-bottom: 10px; }
        .detail-category { font-size: 14px; color: #667eea; background: #f0f0ff; padding: 4px 12px; border-radius: 15px; display: inline-block; margin-bottom: 15px; }
        .detail-price { font-size: 28px; font-weight: bold; color: #e74c3c; margin-bottom: 20px; }
        .detail-description { font-size: 15px; color: #555; line-height: 1.7; margin-bottom: 20px; }
        .detail-description h3 { color: #333; margin-bottom: 8px; font-size: 16px; }
        .detail-meta { font-size: 13px; color: #aaa; border-top: 1px solid #eee; padding-top: 15px; }
        .detail-meta span { margin-right: 20px; }

        .back-btn { display: inline-block; margin-top: 20px; padding: 10px 25px; background: linear-gradient(135deg, #667eea, #764ba2); color: white; text-decoration: none; border-radius: 25px; font-size: 14px; transition: all 0.3s; }
        .back-btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
    </style>
</head>
<body>

    <!-- BREADCRUMB -->
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/home">Trang chủ</a> /
        <a href="${pageContext.request.contextPath}/product">Sản phẩm</a> /
        ${product.productName}
    </div>

    <!-- PRODUCT DETAIL -->
    <div class="product-detail">
        <div class="detail-card">
            <div class="detail-img">
                <c:choose>
                    <c:when test="${not empty product.image && product.image.length() >= 5 && product.image.substring(0,5) == 'https'}">
                        <img src="${product.image}" alt="${product.productName}"/>
                    </c:when>
                    <c:when test="${not empty product.image}">
                        <c:url value="/image" var="imgUrl">
                            <c:param name="fname" value="${product.image}"/>
                        </c:url>
                        <img src="${imgUrl}" alt="${product.productName}"/>
                    </c:when>
                    <c:otherwise>
                        📷 Không có ảnh
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="detail-info">
                <h1>${product.productName}</h1>

                <c:if test="${product.category != null}">
                    <span class="detail-category">${product.category.categoryname}</span>
                </c:if>

                <div class="detail-price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ</div>

                <div class="detail-description">
                    <h3>Mô tả sản phẩm</h3>
                    <c:choose>
                        <c:when test="${not empty product.description}">
                            ${product.description}
                        </c:when>
                        <c:otherwise>
                            <span style="color:#999;">Chưa có mô tả cho sản phẩm này.</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="detail-meta">
                    <span>Trạng thái: <strong style="color: ${product.status == 1 ? 'green' : 'red'};">${product.status == 1 ? 'Còn hàng' : 'Hết hàng'}</strong></span>
                    <c:if test="${not empty product.createdDate}">
                        <span>Ngày đăng: <fmt:formatDate value="${product.createdDate}" pattern="dd/MM/yyyy"/></span>
                    </c:if>
                </div>

                <a href="${pageContext.request.contextPath}/product" class="back-btn">← Quay lại danh sách</a>
            </div>
        </div>
    </div>
</body>
</html>
