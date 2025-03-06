package org.app.submission.scholary.hibernate;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static final SessionFactory sessionFactory = buildSessionFactory();

    private static SessionFactory buildSessionFactory() {
        try {
            return new Configuration().configure("hibernate.cfg.xml").addAnnotatedClass(org.app.submission.scholary.models.Instructor.class)
                    .addAnnotatedClass(org.app.submission.scholary.models.Assignment.class)
                    .buildSessionFactory();
        } catch (Exception e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Failed to initialize Hibernate session factory");
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
