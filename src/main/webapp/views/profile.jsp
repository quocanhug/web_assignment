<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân - WebShop</title>
    <style>
        .profile-container { max-width: 600px; margin: 40px auto; padding: 0 20px; }
        .profile-card { background: white; border-radius: 12px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); overflow: hidden; }
        .profile-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; text-align: center; padding: 40px 20px 30px; }
        .profile-avatar { width: 120px; height: 120px; border-radius: 50%; border: 4px solid rgba(255,255,255,0.5); object-fit: cover; background: rgba(255,255,255,0.2); display: inline-flex; align-items: center; justify-content: center; overflow: hidden; }
        .profile-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .profile-avatar .no-avatar { font-size: 48px; color: rgba(255,255,255,0.8); }
        .profile-header h2 { margin: 15px 0 5px; font-size: 22px; }
        .profile-header p { opacity: 0.85; font-size: 14px; }

        .profile-form { padding: 30px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: bold; color: #555; margin-bottom: 6px; font-size: 14px; }
        .form-group input[type="text"], .form-group input[type="email"] {
            width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px;
            box-sizing: border-box; font-size: 14px; transition: border-color 0.3s;
        }
        .form-group input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.1); }
        .form-group input[readonly] { background: #f5f5f5; color: #888; cursor: not-allowed; }

        .file-upload { position: relative; }
        .file-upload input[type="file"] { width: 100%; padding: 10px; border: 2px dashed #ddd; border-radius: 8px; cursor: pointer; font-size: 13px; background: #fafafa; transition: border-color 0.3s; }
        .file-upload input[type="file"]:hover { border-color: #667eea; }
        .file-hint { font-size: 12px; color: #999; margin-top: 4px; }

        .btn-save { width: 100%; padding: 14px; border: none; border-radius: 8px; cursor: pointer; font-size: 16px; font-weight: bold;
            background: linear-gradient(135deg, #667eea, #764ba2); color: white; transition: all 0.3s; }
        .btn-save:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(102,126,234,0.4); }

        .alert-success { color: #27ae60; background: #eafff0; padding: 12px; border-radius: 8px; text-align: center; margin-bottom: 20px; font-size: 14px; }
        .alert-error { color: #e74c3c; background: #ffeaea; padding: 12px; border-radius: 8px; text-align: center; margin-bottom: 20px; font-size: 14px; }

        .current-img { margin-top: 8px; }
        .current-img img { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; border: 2px solid #eee; }

        *[id$=.errors] {
            color: #dc3545;
            font-style: italic;
            font-size: 13px;
            margin-top: 4px;
            display: block;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-card">
            <!-- Header with Avatar -->
            <div class="profile-header">
                <div class="profile-avatar">
                    <c:choose>
                        <c:when test="${not empty user.image}">
                            <c:url value="/image" var="avatarUrl">
                                <c:param name="fname" value="${user.image}"/>
                            </c:url>
                            <img src="${avatarUrl}" alt="Avatar"/>
                        </c:when>
                        <c:otherwise>
                            <span class="no-avatar">👤</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <h2>${user.fullname}</h2>
                <p>${user.email}</p>
            </div>

            <!-- Form -->
            <div class="profile-form">
                <c:if test="${not empty success}">
                    <div class="alert-success">${success}</div>
                    <c:remove var="success" scope="session"/>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert-error">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/account/profile" method="post" enctype="multipart/form-data">

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" value="${user.email}" readonly/>
                    </div>

                    <div class="form-group">
                        <label>Họ và tên: <span style="color:red;">*</span></label>
                        <input type="text" name="fullname" value="${user.fullname}" required placeholder="Nhập họ và tên"/>
                        <span id="fullname.errors">${errors.fullname}</span>
                    </div>

                    <div class="form-group">
                        <label>Số điện thoại:</label>
                        <input type="text" name="phone" value="${user.phone}" placeholder="Nhập số điện thoại"/>
                        <span id="phone.errors">${errors.phone}</span>
                    </div>

                    <div class="form-group">
                        <label>Ảnh đại diện:</label>
                        <div class="file-upload">
                            <input type="file" name="avatar" accept="image/*"/>
                            <p class="file-hint">Chấp nhận: JPG, PNG, GIF, WEBP. Tối đa 5MB. Để trống nếu không thay đổi.</p>
                        </div>
                        <span id="avatar.errors">${errors.avatar}</span>
                        <c:if test="${not empty user.image}">
                            <div class="current-img">
                                <p style="font-size:12px;color:#888;margin-bottom:4px;">Ảnh hiện tại:</p>
                                <c:url value="/image" var="currentImg">
                                    <c:param name="fname" value="${user.image}"/>
                                </c:url>
                                <img src="${currentImg}" alt="Current avatar"/>
                            </div>
                        </c:if>
                    </div>

                    <button type="submit" class="btn-save">💾 Lưu thay đổi</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
