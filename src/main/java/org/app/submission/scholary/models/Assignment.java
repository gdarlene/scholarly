package org.app.submission.scholary.models;

import jakarta.persistence.*;

import java.io.InputStream;

@Entity
@Table(name = "assignments")
public class Assignment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private int classId;



    private int week;
    private String title;
    private String course;
    private String deadline;

    @Lob
    @Column(columnDefinition = "BYTEA") // PostgreSQL-specific BLOB storage
    private byte[] fileContent;

    private String fileName; // Store the filename separately

    public Assignment() {}

    public Assignment(int id, int classId, int week, String title, String course, String deadline, byte[] fileContent, String fileName) {
        this.id = id;
        this.classId = classId;
        this.week = week;
        this.title = title;
        this.course = course;
        this.deadline = deadline;
        this.fileContent = fileContent;
        this.fileName = fileName;
    }

    public Assignment(int id, String title, String course, String deadline, byte[] fileContent, String fileName) {
        this.id = id;
        this.title = title;
        this.course = course;
        this.deadline = deadline;
        this.fileContent = fileContent;
        this.fileName = fileName;
    }

    public Assignment(int i, String title, String course, String deadline, InputStream fileContent) {
    }

    public int getId() { return id; }
    public String getTitle() {
        return title;
    }

    public String getCourse() {
        return course;
    }

    public String getDeadline() {
        return deadline;
    }

    public byte[] getFileContent() {
        return fileContent;
    }

    public String getFileName() { return fileName; }

    public void setFileContent(byte[] fileContent) {
        this.fileContent = fileContent;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public int getWeek() {
        return week;
    }

    public void setWeek(int week) {
        this.week = week;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }
}
