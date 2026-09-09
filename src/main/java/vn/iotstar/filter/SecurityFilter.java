package vn.iotstar.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Bộ lọc bảo mật kiểm tra quyền truy cập các trang quản trị và thông tin cá nhân
 */
@WebFilter(urlPatterns = { "/admin/*", "/account/profile" })
public class SecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        // Kiểm tra xem trong session có attribute 'user' hay chưa
        if (session == null || session.getAttribute("user") == null) {
            // Lưu URL ban đầu để redirect lại sau khi đăng nhập nếu cần
            String targetUrl = req.getRequestURI();
            String queryString = req.getQueryString();
            if (queryString != null && !queryString.isEmpty()) {
                targetUrl += "?" + queryString;
            }
            req.getSession(true).setAttribute("redirectUrl", targetUrl);
            req.getSession().setAttribute("error", "Vui lòng đăng nhập để truy cập trang này!");

            resp.sendRedirect(req.getContextPath() + "/account/login");
            return;
        }

        // Đã đăng nhập, cho phép tiếp tục chuỗi xử lý
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Dọn dẹp tài nguyên
    }
}
