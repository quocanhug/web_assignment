<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 40px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
        .container { max-width: 420px; margin: 0 auto; background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 40px rgba(0,0,0,0.2); text-align: center; }
        h2 { color: #333; margin-bottom: 10px; }
        .subtitle { color: #777; font-size: 14px; margin-bottom: 25px; }
        .email-display { background: #f0f0f0; padding: 8px 16px; border-radius: 20px; display: inline-block; font-size: 14px; color: #555; margin-bottom: 20px; }
        label { display: block; text-align: left; margin-top: 15px; font-weight: bold; color: #555; font-size: 14px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 12px; margin-top: 5px; border: 1px solid #ddd; border-radius: 6px; box-sizing: border-box; font-size: 14px; transition: border-color 0.3s; }
        input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.1); }
        .otp-input { font-size: 24px; text-align: center; letter-spacing: 8px; font-weight: bold; }
        .btn { width: 100%; padding: 12px; border: none; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 20px; transition: all 0.3s; }
        .btn-submit { background: linear-gradient(135deg, #667eea, #764ba2); color: white; }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }
        .error { color: #e74c3c; margin-bottom: 15px; padding: 10px; background: #ffeaea; border-radius: 6px; font-size: 14px; }
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
        <div class="icon">🔑</div>
        <h2>Đặt lại mật khẩu</h2>
        <p class="subtitle">Nhập mã OTP đã gửi đến email và mật khẩu mới</p>

        <c:if test="${not empty email}">
            <div class="email-display">${email}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/account/reset-password" method="post">
            <input type="hidden" name="email" value="${email}"/>

            <label>Mã OTP: <span style="color:red;">*</span></label>
            <input type="text" name="otp" value="${not empty otp ? otp : param.otp}" maxlength="6" placeholder="000000" class="otp-input" required autofocus/>
            <span id="otp.errors">${errors.otp}</span>

            <label>Mật khẩu mới: <span style="color:red;">*</span></label>
            <input type="password" name="newPassword" placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)" required/>
            <span id="newPassword.errors">${errors.newPassword}</span>

            <label>Xác nhận mật khẩu mới: <span style="color:red;">*</span></label>
            <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu mới" required/>
            <span id="confirmPassword.errors">${errors.confirmPassword}</span>

            <button type="submit" class="btn btn-submit">Đặt lại mật khẩu</button>
        </form>
    </div>
</body>
</html>
