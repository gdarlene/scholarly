package org.app.submission.scholary.services;

import org.app.submission.scholary.models.Assignment;
import org.app.submission.scholary.hibernate.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class AssignmentDAO {

    public static void saveAssignment(Assignment assignment, InputStream fileInputStream, String fileName) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            // Convert InputStream to byte[]
            byte[] fileBytes = fileInputStream.readAllBytes();

            // Set file content in the assignment object
            assignment.setFileContent(fileBytes);
            assignment.setFileName(fileName);

            session.persist(assignment);
            transaction.commit();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public static List<Assignment> getAllAssignments() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Assignment", Assignment.class).list();
        }
    }

    public static void saveAssignment(Assignment assignment) {
    }
}
