package vn.iotstar.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/account/forgot-password", "/account/reset-password" })
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/reset-password")) {
            // Kiểm tra có email trong session không
            String email = (String) req.getSession().getAttribute("resetEmail");
            if (email == null) {
                resp.sendRedirect(req.getContextPath() + "/account/forgot-password");
                return;
            }
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        } else {
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/reset-password")) {
            // Xử lý đặt lại mật khẩu
            String email = (String) req.getSession().getAttribute("resetEmail");
            if (email == null || email.trim().isEmpty()) {
                email = req.getParameter("email");
            }
            String otp = req.getParameter("otp");
            String newPassword = req.getParameter("newPassword");

            if (email == null || email.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/account/forgot-password");
                return;
            }

            boolean success = userService.resetPassword(email.trim(), otp != null ? otp.trim() : "", newPassword);

            if (success) {
                req.getSession().removeAttribute("resetEmail");
                req.getSession().setAttribute("success", "Mật khẩu đã được đặt lại thành công! Bạn có thể đăng nhập ngay bây giờ.");
                resp.sendRedirect(req.getContextPath() + "/account/login");
            } else {
                req.setAttribute("email", email);
                req.setAttribute("error", "Mã OTP không đúng hoặc đã hết hạn.");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            }

        } else {
            // Xử lý quên mật khẩu - gửi OTP
            String email = req.getParameter("email");

            boolean success = userService.generateOtpForForgotPassword(email);

            if (success) {
                req.getSession().setAttribute("resetEmail", email);
                resp.sendRedirect(req.getContextPath() + "/account/reset-password");
            } else {
                req.setAttribute("error", "Email không tồn tại hoặc tài khoản chưa được kích hoạt.");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
        }
    }
}
