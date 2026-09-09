<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Đăng nhập</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    margin: 0;
                    padding: 40px;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    min-height: 100vh;
                }

                .container {
                    max-width: 420px;
                    margin: 0 auto;
                    background: white;
                    padding: 40px;
                    border-radius: 12px;
                    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
                }

                h2 {
                    text-align: center;
                    color: #333;
                    margin-bottom: 30px;
                }

                label {
                    display: block;
                    margin-top: 15px;
                    font-weight: bold;
                    color: #555;
                    font-size: 14px;
                }

                input[type="email"],
                input[type="password"] {
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

                .success {
                    color: #27ae60;
                    text-align: center;
                    margin-bottom: 15px;
                    padding: 10px;
                    background: #eafff0;
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
                    margin: 0 10px;
                }

                .links a:hover {
                    text-decoration: underline;
                }

                .divider {
                    border-top: 1px solid #eee;
                    margin: 15px 0;
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
                <h2>Đăng nhập</h2>

                <c:if test="${not empty success}">
                    <div class="success">${success}</div>
                    <c:remove var="success" scope="session" />
                </c:if>
                <c:if test="${not empty error}">
                    <div class="error">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/account/login" method="post">
                    <label>Email:</label>
                    <input type="email" name="email" value="${not empty email ? email : param.email}"
                        placeholder="Nhập email" required />
                    <span id="email.errors">${errors.email}</span>

                    <label>Mật khẩu:</label>
                    <input type="password" name="password" placeholder="Nhập mật khẩu" required />
                    <span id="password.errors">${errors.password}</span>

                    <button type="submit" class="btn btn-submit">Đăng nhập</button>
                </form>

                <div class="links">
                    <a href="${pageContext.request.contextPath}/account/forgot-password">Quên mật khẩu?</a>
                </div>
                <div class="divider"></div>
                <div class="links">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/account/register">Đăng ký</a>
                </div>
            </div>
        </body>

        </html>