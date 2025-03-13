package com.app.jakarta.scholarly.services;

import com.app.jakarta.scholarly.models.Teacher;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

public class TeacherDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("scholarlyPU");

    public static void saveTeacher(Teacher instructor) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(instructor);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Teacher getTeacherByEmail(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Teacher> query = em.createQuery("SELECT t FROM Teacher t WHERE t.email = :email", Teacher.class);
            query.setParameter("email", email);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }
}
