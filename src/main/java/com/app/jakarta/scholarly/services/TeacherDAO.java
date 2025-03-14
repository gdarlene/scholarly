package com.app.jakarta.scholarly.services;

import com.app.jakarta.scholarly.models.Classroom;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

import java.util.List;

public class ClassroomDAO {
    private EntityManagerFactory emf;

    public ClassroomDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public void saveClassroom(Classroom classroom) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(classroom);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Classroom findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Classroom.class, id);
        } finally {
            em.close();
        }
    }

    public List<Classroom> getAllClassrooms() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT c FROM Classroom c", Classroom.class).getResultList();
        } finally {
            em.close();
        }
    }
}
