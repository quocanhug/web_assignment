package vn.iotstar.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.ValidationUtil;

@WebServlet(urlPatterns = { "/account/register" })
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        Map<String, String> errors = new HashMap<>();

        // 1. Kiểm tra Họ và tên
        if (ValidationUtil.isBlank(fullname)) {
            errors.put("fullname", "Vui lòng nhập họ và tên.");
        } else if (fullname.trim().length() < 2 || fullname.trim().length() > 50) {
            errors.put("fullname", "Họ và tên phải từ 2 đến 50 ký tự.");
        }

        // 2. Kiểm tra Email
        if (ValidationUtil.isBlank(email)) {
            errors.put("email", "Vui lòng nhập địa chỉ email.");
        } else if (!ValidationUtil.isValidEmail(email)) {
            errors.put("email", "Địa chỉ email không đúng định dạng.");
        }

        // 3. Kiểm tra Số điện thoại (nếu có nhập)
        if (!ValidationUtil.isBlank(phone) && !ValidationUtil.isValidPhone(phone)) {
            errors.put("phone", "Số điện thoại không đúng định dạng (10 số, vd: 0912345678).");
        }

        // 4. Kiểm tra Mật khẩu
        if (ValidationUtil.isBlank(password)) {
            errors.put("password", "Vui lòng nhập mật khẩu.");
        } else if (password.length() < 6) {
            errors.put("password", "Mật khẩu phải có tối thiểu 6 ký tự.");
        }

        // 5. Kiểm tra Xác nhận mật khẩu
        if (ValidationUtil.isBlank(confirmPassword)) {
            errors.put("confirmPassword", "Vui lòng xác nhận lại mật khẩu.");
        } else if (password != null && !password.equals(confirmPassword)) {
            errors.put("confirmPassword", "Mật khẩu xác nhận không trùng khớp.");
        }

        // Nếu có lỗi validation
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("fullname", fullname);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setFullname(fullname.trim());
        user.setEmail(email.trim());
        user.setPhone(phone != null ? phone.trim() : null);
        user.setPassword(password);

        boolean success = userService.register(user);

        if (success) {
            // Lưu email vào session để dùng ở trang verify OTP
            req.getSession().setAttribute("otpEmail", email.trim());
            req.getSession().setAttribute("otpType", "register");
            resp.sendRedirect(req.getContextPath() + "/account/verify");
        } else {
            errors.put("email", "Email này đã được đăng ký trong hệ thống. Vui lòng dùng email khác.");
            req.setAttribute("errors", errors);
            req.setAttribute("fullname", fullname);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}
