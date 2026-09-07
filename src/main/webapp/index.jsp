<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Web Assignment - Servlet JPA</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
        h1 { color: #333; }
        .menu { list-style: none; padding: 0; }
        .menu li { margin: 12px 0; }
        .menu a { display: inline-block; padding: 12px 30px; color: white; text-decoration: none; border-radius: 4px; font-size: 16px; min-width: 280px; transition: all 0.3s; }
        .menu a:hover { opacity: 0.85; transform: translateY(-1px); }
        .menu a.green { background: #4CAF50; }
        .menu a.blue { background: #2196F3; }
        .menu a.purple { background: linear-gradient(135deg, #667eea, #764ba2); }
        .menu a.orange { background: #FF9800; }
        .menu a.red { background: #e74c3c; }
        .section-title { color: #888; font-size: 13px; text-transform: uppercase; margin-top: 25px; margin-bottom: 5px; letter-spacing: 1px; }
        hr { border: none; border-top: 1px solid #eee; margin: 10px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Web Assignment</h1>
        <p>Lập trình Web - Servlet + JPA/Hibernate</p>

        <p class="section-title">Trang công khai</p>
        <hr>
        <ul class="menu">
            <li><a class="purple" href="${pageContext.request.contextPath}/home">🏠 Trang chủ</a></li>
            <li><a class="purple" href="${pageContext.request.contextPath}/product">📦 Tất cả sản phẩm</a></li>
        </ul>

        <p class="section-title">Tài khoản</p>
        <hr>
        <ul class="menu">
            <li><a class="green" href="${pageContext.request.contextPath}/account/login">🔐 Đăng nhập</a></li>
            <li><a class="green" href="${pageContext.request.contextPath}/account/register">📝 Đăng ký</a></li>
            <li><a class="purple" href="${pageContext.request.contextPath}/account/profile">👤 Hồ sơ cá nhân (Profile)</a></li>
        </ul>

        <p class="section-title">Quản trị</p>
        <hr>
        <ul class="menu">
            <li><a class="blue" href="${pageContext.request.contextPath}/admin/categories">📂 Quản lý Category</a></li>
            <li><a class="orange" href="${pageContext.request.contextPath}/admin/products">📦 Quản lý Product</a></li>
        </ul>

        <p class="section-title">Demo cũ</p>
        <hr>
        <ul class="menu">
            <li><a class="red" href="${pageContext.request.contextPath}/login.html">🍪 Login Cookie & Session</a></li>
        </ul>
    </div>
</body>
</html>
