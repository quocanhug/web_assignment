package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

@MultipartConfig()
@WebServlet(urlPatterns = { "/account/profile" })
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/account/login");
            return;
        }

        // Load lại user mới nhất từ DB
        User sessionUser = (User) session.getAttribute("user");
        User user = userService.findById(sessionUser.getUserId());
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/account/login");
            return;
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/account/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        User user = userService.findById(sessionUser.getUserId());
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/account/login");
            return;
        }

        // Nhận dữ liệu từ form
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        if (fullname != null && !fullname.trim().isEmpty()) {
            user.setFullname(fullname.trim());
        }
        user.setPhone(phone != null ? phone.trim() : "");

        // Xử lý upload ảnh
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        try {
            Part part = req.getPart("avatar");
            if (part != null && part.getSize() > 0) {
                // Xóa file ảnh cũ
                String oldImage = user.getImage();
                if (oldImage != null && !oldImage.isEmpty()) {
                    try {
                        Path oldPath = Paths.get(uploadPath + "/" + oldImage);
                        Files.deleteIfExists(oldPath);
                    } catch (Exception ex) {
                        // file cũ không tồn tại, bỏ qua
                    }
                }

                // Lưu file mới
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                String ext = filename.substring(index + 1);
                String fname = "user_" + user.getUserId() + "_" + System.currentTimeMillis() + "." + ext;
                part.write(uploadPath + "/" + fname);
                user.setImage(fname);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Cập nhật vào DB
        userService.updateProfile(user);

        // Cập nhật lại session
        session.setAttribute("user", user);
        session.setAttribute("username", user.getFullname());

        // Flash message
        session.setAttribute("success", "Cập nhật hồ sơ thành công!");
        resp.sendRedirect(req.getContextPath() + "/account/profile");
    }
}
