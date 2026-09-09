package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.ValidationUtil;

@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/categories", "/admin/category/add", "/admin/category/insert",
        "/admin/category/edit", "/admin/category/update", "/admin/category/delete" })
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/categories")) {
            // Hiển thị danh sách Category
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/add")) {
            // Hiển thị form thêm Category
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);

        } else if (url.contains("/admin/category/edit")) {
            // Hiển thị form sửa Category
            String idStr = req.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }
            try {
                int id = Integer.parseInt(idStr.trim());
                Category category = cateService.findById(id);
                if (category == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/categories");
                    return;
                }
                req.setAttribute("cate", category);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
            }

        } else if (url.contains("/admin/category/delete")) {
            // Xóa Category
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr.trim());
                    cateService.delete(id);
                    req.getSession().setAttribute("success", "Xóa danh mục thành công!");
                } catch (Exception e) {
                    e.printStackTrace();
                    req.getSession().setAttribute("error", "Không thể xóa danh mục này do đang có sản phẩm thuộc về nó.");
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        String url = req.getRequestURI();

        if (url.contains("/admin/category/insert")) {
            // === THÊM CATEGORY MỚI ===
            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            int status = "1".equals(statusStr) ? 1 : 0;
            String images = req.getParameter("images");
            Part part = null;
            try {
                part = req.getPart("images1");
            } catch (Exception e) {
                // bỏ qua
            }

            Map<String, String> errors = new HashMap<>();

            // 1. Kiểm tra Tên danh mục (@NotBlank, Length)
            if (ValidationUtil.isBlank(categoryname)) {
                errors.put("categoryname", "Tên danh mục không được để trống.");
            } else if (categoryname.trim().length() < 2 || categoryname.trim().length() > 100) {
                errors.put("categoryname", "Tên danh mục phải có độ dài từ 2 đến 100 ký tự.");
            }

            // 2. Kiểm tra file upload ảnh (nếu có)
            if (part != null && part.getSize() > 0) {
                if (!ValidationUtil.isImageFile(part)) {
                    errors.put("images1", "File ảnh không đúng định dạng (JPG, PNG, GIF, WEBP).");
                } else if (!ValidationUtil.isFileSizeValid(part, ValidationUtil.MAX_IMAGE_SIZE)) {
                    errors.put("images1", "Dung lượng file ảnh không được vượt quá 5MB.");
                }
            }

            // Nếu có lỗi, giữ lại dữ liệu và quay lại form
            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("categoryname", categoryname);
                req.setAttribute("images", images);
                req.setAttribute("status", status);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            Category category = new Category();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            // Xử lý upload file
            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images.trim());
                } else {
                    category.setImages("avatar.png");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            cateService.insert(category);
            req.getSession().setAttribute("success", "Thêm danh mục mới thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }

        if (url.contains("/admin/category/update")) {
            // === CẬP NHẬT CATEGORY ===
            String idStr = req.getParameter("categoryid");
            int categoryid = 0;
            try {
                categoryid = Integer.parseInt(idStr);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            String categoryname = req.getParameter("categoryname");
            String statusStr = req.getParameter("status");
            int status = "1".equals(statusStr) ? 1 : 0;
            String images = req.getParameter("images");
            Part part = null;
            try {
                part = req.getPart("images1");
            } catch (Exception e) {
                // bỏ qua
            }

            Map<String, String> errors = new HashMap<>();

            // 1. Kiểm tra Tên danh mục (@NotBlank, Length)
            if (ValidationUtil.isBlank(categoryname)) {
                errors.put("categoryname", "Tên danh mục không được để trống.");
            } else if (categoryname.trim().length() < 2 || categoryname.trim().length() > 100) {
                errors.put("categoryname", "Tên danh mục phải có độ dài từ 2 đến 100 ký tự.");
            }

            // 2. Kiểm tra file upload ảnh mới (nếu có)
            if (part != null && part.getSize() > 0) {
                if (!ValidationUtil.isImageFile(part)) {
                    errors.put("images1", "File ảnh không đúng định dạng (JPG, PNG, GIF, WEBP).");
                } else if (!ValidationUtil.isFileSizeValid(part, ValidationUtil.MAX_IMAGE_SIZE)) {
                    errors.put("images1", "Dung lượng file ảnh không được vượt quá 5MB.");
                }
            }

            Category category = cateService.findById(categoryid);
            if (category == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/categories");
                return;
            }

            // Nếu có lỗi, quay lại trang sửa
            if (!errors.isEmpty()) {
                category.setCategoryname(categoryname);
                category.setStatus(status);
                req.setAttribute("cate", category);
                req.setAttribute("errors", errors);
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            String fileold = category.getImages();
            category.setCategoryname(categoryname.trim());
            category.setStatus(status);

            // Xử lý upload file mới
            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                if (part != null && part.getSize() > 0) {
                    // Xóa file ảnh cũ nếu có
                    if (fileold != null && !fileold.isEmpty()
                            && !fileold.startsWith("https") && !fileold.equals("avatar.png")) {
                        try {
                            deleteFile(uploadPath + "\\" + fileold);
                        } catch (Exception ex) {
                            // file cũ không tồn tại, bỏ qua
                        }
                    }
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    category.setImages(fname);
                } else if (images != null && !images.trim().isEmpty()) {
                    category.setImages(images.trim());
                } else {
                    category.setImages(fileold);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            cateService.update(category);
            req.getSession().setAttribute("success", "Cập nhật danh mục thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }
}
