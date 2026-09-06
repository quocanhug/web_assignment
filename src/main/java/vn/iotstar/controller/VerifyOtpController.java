package vn.iotstar.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/account/verify" })
public class VerifyOtpController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra có email trong session không
        String email = (String) req.getSession().getAttribute("otpEmail");
        if (email == null) {
            resp.sendRedirect(req.getContextPath() + "/account/register");
            return;
        }
        req.setAttribute("email", email);
        req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = (String) req.getSession().getAttribute("otpEmail");
        if (email == null || email.trim().isEmpty()) {
            email = req.getParameter("email");
        }
        String otp = req.getParameter("otp");

        if (email == null || email.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/account/register");
            return;
        }

        boolean success = userService.activate(email.trim(), otp != null ? otp.trim() : "");

        if (success) {
            // Xóa dữ liệu OTP khỏi session
            req.getSession().removeAttribute("otpEmail");
            req.getSession().removeAttribute("otpType");
            // Đặt thông báo thành công vào session để hiển thị trên trang đăng nhập
            req.getSession().setAttribute("success", "Tài khoản đã được kích hoạt thành công! Bạn có thể đăng nhập ngay bây giờ.");
            resp.sendRedirect(req.getContextPath() + "/account/login");
        } else {
            req.setAttribute("email", email);
            req.setAttribute("error", "Mã OTP không đúng hoặc đã hết hạn. Vui lòng thử lại.");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
