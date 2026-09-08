<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- HEADER ADMIN (BOOTSTRAP 5) -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm py-2">
    <div class="container-fluid px-3">
        <!-- Logo / Brand Admin -->
        <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/admin/categories">
            <span class="badge bg-danger me-2 py-1 px-2">ADMIN</span>
            <span>WebShop Portal</span>
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#adminNavbarContent"
                aria-controls="adminNavbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="adminNavbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/categories">
                        <i class="bi bi-folder me-1 text-info"></i>Categories
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/products">
                        <i class="bi bi-box-seam me-1 text-warning"></i>Products
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                <li class="nav-item me-3">
                    <a class="btn btn-outline-light btn-sm rounded-pill px-3" href="${pageContext.request.contextPath}/home" target="_blank">
                        <i class="bi bi-box-arrow-up-right me-1"></i>Xem trang web
                    </a>
                </li>
                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-light d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="bi bi-person-circle me-1 fs-5"></i>
                            <span>${sessionScope.user.fullname}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account/profile"><i class="bi bi-person me-2"></i>Hồ sơ cá nhân</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/account/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>
