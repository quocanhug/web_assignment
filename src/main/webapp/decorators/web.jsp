<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>
                <sitemesh:write property="title" />
            </title>
            <!-- Bootstrap 5 CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <!-- Bootstrap Icons -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
                rel="stylesheet">
            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
                rel="stylesheet">
            <style>
                body {
                    font-family: 'Roboto', Arial, sans-serif;
                }

                .hover-white:hover {
                    color: #fff !important;
                }

                *[id$=".errors"] {
                    color: #dc3545;
                    font-style: italic;
                    font-size: 0.875rem;
                    margin-top: 0.25rem;
                    display: block;
                }
            </style>
            <sitemesh:write property="head" />
        </head>

        <body class="d-flex flex-column min-vh-100 bg-light">
            <!-- Header chung -->
            <div>
                <%@include file="/commons/web/header.jsp" %>
            </div>

            <!-- Content riêng cho từng trang -->
            <main class="flex-grow-1">
                <c:if test="${not empty sessionScope.success}">
                    <div class="container mt-3">
                        <div class="alert alert-success alert-dismissible fade show text-center shadow-sm" role="alert">
                            <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </div>
                    <c:remove var="success" scope="session" />
                </c:if>
                <sitemesh:write property="body" />
            </main>

            <!-- Footer chung -->
            <div>
                <%@include file="/commons/web/footer.jsp" %>
            </div>

            <!-- Bootstrap 5 JS Bundle with Popper -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>