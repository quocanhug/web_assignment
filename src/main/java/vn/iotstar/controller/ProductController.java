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
import vn.iotstar.entity.Product;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IProductService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.ProductServiceImpl;
import vn.iotstar.util.Constant;
import vn.iotstar.util.ValidationUtil;

@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/products", "/admin/product/add", "/admin/product/insert",
        "/admin/product/edit", "/admin/product/update", "/admin/product/delete" })
public class ProductController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private IProductService productService = new ProductServiceImpl();
    private ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/products")) {
            // Hiển thị danh sách sản phẩm
            List<Product> list = productService.findAll();
            req.setAttribute("listProduct", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/add")) {
            // Hiển thị form thêm sản phẩm
            List<Category> categories = cateService.findAll();
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/edit")) {
            // Hiển thị form sửa sản phẩm
            String idStr = req.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }
            try {
                int id = Integer.parseInt(idStr.trim());
                Product product = productService.findById(id);
                if (product == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/products");
                    return;
                }
                List<Category> categories = cateService.findAll();
                req.setAttribute("product", product);
                req.setAttribute("categories", categories);
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }

        } else if (url.contains("/admin/product/delete")) {
            // Xóa sản phẩm
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.trim().isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr.trim());
                    productService.delete(id);
                    req.getSession().setAttribute("success", "Xóa sản phẩm thành công!");
                } catch (Exception e) {
                    e.printStackTrace();
                    req.getSession().setAttribute("error", "Xảy ra lỗi khi xóa sản phẩm.");
                }
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        String url = req.getRequestURI();

        if (url.contains("/admin/product/insert")) {
            // === THÊM SẢN PHẨM MỚI ===
            String productName = req.getParameter("productName");
            String priceStr = req.getParameter("price");
            String description = req.getParameter("description");
            String statusStr = req.getParameter("status");
            int status = "1".equals(statusStr) ? 1 : 0;
            String cateIdStr = req.getParameter("cateId");
            String imageUrl = req.getParameter("imageUrl");

            Part part = null;
            try {
                part = req.getPart("imageFile");
            } catch (Exception e) {
                // bỏ qua
            }

            Map<String, String> errors = new HashMap<>();

            // 1. Kiểm tra Tên sản phẩm (@NotBlank, Length)
            if (ValidationUtil.isBlank(productName)) {
                errors.put("productName", "Tên sản phẩm không được để trống.");
            } else if (productName.trim().length() < 2 || productName.trim().length() > 200) {
                errors.put("productName", "Tên sản phẩm phải từ 2 đến 200 ký tự.");
            }

            // 2. Kiểm tra Giá sản phẩm (@NotNull, @DecimalMin("0"))
            double price = 0.0;
            if (ValidationUtil.isBlank(priceStr)) {
                errors.put("price", "Vui lòng nhập giá sản phẩm.");
            } else {
                try {
                    price = Double.parseDouble(priceStr.trim());
                    if (price < 0) {
                        errors.put("price", "Giá sản phẩm phải lớn hơn hoặc bằng 0.");
                    }
                } catch (NumberFormatException e) {
                    errors.put("price", "Giá sản phẩm phải là một số hợp lệ.");
                }
            }

            // 3. Kiểm tra Chọn danh mục
            int cateId = 0;
            Category category = null;
            if (ValidationUtil.isBlank(cateIdStr)) {
                errors.put("cateId", "Vui lòng chọn danh mục cho sản phẩm.");
            } else {
                try {
                    cateId = Integer.parseInt(cateIdStr.trim());
                    if (cateId <= 0) {
                        errors.put("cateId", "Vui lòng chọn một danh mục hợp lệ.");
                    } else {
                        category = cateService.findById(cateId);
                        if (category == null) {
                            errors.put("cateId", "Danh mục đã chọn không tồn tại.");
                        }
                    }
                } catch (NumberFormatException e) {
                    errors.put("cateId", "Mã danh mục không hợp lệ.");
                }
            }

            // 4. Kiểm tra file ảnh upload
            if (part != null && part.getSize() > 0) {
                if (!ValidationUtil.isImageFile(part)) {
                    errors.put("imageFile", "File ảnh không đúng định dạng (JPG, PNG, GIF, WEBP).");
                } else if (!ValidationUtil.isFileSizeValid(part, ValidationUtil.MAX_IMAGE_SIZE)) {
                    errors.put("imageFile", "Dung lượng file ảnh không được vượt quá 5MB.");
                }
            }

            // Nếu có lỗi, giữ lại dữ liệu và forward lại form
            if (!errors.isEmpty()) {
                req.setAttribute("errors", errors);
                req.setAttribute("productName", productName);
                req.setAttribute("price", priceStr);
                req.setAttribute("description", description);
                req.setAttribute("status", status);
                req.setAttribute("cateId", cateIdStr);
                req.setAttribute("imageUrl", imageUrl);
                req.setAttribute("categories", cateService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }

            Product product = new Product();
            product.setProductName(productName.trim());
            product.setPrice(price);
            product.setDescription(description != null ? description.trim() : "");
            product.setStatus(status);
            product.setCategory(category);

            // Xử lý upload file
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    product.setImage(fname);
                } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    product.setImage(imageUrl.trim());
                } else {
                    product.setImage("default-product.png");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            productService.insert(product);
            req.getSession().setAttribute("success", "Thêm sản phẩm mới thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }

        if (url.contains("/admin/product/update")) {
            // === CẬP NHẬT SẢN PHẨM ===
            String productIdStr = req.getParameter("productId");
            int productId = 0;
            try {
                productId = Integer.parseInt(productIdStr);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            String productName = req.getParameter("productName");
            String priceStr = req.getParameter("price");
            String description = req.getParameter("description");
            String statusStr = req.getParameter("status");
            int status = "1".equals(statusStr) ? 1 : 0;
            String cateIdStr = req.getParameter("cateId");
            String imageUrl = req.getParameter("imageUrl");

            Part part = null;
            try {
                part = req.getPart("imageFile");
            } catch (Exception e) {
                // bỏ qua
            }

            Map<String, String> errors = new HashMap<>();

            // 1. Kiểm tra Tên sản phẩm (@NotBlank, Length)
            if (ValidationUtil.isBlank(productName)) {
                errors.put("productName", "Tên sản phẩm không được để trống.");
            } else if (productName.trim().length() < 2 || productName.trim().length() > 200) {
                errors.put("productName", "Tên sản phẩm phải từ 2 đến 200 ký tự.");
            }

            // 2. Kiểm tra Giá sản phẩm
            double price = 0.0;
            if (ValidationUtil.isBlank(priceStr)) {
                errors.put("price", "Vui lòng nhập giá sản phẩm.");
            } else {
                try {
                    price = Double.parseDouble(priceStr.trim());
                    if (price < 0) {
                        errors.put("price", "Giá sản phẩm phải lớn hơn hoặc bằng 0.");
                    }
                } catch (NumberFormatException e) {
                    errors.put("price", "Giá sản phẩm phải là một số hợp lệ.");
                }
            }

            // 3. Kiểm tra Chọn danh mục
            int cateId = 0;
            Category category = null;
            if (ValidationUtil.isBlank(cateIdStr)) {
                errors.put("cateId", "Vui lòng chọn danh mục cho sản phẩm.");
            } else {
                try {
                    cateId = Integer.parseInt(cateIdStr.trim());
                    if (cateId <= 0) {
                        errors.put("cateId", "Vui lòng chọn một danh mục hợp lệ.");
                    } else {
                        category = cateService.findById(cateId);
                        if (category == null) {
                            errors.put("cateId", "Danh mục đã chọn không tồn tại.");
                        }
                    }
                } catch (NumberFormatException e) {
                    errors.put("cateId", "Mã danh mục không hợp lệ.");
                }
            }

            // 4. Kiểm tra file upload
            if (part != null && part.getSize() > 0) {
                if (!ValidationUtil.isImageFile(part)) {
                    errors.put("imageFile", "File ảnh không đúng định dạng (JPG, PNG, GIF, WEBP).");
                } else if (!ValidationUtil.isFileSizeValid(part, ValidationUtil.MAX_IMAGE_SIZE)) {
                    errors.put("imageFile", "Dung lượng file ảnh không được vượt quá 5MB.");
                }
            }

            Product product = productService.findById(productId);
            if (product == null) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
                return;
            }

            // Nếu có lỗi, quay lại trang sửa
            if (!errors.isEmpty()) {
                product.setProductName(productName);
                if (!ValidationUtil.isBlank(priceStr)) {
                    try { product.setPrice(Double.parseDouble(priceStr)); } catch (Exception ignored) {}
                }
                product.setDescription(description);
                product.setStatus(status);
                if (category != null) {
                    product.setCategory(category);
                }
                req.setAttribute("product", product);
                req.setAttribute("errors", errors);
                req.setAttribute("categories", cateService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }

            String fileold = product.getImage();
            product.setProductName(productName.trim());
            product.setPrice(price);
            product.setDescription(description != null ? description.trim() : "");
            product.setStatus(status);
            product.setCategory(category);

            // Xử lý upload file mới
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                if (part != null && part.getSize() > 0) {
                    // Xóa file ảnh cũ nếu không phải default hoặc https
                    if (fileold != null && !fileold.isEmpty()
                            && !fileold.startsWith("https") && !fileold.equals("default-product.png")) {
                        try {
                            deleteFile(uploadPath + "\\" + fileold);
                        } catch (Exception ex) {
                            // file cũ không tồn tại, bỏ qua
                        }
                    }
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    product.setImage(fname);
                } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                    product.setImage(imageUrl.trim());
                } else {
                    product.setImage(fileold);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            productService.update(product);
            req.getSession().setAttribute("success", "Cập nhật sản phẩm thành công!");
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }
}
