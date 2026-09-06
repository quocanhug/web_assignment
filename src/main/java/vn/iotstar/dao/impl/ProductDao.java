package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

import vn.iotstar.config.JPAConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDao implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.persist(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void update(Product product) {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            enma.merge(product);
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public void delete(int productId) throws Exception {
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();
        try {
            trans.begin();
            Product product = enma.find(Product.class, productId);
            if (product != null) {
                enma.remove(product);
            } else {
                throw new Exception("Không tìm thấy sản phẩm");
            }
            trans.commit();
        } catch (Exception e) {
            e.printStackTrace();
            trans.rollback();
            throw e;
        } finally {
            enma.close();
        }
    }

    @Override
    public Product findById(int productId) {
        EntityManager enma = JPAConfig.getEntityManager();
        Product product = enma.find(Product.class, productId);
        enma.close();
        return product;
    }

    @Override
    public List<Product> findAll() {
        EntityManager enma = JPAConfig.getEntityManager();
        TypedQuery<Product> query = enma.createNamedQuery("Product.findAll", Product.class);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public List<Product> findAll(int page, int pagesize) {
        EntityManager enma = JPAConfig.getEntityManager();
        TypedQuery<Product> query = enma.createNamedQuery("Product.findAll", Product.class);
        query.setFirstResult((page - 1) * pagesize);
        query.setMaxResults(pagesize);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public List<Product> findLatest(int n) {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p ORDER BY p.createdDate DESC";
        TypedQuery<Product> query = enma.createQuery(jpql, Product.class);
        query.setMaxResults(n);
        List<Product> list = query.getResultList();
        enma.close();
        return list;
    }

    @Override
    public int count() {
        EntityManager enma = JPAConfig.getEntityManager();
        String jpql = "SELECT count(p) FROM Product p";
        Query query = enma.createQuery(jpql);
        int count = ((Long) query.getSingleResult()).intValue();
        enma.close();
        return count;
    }
}
