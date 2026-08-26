package vn.iotstar.entity;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "Category")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int categoryid;

    @Column(name = "cate_name", columnDefinition = "nvarchar(255) not null")
    private String categoryname;

    @Column(name = "icons", columnDefinition = "nvarchar(255) null")
    private String images;

    @Column(name = "status")
    private Integer status = 1;

    // bi-directional many-to-one association to Video
    @OneToMany(mappedBy = "category")
    private List<Video> videos;

    public Category() {
    }

    public int getCategoryid() {
        return this.categoryid;
    }

    public void setCategoryid(int categoryid) {
        this.categoryid = categoryid;
    }

    public String getCategoryname() {
        return categoryname;
    }

    public void setCategoryname(String categoryname) {
        this.categoryname = categoryname;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return this.status != null ? this.status : 1;
    }

    public void setStatus(Integer status) {
        this.status = status != null ? status : 1;
    }

    public List<Video> getVideos() {
        return this.videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }

    public Video addVideo(Video video) {
        getVideos().add(video);
        video.setCategory(this);
        return video;
    }

    public Video removeVideo(Video video) {
        getVideos().remove(video);
        video.setCategory(null);
        return video;
    }
}
