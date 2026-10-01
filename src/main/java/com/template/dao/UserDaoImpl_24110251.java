package com.template.dao;

import com.template.entity.User_24110251;
import com.template.util.JpaUtil_24110251;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.Collections;
import java.util.List;


public class UserDaoImpl_24110251 implements IUserDao_24110251 {

    @Override
    public User_24110251 findById(String username) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            return em.find(User_24110251.class, username);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public User_24110251 findByEmail(String email) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<User_24110251> query = em.createNamedQuery("User_24110251.findByEmail", User_24110251.class);
            query.setParameter("email", email);
            List<User_24110251> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public List<User_24110251> findAll() {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<User_24110251> query = em.createNamedQuery("User_24110251.findAll", User_24110251.class);
            return query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
            return Collections.emptyList();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean create(User_24110251 user) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(user);
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
    public boolean update(User_24110251 user) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(user);
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
    public boolean delete(String username) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            User_24110251 user = em.find(User_24110251.class, username);
            if (user != null) {
                em.remove(user);
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
