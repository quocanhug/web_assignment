<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- SIDEBAR / LEFT MENU ADMIN (BOOTSTRAP 5) -->
<div class="card shadow-sm border-0 rounded-3 mb-3">
    <div class="card-header bg-dark text-white fw-bold py-3">
        <i class="bi bi-speedometer2 me-2 text-warning"></i>BẢNG ĐIỀU KHIỂN
    </div>
    <div class="list-group list-group-flush small">
        <div class="list-group-item bg-light text-muted fw-bold text-uppercase py-2" style="font-size: 11px;">
            Quản lý Danh mục
        </div>
        <a href="${pageContext.request.contextPath}/admin/categories" class="list-group-item list-group-item-action d-flex align-items-center py-2">
            <i class="bi bi-folder2-open me-2 text-primary fs-6"></i>
            <span>Tất cả Danh mục</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/category/add" class="list-group-item list-group-item-action d-flex align-items-center py-2">
            <i class="bi bi-plus-circle me-2 text-success fs-6"></i>
            <span>Thêm Danh mục mới</span>
        </a>

        <div class="list-group-item bg-light text-muted fw-bold text-uppercase py-2" style="font-size: 11px;">
            Quản lý Sản phẩm
        </div>
        <a href="${pageContext.request.contextPath}/admin/products" class="list-group-item list-group-item-action d-flex align-items-center py-2">
            <i class="bi bi-box-seam me-2 text-warning fs-6"></i>
            <span>Tất cả Sản phẩm</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/product/add" class="list-group-item list-group-item-action d-flex align-items-center py-2">
            <i class="bi bi-plus-circle me-2 text-success fs-6"></i>
            <span>Thêm Sản phẩm mới</span>
        </a>

        <div class="list-group-item bg-light text-muted fw-bold text-uppercase py-2" style="font-size: 11px;">
            Hệ thống & Người dùng
        </div>
        <a href="${pageContext.request.contextPath}/home" class="list-group-item list-group-item-action d-flex align-items-center py-2">
            <i class="bi bi-house me-2 text-secondary fs-6"></i>
            <span>Về Trang chủ Web</span>
        </a>
        <a href="${pageContext.request.contextPath}/account/profile" class="list-group-item list-group-item-action d-flex align-items-center py-2">
            <i class="bi bi-person me-2 text-info fs-6"></i>
            <span>Hồ sơ cá nhân</span>
        </a>
    </div>
</div>
