package vn.iotstar.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/hello-cookie" })
public class HelloCookieServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        // Đọc cookie từ request
        String name = "";
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("username")) {
                    name = c.getValue();
                }
            }
        }

        // Nếu không tìm thấy cookie username -> chuyển về trang login
        if (name.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/login-cookie");
            return;
        }

        // Hiển thị lời chào
        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>Hello Cookie</title>");
        out.println("<style>body{font-family:Arial;margin:40px;background:#f5f5f5;}"
                + ".container{max-width:500px;margin:0 auto;background:white;padding:30px;"
                + "border-radius:8px;box-shadow:0 2px 10px rgba(0,0,0,0.1);text-align:center;}"
                + "a{color:#4CAF50;}</style></head><body>");
        out.println("<div class='container'>");
        out.println("<h1>Xin chào " + name + "!</h1>");
        out.println("<p>Bạn đã đăng nhập thành công bằng <b>Cookie</b>.</p>");
        out.println("<p>Cookie sẽ hết hạn sau 30 giây.</p>");
        out.println("<a href='" + req.getContextPath() + "/delete-cookie'>Xóa Cookie (Đăng xuất)</a>");
        out.println(" | <a href='" + req.getContextPath() + "/login.html'>Về trang Login</a>");
        out.println("</div></body></html>");
        out.close();
    }
}
