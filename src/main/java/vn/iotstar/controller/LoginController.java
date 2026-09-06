package vn.iotstar.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;

@WebServlet(urlPatterns = { "/account/login" })
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userService.login(email, password);

        if (user != null) {
            // Tạo session
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("username", user.getFullname());
            session.setMaxInactiveInterval(30 * 60); // 30 phút
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng, hoặc tài khoản chưa được kích hoạt.");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}
