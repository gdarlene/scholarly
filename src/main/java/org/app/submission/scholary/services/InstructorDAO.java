package org.app.submission.scholary.services;

import org.app.submission.scholary.models.Assignment;
import org.app.submission.scholary.models.Instructor;
import org.app.submission.scholary.hibernate.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class InstructorDAO {
    // Save an instructor to the database
    public static void saveInstructor(Instructor instructor) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(instructor);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    // Fetch all assignments
    public static List<Assignment> getAllAssignments() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Assignment", Assignment.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    // Fetch assignments by class ID
    public static List<Assignment> getAssignmentsByClass(int classId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Assignment> query = session.createQuery("FROM Assignment WHERE classId = :classId", Assignment.class);
            query.setParameter("classId", classId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    // Fetch assignments by class and week
    public static List<Assignment> getAssignmentsByClassAndWeek(int classId, int week) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Assignment> query = session.createQuery("FROM Assignment WHERE classId = :classId AND week = :week", Assignment.class);
            query.setParameter("classId", classId);
            query.setParameter("week", week);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }

    // Fetch assignments by week
    public static List<Assignment> getAssignmentsByWeek(int week) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Assignment> query = session.createQuery("FROM Assignment WHERE week = :week", Assignment.class);
            query.setParameter("week", week);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        }
    }
}
