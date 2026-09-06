package vn.iotstar.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;

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
        String password = req.getParameter("password");

        User user = new User();
        user.setFullname(fullname);
        user.setEmail(email);
        user.setPassword(password);

        boolean success = userService.register(user);

        if (success) {
            // Lưu email vào session để dùng ở trang verify OTP
            req.getSession().setAttribute("otpEmail", email);
            req.getSession().setAttribute("otpType", "register");
            resp.sendRedirect(req.getContextPath() + "/account/verify");
        } else {
            req.setAttribute("error", "Email đã được sử dụng. Vui lòng dùng email khác.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}
