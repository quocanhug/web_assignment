<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Sửa Category</title>
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

                .current-img {
                    margin-top: 10px;
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
                <h1>Sửa Category</h1>

                <form action="<c:url value=" /admin/category/update" />" method="post" enctype="multipart/form-data">
                <input type="hidden" name="categoryid" value="${cate.categoryid}" />

                <label>Tên danh mục: <span style="color:red;">*</span></label>
                <input type="text" name="categoryname" value="${cate.categoryname}" required />
                <span id="categoryname.errors">${errors.categoryname}</span>

                <label>Link ảnh (URL):</label>
                <input type="text" name="images" value="${cate.images}" />

                <label>Ảnh hiện tại:</label>
                <div class="current-img">
                    <c:choose>
                        <c:when
                            test="${not empty cate.images && cate.images.length() >= 5 && cate.images.substring(0,5) == 'https'}">
                            <img height="150" width="200" src="${cate.images}" />
                        </c:when>
                        <c:when test="${not empty cate.images}">
                            <c:url value="/image" var="imgUrl">
                                <c:param name="fname" value="${cate.images}" />
                            </c:url>
                            <img height="150" width="200" src="${imgUrl}" />
                        </c:when>
                        <c:otherwise>
                            <span style="color:#999;">Chưa có ảnh</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <label>Upload ảnh mới:</label>
                <input type="file" name="images1" accept="image/*" />
                <span id="images1.errors">${errors.images1}</span>

                <label>Trạng thái:</label>
                <div class="radio-group">
                    <input type="radio" name="status" value="1" ${cate.status==1 ? 'checked' : '' }>
                    <label>Hoạt động</label>
                    <input type="radio" name="status" value="0" ${cate.status !=1 ? 'checked' : '' }>
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