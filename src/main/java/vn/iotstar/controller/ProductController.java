package vn.iotstar.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

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
            int id = Integer.parseInt(req.getParameter("id"));
            Product product = productService.findById(id);
            List<Category> categories = cateService.findAll();
            req.setAttribute("product", product);
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);

        } else if (url.contains("/admin/product/delete")) {
            // Xóa sản phẩm
            int id = Integer.parseInt(req.getParameter("id"));
            try {
                productService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
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
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int status = Integer.parseInt(req.getParameter("status"));
            int cateId = Integer.parseInt(req.getParameter("cateId"));
            String imageUrl = req.getParameter("imageUrl");

            Product product = new Product();
            product.setProductName(productName);
            product.setPrice(price);
            product.setDescription(description);
            product.setStatus(status);

            // Set category
            Category category = cateService.findById(cateId);
            product.setCategory(category);

            // Xử lý upload file
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                Part part = req.getPart("imageFile");
                if (part != null && part.getSize() > 0) {
                    String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    int index = filename.lastIndexOf(".");
                    String ext = filename.substring(index + 1);
                    String fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    product.setImage(fname);
                } else if (imageUrl != null && !imageUrl.isEmpty()) {
                    product.setImage(imageUrl);
                } else {
                    product.setImage("default-product.png");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }

        if (url.contains("/admin/product/update")) {
            // === CẬP NHẬT SẢN PHẨM ===
            int productId = Integer.parseInt(req.getParameter("productId"));
            String productName = req.getParameter("productName");
            double price = Double.parseDouble(req.getParameter("price"));
            String description = req.getParameter("description");
            int status = Integer.parseInt(req.getParameter("status"));
            int cateId = Integer.parseInt(req.getParameter("cateId"));
            String imageUrl = req.getParameter("imageUrl");

            Product product = productService.findById(productId);
            String fileold = product.getImage();
            product.setProductName(productName);
            product.setPrice(price);
            product.setDescription(description);
            product.setStatus(status);

            // Set category
            Category category = cateService.findById(cateId);
            product.setCategory(category);

            // Xử lý upload file mới
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            try {
                Part part = req.getPart("imageFile");
                if (part != null && part.getSize() > 0) {
                    // Xóa file ảnh cũ
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
                } else if (imageUrl != null && !imageUrl.isEmpty()) {
                    product.setImage(imageUrl);
                } else {
                    product.setImage(fileold);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.delete(path);
    }
}
