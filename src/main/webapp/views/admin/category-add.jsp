<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Thêm Category</title>
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
                input[type="file"] {
                    width: 100%;
                    padding: 10px;
                    margin-top: 5px;
                    border: 1px solid #ccc;
                    border-radius: 4px;
                    box-sizing: border-box;
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
                <a class="back-link" href="${pageContext.request.contextPath}/admin/categories">&larr; Quay lại danh
                    sách</a>
                <h1>Thêm Category</h1>

                <form action="<c:url value=" /admin/category/insert" />" method="post" enctype="multipart/form-data">

                <label>Tên danh mục: <span style="color:red;">*</span></label>
                <input type="text" name="categoryname"
                    value="${not empty categoryname ? categoryname : param.categoryname}"
                    placeholder="Nhập tên danh mục" required />
                <span id="categoryname.errors">${errors.categoryname}</span>

                <label>Link ảnh (URL):</label>
                <input type="text" name="images" value="${not empty images ? images : param.images}"
                    placeholder="https://... (tùy chọn)" />

                <label>Upload ảnh:</label>
                <input type="file" name="images1" accept="image/*" />
                <span id="images1.errors">${errors.images1}</span>

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