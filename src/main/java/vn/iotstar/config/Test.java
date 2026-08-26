package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;

public class Test {
    public static void main(String[] args) {
        System.out.println("====== TEST JPA KẾT NỐI VÀ TẠO BẢNG ======");

        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        Category cate = new Category();
        cate.setCategoryname("Iphone");
        cate.setImages("abc.jpg");
        cate.setStatus(1);

        Video video = new Video();
        video.setVideoId("v01");
        video.setTitle("test video");
        video.setCategory(cate);

        try {
            trans.begin();
            enma.persist(cate);
            enma.persist(video);
            trans.commit();
            System.out.println("✅ THÀNH CÔNG! Đã tạo bảng và thêm dữ liệu mẫu.");
            System.out.println("   Category ID: " + cate.getCategoryid());
            System.out.println("   Category Name: " + cate.getCategoryname());
            System.out.println("   Video ID: " + video.getVideoId());
        } catch (Exception e) {
            System.err.println("❌ THẤT BẠI! Chi tiết lỗi:");
            e.printStackTrace();
            trans.rollback();
        } finally {
            enma.close();
        }
    }
}
