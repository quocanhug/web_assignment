package vn.iotstar.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(urlPatterns = { "/profile" })
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        // Lấy session (false = không tạo mới nếu chưa có)
        HttpSession session = req.getSession(false);
        String name = null;

        if (session != null) {
            Object obj = session.getAttribute("username");
            if (obj != null) {
                name = String.valueOf(obj);
            }
        }

        // Nếu session không có username -> chuyển về trang login
        if (name == null) {
            resp.sendRedirect(req.getContextPath() + "/login-session");
            return;
        }

        // Hiển thị thông tin profile
        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>Profile - Session</title>");
        out.println("<style>body{font-family:Arial;margin:40px;background:#f5f5f5;}"
                + ".container{max-width:500px;margin:0 auto;background:white;padding:30px;"
                + "border-radius:8px;box-shadow:0 2px 10px rgba(0,0,0,0.1);text-align:center;}"
                + "a{color:#e91e63;}</style></head><body>");
        out.println("<div class='container'>");
        out.println("<h1>Chào " + name + "!</h1>");
        out.println("<p>Bạn đã đăng nhập thành công bằng <b>Session</b>.</p>");
        out.println("<p>Session ID: " + session.getId() + "</p>");
        out.println("<p>Session sẽ hết hạn sau 30 giây không hoạt động.</p>");
        out.println("<a href='" + req.getContextPath() + "/logout'>Đăng xuất (Hủy Session)</a>");
        out.println(" | <a href='" + req.getContextPath() + "/login.html'>Về trang Login</a>");
        out.println("</div></body></html>");
        out.close();
    }
}
