<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 40px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .container { max-width: 420px; margin: 0 auto; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); text-align: center; }
        h2 { color: #333; margin-bottom: 10px; }
        .subtitle { color: #777; font-size: 14px; margin-bottom: 25px; }
        label { display: block; text-align: left; margin-top: 15px; font-weight: bold; color: #555; font-size: 14px; }
        input[type="email"] { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-size: 14px; transition: border-color 0.3s; }
        input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.1); }
        .btn { width: 100%; padding: 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 20px; transition: all 0.3s; }
        .btn-submit { background: linear-gradient(135deg, #667eea, #764ba2); color: white; }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .error { color: #e74c3c; margin-bottom: 15px; padding: 10px; background: #ffeaea; border-radius: 6px; font-size: 14px; }
        .links { text-align: center; margin-top: 20px; font-size: 14px; }
        .links a { color: #667eea; text-decoration: none; font-weight: bold; }
        .links a:hover { text-decoration: underline; }
        .icon { font-size: 48px; margin-bottom: 10px; }

        *[id$=.errors] {
            color: #dc3545;
            font-style: italic;
            font-size: 13px;
            margin-top: 4px;
            display: block;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">🔒</div>
        <h2>Quên mật khẩu</h2>
        <p class="subtitle">Nhập email của bạn, chúng tôi sẽ gửi mã OTP để đặt lại mật khẩu</p>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/account/forgot-password" method="post">
            <input type="email" name="email" value="${not empty email ? email : param.email}" placeholder="Nhập email đã đăng ký" required/>
            <span id="email.errors">${errors.email}</span>

            <button type="submit" class="btn btn-submit">Gửi mã OTP</button>
        </form>

        <div class="links">
            <a href="${pageContext.request.contextPath}/account/login">← Quay lại đăng nhập</a>
        </div>
    </div>
</body>
</html>
