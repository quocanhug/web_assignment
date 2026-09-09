<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Thêm sản phẩm</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 20px;
                    background: #f5f5f5;
                }

                .container {
                    max-width: 600px;
                    margin: 0 auto;
                    background: white;
                    padding: 30px;
                    border-radius: 8px;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }

                h1 {
                    color: #333;
                    text-align: center;
                }

                label {
                    display: block;
                    margin-top: 15px;
                    font-weight: bold;
                    color: #555;
                }

                input[type="text"],
                input[type="number"],
                input[type="file"],
                textarea,
                select {
                    width: 100%;
                    padding: 10px;
                    margin-top: 5px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    box-sizing: border-box;
                }

                textarea {
                    height: 100px;
                    resize: vertical;
                }

                .radio-group {
                    margin-top: 5px;
                }

                .radio-group label {
                    display: inline;
                    font-weight: normal;
                    margin-right: 20px;
                }

                .btn {
                    padding: 10px 20px;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                    color: white;
                    font-size: 14px;
                    margin-top: 20px;
                    margin-right: 10px;
                }

                .btn-submit {
                    background: #4CAF50;
                }

                .btn-reset {
                    background: #2196F3;
                }

                .back-link {
                    display: inline-block;
                    margin-bottom: 15px;
                    color: #666;
                    text-decoration: none;
                }

                *[id$=".errors"] {
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
                <a class="back-link" href="${pageContext.request.contextPath}/admin/products">&larr; Quay lại danh
                    sách</a>
                <h1>Thêm sản phẩm</h1>

                <form action="<c:url value=" /admin/product/insert" />" method="post" enctype="multipart/form-data">

                <label>Tên sản phẩm: <span style="color:red;">*</span></label>
                <input type="text" name="productName" value="${not empty productName ? productName : param.productName}"
                    placeholder="Nhập tên sản phẩm" required />
                <span id="productName.errors">${errors.productName}</span>

                <label>Giá (VNĐ): <span style="color:red;">*</span></label>
                <input type="number" name="price" value="${not empty price ? price : param.price}"
                    placeholder="Nhập giá sản phẩm (>= 0)" step="1000" min="0" required />
                <span id="price.errors">${errors.price}</span>

                <label>Mô tả:</label>
                <textarea name="description"
                    placeholder="Nhập mô tả sản phẩm">${not empty description ? description : param.description}</textarea>

                <label>Danh mục: <span style="color:red;">*</span></label>
                <select name="cateId" required>
                    <option value="">-- Chọn danh mục --</option>
                    <c:forEach items="${categories}" var="cate">
                        <option value="${cate.categoryid}" ${cateId==cate.categoryid ? 'selected' : '' }>
                            ${cate.categoryname}</option>
                    </c:forEach>
                </select>
                <span id="cateId.errors">${errors.cateId}</span>

                <label>Link ảnh (URL):</label>
                <input type="text" name="imageUrl" value="${not empty imageUrl ? imageUrl : param.imageUrl}"
                    placeholder="https://... (tùy chọn)" />

                <label>Upload ảnh:</label>
                <input type="file" name="imageFile" accept="image/*" />
                <span id="imageFile.errors">${errors.imageFile}</span>

                <label>Trạng thái:</label>
                <div class="radio-group">
                    <input type="radio" name="status" value="1" ${empty status || status==1 ? 'checked' : '' }>
                    <label>Hoạt động</label>
                    <input type="radio" name="status" value="0" ${status==0 ? 'checked' : '' }>
                    <label>Khóa</label>
                </div>

                <div>
                    <button type="submit" class="btn btn-submit">Thêm</button>
                    <button type="reset" class="btn btn-reset">Hủy</button>
                </div>
                </form>
            </div>
        </body>

        </html>