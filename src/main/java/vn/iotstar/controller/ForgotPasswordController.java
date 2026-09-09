package vn.iotstar.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.ValidationUtil;

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
            String confirmPassword = req.getParameter("confirmPassword");

            if (email == null || email.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/account/forgot-password");
                return;
            }

            Map<String, String> errors = new HashMap<>();

            // 1. Kiểm tra OTP
            if (ValidationUtil.isBlank(otp)) {
                errors.put("otp", "Vui lòng nhập mã OTP 6 chữ số.");
            } else if (!ValidationUtil.isValidOtp(otp)) {
                errors.put("otp", "Mã OTP phải bao gồm đúng 6 chữ số.");
            }

            // 2. Kiểm tra Mật khẩu mới
            if (ValidationUtil.isBlank(newPassword)) {
                errors.put("newPassword", "Vui lòng nhập mật khẩu mới.");
            } else if (newPassword.length() < 6) {
                errors.put("newPassword", "Mật khẩu mới phải có tối thiểu 6 ký tự.");
            }

            // 3. Kiểm tra Xác nhận mật khẩu mới
            if (ValidationUtil.isBlank(confirmPassword)) {
                errors.put("confirmPassword", "Vui lòng xác nhận lại mật khẩu mới.");
            } else if (newPassword != null && !newPassword.equals(confirmPassword)) {
                errors.put("confirmPassword", "Mật khẩu xác nhận không khớp.");
            }

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("email", email);
                req.setAttribute("otp", otp);
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                return;
            }

            boolean success = userService.resetPassword(email.trim(), otp.trim(), newPassword);

            if (success) {
                req.getSession().removeAttribute("resetEmail");
                req.getSession().setAttribute("success", "Mật khẩu đã được đặt lại thành công! Bạn có thể đăng nhập ngay bây giờ.");
                resp.sendRedirect(req.getContextPath() + "/account/login");
            } else {
                req.setAttribute("email", email);
                req.setAttribute("otp", otp);
                errors.put("otp", "Mã OTP không đúng hoặc đã hết hạn (chỉ có hiệu lực trong 5 phút).");
                req.setAttribute("errors", errors);
                req.setAttribute("error", "Đặt lại mật khẩu thất bại. Vui lòng kiểm tra lại mã OTP.");
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            }

        } else {
            // Xử lý quên mật khẩu - gửi OTP
            String email = req.getParameter("email");
            Map<String, String> errors = new HashMap<>();

            if (ValidationUtil.isBlank(email)) {
                errors.put("email", "Vui lòng nhập địa chỉ email.");
            } else if (!ValidationUtil.isValidEmail(email)) {
                errors.put("email", "Địa chỉ email không đúng định dạng.");
            }

            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("email", email);
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                return;
            }

            boolean success = userService.generateOtpForForgotPassword(email.trim());

            if (success) {
                req.getSession().setAttribute("resetEmail", email.trim());
                resp.sendRedirect(req.getContextPath() + "/account/reset-password");
            } else {
                errors.put("email", "Email này không tồn tại trong hệ thống hoặc tài khoản chưa được kích hoạt.");
                req.setAttribute("errors", errors);
                req.setAttribute("email", email);
                req.setAttribute("error", "Email không hợp lệ hoặc chưa được kích hoạt.");
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            }
        }
    }
}
