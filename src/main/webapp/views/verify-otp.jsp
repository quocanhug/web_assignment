<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận OTP</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 40px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .container { max-width: 420px; margin: 0 auto; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); text-align: center; }
        h2 { color: #333; margin-bottom: 10px; }
        .subtitle { color: #777; font-size: 14px; margin-bottom: 25px; }
        .email-display { background: #f0f0f0; padding: 8px 16px; border-radius: 20px; display: inline-block; font-size: 14px; color: #555; margin-bottom: 20px; }
        input[type="text"] { width: 100%; padding: 15px; border: 2px solid #ddd; border-radius: 8px; box-sizing: border-box; font-size: 24px; text-align: center; letter-spacing: 8px; font-weight: bold; transition: border-color 0.3s; }
        input[type="text"]:focus { outline: none; border-color: #667eea; }
        .btn { width: 100%; padding: 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 20px; transition: all 0.3s; }
        .btn-submit { background: linear-gradient(135deg, #667eea, #764ba2); color: white; }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .error { color: #e74c3c; margin-bottom: 15px; padding: 10px; background: #ffeaea; border-radius: 6px; font-size: 14px; }
        .success { color: #27ae60; margin-bottom: 15px; padding: 10px; background: #eafff0; border-radius: 6px; font-size: 14px; }
        .icon { font-size: 48px; margin-bottom: 10px; }

        *[id$=.errors] {
            color: #dc3545;
            font-style: italic;
            font-size: 13px;
            margin-top: 6px;
            display: block;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon">📧</div>
        <h2>Xác nhận mã OTP</h2>
        <p class="subtitle">Chúng tôi đã gửi mã xác nhận 6 số đến email của bạn</p>

        <c:if test="${not empty email}">
            <div class="email-display">${email}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/account/verify" method="post">
            <input type="hidden" name="email" value="${email}"/>
            <input type="text" name="otp" value="${not empty otp ? otp : param.otp}" maxlength="6" placeholder="000000" required autofocus/>
            <span id="otp.errors">${errors.otp}</span>

            <button type="submit" class="btn btn-submit">Xác nhận</button>
        </form>
    </div>
</body>
</html>
