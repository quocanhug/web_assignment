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
        .menu li { margin: 15px 0; }
        .menu a { display: inline-block; padding: 12px 30px; background: #4CAF50; color: white; text-decoration: none; border-radius: 4px; font-size: 16px; min-width: 250px; }
        .menu a:hover { background: #45a049; }
        .menu a.blue { background: #2196F3; }
        .menu a.blue:hover { background: #1976D2; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Web Assignment</h1>
        <p>Lập trình Web - Servlet + JPA/Hibernate</p>
        <ul class="menu">
            <li><a href="${pageContext.request.contextPath}/login.html">Login (Cookie & Session)</a></li>
            <li><a class="blue" href="${pageContext.request.contextPath}/admin/categories">CRUD Category (JPA)</a></li>
        </ul>
    </div>
</body>
</html>
