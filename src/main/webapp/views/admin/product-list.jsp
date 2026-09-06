<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sản phẩm</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1100px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; text-align: center; }
        .btn { padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; color: white; font-size: 14px; }
        .btn-add { background: #4CAF50; margin-bottom: 20px; display: inline-block; }
        .btn-edit { background: #2196F3; }
        .btn-delete { background: #f44336; }
        .btn:hover { opacity: 0.85; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { background: #949494; color: white; padding: 12px 8px; text-align: left; }
        td { padding: 10px 8px; border-bottom: 1px solid #ddd; vertical-align: middle; }
        tr:hover { background: #f0f0f0; }
        .actions a { margin-right: 8px; }
        .home-link { display: inline-block; margin-bottom: 15px; color: #666; text-decoration: none; }
        .status-active { color: green; font-weight: bold; }
        .status-locked { color: red; font-weight: bold; }
        .price { color: #e74c3c; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <a class="home-link" href="${pageContext.request.contextPath}/">&larr; Về trang chính</a>
        <h1>Quản lý Sản phẩm (JPA)</h1>

        <a class="btn btn-add" href="<c:url value="/admin/product/add"/>">+ Thêm sản phẩm</a>
        <hr>

        <table>
            <tr>
                <th>STT</th>
                <th>Hình ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Giá</th>
                <th>Danh mục</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
            <c:forEach items="${listProduct}" var="product" varStatus="STT">
                <tr>
                    <td>${STT.index + 1}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty product.image && product.image.length() >= 5 && product.image.substring(0,5) == 'https'}">
                                <img height="60" width="60" src="${product.image}" style="object-fit:cover; border-radius:4px;"/>
                            </c:when>
                            <c:when test="${not empty product.image}">
                                <c:url value="/image" var="imgUrl">
                                    <c:param name="fname" value="${product.image}"/>
                                </c:url>
                                <img height="60" width="60" src="${imgUrl}" style="object-fit:cover; border-radius:4px;"/>
                            </c:when>
                            <c:otherwise>
                                <span style="color:#999;">Không có ảnh</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${product.productName}</td>
                    <td class="price"><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true"/>đ</td>
                    <td>${product.category != null ? product.category.categoryname : 'N/A'}</td>
                    <td>
                        <c:if test="${product.status == 1}">
                            <span class="status-active">Hoạt động</span>
                        </c:if>
                        <c:if test="${product.status != 1}">
                            <span class="status-locked">Khóa</span>
                        </c:if>
                    </td>
                    <td class="actions">
                        <a class="btn btn-edit" href="<c:url value='/admin/product/edit?id=${product.productId}'/>">Sửa</a>
                        <a class="btn btn-delete" href="<c:url value='/admin/product/delete?id=${product.productId}'/>"
                           onclick="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty listProduct}">
                <tr><td colspan="7" style="text-align:center; color:#999;">Chưa có sản phẩm nào.</td></tr>
            </c:if>
        </table>
    </div>
</body>
</html>
