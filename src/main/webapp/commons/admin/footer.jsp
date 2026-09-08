<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- FOOTER ADMIN (BOOTSTRAP 5) -->
<footer class="bg-dark text-secondary py-3 mt-auto border-top border-secondary border-opacity-25">
    <div class="container-fluid px-4">
        <div class="d-flex align-items-center justify-content-between small">
            <div>
                © 2026 <strong>WebShop Admin Portal</strong> - Hệ thống Quản trị Bán hàng Trực tuyến
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none me-3"><i class="bi bi-globe me-1"></i>Trang khách hàng</a>
                <a href="${pageContext.request.contextPath}/" class="text-secondary text-decoration-none">Menu Root</a>
            </div>
        </div>
    </div>
</footer>
