<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><sitemesh:write property='title'/></title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; min-height: 100vh; display: flex; flex-direction: column; }

        /* === NAVBAR === */
        .navbar { background: linear-gradient(135deg, #667eea, #764ba2); padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.2); }
        .navbar .logo { color: white; font-size: 22px; font-weight: bold; text-decoration: none; }
        .navbar .nav-links { display: flex; gap: 15px; align-items: center; }
        .navbar .nav-links a { color: white; text-decoration: none; font-size: 14px; padding: 8px 16px; border-radius: 20px; transition: all 0.3s; }
        .navbar .nav-links a:hover { background: rgba(255,255,255,0.2); }
        .navbar .nav-links a.active { background: rgba(255,255,255,0.3); }

        /* === MAIN CONTENT === */
        .main-content { flex: 1; }

        /* === FOOTER === */
        .footer { background: #2c3e50; color: #aaa; text-align: center; padding: 20px; font-size: 13px; margin-top: auto; }
        .footer a { color: #667eea; text-decoration: none; }
        .footer a:hover { text-decoration: underline; }
    </style>
    <sitemesh:write property='head'/>
</head>
<body>
    <!-- NAVBAR CHUNG -->
    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="logo">🛒 WebShop</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
            <a href="${pageContext.request.contextPath}/product">Sản phẩm</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/account/profile">👤 ${sessionScope.user.fullname}</a>
                    <a href="${pageContext.request.contextPath}/account/logout">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/account/login">Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/account/register">Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- NỘI DUNG TRANG -->
    <div class="main-content">
        <sitemesh:write property='body'/>
    </div>

    <!-- FOOTER CHUNG -->
    <div class="footer">
        <p>© 2026 WebShop - Bài tập Lập trình Web | <a href="${pageContext.request.contextPath}/">Trang chủ</a></p>
    </div>
</body>
</html>
