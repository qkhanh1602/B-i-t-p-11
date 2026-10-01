package com.template.dao;

import com.template.entity.Video_24110251;
import com.template.util.JpaUtil_24110251;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.Collections;
import java.util.List;


public class VideoDaoImpl_24110251 implements IVideoDao_24110251 {

    @Override
    public Video_24110251 findById(String id) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            return em.find(Video_24110251.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24110251> findAll() {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Video_24110251> query = em.createQuery("SELECT v FROM Video_24110251 v ORDER BY v.videoId DESC", Video_24110251.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24110251> findAllPaginated(int page, int pageSize) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Video_24110251> query = em.createQuery("SELECT v FROM Video_24110251 v ORDER BY v.videoId DESC", Video_24110251.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countAll() {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(v) FROM Video_24110251 v", Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Video_24110251> findByCategoryId(Integer categoryId, int page, int pageSize) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Video_24110251> query = em.createQuery(
                "SELECT v FROM Video_24110251 v WHERE v.category.categoryId = :categoryId AND v.active = true ORDER BY v.videoId DESC",
                Video_24110251.class
            );
            query.setParameter("categoryId", categoryId);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    @Override
    public long countByCategoryId(Integer categoryId) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(v) FROM Video_24110251 v WHERE v.category.categoryId = :categoryId AND v.active = true",
                Long.class
            );
            query.setParameter("categoryId", categoryId);
            return query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean create(Video_24110251 video) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(video);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean update(Video_24110251 video) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(video);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean delete(String id) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Video_24110251 video = em.find(Video_24110251.class, id);
            if (video != null) {
                em.remove(video);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean incrementViews(String id) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Video_24110251 video = em.find(Video_24110251.class, id);
            if (video != null) {
                int currentViews = video.getViews() != null ? video.getViews() : 0;
                video.setViews(currentViews + 1);
                em.merge(video);
                tx.commit();
                return true;
            }
            tx.rollback();
            return false;
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
