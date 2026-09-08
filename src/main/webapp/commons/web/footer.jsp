<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!-- FOOTER CHUNG CHO WEB (BOOTSTRAP 5) -->
<footer class="bg-dark text-white pt-5 pb-4 mt-auto">
    <div class="container">
        <div class="row g-4">
            <!-- Cột 1: Về WebShop & Thông tin liên hệ -->
            <div class="col-lg-4 col-md-6">
                <h5 class="fw-bold text-uppercase mb-3 d-flex align-items-center">
                    <i class="bi bi-cart3 text-primary me-2 fs-4"></i>WebShop
                </h5>
                <p class="text-secondary small mb-3">
                    WebShop là nền tảng mua sắm trực tuyến chuyên cung cấp các sản phẩm điện thoại, laptop và phụ kiện công nghệ chính hãng với chất lượng và dịch vụ tốt nhất.
                </p>
                <div class="text-secondary small">
                    <p class="mb-2"><i class="bi bi-geo-alt-fill text-primary me-2"></i>1 Võ Văn Ngân, TP. Thủ Đức, TP. Hồ Chí Minh</p>
                    <p class="mb-2"><i class="bi bi-telephone-fill text-primary me-2"></i>Hotline: <strong>1900 6868</strong> (8:00 - 21:30)</p>
                    <p class="mb-0"><i class="bi bi-envelope-fill text-primary me-2"></i>Email: <strong>support@webshop.vn</strong></p>
                </div>
            </div>

            <!-- Cột 2: Danh mục & Mua sắm -->
            <div class="col-lg-3 col-md-6">
                <h6 class="fw-bold text-uppercase mb-3 text-light">Danh mục sản phẩm</h6>
                <ul class="list-unstyled text-secondary small">
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/product" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-chevron-right me-1"></i>Tất cả sản phẩm
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/product" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-chevron-right me-1"></i>Điện thoại di động
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/product" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-chevron-right me-1"></i>Máy tính & Laptop
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/product" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-chevron-right me-1"></i>Phụ kiện công nghệ
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Cột 3: Hỗ trợ khách hàng -->
            <div class="col-lg-3 col-md-6">
                <h6 class="fw-bold text-uppercase mb-3 text-light">Hỗ trợ khách hàng</h6>
                <ul class="list-unstyled text-secondary small">
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-shield-check me-1"></i>Chính sách bảo hành & Đổi trả
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-truck me-1"></i>Chính sách giao hàng toàn quốc
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-lock me-1"></i>Bảo mật thông tin khách hàng
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-credit-card me-1"></i>Phương thức thanh toán an toàn
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Cột 4: Tài khoản & Kết nối -->
            <div class="col-lg-2 col-md-6">
                <h6 class="fw-bold text-uppercase mb-3 text-light">Tài khoản</h6>
                <ul class="list-unstyled text-secondary small">
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/account/login" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-person me-1"></i>Đăng nhập
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/account/register" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-person-plus me-1"></i>Đăng ký
                        </a>
                    </li>
                    <li class="mb-2">
                        <a href="${pageContext.request.contextPath}/account/profile" class="text-secondary text-decoration-none hover-white">
                            <i class="bi bi-person-lines-fill me-1"></i>Hồ sơ cá nhân
                        </a>
                    </li>
                </ul>
                <div class="d-flex gap-2 mt-3">
                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-circle text-light"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-circle text-light"><i class="bi bi-youtube"></i></a>
                    <a href="#" class="btn btn-outline-secondary btn-sm rounded-circle text-light"><i class="bi bi-tiktok"></i></a>
                </div>
            </div>
        </div>

        <hr class="my-4 border-secondary opacity-25">

        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start small text-secondary">
                © 2026 <strong>WebShop</strong>. Tất cả các quyền được bảo lưu.
            </div>
            <div class="col-md-6 text-center text-md-end small text-secondary mt-2 mt-md-0">
                <a href="${pageContext.request.contextPath}/home" class="text-secondary text-decoration-none me-3">Trang chủ</a>
                <a href="${pageContext.request.contextPath}/product" class="text-secondary text-decoration-none me-3">Sản phẩm</a>
                <a href="${pageContext.request.contextPath}/admin/categories" class="text-secondary text-decoration-none">Quản trị viên</a>
            </div>
        </div>
    </div>
</footer>
