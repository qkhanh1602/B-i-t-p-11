package com.template.dao;

import com.template.entity.Category_24110251;
import com.template.util.JpaUtil_24110251;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.Collections;
import java.util.List;


public class CategoryDaoImpl_24110251 implements ICategoryDao_24110251 {

    @Override
    public Category_24110251 findById(Integer id) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            return em.find(Category_24110251.class, id);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<Category_24110251> findAll() {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Category_24110251> query = em.createNamedQuery("Category_24110251.findAll", Category_24110251.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean create(Category_24110251 category) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(category);
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
    public boolean update(Category_24110251 category) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(category);
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
    public boolean delete(Integer id) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Category_24110251 cat = em.find(Category_24110251.class, id);
            if (cat != null) {
                em.remove(cat);
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
