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

        Map<String, String> errors = new HashMap<>();

        if (ValidationUtil.isBlank(otp)) {
            errors.put("otp", "Vui lòng nhập mã OTP xác nhận.");
        } else if (!ValidationUtil.isValidOtp(otp)) {
            errors.put("otp", "Mã OTP phải bao gồm đúng 6 chữ số.");
        }

        if (!errors.isEmpty()) {
            req.setAttribute("email", email);
            req.setAttribute("otp", otp);
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean success = userService.activate(email.trim(), otp.trim());

        if (success) {
            // Xóa dữ liệu OTP khỏi session
            req.getSession().removeAttribute("otpEmail");
            req.getSession().removeAttribute("otpType");
            // Đặt thông báo thành công vào session để hiển thị trên trang đăng nhập
            req.getSession().setAttribute("success", "Tài khoản đã được kích hoạt thành công! Bạn có thể đăng nhập ngay bây giờ.");
            resp.sendRedirect(req.getContextPath() + "/account/login");
        } else {
            req.setAttribute("email", email);
            req.setAttribute("otp", otp);
            errors.put("otp", "Mã OTP không đúng hoặc đã hết hạn (chỉ có hiệu lực trong 5 phút).");
            req.setAttribute("errors", errors);
            req.setAttribute("error", "Kích hoạt thất bại. Vui lòng kiểm tra lại mã OTP.");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }
}
