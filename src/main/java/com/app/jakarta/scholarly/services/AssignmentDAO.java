package com.app.jakarta.scholarly.services;

import com.app.jakarta.scholarly.models.Assignment;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

import java.util.List;

public class AssignmentDAO {
    private EntityManagerFactory emf;

    public AssignmentDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public void saveAssignment(Assignment assignment) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(assignment);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Assignment findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Assignment.class, id);
        } finally {
            em.close();
        }
    }

    public void updateAssignment(Assignment assignment) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(assignment);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void deleteAssignment(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Assignment assignment = em.find(Assignment.class, id);
            if (assignment != null) {
                em.remove(assignment);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Assignment> getAllAssignments() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT a FROM Assignment a", Assignment.class).getResultList();
        } finally {
            em.close();
        }
    }
}
