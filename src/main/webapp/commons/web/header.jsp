<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- HEADER / NAVBAR CHUNG CHO WEB (BOOTSTRAP 5) -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;">
    <div class="container">
        <!-- Logo / Brand -->
        <a class="navbar-brand fw-bold fs-4 d-flex align-items-center" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-cart3 me-2"></i>WebShop
        </a>

        <!-- Toggle button on mobile -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent"
                aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Menu Links -->
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link text-white fw-semibold px-3" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door me-1"></i>Trang chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-white fw-semibold px-3" href="${pageContext.request.contextPath}/product">
                        <i class="bi bi-grid me-1"></i>Tất cả sản phẩm
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white fw-semibold px-3" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-gear me-1"></i>Quản trị
                    </a>
                    <ul class="dropdown-menu shadow">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/categories"><i class="bi bi-folder me-2 text-primary"></i>Quản lý Category</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/products"><i class="bi bi-box-seam me-2 text-warning"></i>Quản lý Product</a></li>
                    </ul>
                </li>
            </ul>

            <!-- Right side: User authentication -->
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <li class="nav-item me-2">
                            <a class="btn btn-outline-light rounded-pill px-3 py-1 d-flex align-items-center" href="${pageContext.request.contextPath}/account/profile">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.user.image}">
                                        <c:url value="/image" var="userNavAvatar">
                                            <c:param name="fname" value="${sessionScope.user.image}"/>
                                        </c:url>
                                        <img src="${userNavAvatar}" alt="avatar" class="rounded-circle me-2" style="width: 26px; height: 26px; object-fit: cover; border: 1px solid white;"/>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-person-circle me-2 fs-5"></i>
                                    </c:otherwise>
                                </c:choose>
                                <span>${sessionScope.user.fullname}</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-danger btn-sm rounded-pill px-3 py-1" href="${pageContext.request.contextPath}/account/logout">
                                <i class="bi bi-box-arrow-right me-1"></i>Đăng xuất
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item me-2">
                            <a class="btn btn-outline-light rounded-pill px-3 py-1" href="${pageContext.request.contextPath}/account/login">
                                <i class="bi bi-box-arrow-in-right me-1"></i>Đăng nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-light text-primary fw-bold rounded-pill px-3 py-1 shadow-sm" href="${pageContext.request.contextPath}/account/register">
                                <i class="bi bi-person-plus me-1"></i>Đăng ký
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
