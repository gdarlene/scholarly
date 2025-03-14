package com.app.jakarta.scholarly.services;

import com.app.jakarta.scholarly.models.Submission;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

public class SubmissionDAO {
    private EntityManagerFactory emf;

    public SubmissionDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public void saveSubmission(Submission submission) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(submission);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Submission findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Submission.class, id);
        } finally {
            em.close();
        }
    }

    public Submission findByStudentAndAssignment(Long studentId, Long assignmentId) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery(
                    "SELECT s FROM Submission s WHERE s.student.id = :studentId AND s.assignment.id = :assignmentId", 
                    Submission.class)
                    .setParameter("studentId", studentId)
                    .setParameter("assignmentId", assignmentId)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            em.close();
        }
    }
}
