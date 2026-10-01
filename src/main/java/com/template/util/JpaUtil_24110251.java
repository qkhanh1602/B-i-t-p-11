package com.template.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;


public class JpaUtil_24110251 {

    public static EntityManager getEntityManager() {
        return JpaConfig_24110251.getEntityManager();
    }

    public static EntityManagerFactory getEntityManagerFactory() {
        return JpaConfig_24110251.getEntityManagerFactory();
    }

    public static boolean testJpaConnection() {
        try {
            EntityManager em = getEntityManager();
            boolean isOpen = em.isOpen();
            em.close();
            return isOpen;
        } catch (Exception e) {
            System.err.println("[JpaUtil_24110251] Test JPA connection failed: " + e.getMessage());
            return false;
        }
    }

    public static void shutdown() {
        JpaConfig_24110251.shutdown();
    }
}
