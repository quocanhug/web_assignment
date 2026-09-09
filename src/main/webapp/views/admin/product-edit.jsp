<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa sản phẩm</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; text-align: center; }
        label { display: block; margin-top: 15px; font-weight: bold; color: #555; }
        input[type="text"], input[type="number"], input[type="file"], textarea, select { width: 100%; padding: 10px; margin-top: 5px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        textarea { height: 100px; resize: vertical; }
        .radio-group { margin-top: 5px; }
        .radio-group label { display: inline; font-weight: normal; margin-right: 20px; }
        .btn { padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; color: white; font-size: 14px; margin-top: 20px; margin-right: 10px; }
        .btn-submit { background: #4CAF50; }
        .btn-reset { background: #2196F3; }
        .back-link { display: inline-block; margin-bottom: 15px; color: #666; text-decoration: none; }
        .current-img { margin-top: 10px; }

        *[id$=.errors] {
            color: #dc3545;
            font-style: italic;
            font-size: 13px;
            margin-top: 4px;
            display: block;
        }
    </style>
</head>
<body>
    <div class="container">
        <a class="back-link" href="${pageContext.request.contextPath}/admin/products">&larr; Quay lại danh sách</a>
        <h1>Sửa sản phẩm</h1>

        <form action="<c:url value="/admin/product/update"/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="${product.productId}"/>

            <label>Tên sản phẩm: <span style="color:red;">*</span></label>
            <input type="text" name="productName" value="${product.productName}" required/>
            <span id="productName.errors">${errors.productName}</span>

            <label>Giá (VNĐ): <span style="color:red;">*</span></label>
            <input type="number" name="price" value="${product.price}" step="1000" min="0" required/>
            <span id="price.errors">${errors.price}</span>

            <label>Mô tả:</label>
            <textarea name="description">${product.description}</textarea>

            <label>Danh mục: <span style="color:red;">*</span></label>
            <select name="cateId" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach items="${categories}" var="cate">
                    <option value="${cate.categoryid}" ${product.category != null && product.category.categoryid == cate.categoryid ? 'selected' : ''}>${cate.categoryname}</option>
                </c:forEach>
            </select>
            <span id="cateId.errors">${errors.cateId}</span>

            <label>Link ảnh (URL):</label>
            <input type="text" name="imageUrl" value="${product.image}"/>

            <label>Ảnh hiện tại:</label>
            <div class="current-img">
                <c:choose>
                    <c:when test="${not empty product.image && product.image.length() >= 5 && product.image.substring(0,5) == 'https'}">
                        <img height="150" width="200" src="${product.image}" style="object-fit:cover; border-radius:4px;"/>
                    </c:when>
                    <c:when test="${not empty product.image}">
                        <c:url value="/image" var="imgUrl">
                            <c:param name="fname" value="${product.image}"/>
                        </c:url>
                        <img height="150" width="200" src="${imgUrl}" style="object-fit:cover; border-radius:4px;"/>
                    </c:when>
                    <c:otherwise>
                        <span style="color:#999;">Chưa có ảnh</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <label>Upload ảnh mới:</label>
            <input type="file" name="imageFile" accept="image/*"/>
            <span id="imageFile.errors">${errors.imageFile}</span>

            <label>Trạng thái:</label>
            <div class="radio-group">
                <input type="radio" name="status" value="1" ${product.status == 1 ? 'checked' : ''}>
                <label>Hoạt động</label>
                <input type="radio" name="status" value="0" ${product.status != 1 ? 'checked' : ''}>
                <label>Khóa</label>
            </div>

            <div>
                <button type="submit" class="btn btn-submit">Cập nhật</button>
                <button type="reset" class="btn btn-reset">Reset</button>
            </div>
        </form>
    </div>
</body>
</html>
