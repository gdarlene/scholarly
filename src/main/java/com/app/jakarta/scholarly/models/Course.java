package com.app.jakarta.scholarly.models;


import jakarta.persistence.*;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "course_name")
    private String courseName;

    @Column(name = "course_code")
    private String courseCode;

    @ManyToOne
    @JoinColumn(name = "instructor_id") // Foreign key to Instructor
    private Teacher teacher;

    public Course() {
    }

    public Course(int id, String courseName, String courseCode, Teacher teacher) {
        this.id = id;
        this.courseName = courseName;
        this.courseCode = courseCode;
        this.teacher = teacher;
    }

    // Getter and Setter methods
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public Teacher getInstructor() {
        return teacher;
    }

    public void setInstructor(Teacher instructor) {
        this.teacher = teacher;
    }
}

