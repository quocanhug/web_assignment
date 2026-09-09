<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Đăng ký tài khoản</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 40px;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    min-height: 100vh;
                }

                .container {
                    max-width: 480px;
                    margin: 0 auto;
                    background: white;
                    padding: 40px;
                    border-radius: 12px;
                    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
                }

                h2 {
                    text-align: center;
                    color: #333;
                    margin-bottom: 25px;
                }

                label {
                    display: block;
                    margin-top: 15px;
                    font-weight: bold;
                    color: #555;
                    font-size: 14px;
                }

                input[type="text"],
                input[type="email"],
                input[type="password"],
                input[type="tel"] {
                    width: 100%;
                    padding: 12px;
                    margin-top: 5px;
                    border: 1px solid #ddd;
                    border-radius: 6px;
                    box-sizing: border-box;
                    font-size: 14px;
                    transition: border-color 0.3s;
                }

                input:focus {
                    outline: none;
                    border-color: #667eea;
                    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                }

                .btn {
                    width: 100%;
                    padding: 12px;
                    border: none;
                    border-radius: 6px;
                    cursor: pointer;
                    font-size: 16px;
                    font-weight: bold;
                    margin-top: 25px;
                    transition: all 0.3s;
                }

                .btn-submit {
                    background: linear-gradient(135deg, #667eea, #764ba2);
                    color: white;
                }

                .btn-submit:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                }

                .error {
                    color: #e74c3c;
                    text-align: center;
                    margin-bottom: 15px;
                    padding: 10px;
                    background: #ffeaea;
                    border-radius: 6px;
                    font-size: 14px;
                }

                .links {
                    text-align: center;
                    margin-top: 20px;
                    font-size: 14px;
                }

                .links a {
                    color: #667eea;
                    text-decoration: none;
                    font-weight: bold;
                }

                .links a:hover {
                    text-decoration: underline;
                }

                *[id$=".errors"] {
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
                <h2>Đăng ký tài khoản</h2>

                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/account/register" method="post">
                    <label>Họ và tên: <span style="color:red;">*</span></label>
                    <input type="text" name="fullname" value="${not empty fullname ? fullname : param.fullname}"
                        placeholder="Nhập họ và tên" required />
                    <span id="fullname.errors">${errors.fullname}</span>

                    <label>Email: <span style="color:red;">*</span></label>
                    <input type="email" name="email" value="${not empty email ? email : param.email}"
                        placeholder="Nhập email" required />
                    <span id="email.errors">${errors.email}</span>

                    <label>Số điện thoại:</label>
                    <input type="tel" name="phone" value="${not empty phone ? phone : param.phone}"
                        placeholder="Ví dụ: 0912345678" />
                    <span id="phone.errors">${errors.phone}</span>

                    <label>Mật khẩu: <span style="color:red;">*</span></label>
                    <input type="password" name="password" placeholder="Tối thiểu 6 ký tự" required />
                    <span id="password.errors">${errors.password}</span>

                    <label>Xác nhận mật khẩu: <span style="color:red;">*</span></label>
                    <input type="password" name="confirmPassword" placeholder="Nhập lại mật khẩu" required />
                    <span id="confirmPassword.errors">${errors.confirmPassword}</span>

                    <button type="submit" class="btn btn-submit">Đăng ký</button>
                </form>

                <div class="links">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/account/login">Đăng nhập</a>
                </div>
            </div>
        </body>

        </html>