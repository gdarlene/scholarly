package org.app.submission.scholary.models;

public class Participant {
    private int id;
    private String userName;
    private String lastName;
    private String firstName;
    private String email;
    private String password;
    private String Gender;
    private String phoneNumber;

    private String course;
    private String classRoom;

    Participant(){}

    public Participant(int id, String userName, String lastName, String firstName, String email, String password, String gender, String phoneNumber, org.app.submission.scholary.models.UserRole userRole) {
        this.id = id;
        this.userName = userName;
        this.lastName = lastName;
        this.firstName = firstName;
        this.email = email;
        this.password = password;
        Gender = gender;
        this.phoneNumber = phoneNumber;

    }

    public Participant(int id, String userName, String lastName, String firstName, String email, String password, String gender, String course, String phoneNumber, String classRoom, org.app.submission.scholary.models.UserRole userRole) {
        this.id = id;
        this.userName = userName;
        this.lastName = lastName;
        this.firstName = firstName;
        this.email = email;
        this.password = password;
        Gender = gender;
        this.course = course;
        this.phoneNumber = phoneNumber;
        this.classRoom = classRoom;
    }

    public Participant(String userName, String lastName, String firstName, String email, String hashedPassword, String gender, String phoneNumber, UserRole userRole) {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String gender) {
        Gender = gender;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getClassRoom() {
        return classRoom;
    }

    public void setClassRoom(String classRoom) {
        this.classRoom = classRoom;
    }


}