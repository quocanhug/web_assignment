package vn.iotstar.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/login-cookie" })
public class LoginCookieServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // GET: hiển thị trang Login.html
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("login.html").forward(req, resp);
    }

    // POST: xử lý đăng nhập
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String user = req.getParameter("username");
        String pass = req.getParameter("password");

        // Kiểm tra tài khoản (hardcode để demo)
        if (user != null && user.equals("quocanh") && pass.equals("123")) {
            // Tạo cookie lưu username
            Cookie cookie = new Cookie("username", user);
            // Thiết lập thời gian tồn tại 30 giây (để dễ test)
            cookie.setMaxAge(30);
            // Thêm cookie vào response
            resp.addCookie(cookie);
            // Chuyển sang trang hello (đọc cookie)
            resp.sendRedirect(req.getContextPath() + "/hello-cookie");
        } else {
            // Đăng nhập thất bại
            PrintWriter out = resp.getWriter();
            out.println("<p style='color:red; text-align:center;'>Tài khoản hoặc mật khẩu không chính xác!</p>");
            req.getRequestDispatcher("login.html").include(req, resp);
        }
    }
}
