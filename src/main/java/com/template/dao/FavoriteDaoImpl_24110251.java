package com.template.dao;

import com.template.entity.Favorite_24110251;
import com.template.util.JpaUtil_24110251;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.util.List;


public class FavoriteDaoImpl_24110251 implements IFavoriteDao_24110251 {

    @Override
    public long countByVideoId(String videoId) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Long> query = em.createNamedQuery("Favorite_24110251.countByVideoId", Long.class);
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
    public Favorite_24110251 findByUserAndVideo(String username, String videoId) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        try {
            TypedQuery<Favorite_24110251> query = em.createNamedQuery("Favorite_24110251.findByUserAndVideo", Favorite_24110251.class);
            query.setParameter("username", username);
            query.setParameter("videoId", videoId);
            List<Favorite_24110251> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    @Override
    public boolean create(Favorite_24110251 favorite) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(favorite);
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
    public boolean delete(Integer favoriteId) {
        EntityManager em = JpaUtil_24110251.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Favorite_24110251 fav = em.find(Favorite_24110251.class, favoriteId);
            if (fav != null) {
                em.remove(fav);
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
