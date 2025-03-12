package com.app.jakarta.scholarly.models;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "submissions")
public class Submission {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "assignment_id")
    private Assignment assignment;

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @Column(name = "submission_date")
    private LocalDateTime subcmissionDate;

    @Column(name = "file_path")
    private String filePath;

    @Column(name = "grade")
    private Double grade;

    public Submission() {}

    public Submission(Assignment assignment, Student student, LocalDateTime submissionDate, String filePath) {
        this.assignment = assignment;
        this.student = student;
        this.submissionDate = submissionDate;
        this.filePath = filePath;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Assignment getAssignment() { return assignment; }
    public void setAssignment(Assignment assignment) { this.assignment = assignment; }
    public Student getStudent() { return student; }
    public void setStudent(Student student) { this.student = student; }
    public LocalDateTime getSubmissionDate() { return submissionDate; }
    public void setSubmissionDate(LocalDateTime submissionDate) { this.submissionDate = submissionDate; }
    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
    public Double getGrade() { return grade; }
    public void setGrade(Double grade) { this.grade = grade; }
}