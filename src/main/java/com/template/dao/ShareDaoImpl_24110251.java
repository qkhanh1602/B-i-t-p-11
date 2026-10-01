package com.template.dao;

import com.template.entity.Share_24110251;
import com.template.util.JpaUtil_24110251;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;


public class ShareDaoImpl_24110251 implements IShareDao_24110251 {

    @Override
    public long countByVideoId(String videoId) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Long> query = em.createNamedQuery("Share_24110251.countByVideoId", Long.class);
            query.setParameter("videoId", videoId);
            return query.getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean create(Share_24110251 share) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(share);
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
}
